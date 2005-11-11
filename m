Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVKKXI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVKKXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKKXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:08:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:45780 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751368AbVKKXI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:08:27 -0500
Subject: Re: [PATCH] TPM: cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcel Selhorst <selhorst@crypto.rub.de>, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr
In-Reply-To: <1131739863.5048.18.camel@localhost.localdomain>
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
	 <4360B889.1010502@crypto.rub.de>
	 <1130422052.4839.134.camel@localhost.localdomain>
	 <20051027145535.0741b647.akpm@osdl.org>
	 <1131739863.5048.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 17:08:53 -0600
Message-Id: <1131750533.5048.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > b) user_reader_timeout does down() from within a timer handler!  That's
> >    deadlocky and is illegal - timer handlers are run from interrupt
> >    context.
> > 
> >    This should have generated a storm of runtime warnings if tested with
> >    CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP.  Developers really should
> >    enable all the kernel debug options during development - they find bugs.
> > 
> >    Suggest you convert this to using schedule_work() or
> >    schedule_delayed_work(). 
> > 
> I'll look into this.

Addressed this timer/interrupt/spinlock issue with schedule_work.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -urpN --exclude='*.o' --exclude='*.ko' --exclude='*.orig' --exclude='*mod*' --exclude='.*' --exclude='tpm_*' --exclude='*~' --exclude='*.rej' linux-2.6.14/drivers/char/tpm/tpm.c linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.14/drivers/char/tpm/tpm.c	2005-11-11 14:09:47.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.c	2005-11-11 15:40:34.000000000 -0600
@@ -43,6 +43,13 @@ static void user_reader_timeout(unsigned
 {
 	struct tpm_chip *chip = (struct tpm_chip *) ptr;
 
+	schedule_work(&chip->work);
+}
+
+static void timeout_work(void * ptr)
+{
+	struct tpm_chip *chip = (struct tpm_chip*) ptr;
+
 	down(&chip->buffer_mutex);
 	atomic_set(&chip->data_pending, 0);
 	memset(chip->data_buffer, 0, TPM_BUFSIZE);
@@ -527,6 +535,8 @@ int tpm_register_hardware(struct device 
 	init_MUTEX(&chip->tpm_mutex);
 	INIT_LIST_HEAD(&chip->list);
 
+	INIT_WORK(&chip->work, timeout_work, chip);
+
 	init_timer(&chip->user_read_timer);
 	chip->user_read_timer.function = user_reader_timeout;
 	chip->user_read_timer.data = (unsigned long) chip;
diff -urpN --exclude='*.o' --exclude='*.ko' --exclude='*.orig' --exclude='*mod*' --exclude='.*' --exclude='tpm_*' --exclude='*~' --exclude='*.rej' linux-2.6.14/drivers/char/tpm/tpm.h linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.h
--- linux-2.6.14/drivers/char/tpm/tpm.h	2005-11-11 16:44:23.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.h	2005-11-11 15:39:03.000000000 -0600
@@ -77,6 +77,7 @@ struct tpm_chip {
 	struct semaphore buffer_mutex;
 
 	struct timer_list user_read_timer;	/* user needs to claim result */
+	struct work_struct work;
 	struct semaphore tpm_mutex;	/* tpm is processing */
 
 	struct tpm_vendor_specific *vendor;


