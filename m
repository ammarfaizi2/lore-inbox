Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUIAQZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUIAQZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUIAQWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:22:49 -0400
Received: from mail.shareable.org ([81.29.64.88]:54473 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267314AbUIAQQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:16:27 -0400
Date: Wed, 1 Sep 2004 17:14:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901161456.GA31934@mail.shareable.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <20040901045922.GA512@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901045922.GA512@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > It's not about the kernel, it's about the interface.  And see my other mail:
> > 	cat foo.zip/README
> > 	less foo.zip/contents/bar.c
> > is a lot easier than
> > 	lynx http://google.com/search?q=zip
> > 	emerge zip
> > 	man zip
> > 	unzip foo.zip
> > 	cat bar.c
> > which already assumes quite a lot of expertise.
> 
> If you only want nice user interface, you can have that today. Its
> done using coda, and hosted at uservfs.sf.net.

Can I do these already using uservfs?

   cd
   less foo.zip/contents/bar.c
   less /usr/portage/distfiles/perl-5.8.5.tar.gz/contents/toke.c
   grep -R obscure_label ~/RPMS

No I can't.

Even using the right "#" names for uservfs ('foo.zip#zip' etc.), I can
only do the above with convenient paths, completion etc. if I mount my
home directory and distfiles over uservfs, so that all I/O in those
directories including ordinary accesses is through uservfs, and have
the _real_ storage elsewhere.  That's quite illogical, cumbersome to
set up, and slows down normal I/O significantly.

I can do some of those things in a similar way if I do them inside
Midnight Commander, Gnome, KDE, or Emacs -- but even then a path that
works in one of those doesn't work in another, and the extensions
don't even work in all programs, plugins or scripts for those systems.

As we're adding file-as-directories to VFS, I propose it would be good
to have *hooks* in place, and non-metadata namespace reserved inside
the directories, so that uservfs-like userspace filesystems can
be auto-mounted at those places and synchronised with the file.

In other words, something that makes the next version of uservfs a
whole lot more useful.

The good news is that a lot of the hooks are falling into place already.

Kernel support is needed to handle the interface, cacheing to trigger
deletions, page cacheing so that I/O is a normal speed and mmap()
works, moveable mounts so that renames work and the cached data
followed them, and coherency so that if the underlying archive is
changed, it invalidates cached data with the appropriate degree of
synchronisation.  Note that the current dnotify cannot provide the
latter with any strength; it's too weak an interface (so is inotify).
(You can omit a lot of these things, but then you get a flaky interface).

The FUSE project looks like it will provide an efficient interface to
the page cache, avoiding round trips where possible and supporting
mmap.  If it doesn't, it should.  (Similar VFS facilities are useful
for distributed filesystems).  The presently discussed file-as-directory
semantics will provide a nice view, and force the necessary minimal
tool changes, so _all_ tools will be fine with the new uservfs.

So all I am asking for is a facility to auto-mount with
file-as-directory, and the ability for a userspace daemon to be
notified of regular file modifications synchronously.  Both can be
added later, once file-as-directory and moveable mounts are
established.  (fcntl leases and dnotify _almost_ provide this, but
they don't.  Looks like incoherent hacks keep getting added all over
the place for Samba... :).

That's all.  Kernel space needs to provide very little that it doesn't
already provide, for this rather nice and universally usable feature to work.

-- Jamie
