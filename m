Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269588AbUHZUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269588AbUHZUVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbUHZUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:19:59 -0400
Received: from mail.shareable.org ([81.29.64.88]:65222 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269578AbUHZUQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:16:08 -0400
Date: Thu, 26 Aug 2004 21:13:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Stoffel <stoffel@lucent.com>
Cc: Rik van Riel <riel@redhat.com>, Christophe Saout <christophe@saout.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826201330.GZ5733@mail.shareable.org>
References: <20040826154446.GG5733@mail.shareable.org> <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <20040826165351.GM5733@mail.shareable.org> <16686.15061.549250.611694@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16686.15061.549250.611694@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> Jamie> Yes, exactly that.  The streams are created on demand of
> Jamie> course, and by userspace helpers when that's appropriate which
> Jamie> I suspect it almost always is.
> 
> So how would a program that converts between a JPEG file (with exif
> data) and a PNG work, such as ImageMagick?  Are we proposing to teach
> the VFS (or worse yet each filesystem) how to do this?  

No.  (1) That's what "userspace helpers" are for.  (2) What does image
format conversion have to do with viewing files in their component
parts?  (3) I suspect someone will write a plugin that does indeed
convert virtually every known image format to a common format
(probably PNG and something "raw") at some point.  Why not?  It's just
a small script (it would run ImageMagick!).

> I've been following this discussion a bit and I'm not sure that I've
> actually seen any concrete examples of where this is a *good* thing to
> have.  People talk about only having to modify 20 bytes at a time
> instead of reading and writing 1mb of data.  Isn't that what mmap()
> does?

Sure, if you think mmap() is an easy substitute for "parse the author
& license tags from this [unknown format] audio, video or font file".

> Now I can sorta understand the idea that having a directory look like
> a file is neat, and certainly simplifies some aspects, but I think
> that going all the way down to the logical conclusion here is a bit
> silly.
> 
> To use the principle of blowing things up to make them very large or
> very small, what happens if I decide that the best idea is to make all
> files just be directories which contain single byte files?  Isn't that
> the logical extreme here?  So my 1mb JPEG file is not just some image
> data and header info in multiple files, but it's really just 1
> million (ok 1024 * 1024) individual files that the VFS knows how to
> put together.  Seems like the logical extreme.  Oh wait, maybe we
> should be exposing a single file per bit instead! 

If you decide to do that, you are welcome to write the userspace
helper which creates that view in your directory.

Why not?  It's very silly, but it's no sillier then writing a program
to read your 1mb JPEG and write it out one file per bit, which you're
welcome to write right now.

> >From my point of view, there lies madness.  As Rik pointed out, how do
> backup and restore tools work with this stuff?  Most people could care
> less about how their data is organized, but they certainly care when
> they can't restore it from backups.  

Generated views are something which should _not_ be backed up and
restored.  That's not what they are for.

Auxiliary metadata, such as author info and signatures which cannot be
stored in the main file for some reason -- that should be backed up.

Permissions, that should be backed up.

But not views which are computed from the main file.  You don't need
to back them up, and they don't need to take any real space.  They're
virtual, just like an infinitely deep directory on a web server can be
virtual.  You can make those very silly too, if you want to.

(Some help from the filesystem with storing temporarily cached values
is fine, for performance, but we shouldn't pretend that generated
views are anything other than virtual).

> I'd really like to see a concrete example from Hans or other
> proponents about why this makes things easier/faster/better to do.
> Mostly, I've just seen "proof by vigorous handwaving" that it's a good
> thing.
> 
> In alot of ways, I think people are going in the wrong direction, you
> want to excapsulate and hide the details more, not expose them.
> That's what a good API does, it hides the details while giving you a
> rich set of semantics to manage your data.  

Would you like to propose an alternate API?  I was under the
impression that we were discussing one, right here in this thread.
It's called POSIX with an extension where you can cd into a file.  It
has a rich set of semantics to manage your data, and works with a lot
of familiar programs.

A better one would be welcome, if you have an idea.

> God knows I'm not smart enough or driven enough to actually come up
> with my own ideas, but I certainly haven't seen anyone else (even
> Linus) come up with an earth shattering arguement to say why this is
> the right move to make.

Come up with a better one otherwise it's right ;)

> As Linus says, most of the OS's job is to mediate access to
> objects/data.  Why do we want to expose such low level data then?

Eh?  In this case the OS is mediating by providing a uniform interface
between programs that access the data and programs that handle file
formats.

What is this "low level" data you speak of?  I would say something
like the "designer" of a font, or the "from address" and "subject" of
an email are very high level abstractions, and that's among the sorts
of things which are to be exposed by these interfaces.

-- Jamie
