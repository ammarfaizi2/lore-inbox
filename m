Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCRP41>; Tue, 18 Mar 2003 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262493AbTCRP41>; Tue, 18 Mar 2003 10:56:27 -0500
Received: from verein.lst.de ([212.34.181.86]:47367 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262492AbTCRP4Z>;
	Tue, 18 Mar 2003 10:56:25 -0500
Date: Tue, 18 Mar 2003 17:04:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining occurances of DEVFS_FL_AUTO_DEVNUM in 2.5.65
Message-ID: <20030318170409.A7043@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com> <20030318124516.GC18135@fs.tum.de> <20030318164037.A6878@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030318164037.A6878@lst.de>; from hch@lst.de on Tue, Mar 18, 2003 at 04:40:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 04:40:37PM +0100, Christoph Hellwig wrote:
> > drivers/media/dvb/dvb-core/dvbdev.c:    #define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT|DEVFS_FL_AUTO_DEVNUM)
> > 
> > 
> > The last one causes a compile error on i386 with CONFIG_DVB_DEVFS_ONLY 
> > enabled.
> 
> I thought I removed that config option, need to check whether that hunk
> got left.

Ok, here's the lost hunk:


--- 1.1/drivers/media/dvb/dvb-core/Kconfig	Wed Oct 30 02:16:55 2002
+++ edited/drivers/media/dvb/dvb-core/Kconfig	Tue Mar 18 16:56:51 2003
@@ -5,13 +5,3 @@
 	  DVB core utility functions for device handling, software fallbacks etc.
 
 	  Say Y when you have a DVB card and want to use it. If unsure say N.
-
-config DVB_DEVFS_ONLY
-	bool "devfs only"
-	depends on DVB_CORE=y && DEVFS_FS
-	help
-	  Drop support for old major/minor device scheme and support only devfs 
-	  systems. This saves some code.
-
-	  If unsure say N.
-
--- 1.3/drivers/media/dvb/dvb-core/dvbdev.c	Mon Nov 25 16:57:37 2002
+++ edited/drivers/media/dvb/dvb-core/dvbdev.c	Tue Mar 18 16:57:45 2003
@@ -21,8 +21,6 @@
  *
  */
 
-/*#define CONFIG_DVB_DEVFS_ONLY 1*/
-
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -56,17 +54,8 @@
 };
 
 
-#ifdef CONFIG_DVB_DEVFS_ONLY
-
-	#define DVB_MAX_IDS              ~0
-	#define nums2minor(num,type,id)  0
-	#define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT|DEVFS_FL_AUTO_DEVNUM)
-
-#else
-
-	#define DVB_MAX_IDS              4
-	#define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
-	#define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT)
+#define DVB_MAX_IDS              4
+#define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 
 
 static
@@ -234,8 +223,7 @@
 
 	sprintf(name, "%s%d", dnames[type], id);
 	dvbdev->devfs_handle = devfs_register(adap->devfs_handle, name,
-					      DVB_DEVFS_FLAGS,
-					      DVB_MAJOR,
+					      0, DVB_MAJOR,
 					      nums2minor(adap->num, type, id),
 					      S_IFCHR | S_IRUSR | S_IWUSR,
 					      dvbdev->fops, dvbdev);
