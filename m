Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbUJYVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUJYVUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUJYVI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:08:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262024AbUJYVBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:01:13 -0400
Date: Mon, 25 Oct 2004 23:01:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Alexander Batyrshin <abatyrshin@ru.mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025210135.GA28699@elte.hu>
References: <OF1ADC83B8.7696CB2F-ON86256F38.0066D6EA@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1ADC83B8.7696CB2F-ON86256F38.0066D6EA@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> BUG: sleeping function called from invalid context hdparm(3606) at
> kernel/mutex.c
> in_atomic():0 [00000000], irqs_disabled():1
> ... will send stack traceback separately ...
> when setting udma2 mode in hdparm.

i suspect the patch below will fix the hdparm message - but i dont think
it's related to the other problems you have reported. 

	Ingo

--- linux/drivers/ide/ide-iops.c.orig
+++ linux/drivers/ide/ide-iops.c
@@ -783,13 +783,11 @@ int ide_driveid_update (ide_drive_t *dri
 		printk("%s: CHECK for good STATUS\n", drive->name);
 		return 0;
 	}
-	local_irq_save(flags);
-	SELECT_MASK(drive, 0);
 	id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
-	if (!id) {
-		local_irq_restore(flags);
+	if (!id)
 		return 0;
-	}
+	local_irq_save(flags);
+	SELECT_MASK(drive, 0);
 	ata_input_data(drive, id, SECTOR_WORDS);
 	(void) hwif->INB(IDE_STATUS_REG);	/* clear drive IRQ */
 	local_irq_enable();
