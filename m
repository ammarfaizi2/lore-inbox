Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315888AbSEGQPa>; Tue, 7 May 2002 12:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315889AbSEGQPa>; Tue, 7 May 2002 12:15:30 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5124 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315888AbSEGQPZ>; Tue, 7 May 2002 12:15:25 -0400
Date: Tue, 7 May 2002 20:15:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
Message-ID: <20020507201511.A766@jurassic.park.msu.ru>
In-Reply-To: <20020506222506.GA8718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 03:25:07PM -0700, Greg KH wrote:
> Here is a series of changesets that reorganize the core and i386 PCI
> files.  It splits the current big files up into smaller pieces,
> according to the different function and platform type (removing lots of
> #ifdefs in the process.)  Pat Mochel did 99.9% of this work, and I've
> tested it out and forward ported it to your most recent kernel version.

There are missing #includes which will break compilation on some non-x86
platforms. With following patch this compiles and works on alpha.

Ivan.

--- 2.5.14-reorg/arch/alpha/kernel/pci.c	Tue May  7 18:38:42 2002
+++ linux/arch/alpha/kernel/pci.c	Tue May  7 19:40:04 2002
@@ -193,13 +193,15 @@ pcibios_align_resource(void *data, struc
 #undef MB
 #undef GB
 
-void __init
+static void __init
 pcibios_init(void)
 {
 	if (!alpha_mv.init_pci)
 		return;
 	alpha_mv.init_pci();
 }
+
+subsys_initcall(pcibios_init);
 
 char * __init
 pcibios_setup(char *str)
--- 2.5.14-reorg/drivers/pci/probe.c	Tue May  7 18:15:54 2002
+++ linux/drivers/pci/probe.c	Tue May  7 19:02:38 2002
@@ -2,7 +2,9 @@
  * probe.c - PCI detection and setup code
  */
 
+#include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 
 #undef DEBUG
--- 2.5.14-reorg/drivers/pci/pci.c	Tue May  7 18:15:54 2002
+++ linux/drivers/pci/pci.c	Tue May  7 19:05:28 2002
@@ -9,6 +9,8 @@
  *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
--- 2.5.14-reorg/drivers/pci/pool.c	Tue May  7 19:07:51 2002
+++ linux/drivers/pci/pool.c	Tue May  7 19:07:15 2002
@@ -1,4 +1,5 @@
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 
 /*
--- 2.5.14-reorg/drivers/pci/proc.c	Tue May  7 18:15:54 2002
+++ linux/drivers/pci/proc.c	Tue May  7 19:09:13 2002
@@ -6,6 +6,7 @@
  *	Copyright (c) 1997--1999 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
