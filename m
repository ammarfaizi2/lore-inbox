Return-Path: <linux-kernel-owner+w=401wt.eu-S1750940AbXAFAIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXAFAIq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXAFAIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:08:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:42569 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXAFAIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=a4Q8NZFjFjO4KDsD4ZGxWtdbiy84e+HGcJXINaVd4Q80MJmJtJpO45v5s8PvIDY0uTu07sIRYGW+9QFwC+qGuAQAej9RFbX1azl700YKHb3QiU2IOsV2WTNv6A3WSR/rqB3G4X5nIX56jsOEK0cQjOzHBSagCWx/lgsDwjh3nNg=
Date: Sat, 6 Jan 2007 02:08:32 +0200
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO code cleanups
Message-ID: <20070106000831.GB24091@Ahmed>
Mail-Followup-To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 	struct tty_ldisc *ld;
>-	int ret = 0;
> 	
> 	spin_lock_irqsave(&tty_ldisc_lock, flags);
> 	ld = &tty->ldisc;
>-	if(test_bit(TTY_LDISC, &tty->flags))
>-	{
>+	if(test_bit(TTY_LDISC, &tty->flags)) {
> 		ld->refcount++;
>-		ret = 1;
>+		return 1;
> 	}
> 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
>-	return ret;
>+	return 0;
> }

Very sorry, Didn't mention the spin_unlock_irqrestore().
Here's the modified patch without this hunk.

Signed-off-by: Ahmed S. Darwish

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 47a6eac..9da9537 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -331,7 +331,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_struct *tty, size_t size)
 	p->next = NULL;
 	p->commit = 0;
 	p->read = 0;
-	p->char_buf_ptr = (char *)(p->data);
+	p->char_buf_ptr = (char *)p->data;
 	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
 	tty->buf.memory_used += size;
 	return p;
@@ -640,7 +640,6 @@ static struct tty_ldisc tty_ldiscs[NR_LDISCS];	/* line disc dispatch table */
 int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc)
 {
 	unsigned long flags;
-	int ret = 0;
 	
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
@@ -652,7 +651,7 @@ int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc)
 	tty_ldiscs[disc].refcount = 0;
 	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(tty_register_ldisc);
 
@@ -1932,19 +1931,16 @@ static int init_dev(struct tty_driver *driver, int idx,
 	}
 
 	if (!*tp_loc) {
-		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						GFP_KERNEL);
+		tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 		if (!tp)
 			goto free_mem_out;
 		*tp = driver->init_termios;
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						 GFP_KERNEL);
+		ltp = kzalloc(sizeof(struct ktermios), GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
-		memset(ltp, 0, sizeof(struct ktermios));
 	}
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY) {
@@ -1965,19 +1961,16 @@ static int init_dev(struct tty_driver *driver, int idx,
 		}
 
 		if (!*o_tp_loc) {
-			o_tp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_tp)
 				goto free_mem_out;
 			*o_tp = driver->other->init_termios;
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_ltp = kzalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
-			memset(o_ltp, 0, sizeof(struct ktermios));
 		}
 
 		/*
@@ -3605,9 +3598,8 @@ struct tty_driver *alloc_tty_driver(int lines)
 {
 	struct tty_driver *driver;
 
-	driver = kmalloc(sizeof(struct tty_driver), GFP_KERNEL);
+	driver = kzalloc(sizeof(struct tty_driver), GFP_KERNEL);
 	if (driver) {
-		memset(driver, 0, sizeof(struct tty_driver));
 		driver->magic = TTY_DRIVER_MAGIC;
 		driver->num = lines;
 		/* later we'll move allocation of tables here */
@@ -3667,10 +3659,9 @@ int tty_register_driver(struct tty_driver *driver)
 		return 0;
 
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
-		p = kmalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
+		p = kzalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
-		memset(p, 0, driver->num * 3 * sizeof(void *));
 	}
 
 	if (!driver->major) {

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
