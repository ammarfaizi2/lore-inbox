Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285569AbRLGVuX>; Fri, 7 Dec 2001 16:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285573AbRLGVuO>; Fri, 7 Dec 2001 16:50:14 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20105 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285569AbRLGVt4>; Fri, 7 Dec 2001 16:49:56 -0500
Message-ID: <3C113949.2050102@us.ibm.com>
Date: Fri, 07 Dec 2001 13:48:57 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Martin A. Brooks" <martin@jtrix.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1pre6 compile error
In-Reply-To: <1007722213.24166.2.camel@unhygienix> <20011207145206.GH12017@suse.de>
Content-Type: multipart/mixed;
 boundary="------------020100040404030705050404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020100040404030705050404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:

 >On Fri, Dec 07 2001, Martin A. Brooks wrote:
 >
 >>gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
 >>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
 >>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
 >>-march=i686    -c -o ps2esdi.o ps2esdi.c
 >>ps2esdi.c: In function `do_ps2esdi_request':
 >>ps2esdi.c:498: switch quantity not an integer
 >>ps2esdi.c:500: warning: unreachable code at beginning of switch
 >>statement
 >>make[3]: *** [ps2esdi.o] Error 1
 >>
 >Please take a look at the rq->cmd -> rq->flags changes. Then understand
 >them. Then fix ps2 and send me a diff, thanks.
 >
Jens,
   It looks like in the rest of the code, you replaced CURRENT->cmd with
rq_data_dir(CURRENT).  I've attached a patch that does this for
ps2esdi.c.  Those old PS/2 machines are real workhorses.  I still have a
few of them running.

--
Dave


--------------020100040404030705050404
Content-Type: text/plain;
 name="ps2esdi_cmd_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ps2esdi_cmd_fix.patch"

--- linux-2.5.1-pre6/drivers/block/ps2esdi.c	Fri Nov 30 17:40:03 2001
+++ linux/drivers/block/ps2esdi.c	Fri Dec  7 11:22:29 2001
@@ -466,10 +466,10 @@
 	sti();
 
 #if 0
-	printk("%s:got request. device : %d minor : %d command : %d  sector : %ld count : %ld, buffer: %p\n",
+	printk("%s:got request. device : %d minor : %d flags : %d  sector : %ld count : %ld, buffer: %p\n",
 	       DEVICE_NAME,
 	       CURRENT_DEV, MINOR(CURRENT->rq_dev),
-	       CURRENT->cmd, CURRENT->sector,
+	       rq_data_dir(CURRENT), CURRENT->sector,
 	       CURRENT->current_nr_sectors, CURRENT->buffer);
 #endif
 
@@ -485,17 +485,17 @@
 	    (CURRENT->sector + CURRENT->current_nr_sectors <=
 	     ps2esdi[MINOR(CURRENT->rq_dev)].nr_sects)) {
 #if 0
-		printk("%s:got request. device : %d minor : %d command : %d  sector : %ld count : %ld\n",
+		printk("%s:got request. device : %d minor : %d flags : %d  sector : %ld count : %ld\n",
 		       DEVICE_NAME,
 		       CURRENT_DEV, MINOR(CURRENT->rq_dev),
-		       CURRENT->cmd, CURRENT->sector,
+		       rq_data_dir(CURRENT), CURRENT->sector,
 		       CURRENT->current_nr_sectors);
 #endif
 
 		block = CURRENT->sector;
 		count = CURRENT->current_nr_sectors;
 
-		switch (CURRENT->cmd) {
+		switch (rq_data_dir(CURRENT)) {
 		case READ:
 			ps2esdi_readwrite(READ, CURRENT_DEV, block, count);
 			break;
@@ -850,7 +850,7 @@
 	switch (int_ret_code & 0x0f) {
 	case INT_TRANSFER_REQ:
 		ps2esdi_prep_dma(CURRENT->buffer, CURRENT->current_nr_sectors,
-		    (CURRENT->cmd == READ)
+		    ( rq_data_dir(CURRENT) == READ)
 		    ? MCA_DMA_MODE_16 | MCA_DMA_MODE_WRITE | MCA_DMA_MODE_XFER
 		    : MCA_DMA_MODE_16 | MCA_DMA_MODE_READ);
 		outb(CTRL_ENABLE_DMA | CTRL_ENABLE_INTR, ESDI_CONTROL);


--------------020100040404030705050404--

