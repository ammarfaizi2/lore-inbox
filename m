Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAaN4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAaN4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVAaN4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:56:47 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:58050 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261198AbVAaN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:56:25 -0500
Date: Mon, 31 Jan 2005 14:56:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050131135631.GA6694@wohnheim.fh-wedel.de>
References: <20050130180016.GA12987@infradead.org> <1107132112.783.219.camel@baythorne.infradead.org> <1107159869.4221.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1107159869.4221.53.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 January 2005 09:24:29 +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-31 at 00:41 +0000, David Woodhouse wrote:
> > On Sun, 2005-01-30 at 18:00 +0000, Arjan van de Ven wrote:
> > > 
> > > intermodule is deprecated for quite some time now, and MTD is the sole last
> > > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > > to prevent accidental return of more users of this, make the compiling of
> > > this function conditional on MTD.
> > 
> > Please get the dependencies right -- it's not core MTD code, but the NOR
> > chip drivers and the old DiskOnChip drivers which use this. 
> 
> that's just a slightly more finegrained thing, not sure if it's worth
> going that deep, esp since it become 2 deps not one, making a bigger
> mess than needed.

How about this one?  It's actually less messy inside kernel/Makefile.

Completely untested, though.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/chips/Kconfig   |    4 ++++
 drivers/mtd/devices/Kconfig |    4 ++++
 kernel/Makefile             |    3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

--- linux-2.6.10cow/kernel/Makefile~inter_module	2004-12-28 17:31:37.000000000 +0100
+++ linux-2.6.10cow/kernel/Makefile	2005-01-31 14:49:40.000000000 +0100
@@ -6,9 +6,10 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o
 
+obj-$(CONFIG_INTER_MODULE_CRAP) += intermodule.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
--- linux-2.6.10cow/drivers/mtd/devices/Kconfig~inter_module	2005-01-11 20:48:52.000000000 +0100
+++ linux-2.6.10cow/drivers/mtd/devices/Kconfig	2005-01-31 14:51:29.000000000 +0100
@@ -140,6 +140,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOC2000
 	tristate "M-Systems Disk-On-Chip 2000 and Millennium (DEPRECATED)"
 	depends on MTD
+	select INTER_MODULE_CRAP
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  2000 and Millennium devices.  Originally designed for the DiskOnChip
@@ -161,6 +162,7 @@ config MTD_DOC2000
 config MTD_DOC2001
 	tristate "M-Systems Disk-On-Chip Millennium-only alternative driver (DEPRECATED)"
 	depends on MTD
+	select INTER_MODULE_CRAP
 	---help---
 	  This provides an alternative MTD device driver for the M-Systems 
 	  DiskOnChip Millennium devices.  Use this if you have problems with
@@ -181,6 +183,7 @@ config MTD_DOC2001
 config MTD_DOC2001PLUS
 	tristate "M-Systems Disk-On-Chip Millennium Plus"
 	depends on MTD
+	select INTER_MODULE_CRAP
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  Millennium Plus devices.
@@ -198,6 +201,7 @@ config MTD_DOCPROBE
 	tristate
 	default m if MTD_DOC2001!=y && MTD_DOC2000!=y && MTD_DOC2001PLUS!=y && (MTD_DOC2001=m || MTD_DOC2000=m || MTD_DOC2001PLUS=m)
 	default y if MTD_DOC2001=y || MTD_DOC2000=y || MTD_DOC2001PLUS=y
+	select INTER_MODULE_CRAP
 	help
 	  This isn't a real config option; it's derived.
 
--- linux-2.6.10cow/drivers/mtd/chips/Kconfig~inter_module	2004-09-04 22:59:02.000000000 +0200
+++ linux-2.6.10cow/drivers/mtd/chips/Kconfig	2005-01-31 14:53:05.000000000 +0100
@@ -7,6 +7,7 @@ menu "RAM/ROM/Flash chip drivers"
 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
 	depends on MTD
+	select INTER_MODULE_CRAP
 	help
 	  The Common Flash Interface specification was developed by Intel,
 	  AMD and other flash manufactures that provides a universal method
@@ -158,6 +159,7 @@ config MTD_CFI_I8
 config MTD_CFI_INTELEXT
 	tristate "Support for Intel/Sharp flash chips"
 	depends on MTD_GEN_PROBE
+	select INTER_MODULE_CRAP
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
@@ -167,6 +169,7 @@ config MTD_CFI_INTELEXT
 config MTD_CFI_AMDSTD
 	tristate "Support for AMD/Fujitsu flash chips"
 	depends on MTD_GEN_PROBE
+	select INTER_MODULE_CRAP
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
@@ -197,6 +200,7 @@ config MTD_CFI_AMDSTD_RETRY_MAX
 config MTD_CFI_STAA
 	tristate "Support for ST (Advanced Architecture) flash chips"
 	depends on MTD_GEN_PROBE
+	select INTER_MODULE_CRAP
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
