Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTJZTpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTJZTpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:45:25 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:22656
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263620AbTJZTpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:45:23 -0500
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: re: PPC: slab error in cache_free_debugcheck() from sd_revalidate_disk [PATCH, -test9]
Message-Id: <E1ADqpf-0000WU-00@penngrove.fdns.net>
Date: Sun, 26 Oct 2003 11:45:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this one here over a week ago, and upon a suggestion from 'benh', 
i came up with a workaround patch for this bug, now documented in Bugzilla:

	http://bugzilla.kernel.org/show_bug.cgi?id=1426

Attached below is said workaround patch which works for me.  I don't like 
it as i don't think platform-specific code belongs in 'drivers/scsi/sd.c'.
Hence i'm not necessarily recommending this for 2.6.0 unless important
people think otherwise.  It does seem to make the problem go away and
eventually, 'benh' will fix this one properly.

				  -- JM

-------------------------------------------------------------------------------
--- drivers/scsi/sd.c.orig	2003-10-25 11:44:14.000000000 -0700
+++ drivers/scsi/sd.c	2003-10-26 10:11:11.020000000 -0800
@@ -1218,6 +1218,9 @@
 	struct scsi_device *sdp = sdkp->device;
 	struct scsi_request *sreq;
 	unsigned char *buffer;
+#ifdef CONFIG_SCSI_MESH
+	int mesh_fudge;
+#endif
 
 	SCSI_LOG_HLQUEUE(3, printk("sd_revalidate_disk: disk=%s\n", disk->disk_name));
 
@@ -1235,7 +1238,18 @@
 		goto out;
 	}
 
+#ifndef CONFIG_SCSI_MESH
 	buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
+#else
+	/* According to 'benh', some MESH controllers have buggy hardware 
+	   that wants its buffer aligned to a specific byte boundary under
+	   certain circumstances (we think it's a 16 byte boundary, but a
+	   32 byte boundary won't hurt).  KD6PAG/Oct03 */
+	buffer = kmalloc(512+0x20, GFP_KERNEL | __GFP_DMA);
+	   
+	mesh_fudge = (0x20-(int)buffer)&0x1f;	/* Result zero if NULL */
+	buffer += mesh_fudge;
+#endif
 	if (!buffer) {
 		printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
 		       "failure.\n");
@@ -1265,6 +1279,9 @@
 	}
 		
 	set_capacity(disk, sdkp->capacity);
+#ifdef CONFIG_SCSI_MESH
+	buffer -= mesh_fudge;
+#endif
 	kfree(buffer);
 
  out_release_request: 
===============================================================================
