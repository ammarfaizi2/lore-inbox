Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUL2Wsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUL2Wsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUL2Wsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:48:33 -0500
Received: from smtp15.wxs.nl ([195.121.6.54]:32660 "EHLO smtp15.wxs.nl")
	by vger.kernel.org with ESMTP id S261433AbUL2Wr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:47:29 -0500
Date: Wed, 29 Dec 2004 23:47:23 +0100
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 2/3] 2.6.10 zr36067 driver - ppc/be port
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, mjpeg-developer@lists.sf.net,
       Ben Capper <benandeve@optusnet.com.au>
Message-id: <1104360442.25472.85.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="Boundary_(ID_/50w5GJF758es9Vgm7EEOA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_/50w5GJF758es9Vgm7EEOA)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi Linus/Andrew,

Attached patch adds some host<->le conversion functions for 32-bit
integers. The hardware expects 32-bit integers, which the host does not
always provide. With the attached patch, the hardware runs fine on PPC
hardware as well.

Original patch by Ben Capper (see CC).

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Regards,

Ronald

Ben Capper <benandeve@optusnet.com.au>
-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>

--Boundary_(ID_/50w5GJF758es9Vgm7EEOA)
Content-type: text/x-patch; name=zoran-ppc.diff; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=zoran-ppc.diff

Index: linux-2.6.10/drivers/media/video/zoran_device.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/zoran_device.c	2004-12-29 21:54:16.000000000 +0100
+++ linux-2.6.10/drivers/media/video/zoran_device.c	2004-12-29 23:31:01.090763643 +0100
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/byteorder/generic.h>
 
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
@@ -758,7 +759,7 @@
 		zr->jpg_buffers.buffer[i].state = BUZ_STATE_USER;	/* nothing going on */
 	}
 	for (i = 0; i < BUZ_NUM_STAT_COM; i++) {
-		zr->stat_com[i] = 1;	/* mark as unavailable to zr36057 */
+		zr->stat_com[i] = cpu_to_le32(1);	/* mark as unavailable to zr36057 */
 	}
 }
 
@@ -1163,20 +1164,20 @@
 			/* fill 1 stat_com entry */
 			i = (zr->jpg_dma_head -
 			     zr->jpg_err_shift) & BUZ_MASK_STAT_COM;
-			if (!(zr->stat_com[i] & 1))
+			if (!(zr->stat_com[i] & cpu_to_le32(1)))
 				break;
 			zr->stat_com[i] =
-			    zr->jpg_buffers.buffer[frame].frag_tab_bus;
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].frag_tab_bus);
 		} else {
 			/* fill 2 stat_com entries */
 			i = ((zr->jpg_dma_head -
 			      zr->jpg_err_shift) & 1) * 2;
-			if (!(zr->stat_com[i] & 1))
+			if (!(zr->stat_com[i] & cpu_to_le32(1)))
 				break;
 			zr->stat_com[i] =
-			    zr->jpg_buffers.buffer[frame].frag_tab_bus;
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].frag_tab_bus);
 			zr->stat_com[i + 1] =
-			    zr->jpg_buffers.buffer[frame].frag_tab_bus;
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].frag_tab_bus);
 		}
 		zr->jpg_buffers.buffer[frame].state = BUZ_STATE_DMA;
 		zr->jpg_dma_head++;
@@ -1213,7 +1214,7 @@
 			i = ((zr->jpg_dma_tail -
 			      zr->jpg_err_shift) & 1) * 2 + 1;
 
