Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTATIJz>; Mon, 20 Jan 2003 03:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTATIJz>; Mon, 20 Jan 2003 03:09:55 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:59547 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S261495AbTATIJy>; Mon, 20 Jan 2003 03:09:54 -0500
Date: Mon, 20 Jan 2003 08:18:50 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: dwmw2@imladris.demon.co.uk
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030119115647.GD10647@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301200759270.29823-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Subject: Re: [2.5 patch] mics cleanups for mtd
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003, Adrian Bunk wrote:

> On Sun, Jan 19, 2003 at 11:32:33AM +0000, David Woodhouse wrote:
> > For most of the other code, the pain of maintaining two separate versions
> > just isn't justified by the marginal cleanup which this affords -- 
> > especially for the drivers where the _only_ difference between building 
> > out-of-the-box in 2.4 and not doing so is a #include <linux/mtd/compatmac.h>
> 
> The #include <linux/mtd/compatmac.h> has _no_ effect for building on 2.4
> kernels, it only affects 2.0 and 2.2 kernels.

The mtd/compatmac.h in the 2.5 kernel tree has no effect for building on 
2.4 kernels, true. That's because I haven't bothered to update the version 
in Linus' tree -- as you observed, it has no effect there.

To take a random example -- when I changed the JFFS2 code to use 
PageUptodate() instead of Page_Uptodate(), I also added this to 
mtd/compatmac.h in CVS:

	#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,12)
	#define PageUptodate(x) Page_Uptodate(x)
	#endif

However, there was no point in sending that part of the change to Linus 
for the 2.5 kernel -- it's pointless there. That's why you see no 
compatibility code _IN THE 2.5 TREE_ for older trees. 

The mtd/compatmac.h in the CVS tree, however, makes the 2.5-specific code
actually build and work on 2.4 and earlier kernels -- and removing the
#include of it is not helpful.

> The only reason why I said kernels < 2.4.4 is that I removed some
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
> from drivers/mtd/devices/blkmtd.c.

The author of blkmtd.c recently rewrote it completely for 2.5 -- the 
ifdefs in there were getting so ugly it was worth forking it. 

The same treatment is appropriate for the block device drivers too -- 
mtdblock is done, and once ftl and nftl are also done I'll be sending them 
to Linus. If you really want to help, your assistance would be very much 
appreciated in forking those drivers in the CVS tree into 2.5-specific and 
older versions.

> I can send whatever patch you want.

Thanks -- your help is welcome :)

> What is the minimum kernel version you want to support:
> - 2.0.0
> - 2.2.0
> - 2.4.0
> - 2.4.4

Check out the CVS tree, using the cvsroot/password given at 
http://www.linux-mtd.infradead.org/ 

Observe that it contains 2.5-specific code, but builds for the 2.4 kernel
too because of compatmac.h. It may, in fact, not build against 2.5 de jour
because I may be slightly behind in my merging of 2.5-specific changes,
but it shouldn't be far behind.

1. Observe that in some cases, _all_ that was required was to include that 
   file in order to make the code work in 2.4. 

2. Observe that in other cases we need a little bit of #ifdef to make it
   work, but that it's not _too_ ugly.

3. Observe that in further cases the ifdefs are getting _really_ ugly.

4. Observe that occasionally the ifdefs have got so ugly that we've split
   a driver into separate files for different versions of the kernel. Note
   the extra maintenance burden of having two separate copies of 
   essentially the same driver.

The most helpful thing you can do is find drivers in state (3) and convert
them to state (4). But please _do_ build and test against both 2.4 and 2.5
when doing so, and it's probably best to ask before spending your time on
doing them -- the block device drivers are fine because they don't get
much attention, so the extra cost of maintaining two versions instead of
one is negligible. If, on the other hand, you suggest splitting
fs/jffs2/dir.c into two separate files; one for <=2.4 and one for >=2.5,
I'll ignore you :)

> I haven't checked older kernels but at least kernel 2.2.20 includes all 
> header files I've added (init.h, sched.h, vmalloc.h).

Sorry, I meant uClinux 2.0 -- as Greg pointed out, there was no uClinux 
2.2. But to be honest I'm not _really_ bothered about anything earlier 
than about 2.4.14.

-- 
dwmw2

