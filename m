Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269514AbUHZTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbUHZTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269512AbUHZTp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:45:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:58566 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269232AbUHZTeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:34:14 -0400
Date: Thu, 26 Aug 2004 20:29:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826192918.GW5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408261149510.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> What do we do with O_CREAT ?
> 
> Do we always allow both a directory and a file to be created with
> the same name ?

I haven't analysed it thoroughly.  I suspect it's fine as long as:

(1) O_CREAT creates something with "file-like
    attributes", meaning stat() says it's a regular file.

(2) File-like means it can be unlinked, linked and renamed, even if
    someone has something inside it open.  Nothing that can be created
    inside it will prevent it from being unlinked (unlike a
    directory-like object, where rmdir() will refuse if it's not empty).

    File-like also means that programs like "cp from to_my_new_file"
    won't do anything so silly as to write _inside_, the way that
    "cp from to_my_new_file/from" would.

    Basic utilities will need to be checked to make sure they don't
    try appending "/" as their method of deciding if the target object
    is a directory and should be entered.

> Does this create a new class of "symlink attack" style security
> holes ?

Yes, but they don't need O_CREAT.

An adversary creates a symlink to metadata inside your file.  You
write to it: it has interesting effects that weren't anticipated, such
as either modifying another (virtual) file, or altering permissions or
other parameters which writing doesn't normally do.

This is very difficult to prevent.

We are creating a way for scripts and classic unix tools to have easy
access to fancy attributes which may affect the security: things like
being able to change a file's permissions just by writing to the
appropriate path, or reading characteristics of files that shouldn't
be visible.  In Hans Reiser's example of expanded /etc/passwd, atimes
and mtimes of individual passwd entries is security information that
perhaps shouldn't be exposed.

In a way, these holes are similar to /proc, in that just writing has
side effects which might not be acceptable.

The solution is the same as for /proc (I hope): make sure the read
permissions on all metadata inside a directory branch are restricted
to the permissions of the file branch, and write permissions even more
restricted at least by default.

For the paranoid, one way is to make new files "not readable or
executable as directories".  It's possible for the file and directory
branches to have different permission bits, though I could see that
getting a bit annoying.  Other possibilities abound.

-- Jamie