-		stat_com = zr->stat_com[i];
+		stat_com = le32_to_cpu(zr->stat_com[i]);
 
 		if ((stat_com & 1) == 0) {
 			return;
@@ -1309,7 +1310,7 @@
 					for (i = 0;
 					     i < zr->jpg_buffers.num_buffers;
 					     i++) {
-						if (zr->stat_com[j] ==
+						if (le32_to_cpu(zr->stat_com[j]) ==
 						    zr->jpg_buffers.
 						    buffer[i].
 						    frag_tab_bus) {
@@ -1321,7 +1322,6 @@
 				printk("\n");
 			}
 		}
-
 		/* Find an entry in stat_com and rotate contents */
 		{
 			int i;
@@ -1334,9 +1334,9 @@
 				      zr->jpg_err_shift) & 1) * 2;
 			if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS) {
 				/* Mimic zr36067 operation */
-				zr->stat_com[i] |= 1;
+				zr->stat_com[i] |= cpu_to_le32(1);
 				if (zr->jpg_settings.TmpDcm != 1)
-					zr->stat_com[i + 1] |= 1;
+					zr->stat_com[i + 1] |= cpu_to_le32(1);
 				/* Refill */
 				zoran_reap_stat_com(zr);
 				zoran_feed_stat_com(zr);
@@ -1355,12 +1355,17 @@
 				int j;
 				u32 bus_addr[BUZ_NUM_STAT_COM];
 
+				/* Here we are copying the stat_com array, which
+				 * is already in little endian format, so
+				 * no endian conversions here
+				 */
 				memcpy(bus_addr, zr->stat_com,
 				       sizeof(bus_addr));
 				for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
 					zr->stat_com[j] =
 					    bus_addr[(i + j) &
 						     BUZ_MASK_STAT_COM];
+						     
 				}
 				zr->jpg_err_shift += i;
 				zr->jpg_err_shift &= BUZ_MASK_STAT_COM;
@@ -1564,7 +1569,7 @@
 						int i;
 						strcpy(sv, sc);
 						for (i = 0; i < 4; i++) {
-							if (zr->stat_com[i] & 1)
+							if (le32_to_cpu(zr->stat_com[i]) & 1)
 								sv[i] = '1';
 						}
 						sv[4] = 0;
@@ -1592,7 +1597,7 @@
 					       ZR_DEVNAME(zr), zr->jpg_seq_num);
 					for (i = 0; i < 4; i++) {
 						printk(" %08x",
-						       zr->stat_com[i]);
+						       le32_to_cpu(zr->stat_com[i]));
 					}
 					printk("\n");
 				}
Index: linux-2.6.10/drivers/media/video/zoran_driver.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/zoran_driver.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10/drivers/media/video/zoran_driver.c	2004-12-29 23:30:42.144002358 +0100
@@ -52,6 +52,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <linux/byteorder/generic.h>
 
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -516,6 +517,16 @@
  *       virtual addresses) and then again have to make a lot of efforts
  *       to get the physical address.
  *
+ *   Ben Capper:
+ *       On big-endian architectures (such as ppc) some extra steps
+ *       are needed. When reading and writing to the stat_com array
+ *       and fragment buffers, the device expects to see little-
+ *       endian values. The use of cpu_to_le32() and le32_to_cpu()
+ *       in this function (and one or two others in zoran_device.c)
+ *       ensure that these values are always stored in little-endian
+ *       form, regardless of architecture. The zr36057 does Very Bad
+ *       Things on big endian architectures if the stat_com array
+ *       and fragment buffers are not little-endian.
  */
 
 static int
@@ -569,9 +580,9 @@
 				return -ENOBUFS;
 			}
 			fh->jpg_buffers.buffer[i].frag_tab[0] =
-			    virt_to_bus((void *) mem);
+			    cpu_to_le32(virt_to_bus((void *) mem));
 			fh->jpg_buffers.buffer[i].frag_tab[1] =
-			    ((fh->jpg_buffers.buffer_size / 4) << 1) | 1;
+			    cpu_to_le32(((fh->jpg_buffers.buffer_size / 4) << 1) | 1);
 			for (off = 0; off < fh->jpg_buffers.buffer_size;
 			     off += PAGE_SIZE)
 				SetPageReserved(MAP_NR(mem + off));
