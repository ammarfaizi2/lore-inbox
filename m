Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUHDWF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUHDWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHDWF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:05:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:65470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267378AbUHDWFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:05:16 -0400
Date: Wed, 4 Aug 2004 15:07:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Howard <ghoward@sgi.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6.8-rc2-mm2] More Altix system controller changes
Message-Id: <20040804150715.55e4f6aa.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.58.0408031041220.10767@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0408031041220.10767@gallifrey.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Howard <ghoward@sgi.com> wrote:
>
> Hi Andrew,
> 
> Here's an update to the Altix system conroller communication driver.
> It incorporates some suggestions Christoph made about the last patch
> and fixes a couple of config files.  It's based on 2.6.8-rc2-mm2.
> 
> ...
> -	depends on CONFIG_IA64_SGI_SN2
> +	depends on IA64_SGI_SN2

oop, sorry.

> +scdrv_interrupt(int irq, void *subch_data, struct pt_regs *regs)
> ...
> +	struct subch_data_s *sd = (struct subch_data_s *) subch_data;

Please don't typecast void*'s in this manner: if someone were to change the
type of subch_data, this typecast would cause the useful warning to be
suppressed.


> +	if (status > 0) {
> +		if (status & SAL_IROUTER_INTR_RECV) {
> +			wake_up_all(&sd->sd_rq);
> +		}

Why wake_up_all()?  I think wake_up() is the appropriate function here?

> @@ -396,16 +273,25 @@ scdrv_write(struct file *file, const cha
> 
>  	/* if we failed, and we want to block, then loop */
>  	while (status <= 0) {
> +		DECLARE_WAITQUEUE(wait, current);
> +
>  		if (file->f_flags & O_NONBLOCK) {
>  			spin_unlock(&sd->sd_wlock);
>  			return -EAGAIN;
>  		}
> -		if (scdrv_wait(&sd->sd_wq, &sd->sd_wlock, flags, 1000) < 0) {
> -			/* something went wrong with wait */
> +
> +		add_wait_queue(&sd->sd_wq, &wait);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		spin_unlock_irqrestore(&sd->sd_wlock, flags);
> +
> +		schedule_timeout(SCDRV_TIMEOUT);
> +
> +		remove_wait_queue(&sd->sd_wq, &wait);
> +		if (signal_pending(current)) {
> +			/* wait was interrupted */
>  			return -ERESTARTSYS;

hmm, if a signal is pending, scdrv_write() will return with the sd->sd_wbs
semaphore still held.  Dead driver, yes?


