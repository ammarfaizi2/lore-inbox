Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSEAO7F>; Wed, 1 May 2002 10:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSEAO7F>; Wed, 1 May 2002 10:59:05 -0400
Received: from philmont.ecn.purdue.edu ([128.46.154.160]:31699 "EHLO
	philmont.ecn.purdue.edu") by vger.kernel.org with ESMTP
	id <S312938AbSEAO7E>; Wed, 1 May 2002 10:59:04 -0400
Message-Id: <200205011458.g41EwwD6027915@philmont.ecn.purdue.edu>
To: linux-kernel@vger.kernel.org
cc: torvalds@penguin.transmeta.com
Subject: 2.5.1[012] compile fix under drivers/usb/storage
Date: Wed, 01 May 2002 09:58:57 -0500
From: Andrew T Sydelko <sydelko@ecn.purdue.edu>
X-Virus-Scanned-ECN: by AMaVIS version 11 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes compilation problems due to structure changes.
The patch applies against 2.5.1[012].

drivers/usb/storage/datafab.c
drivers/usb/storage/jumpshot.c

--andy.

diff -uNr linux-2.5.11-clean/drivers/usb/storage/datafab.c linux-2.5.11/drivers/usb/storage/datafab.c
--- linux-2.5.11-clean/drivers/usb/storage/datafab.c    Sun Apr 28 22:13:26 2002
+++ linux-2.5.11/drivers/usb/storage/datafab.c  Tue Apr 30 14:25:22 2002
@@ -256,7 +256,7 @@
                        while (sg_idx < use_sg && transferred < len) {
                                if (len - transferred >= sg[sg_idx].length - current_sg_offset) {
                                        US_DEBUGP("datafab_read_data:  adding %d bytes to %d byte sg buffer\n", sg[sg_idx].length - current_sg_offset, sg[sg_idx].length);
-                                       memcpy(sg[sg_idx].address + current_sg_offset,
+                                       memcpy(page_address(sg[sg_idx].page) + current_sg_offset,
                                               buffer + transferred,
                                               sg[sg_idx].length - current_sg_offset);
                                        transferred += sg[sg_idx].length - current_sg_offset;
@@ -265,7 +265,7 @@
                                        ++sg_idx;
                                } else {
                                        US_DEBUGP("datafab_read_data:  adding %d bytes to %d byte sg buffer\n", len - transferred, sg[sg_idx].length);
-                                       memcpy(sg[sg_idx].address + current_sg_offset,
+                                       memcpy(page_address(sg[sg_idx].page) + current_sg_offset,
                                               buffer + transferred,
                                               len - transferred);
                                        current_sg_offset += len - transferred;
@@ -347,7 +347,7 @@
                                if (len - transferred >= sg[sg_idx].length - current_sg_offset) {
                                        US_DEBUGP("datafab_write_data:  getting %d bytes from %d byte sg buffer\n", sg[sg_idx].length - current_sg_offset, sg[sg_idx].length);
                                        memcpy(ptr + transferred,
-                                              sg[sg_idx].address + current_sg_offset,
+                                              page_address(sg[sg_idx].page) + current_sg_offset,
                                               sg[sg_idx].length - current_sg_offset);
                                        transferred += sg[sg_idx].length - current_sg_offset;
                                        current_sg_offset = 0;
@@ -356,7 +356,7 @@
                                } else {
                                        US_DEBUGP("datafab_write_data:  getting %d bytes from %d byte sg buffer\n", len - transferred, sg[sg_idx].length);
                                        memcpy(ptr + transferred,
-                                              sg[sg_idx].address + current_sg_offset,
+                                              page_address(sg[sg_idx].page) + current_sg_offset,
                                               len - transferred);
                                        current_sg_offset += len - transferred;
                                        // we only copied part of this sg buffer
diff -uNr linux-2.5.11-clean/drivers/usb/storage/jumpshot.c linux-2.5.11/drivers/usb/storage/jumpshot.c
--- linux-2.5.11-clean/drivers/usb/storage/jumpshot.c   Sun Apr 28 22:11:24 2002
+++ linux-2.5.11/drivers/usb/storage/jumpshot.c Tue Apr 30 14:25:22 2002
@@ -331,7 +331,7 @@
                         while (sg_idx < use_sg && transferred < len) {
                                 if (len - transferred >= sg[sg_idx].length - current_sg_offset) {
                                         US_DEBUGP("jumpshot_read_data:  adding %d bytes to %d byte sg buffer\n", sg[sg_idx].length - current_sg_offset, sg[sg_idx].length);
-                                        memcpy(sg[sg_idx].address + current_sg_offset,
+                                        memcpy(page_address(sg[sg_idx].page) + current_sg_offset,
                                                buffer + transferred,
                                                sg[sg_idx].length - current_sg_offset);
                                         transferred += sg[sg_idx].length - current_sg_offset;
@@ -340,7 +340,7 @@
                                         ++sg_idx;
                                 } else {
                                         US_DEBUGP("jumpshot_read_data:  adding %d bytes to %d byte sg buffer\n", len - transferred, sg[sg_idx].length);
-                                        memcpy(sg[sg_idx].address + current_sg_offset,
+                                        memcpy(page_address(sg[sg_idx].page) + current_sg_offset,
                                                buffer + transferred,
                                                len - transferred);
                                         current_sg_offset += len - transferred;
@@ -413,7 +413,7 @@
                                 if (len - transferred >= sg[sg_idx].length - current_sg_offset) {
                                         US_DEBUGP("jumpshot_write_data:  getting %d bytes from %d byte sg buffer\n", sg[sg_idx].length - current_sg_offset, sg[sg_idx].length);
                                         memcpy(ptr + transferred,
-                                               sg[sg_idx].address + current_sg_offset,
+                                               page_address(sg[sg_idx].page) + current_sg_offset,
                                                sg[sg_idx].length - current_sg_offset);
                                         transferred += sg[sg_idx].length - current_sg_offset;
                                         current_sg_offset = 0;
@@ -422,7 +422,7 @@
                                 } else {
                                         US_DEBUGP("jumpshot_write_data:  getting %d bytes from %d byte sg buffer\n", len - transferred, sg[sg_idx].length);
                                         memcpy(ptr + transferred,
-                                               sg[sg_idx].address + current_sg_offset,
+                                               page_address(sg[sg_idx].page) + current_sg_offset,
                                                len - transferred);
                                         current_sg_offset += len - transferred;
                                         // we only copied part of this sg buffer

