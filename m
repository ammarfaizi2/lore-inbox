Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJFNZq>; Sun, 6 Oct 2002 09:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJFNZq>; Sun, 6 Oct 2002 09:25:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:44675 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261610AbSJFNZo>;
	Sun, 6 Oct 2002 09:25:44 -0400
Message-ID: <3DA03B17.8010501@colorfullife.com>
Date: Sun, 06 Oct 2002 15:31:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Murray J. Root" <murrayr@brain.org>, linux-kernel@vger.kernel.org,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.5.40-ac4  kernel BUG at slab.c:1477!
Content-Type: multipart/mixed;
 boundary="------------060404060705070704070208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404060705070704070208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > This happens at random during boot when loading modules.
 > About half of the time ide-scsi works fine.
 > The system continues to boot after the BUG with /dev/hdc unaccessible.

from mm/slab.c:

1475 if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
1476     /* Either write before start, or a double free. */
1477     BUG();

You run an uniprocessor kernel, with slab debugging enabled, and the 
red-zoning test notices a write before the beginning of the buffer 
during scsi_probe_and_add_lun, with ide-scsi.

Andre: Do you know if ide-scsi makes any assumptions about memory 
alignment of the input buffers? With slab debugging disabled, the 
alignment is 32 or 64 bytes, with debugging enabled, it's just 4 byte 
[actually sizeof(void*)] aligned.

Murray, could you apply the attached patch? It dumps the redzone value 
during scsi_probe_and_add_lun. Hopefully this will help to find who 
corrupts the buffers.

--
	Manfred

--------------060404060705070704070208
Content-Type: text/plain;
 name="patch-scsi-debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-scsi-debug"

--- 2.5/drivers/scsi/scsi_scan.c	Sun Sep 22 06:25:17 2002
+++ build-2.5/drivers/scsi/scsi_scan.c	Sun Oct  6 14:21:58 2002
@@ -1526,8 +1526,9 @@
 			      GFP_DMA : 0);
 	if (scsi_result == NULL)
 		goto alloc_failed;
-
+printk(KERN_INFO"scsi_result: %p, start %lxh.\n",scsi_result, ((unsigned long*)scsi_result)[-1]);
 	scsi_probe_lun(sreq, scsi_result, &bflags);
+printk(KERN_INFO"scsi_result: %p, start %lxh.\n",scsi_result, ((unsigned long*)scsi_result)[-1]);
 	if (sreq->sr_result)
 		res = SCSI_SCAN_NO_RESPONSE;
 	else {
@@ -1550,8 +1551,10 @@
 					" no device added\n"));
 			res = SCSI_SCAN_TARGET_PRESENT;
 		} else {
+printk(KERN_INFO"scsi_result: %p, start %lxh.\n",scsi_result, ((unsigned long*)scsi_result)[-1]);
 			res = scsi_add_lun(sdevscan, &sdev, sreq, scsi_result,
 					   &bflags);
+printk(KERN_INFO"scsi_result: %p, start %lxh.\n",scsi_result, ((unsigned long*)scsi_result)[-1]);
 			if (res == SCSI_SCAN_LUN_PRESENT) {
 				BUG_ON(sdev == NULL);
 				if ((bflags & BLIST_KEY) != 0) {
@@ -1574,9 +1577,13 @@
 			}
 		}
 	}
+printk(KERN_INFO"scsi_result: %p, start %lxh.\n",scsi_result, ((unsigned long*)scsi_result)[-1]);
 	kfree(scsi_result);
+printk(KERN_INFO"after kfree\n");
 	scsi_release_request(sreq);
+printk(KERN_INFO"after release_request\n");
 	scsi_release_commandblocks(sdevscan);
+printk(KERN_INFO"after release_commandblocks\n");
 	return res;
 
 alloc_failed:

--------------060404060705070704070208--

