Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUJUGiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUJUGiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270665AbUJUG1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:27:25 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54690
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270475AbUJTTjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:39:40 -0400
Subject: [PATCH] SCSI: Replace semaphore with completion
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, SCSI <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098300699.20821.68.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 21:31:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use completion instead of semaphore

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 2.6.9-bk-041020-thomas/drivers/scsi/sym53c8xx_2/sym_glue.c |    8
++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/scsi/sym53c8xx_2/sym_glue.c~sym53c8xx
drivers/scsi/sym53c8xx_2/sym_glue.c
---
2.6.9-bk-041020/drivers/scsi/sym53c8xx_2/sym_glue.c~sym53c8xx	2004-10-20
16:04:34.000000000 +0200
+++
2.6.9-bk-041020-thomas/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-10-20
16:04:50.000000000 +0200
@@ -135,7 +135,7 @@ m_addr_t __vtobus(m_pool_ident_t dev_dma
  *  It is allocated on the eh thread stack.
  */
 struct sym_eh_wait {
-	struct semaphore sem;
+	struct completion done;
 	struct timer_list timer;
 	void (*old_done)(struct scsi_cmnd *);
 	int to_do;
@@ -798,7 +798,7 @@ static void __sym_eh_done(struct scsi_cm
 
 	/* Wake up the eh thread if it wants to sleep */
 	if (ep->to_do == SYM_EH_DO_WAIT)
-		up(&ep->sem);
+		complete(&ep->done);
 }
 
 /*
@@ -858,7 +858,7 @@ prepare:
 	case SYM_EH_DO_IGNORE:
 		break;
 	case SYM_EH_DO_WAIT:
-		init_MUTEX_LOCKED(&ep->sem);
+		init_completion(&ep->done);
 		/* fall through */
 	case SYM_EH_DO_COMPLETE:
 		ep->old_done = cmd->scsi_done;
@@ -909,7 +909,7 @@ prepare:
 		ep->timed_out = 1;	/* Be pessimistic for once :) */
 		add_timer(&ep->timer);
 		spin_unlock_irq(np->s.host->host_lock);
-		down(&ep->sem);
+		wait_for_completion(&ep->done);
 		spin_lock_irq(np->s.host->host_lock);
 		if (ep->timed_out)
 			sts = -2;
_


