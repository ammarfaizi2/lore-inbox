Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbTHZOMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbTHZOLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:11:39 -0400
Received: from m94.net81-67-11.noos.fr ([81.67.11.94]:44447 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263960AbTHZOK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:10:59 -0400
Date: Tue, 26 Aug 2003 16:10:56 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22] meye driver updates
Message-ID: <20030826141056.GB9046@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch updates the meye driver with some tiny changes:
	* use SetPageReserved instead of mem_map_reserve, and remove
	  the wrapper.h dependency
	* document the supported hardware.

Marcelo, please apply.

Stelian.

===== Documentation/video4linux/meye.txt 1.6 vs edited =====
--- 1.6/Documentation/video4linux/meye.txt	Tue Feb 18 12:32:22 2003
+++ edited/Documentation/video4linux/meye.txt	Fri Aug  1 12:47:23 2003
@@ -16,6 +16,23 @@
 
 MJPEG hardware grabbing is supported via a private API (see below).
 
+Hardware supported:
+-------------------
+
+This driver supports the 'second' version of the MotionEye camera :)
+
+The first version was connected directly on the video bus of the Neomagic
+video card and is unsupported.
+
+The second one, made by Kawasaki Steel is fully supported by this 
+driver (PCI vendor/device is 0x136b/0xff01)
+
+The third one, present in recent (more or less last year) Picturebooks
+(C1M* models), is not supported. The manufacturer has given the specs
+to the developers under a NDA (which allows the develoment of a GPL
+driver however), but things are not moving very fast (see
+http://r-engine.sourceforge.net/) (PCI vendor/device is 0x10cf/0x2011).
+
 Driver options:
 ---------------
 
===== drivers/media/video/meye.c 1.14 vs edited =====
--- 1.14/drivers/media/video/meye.c	Sun Jun 29 17:10:26 2003
+++ edited/drivers/media/video/meye.c	Mon Jul  7 11:48:00 2003
@@ -35,7 +35,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <linux/delay.h>
-#include <linux/wrapper.h>
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
 
@@ -139,7 +138,7 @@
 		memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	        adr = (unsigned long)mem;
 		while (size > 0) {
-			mem_map_reserve(vmalloc_to_page((void *)adr));
+			SetPageReserved(vmalloc_to_page((void *)adr));
 			adr += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
@@ -153,7 +152,7 @@
 	if (mem) {
 	        adr = (unsigned long) mem;
 		while ((long) size > 0) {
-			mem_map_unreserve(vmalloc_to_page((void *)adr));
+			ClearPageReserved(vmalloc_to_page((void *)adr));
 			adr += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
-- 
Stelian Pop <stelian@popies.net>
