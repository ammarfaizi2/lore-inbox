Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSFMJSq>; Thu, 13 Jun 2002 05:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSFMJSp>; Thu, 13 Jun 2002 05:18:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32453 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317559AbSFMJSo>;
	Thu, 13 Jun 2002 05:18:44 -0400
Date: Thu, 13 Jun 2002 05:18:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Francois Gouget <fgouget@free.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <Pine.LNX.4.43.0206122352100.21739-100000@amboise.dolphin>
Message-ID: <Pine.GSO.4.21.0206130454040.18281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jun 2002, Francois Gouget wrote:

> On Thu, 13 Jun 2002, Alexander Viro wrote:
> 
> >
> >
> > On Thu, 13 Jun 2002, Stevie O wrote:
> >
> > > At 12:09 AM 6/13/2002 -0400, Alexander Viro wrote:
> > > >Vetoed.  Consider what happens if you rename such file, for one thing.
> > >
> > > I don't understand
> > > What do you mean, if I rename such a file?
> >
> > rename("foo.lnk", "foo");
> 
> Let's not use .lnk as the extension, ok? It's an area that is still
> quite sensitive <g>
> 
> So let's say that we use .!nk as the extension of our brand new symlink
> implementation (assuming using '!' is ok).
> 
> Then here is how it would work:
>  * if the user creates a symlink called "foo", we create a file called
> "foo.!nk" on the underlying filesystem.
>  * opendir+readdir does not return "foo.!nk" but instead returns "foo"
>  * open("foo") opens the symlink, i.e. the VFS reads "foo.!nk"  and open
> the filename contained therein
>  * create("bar.!nk") is not allowed: on such a filesystem, you are not
> allowed to create any file ending with ".!nk"
>  * symlink(...,"...very long name") fails if the filename is too long
> for VFS to append ".!nk"
>  * etc.

I don't see where VFS would come into the game - what you had described
is behaviour of ->symlink() and ->lookup() of filesystem in question.
For VFS name components are arbitrary sequences of characters other than
'\0' and '/'.  Period.  It has no idea of extensions, maximal component
lengths, etc.

Moreover, names returned by ->readdir() are not interpreted - they are
responsibility of filesystem in question.  Ditto for limits you place
on the names acceptable for ->create(), ->mkdir(), etc. - it's up to
filesystem.

Same goes for the way you store and interpret symlinks - VFS has no
business messing with that; that's what ->readlink() and ->follow_link()
are for.

_If_ you want to use "add magical 4 bytes to the end of component to
indicate a symlink" - more power to you, but that's nothing but a
detail of your filesystem layout.  You are making a directory with
both 'foo' and 'foo.!nk' invalid, but that's the matter of fsck for
your filesystem and ability of fs driver to cope with such error
gracefully.

I don't see why anyone would want to do that, but it's certainly doable.
Obviously if you do that for several filesystems and find that some
code is shared, you can put the common helpers into a library and use
them instead of duplicating that code.  I doubt that there would be
that much sharing possible, though.

What I _don't_ want to see is "let's add magical API for reading and
writing these objects" or "let's add a flag telling to VFS that fs
uses that representation of symlinks and make it do the magic".  In
particular, if lookup for "foo" gives you such symlink, lookup for
"foo.!nk" should fail rather than giving you access to "raw" object -
just to forestall the obvious first bogus proposal.

Frankly, I still don't see why anyone would want to use VFAT other than for
ZIP drives / floppies / flash (i.e. shared removable media for transfering
data to/from non-Unix hosts), so I don't see any value in doing symlinks
on VFAT at all, but as long as this weirdness is confined to filesystem
code and plays nice with API - it's none of my problems; take it with
VFAT maintainer.  As soon as it stops being private fs business, though...

