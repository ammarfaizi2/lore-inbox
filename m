Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUFWWXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUFWWXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUFWWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:21:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:23509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbUFWWU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:20:27 -0400
Date: Wed, 23 Jun 2004 15:23:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert.Picco@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET driver
Message-Id: <20040623152304.6e107b09.akpm@osdl.org>
In-Reply-To: <40D9F925.2000304@pobox.com>
References: <200406181616.i5IGGECd003812@hera.kernel.org>
	<40D35740.8070206@pobox.com>
	<20040618145531.015fbc12.akpm@osdl.org>
	<40D37090.20909@pobox.com>
	<40D9F74A.9090508@hp.com>
	<40D9F925.2000304@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > I eliminated the request_irq brain damage, eliminated procfs support, 
> > made the check for FMODE_WRITE  in hpet_open and responded to a few 
> > other suggestions.
> 
> Thanks!  I'll look over it too.

Here's one fixlet against Robert's fixes:



- Need to set TASK_INTERRUPTIBLE before checking devp->hd_irqdata. 
  Otherwise the wakeup from hpet_interrupt() could be missed.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/hpet.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -puN drivers/char/hpet.c~hpet-fixes-fix drivers/char/hpet.c
--- 25/drivers/char/hpet.c~hpet-fixes-fix	Wed Jun 23 14:38:16 2004
+++ 25-akpm/drivers/char/hpet.c	Wed Jun 23 14:38:16 2004
@@ -196,7 +196,8 @@ hpet_read(struct file *file, char *buf, 
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
 
-	do {
+	for ( ; ; ) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(&hpet_lock);
 		data = devp->hd_irqdata;
 		devp->hd_irqdata = 0;
@@ -211,17 +212,14 @@ hpet_read(struct file *file, char *buf, 
 			retval = -ERESTARTSYS;
 			goto out;
 		}
-
-		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
-
-	} while (1);
+	}
 
 	retval = put_user(data, (unsigned long *)buf);
 	if (!retval)
 		retval = sizeof(unsigned long);
-      out:
-	current->state = TASK_RUNNING;
+out:
+	__set_current_state(TASK_RUNNING)
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
 
 	return retval;
_