@@ -591,14 +602,14 @@
 				}
 
 				fh->jpg_buffers.buffer[i].frag_tab[2 * j] =
-				    virt_to_bus((void *) mem);
+				    cpu_to_le32(virt_to_bus((void *) mem));
 				fh->jpg_buffers.buffer[i].frag_tab[2 * j +
 								   1] =
-				    (PAGE_SIZE / 4) << 1;
+				    cpu_to_le32((PAGE_SIZE / 4) << 1);
 				SetPageReserved(MAP_NR(mem));
 			}
 
-			fh->jpg_buffers.buffer[i].frag_tab[2 * j - 1] |= 1;
+			fh->jpg_buffers.buffer[i].frag_tab[2 * j - 1] |= cpu_to_le32(1);
 		}
 	}
 
@@ -631,13 +642,8 @@
 		//if (alloc_contig) {
 		if (fh->jpg_buffers.need_contiguous) {
 			if (fh->jpg_buffers.buffer[i].frag_tab[0]) {
-				mem =
-				    (unsigned char *) bus_to_virt(fh->
-								  jpg_buffers.
-								  buffer
-								  [i].
-								  frag_tab
-								  [0]);
+				mem = (unsigned char *) bus_to_virt(le32_to_cpu(
+					fh->jpg_buffers.buffer[i].frag_tab[0]));
 				for (off = 0;
 				     off < fh->jpg_buffers.buffer_size;
 				     off += PAGE_SIZE)
@@ -656,13 +662,16 @@
 					break;
 				ClearPageReserved(MAP_NR
 						  (bus_to_virt
-						   (fh->jpg_buffers.
-						    buffer[i].frag_tab[2 *
-								       j])));
+						   (le32_to_cpu
+						    (fh->jpg_buffers.
+						     buffer[i].frag_tab[2 *
+								       j]))));
 				free_page((unsigned long)
-					  bus_to_virt(fh->jpg_buffers.
+					  bus_to_virt
+					          (le32_to_cpu
+						   (fh->jpg_buffers.
 						      buffer[i].
-						      frag_tab[2 * j]));
+						      frag_tab[2 * j])));
 				fh->jpg_buffers.buffer[i].frag_tab[2 * j] =
 				    0;
 				fh->jpg_buffers.buffer[i].frag_tab[2 * j +
@@ -4539,14 +4548,14 @@
 			     j < fh->jpg_buffers.buffer_size / PAGE_SIZE;
 			     j++) {
 				fraglen =
-				    (fh->jpg_buffers.buffer[i].
-				     frag_tab[2 * j + 1] & ~1) << 1;
+				    (le32_to_cpu(fh->jpg_buffers.buffer[i].
+				     frag_tab[2 * j + 1]) & ~1) << 1;
 				todo = size;
 				if (todo > fraglen)
 					todo = fraglen;
 				pos =
-				    (unsigned long) fh->jpg_buffers.
-				    buffer[i].frag_tab[2 * j];
+				    le32_to_cpu((unsigned long) fh->jpg_buffers.
+				    buffer[i].frag_tab[2 * j]);
 				/* should just be pos on i386 */
 				page = virt_to_phys(bus_to_virt(pos))
 								>> PAGE_SHIFT;
@@ -4563,8 +4572,8 @@
 				start += todo;
 				if (size == 0)
 					break;
-				if (fh->jpg_buffers.buffer[i].
-				    frag_tab[2 * j + 1] & 1)
+				if (le32_to_cpu(fh->jpg_buffers.buffer[i].
+				    frag_tab[2 * j + 1]) & 1)
 					break;	/* was last fragment */
 			}
 			fh->jpg_buffers.buffer[i].map = map;
@@ -4689,3 +4698,4 @@
 	.release = &zoran_vdev_release,
 	.minor = -1
 };
+

--Boundary_(ID_/50w5GJF758es9Vgm7EEOA)--
