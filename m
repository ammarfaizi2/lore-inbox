Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUAEROz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUAEROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:14:55 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:3456 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265060AbUAEROf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:14:35 -0500
Date: Mon, 5 Jan 2004 18:14:31 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Ville Herva <vherva@twilight.cs.hut.fi>
Cc: xavier.bestel@free.fr, linux-kernel@vger.kernel.org
Subject: floppy driver and multiple floppies (was Re: 2.6.0 under vmware ?)
Message-ID: <20040105171431.GA1776@vana.vc.cvut.cz>
References: <1073297203.12550.30.camel@bip.parateam.prv> <20040105142032.GE11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105142032.GE11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:20:32PM +0200, Ville Herva wrote:
> On Mon, Jan 05, 2004 at 11:06:43AM +0100, you [Xavier Bestel] wrote:
> > Hi,
> > 
> > Has anyone managed to make another distro with 2.6 work under vmware ?
> 
> 2.6.1rc1 works great for me under vmware 4.05 (6030), but that's with an
> ancient glibc and /sbin/init that do not know of sysenter among other
> things.
> 
> There is one regression, though: 2.2.x and 2.4.x can see /dev/fd0 and
> /dev/fd1 under vmware. 2.6.1rc1 only find /dev/fd0. Does anyone else see
> this?

Are you sure that VMware is a culprit? I had to apply patch below to get
floppy option to work at all (otherwise buggy kernel options parser which
does not understand quotes comes in a way making it impossible to do
f.e. "floppy=1,6,cmos").

And even then configuration with more than one floppy drive is broken:
all floppies will use same queue, but it is not allowed - there is even
comment in the code saying "to be cleaned up" before add_disk() call,
and from my understanding there must be 1:1 relation between queues
and registered disks. Otherwise (at least) sysfs breaks and will
crash on floppy unload as queue is deleted twice from sysfs, and it does not 
like doing such things...
						Petr Vandrovec
						vandrove@vc.cvut.cz

 
diff -urdN linux/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux/drivers/block/floppy.c	2003-12-31 02:59:44.000000000 +0100
+++ linux/drivers/block/floppy.c	2003-12-31 14:14:21.000000000 +0100
@@ -150,6 +150,7 @@
 /* do print messages for unexpected interrupts */
 static int print_unex=1;
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -4618,9 +4619,9 @@
 	wait_for_completion(&device_release);
 }
 
-MODULE_PARM(floppy,"s");
-MODULE_PARM(FLOPPY_IRQ,"i");
-MODULE_PARM(FLOPPY_DMA,"i");
+module_param(floppy, charp, 0);
+module_param(FLOPPY_IRQ, int, 0);
+module_param(FLOPPY_DMA, int, 0);
 MODULE_AUTHOR("Alain L. Knaff");
 MODULE_SUPPORTED_DEVICE("fd");
 MODULE_LICENSE("GPL");
