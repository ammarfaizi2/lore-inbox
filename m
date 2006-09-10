Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWIJLRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIJLRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 07:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWIJLRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 07:17:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44239 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750875AbWIJLQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 07:16:59 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 10 Sep 2006 13:15:33 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes + nodemgr patches -- INFO: trying
 to register non-static key (the code is fine but needs lockdep annotation).
To: Miles Lane <miles.lane@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-scsi@vger.kernel.org
In-Reply-To: <a44ae5cd0609072006p627fb127g62949c62a5bfc6c2@mail.gmail.com>
Message-ID: <tkrat.ae0a49a0374e41e2@s5r6.in-berlin.de>
References: <a44ae5cd0609072006p627fb127g62949c62a5bfc6c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Sep, Miles Lane wrote to linux-kernel:
[...]
> ieee1394: sbp2: aborting sbp2 command
> scsi 0:0:0:0:
>         command: cdb[0]=0x12: 12 00 00 00 24 00
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
>  [<c1003d3a>] dump_trace+0x64/0x1a2
>  [<c1003e8a>] show_trace_log_lvl+0x12/0x25
>  [<c1004164>] show_trace+0xd/0x10
>  [<c100417e>] dump_stack+0x17/0x19
>  [<c1038b9c>] __lock_acquire+0x11d/0xa07
>  [<c1039763>] lock_acquire+0x5e/0x7f
>  [<c11e53b2>] _spin_lock_irq+0x1f/0x2e
>  [<c11e3967>] wait_for_completion_timeout+0x2c/0xb9
>  [<f902f441>] scsi_send_eh_cmnd+0x20a/0x318 [scsi_mod]
>  [<f902f573>] scsi_eh_tur+0x24/0x4c [scsi_mod]
>  [<f902fc29>] scsi_error_handler+0x1b2/0x599 [scsi_mod]
>  [<c1032b1d>] kthread+0xc4/0xf3
>  [<c10039d3>] kernel_thread_helper+0x7/0x10
> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[...]


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: SCSI: lockdep annotation in scsi_send_eh_cmnd

Fixup for lockdep enabled kernels: Annotate an on-stack completion.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.18-rc6-mm1/drivers/scsi/scsi_error.c
===================================================================
--- linux-2.6.18-rc6-mm1.orig/drivers/scsi/scsi_error.c	2006-08-28 21:33:31.000000000 +0200
+++ linux-2.6.18-rc6-mm1/drivers/scsi/scsi_error.c	2006-09-10 12:43:51.000000000 +0200
@@ -466,7 +466,7 @@ static int scsi_send_eh_cmnd(struct scsi
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
 	int old_result = scmd->result;
-	DECLARE_COMPLETION(done);
+	DECLARE_COMPLETION_ONSTACK(done);
 	unsigned long timeleft;
 	unsigned long flags;
 	unsigned char old_cmnd[MAX_COMMAND_SIZE];


