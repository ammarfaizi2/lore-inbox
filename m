Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUCGQp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUCGQp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:45:28 -0500
Received: from ns.suse.de ([195.135.220.2]:21396 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262227AbUCGQpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:45:23 -0500
Subject: Re: External kernel modules, second try
From: Andreas Gruenbacher <agruen@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
In-Reply-To: <20040307160824.GA14967@devserv.devel.redhat.com>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
	 <1078664629.9812.1.camel@laptop.fenrus.com>
	 <1078667199.3594.50.camel@nb.suse.de>
	 <1078668091.9106.1.camel@laptop.fenrus.com>
	 <20040307160527.GA2027@mars.ravnborg.org>
	 <20040307160824.GA14967@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1078677922.3615.47.camel@e136.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Mar 2004 17:45:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-07 at 17:08, Arjan van de Ven wrote:
> On Sun, Mar 07, 2004 at 05:05:27PM +0100, Sam Ravnborg wrote:
> > On Sun, Mar 07, 2004 at 03:01:31PM +0100, Arjan van de Ven wrote:
> > > >  and it's missing the symbols from
> > > > module files.
> > > 
> > > sure but the module files are generally installed...
> > I'm aiming for a situation where I can build external modules,
> > using an almost clean kernel src tree.
> 
> Personally I don't see the point. I'm perfectly happy with the current
> situation with the exception of not using System.map and co.
> 
> From a distribution kernel pov; I already ship a subset of files for building
> modules against (basically include/, the KConfig and makefiles), which only
> not 100% works because I don't ship vmlinux.

We have tried that with our latest round of kernels (still 2.4), and the
results have been mixed. You need various headers outside include/ for
some obscure external modules. Amazingly there are even external modules
that make use of kernel C files.

All in all, in the end I changed my mind. I now think that it's better
to build modules against a clean kernel source tree that additionally
has the modversions file copied in. This already works when using O=.
With the SUBDIRS= approach, the kernel source tree must include a few
compiled files (scripts/ stuff), and it cannot be read-only.

I'm still undecided whether it makes sense to disallow the SUBDIRS=
approach completely and only allow building with O=. (Note that this
doesn't change the modversion dump file argument.) When building with
SUBDIRS=, you ideally want a (read-only) kernel source tree that can
adapt to different configurations (e.g., by doing like this:

   make -C $KERNEL_SOURCE modules SUBDIRS=$PWD FLAVOR=bigsmp

), the default being the running kernel. The RedHat kernel has had a
partial solution for merging autoconf.h. I have patches that implement a
more complete solution that I'd happily send them to an appropriate
place for discussion, but I don't think this would make much sense in
mainline. Particularly because, while O= building has a slightly higher
overhead, it gets rid of those problems, anyway.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

