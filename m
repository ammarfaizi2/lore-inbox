Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbTCLW6j>; Wed, 12 Mar 2003 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbTCLW6Q>; Wed, 12 Mar 2003 17:58:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262083AbTCLW5c>;
	Wed, 12 Mar 2003 17:57:32 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Mark Haverkamp <markh@osdl.org>
To: Christoffer Hall-Frederiksen <hall@jiffies.dk>
Cc: linux-scsi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <20030228133037.GB7473@jiffies.dk>
References: <20030228133037.GB7473@jiffies.dk>
Content-Type: text/plain
Organization: 
Message-Id: <1047510381.12193.28.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Mar 2003 15:06:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 05:30, Christoffer Hall-Frederiksen wrote:
> I have a dell poweredge 1650 with a perc3/DI controller. When the
> AACRAID driver loads it stops with the following lines:
> 
> AAC0: kernel 2.7.4 build 3170
> AAC0: monitor 2.7.4 build 3170
> AAC0: bios 2.7.0 build 3170
> AAC0: serial 0b9c810d3
> scsi0 : percraid
> 

We just ran into this too at osdl.  I have something that gets the
driver to load, but I'm not sure what the right thing is to do.

The cmd_per_lun element of the driver_template is set to
AAC_NUM_IO_FIB.  This is 512. 

During probe, scsi_alloc_sdev is called.  It calls
scsi_adjust_queue_depth with the cmd_per_lun value. 
scsi_adjust_queue_depth returns without doing anything if the tags value
is greater than 256.  This leaves the Scsi_Device queue_depth at zero. 
Later when an I/O is queued, scsi_request_fn checks for device_busy >=
queue_depth.  If so, the function does a break and exits.  This is where
it hangs.

To get things to load I set cmd_per_lun to 256.  I don't know if the is
the correct way to deal with the problem.  Maybe someone else can say
something about that.



===== drivers/scsi/aacraid/linit.c 1.12 vs edited =====
--- 1.12/drivers/scsi/aacraid/linit.c	Mon Feb 24 13:03:30 2003
+++ edited/drivers/scsi/aacraid/linit.c	Wed Mar 12 14:32:18 2003
@@ -693,7 +693,7 @@
 	this_id:        	16,
 	sg_tablesize:   	16,
 	max_sectors:    	128,
-	cmd_per_lun:    	AAC_NUM_IO_FIB,
+	cmd_per_lun:    	256,
 	eh_abort_handler:       aac_eh_abort,
 	eh_device_reset_handler:aac_eh_device_reset,
 	eh_bus_reset_handler:	aac_eh_bus_reset,


-- 
Mark Haverkamp <markh@osdl.org>

