Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVLLTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVLLTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLLTF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:05:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:4815 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932144AbVLLTF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:05:26 -0500
Message-ID: <439DC9E4.6030508@us.ibm.com>
Date: Mon, 12 Dec 2005 13:05:08 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Memory corruption & SCSI in 2.6.15
References: <1134371606.6989.95.camel@gaston>
In-Reply-To: <1134371606.6989.95.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------010702070707060207080701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702070707060207080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> Hi !
> 
> Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> pulled after his return) was dying in weird ways for me on POWER5. I had
> the good idea to activate slab debugging, and I now see it detecting
> slab corruption as soon as the IPR driver initializes.

Please try the attached patch. There appears to be a double free going on
in the scsi scan code. There is a direct call to scsi_free_queue and then
the following put_device calls the release function, which also frees
the queue.

Brian


> Since I remember seeing a discussion somewhere on a list between Brian
> King and Jens Axboe about use-after-free problems in SCSI and possible
> other niceties of that sort, I though it might be related...
> 
> Anything I can do to help track this down ?
> 
> ipr: IBM Power RAID SCSI Device Driver version: 2.1.0 (October 31, 2005)
> ipr 0000:c0:01.0: Found IOA with IRQ: 99
> ipr 0000:c0:01.0: Starting IOA initialization sequence.
> ipr 0000:c0:01.0: Adapter firmware version: 020A004E
> ipr 0000:c0:01.0: IOA initialized.
> scsi0 : IBM 570B Storage Adapter
> Slab corruption: start=c000000070de39a0, len=728
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c0000000002297c4>](.blk_cleanup_queue+0xe4/0x170)
> 1d0: 6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 00 00 00 00
> 2b0: 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Prev obj: start=c000000070de36b0, len=728
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<0000000000000000>](0x0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Next obj: start=c000000070de3c90, len=728
> Redzone: 0x170fc2a5/0x170fc2a5.
> Last user: [<c000000000227b00>](.blk_alloc_queue_node+0x30/0x90)
> 
> Ben.
> 
> 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------010702070707060207080701
Content-Type: text/x-patch;
 name="scsi_scan_use_after_free.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_scan_use_after_free.patch"


Current scsi scanning code appears to have a use after free
bug is a LLDD's slave_alloc fails. Remove the redundant
scsi_free_queue.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 drivers/scsi/scsi_scan.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/scsi/scsi_scan.c~scsi_scan_use_after_free drivers/scsi/scsi_scan.c
--- linux-2.6/drivers/scsi/scsi_scan.c~scsi_scan_use_after_free	2005-12-12 13:00:28.000000000 -0600
+++ linux-2.6-bjking1/drivers/scsi/scsi_scan.c	2005-12-12 13:00:28.000000000 -0600
@@ -279,7 +279,6 @@ static struct scsi_device *scsi_alloc_sd
 
 out_device_destroy:
 	transport_destroy_device(&sdev->sdev_gendev);
-	scsi_free_queue(sdev->request_queue);
 	put_device(&sdev->sdev_gendev);
 out:
 	if (display_failure_msg)
_

--------------010702070707060207080701--
