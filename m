Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284569AbRLRSry>; Tue, 18 Dec 2001 13:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284696AbRLRSq3>; Tue, 18 Dec 2001 13:46:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56474 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284629AbRLRSpV>;
	Tue, 18 Dec 2001 13:45:21 -0500
Date: Tue, 18 Dec 2001 13:45:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: RE: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D802@orsmsx111.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0112181326000.7996-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Dec 2001, Grover, Andrew wrote:

> GRUB 0.90 does this today. All other bootloaders could also do it quite
> easily, since this is just an extension of what they have to do for the
> kernel and initrd images.

... and I'm quite sure that EMACS could do it easily.  Let's not talk
about GNU bloatware, OK?

> > I've had a very dubious pleasure of dealing with our boot 
> > sequence lately.
> > Adding more cruft to it (including in-kernel linker, for fsck sake) is
> > _not_ a good idea.
> 
> I see this as cruft elimination. By adding a kernel linker (which can be
> discarded after init) it allows one to increase the modularity of the kernel
> - without using an initrd. Heck, you could make the initrd code
> modularizable ;-)

I will take it into userland, thank you very much.

> > Folks, whatever had happened with "if it can be done in 
> > userland - don't
> > put it into the kernel"?
> 
> Yes, but this isn't an absolute rule. IIRC that rule also has an "unless it
> makes things a lot simpler" clause, too.

Except that in this case it doesn't make anything simpler.
 
> > That goes for a _lot_ of code.  Mounting root.  Detecting the type of
> > initrd contents.  Loading ramdisk from floppies.  Asking to press
> > key (you really ought to look what is done for _that_).  Speaking
> > DHCP - we have a kernel DHCP client, of all things.  All that stuff
> > can (and should) be done from userland process.  And there's much
> > more of the same kind.
> 
> > There is a word for that and that word is "crap".
> 
> These examples are either a direct result of initrd complexities, or not
> related.

They are related to the fact that we enter userland too late.  Which can
(and should) be fixed.

Linker is not something special - it's yet another userland program.
And we _can_ get userland early - before any drivers are initialized.
Including ramdisk.  Including any block filesystems.  Including at
least large part of (if not entire) PCI initialization.

All we need is s/rootfs/ramfs/ (8Kb patch, mostly removing code) and
unpacking archive to absolute root.  End of story.  Loader should
leave that archive (or concatenation of several archives) in core and
I don't believe that creating cpio on the fly is more complex than
whatever structure you will use to tell the kernel where these modules
are left in core.

All you need on the kernel side is a pass through the area where loader
had left the damn thing and uncpio to /.  After that we free that area
and do execve("/init", ...).  End of story.

BTW, we don't need a special device to handle initrd after that.  Just
have your initrd image (gzipped, whatever) in the archive under /initrd.
After that /init will have the contents in that file (regular file, at
that) and can do whatever it bloody wants.

It kills a _lot_ of kernel code.  And works nicely with any existing
loader - if they want they can build archive on the fly, but they can
just get a pre-built archive using the same mechanism they currently
use for initrd images.  IOW, we are backwards compatible with old
loaders.

