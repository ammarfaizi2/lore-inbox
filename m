Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270185AbTGMJJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270186AbTGMJJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:09:26 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:50701 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270185AbTGMJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:09:25 -0400
Date: Sun, 13 Jul 2003 10:24:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Three drivers/i2c/ patches
Message-ID: <20030713102407.A24901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Dittmer <j.dittmer@portrix.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <3F107F0F.40701@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F107F0F.40701@portrix.net>; from j.dittmer@portrix.net on Sat, Jul 12, 2003 at 11:35:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN -X exclude linux-bk/drivers/i2c/i2c-elektor.c 2.5.75-bk1/drivers/i2c/i2c-elektor.c
> --- linux-bk/drivers/i2c/i2c-elektor.c	Sun Jun 15 14:04:13 2003
> +++ 2.5.75-bk1/drivers/i2c/i2c-elektor.c	Sat Jul 12 11:51:34 2003
> @@ -59,6 +59,8 @@
>    need to be rewriten - but for now just remove this for simpler reading */
>  
>  static wait_queue_head_t pcf_wait;
> +
> +spinlock_t pcf_pending_lock = SPIN_LOCK_UNLOCKED;
>  static int pcf_pending;
>  
>  /* ----- global defines -----------------------------------------------	*/
> @@ -120,12 +122,12 @@
>  	int timeout = 2;
>  
>  	if (irq > 0) {
> -		cli();
> +		spin_lock_irq(&pcf_pending_lock);
>  		if (pcf_pending == 0) {
>  			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
>  		} else
>  			pcf_pending = 0;
> -		sti();
> +		spin_unlock_irq(&pcf_pending_lock);

Sleeping with interrupts disabled and a spinlock held still isn't exactly
a good idea.  As is sleep_on..

