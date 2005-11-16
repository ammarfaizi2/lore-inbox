Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbVKPWrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbVKPWrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbVKPWrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:47:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:14292 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030549AbVKPWrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:47:51 -0500
Subject: Re: [PATCH] TPM: cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcel Selhorst <selhorst@crypto.rub.de>, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr
In-Reply-To: <20051112134844.7f177e07.akpm@osdl.org>
References: <435FB8A5.803@crypto.rub.de> <435FBFC4.5060508@free.fr>
	 <4360B889.1010502@crypto.rub.de>
	 <1130422052.4839.134.camel@localhost.localdomain>
	 <20051027145535.0741b647.akpm@osdl.org>
	 <1131739863.5048.18.camel@localhost.localdomain>
	 <1131750533.5048.36.camel@localhost.localdomain>
	 <20051112134844.7f177e07.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:48:15 -0600
Message-Id: <1132181295.4872.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add the necessary flush_schedule_work calls when canceling the
timer.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

On Sat, 2005-11-12 at 13:48 -0800, Andrew Morton wrote:
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> >
> >  +	schedule_work(&chip->work);
> >  +}
> >  +
> >  +static void timeout_work(void * ptr)
> >  +{
> >  +	struct tpm_chip *chip = (struct tpm_chip*) ptr;
> >  +
> 
> I cannot see where the tpm driver stops that timer which it has running on
> device close or on module unload.
> 
> Wherever it is, we'll now also need a flush_scheduled_work() to avoid a race
> wherein the work handler is still executing while the module gets
> unloaded.
> 

---
diff -uprN --exclude='.*' --exclude='*~' --exclude='*.o' --exclude='*.ko' --exclude='*.rej' --exclude='*.orig' --exclude='*infineon*' --exclude='*nsc*' --exclude='*mod*' linux-2.6.14/drivers/char/tpm/tpm.c linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.c
--- linux-2.6.14/drivers/char/tpm/tpm.c	2005-11-15 15:42:10.000000000 -0600
+++ linux-2.6.14-rc4-tpm/drivers/char/tpm/tpm.c	2005-11-15 14:11:20.000000000 -0600
@@ -377,6 +377,7 @@ int tpm_release(struct inode *inode, str
 	file->private_data = NULL;
 	chip->num_opens--;
 	del_singleshot_timer_sync(&chip->user_read_timer);
+	flush_scheduled_work();
 	atomic_set(&chip->data_pending, 0);
 	put_device(chip->dev);
 	kfree(chip->data_buffer);
@@ -428,6 +429,7 @@ ssize_t tpm_read(struct file * file, cha
 	int ret_size;
 
 	del_singleshot_timer_sync(&chip->user_read_timer);
+	flush_scheduled_work();
 	ret_size = atomic_read(&chip->data_pending);
 	atomic_set(&chip->data_pending, 0);
 	if (ret_size > 0) {	/* relay data */


