Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDISeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDISeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDISeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:34:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWDISeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:34:10 -0400
Date: Sun, 9 Apr 2006 11:32:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, James.Bottomley@SteelEye.com
Subject: Re: 2.6.17-rc1-mm2: badness in 3w_xxxx driver
Message-Id: <20060409113240.630b9a24.akpm@osdl.org>
In-Reply-To: <20060409182306.GA4680@nickolas.homeunix.com>
References: <20060409182306.GA4680@nickolas.homeunix.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Orlov <bugfixer@list.ru> wrote:
>
> The following patch: x86-kmap_atomic-debugging.patch exposed a badness
> in 3w_xxx driver.

Sweet, thanks.

> I'm getting a lot of:
> 
> Apr  9 13:00:04 nickolas kernel: kmap_atomic: local irqs are enabled while using KM_IRQn
> Apr  9 13:00:04 nickolas kernel:  <c0104103> show_trace+0x13/0x20   <c010412e> dump_stack+0x1e/0x20
> Apr  9 13:00:04 nickolas kernel:  <c01159c9> kmap_atomic+0x79/0xe0   <c028b885> tw_transfer_internal+0x85/0xa0
> Apr  9 13:00:04 nickolas kernel:  <c028ca7e> tw_interrupt+0x3fe/0x820   <c0143b9e> handle_IRQ_event+0x3e/0x80
> Apr  9 13:00:04 nickolas kernel:  <c0143c70> __do_IRQ+0x90/0x100   <c01057a6> do_IRQ+0x26/0x40
> Apr  9 13:00:04 nickolas kernel:  <c010396e> common_interrupt+0x1a/0x20   <c0101cdd> cpu_idle+0x4d/0xb0
> Apr  9 13:00:04 nickolas kernel:  <c010f2cc> start_secondary+0x24c/0x4b0   <00000000> 0x0
> Apr  9 13:00:04 nickolas kernel:  <c214ffb4> 0xc214ffb4  
> 
> I'm running 32 bit kernel on AMD64x2 w/ HIGHMEM enabled.
> I think this is an old bug since the 3w_xxxx.c has not been changed for
> a long time (at least since 2.6.16-rc1-mm4).
> 
> Please let me know if you want me to try some patches.
> 


From: Andrew Morton <akpm@osdl.org>

We must disable local IRQs while holding KM_IRQ0 or KM_IRQ1.  Otherwise, an
IRQ handler could use those kmap slots while this code is using them,
resulting in memory corruption.

Thanks to Nick Orlov <bugfixer@list.ru> for reporting.

Cc: <linuxraid@amcc.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/scsi/3w-xxxx.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/scsi/3w-xxxx.c~3ware-kmap_atomic-fix drivers/scsi/3w-xxxx.c
--- devel/drivers/scsi/3w-xxxx.c~3ware-kmap_atomic-fix	2006-04-09 11:28:08.000000000 -0700
+++ devel-akpm/drivers/scsi/3w-xxxx.c	2006-04-09 11:29:21.000000000 -0700
@@ -1508,10 +1508,12 @@ static void tw_transfer_internal(TW_Devi
 	struct scsi_cmnd *cmd = tw_dev->srb[request_id];
 	void *buf;
 	unsigned int transfer_len;
+	unsigned long flags = 0;
 
 	if (cmd->use_sg) {
 		struct scatterlist *sg =
 			(struct scatterlist *)cmd->request_buffer;
+		local_irq_save(flags);
 		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 		transfer_len = min(sg->length, len);
 	} else {
@@ -1526,6 +1528,7 @@ static void tw_transfer_internal(TW_Devi
 
 		sg = (struct scatterlist *)cmd->request_buffer;
 		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+		local_irq_restore(flags);
 	}
 }
 
_

