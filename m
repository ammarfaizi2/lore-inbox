Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWCXWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWCXWRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCXWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:17:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751480AbWCXWRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:17:16 -0500
Date: Fri, 24 Mar 2006 14:19:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink_gt add gpio feature
Message-Id: <20060324141929.1fff0c15.akpm@osdl.org>
In-Reply-To: <1143216251.8513.3.camel@amdx2.microgate.com>
References: <1143216251.8513.3.camel@amdx2.microgate.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> Add driver support for general purpose I/O feature
> of the Synclink GT adapters.
> 
>  
> ...
>
>  /*
> + * conditional wait facility
> + */
> +struct cond_wait {
> +	struct cond_wait *next;
> +	wait_queue_head_t q;
> +	wait_queue_t wait;
> +	unsigned int data;
> +};
> +static void init_cond_wait(struct cond_wait *w, unsigned int data);
> +static void add_cond_wait(struct cond_wait **head, struct cond_wait *w);
> +static void remove_cond_wait(struct cond_wait **head, struct cond_wait *w);
> +static void flush_cond_wait(struct cond_wait **head);

Adding new generic-looking infrastructure into a driver is a worry.  Either
we're missing some facility, or the driver is doing something unnecessary
or the driver's requirements are unique.

Tell use more about conditional waits?

> ...
> +static int wait_gpio(struct slgt_info *info, struct gpio_desc __user *user_gpio)
> +{
> + 	unsigned long flags;
> +	int rc = 0;
> +	struct gpio_desc gpio;
> +	struct cond_wait wait;
> +	u32 state;
> +
> +	if (!info->gpio_present)
> +		return -EINVAL;
> +	if (copy_from_user(&gpio, user_gpio, sizeof(gpio)))
> +		return -EFAULT;
> +	DBGINFO(("%s wait_gpio() state=%08x smask=%08x\n",
> +		 info->device_name, gpio.state, gpio.smask));
> +	/* ignore output pins identified by set IODR bit */
> +	if ((gpio.smask &= ~rd_reg32(info, IODR)) == 0)
> +		return -EINVAL;
> +	init_cond_wait(&wait, gpio.smask);
> +
> +	spin_lock_irqsave(&info->lock, flags);
> +	/* enable interrupts for watched pins */
> +	wr_reg32(info, IOER, rd_reg32(info, IOER) | gpio.smask);
> +	/* get current pin states */
> +	state = rd_reg32(info, IOVR);
> +
> +	if (gpio.smask & ~(state ^ gpio.state)) {
> +		/* already in target state */
> +		gpio.state = state;
> +	} else {
> +		/* wait for target state */
> +		add_cond_wait(&info->gpio_wait_q, &wait);
> +		spin_unlock_irqrestore(&info->lock, flags);
> +		schedule();
> +		if (signal_pending(current))
> +			rc = -ERESTARTSYS;
> +		else
> +			gpio.state = wait.data;
> +		spin_lock_irqsave(&info->lock, flags);
> +		remove_cond_wait(&info->gpio_wait_q, &wait);
> +	}
> +
> +	/* disable all GPIO interrupts if no waiting processes */
> +	if (info->gpio_wait_q == NULL)
> +		wr_reg32(info, IOER, 0);

Should we be dong that write if rc!=0?  I guess so..

> +	spin_unlock_irqrestore(&info->lock,flags);
> +
> +	if ((rc == 0) && copy_to_user(user_gpio, &gpio, sizeof(gpio)))
> +		rc = -EFAULT;
> +	return rc;
> +}

