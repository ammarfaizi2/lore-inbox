Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266047AbSKBSka>; Sat, 2 Nov 2002 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266048AbSKBSka>; Sat, 2 Nov 2002 13:40:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266047AbSKBSk3>; Sat, 2 Nov 2002 13:40:29 -0500
Date: Sat, 2 Nov 2002 10:47:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021102070607.GB16100@think.thunk.org>
Message-ID: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Theodore Ts'o wrote:
> 
> HOWEVER, if we're going to do it, Olaf's patches is really not the way
> to do it.  If we're going to do it at all, the right way to do it is
> via extended attributes.  Using a sparse file to store capabilities
> indexed by inode numbers is a bad idea; it will break if the user uses
> resize2fs on an ext2/3 filesystem, for example.

Clearly inode numbers are a bad way to handle it, but I don't think inode
attributes are that great either. I would personally prefer directory
entry attributes, so that the same file can show up with different
behaviour in different places.

I think it was a mistake to have permissions be part of the inode in the
first place, but that's UNIX for you. A direntry-based approach is _so_ 
much more flexible, and doesn't really have any downsides. 

(Having attributes in the direntry also makes it possible to much more
efficiently scan directories for types of files without having to look up
the inode information).

We can't fix the UNIX permission issue, but if we _do_ make FS
capabilities available, I will personally cast a strong vote for not
hiding the information in the inode.

There are two fairly trivial ways to do it:

 - put the actual data in the directory entry itself. This is efficient, 
   but not very easily extensible, since most directory structures have 
   serious size limitations.

 - Make a new file type, and put just that information in the directory
   (so that it shows up in d_type on a readdir()).  Put the real data in
   the file, ie make it largely look like an "extended symlink".

The latter approach is probably a bit too reminiscent of a Windows
"shortcut" aka LNK file to some people, but hey, maybe it's a good idea.

		Linus

