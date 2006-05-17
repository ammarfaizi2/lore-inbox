Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWEQE7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWEQE7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEQE7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:59:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWEQE7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:59:46 -0400
Date: Tue, 16 May 2006 21:56:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
Message-Id: <20060516215610.2b822c00.akpm@osdl.org>
In-Reply-To: <446AAB3C.6050303@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
	<20060516190507.35c1260f.akpm@osdl.org>
	<446AAB3C.6050303@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
>
> Hello, Andrew.
> 
> Andrew Morton wrote:
> [--snip--]
> > [   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> > [   44.719425] ata2.00: ATAPI, max UDMA/66
> > [   44.765263] ata2.00: applying bridge limits
> > [   74.928836] ata2.01: qc timeout (cmd 0xa1)
> > [   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> > [   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> > [   75.468856] ata2.00: ATAPI, max UDMA/66
> > [   75.514678] ata2.00: applying bridge limits
> > [  105.674130] ata2.01: qc timeout (cmd 0xa1)
> 
> Did this device work with previous versions of kernel?

No.  In fact, it doesn't even work with the 2.6.17-rc4-mm1 lineup plus the
latest git-libata-all.  It needs this tweak:

--- devel/drivers/scsi/ata_piix.c~2.6.17-rc4-mm1-ich8-fix	2006-05-16 18:36:12.000000000 -0700
+++ devel-akpm/drivers/scsi/ata_piix.c	2006-05-16 18:36:12.000000000 -0700
@@ -542,6 +542,14 @@ static unsigned int piix_sata_probe (str
 		port = map[base + i];
 		if (port < 0)
 			continue;
+		if (ap->flags & PIIX_FLAG_AHCI) {
+			/* FIXME: Port status of AHCI controllers
+			 * should be accessed in AHCI memory space.  */
+			if (pcs & 1 << port)
+				present_mask |= 1 << i;
+			else
+				pcs &= ~(1 << port);
+		}
 		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
 			present_mask |= 1 << i;
 		else
_


> libata used to give up on the first failure during probe, so the boot 
> time would have been shorter in failure cases.

I don't recall anyone complaining?

>  I think controlled 
> retries during boot probe is a good thing, but the timeout of 30s for 
> IDENTIFY commands can be shortened, I guess.

We should do something, please.  It'll hurt kernel developers the most.
