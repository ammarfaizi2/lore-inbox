Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754760AbWKMO3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbWKMO3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbWKMO3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:29:09 -0500
Received: from rtr.ca ([64.26.128.89]:43269 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1754760AbWKMO3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:29:08 -0500
Message-ID: <45588132.9090200@rtr.ca>
Date: Mon, 13 Nov 2006 09:29:06 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca> <1163363479.3423.8.camel@w100>
In-Reply-To: <1163363479.3423.8.camel@w100>
Content-Type: multipart/mixed;
 boundary="------------040203050109070307000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203050109070307000408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Alonso wrote:
> OK, after adding the printk line I can start seeing
> results.
> 
> I guess it has been close to 10 on quite a few
> occasions.
..
> # grep qstor /var/log/messages
> Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
> Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=1
> Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
> Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=1
> Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=2
..
> On Sun, 2006-11-12 at 00:09 -0500, Mark Lord wrote:
>> Alberto Alonso wrote:
>>> The saga continues. It happened again this morning even with the
>>> patch:
>> ..
>>>> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
>>>> Try this patch (attached) and report back.
>> Did you add the printk() to the patch, as suggested?
..

Excellent!

So, either we have a very noisy bit of hardware in there,
or something is wrong with sata_qstor.c.

The device has two methods for dealing with commands.
Regular R/W uses the driver's host queue "packet" interface,
and all other commands pass through the legacy MMIO mechanism.

I'm betting on some bug/interaction with the latter.

Try this patch and see what happens, on top of the printk patch.

Thanks




--------------040203050109070307000408
Content-Type: text/x-patch;
 name="qstor_check_status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qstor_check_status.patch"

--- linux/drivers/scsi/sata_qstor.c.printk	2006-11-06 09:50:02.000000000 -0500
+++ linux/drivers/scsi/sata_qstor.c	2006-11-13 09:25:49.000000000 -0500
@@ -431,6 +431,7 @@
 		if (ap &&
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
+			u8 status = ata_check_status(ap);
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
 				continue;
@@ -438,7 +439,7 @@
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 
 				/* check main status, clearing INTRQ */
-				u8 status = ata_check_status(ap);
+				//u8 status = ata_check_status(ap);
 				if ((status & ATA_BUSY))
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",

--------------040203050109070307000408--
