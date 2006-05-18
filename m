Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWESBgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWESBgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWESBgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:36:11 -0400
Received: from e-nvb.com ([69.27.17.200]:19423 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932217AbWESBgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:36:10 -0400
Subject: Re: + input-new-force-feedback-interface.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: anssi.hannula@gmail.com, dtor_core@ameritech.net
In-Reply-To: <200605180446.k4I4kFxs007658@shell0.pdx.osdl.net>
References: <200605180446.k4I4kFxs007658@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 16:44:01 +0200
Message-Id: <1147963441.2866.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 21:46 -0700, akpm@osdl.org wrote:
> +
> +#ifdef DEBUG
> +#define debug(format, arg...) printk(KERN_DEBUG "ff-effects: " format "\n" , ## arg)
> +#else
> +#define debug(format, arg...) do {} while (0)
> +#endif

please just use the existing prdebug() thing for this, no need to invent
your own ;)

> +
> +EXPORT_SYMBOL(input_ff_allocate);
> +EXPORT_SYMBOL(input_ff_register);
> +EXPORT_SYMBOL(input_ff_upload);
> +EXPORT_SYMBOL(input_ff_erase);

should these be _GPL exports?


> +
> +#define spin_ff_cond_lock(_ff, _flags)					  \
> +	do {								  \
> +		if (!_ff->driver->playback)				  \
> +			spin_lock_irqsave(&_ff->atomiclock, _flags);	  \
> +	} while (0);
> +
> +#define spin_ff_cond_unlock(_ff, _flags)					  \
> +	do {								  \
> +		if (!_ff->driver->playback)				  \
> +			spin_unlock_irqrestore(&_ff->atomiclock, _flags); \
> +	} while (0);


hmmm conditional locking like this always makes me very nervous... what
is preventing ->playback from changing halfway a locked sequence?

> +	if (!events) {
> +		debug("no actions");
> +		del_timer(&ff->timer);

are you really sure you don't need del_timer_sync() here?



> +static void input_ff_timer(unsigned long timer_data)
> +{
> +	struct input_dev *dev = (struct input_dev *) timer_data;
> +	struct ff_device *ff = dev->ff;
> +	struct ff_effect effect;
> +	int i;
> +	unsigned long flags;
> +	int effects_pending;
> +	unsigned long effect_handled[NBITS(FF_EFFECTS_MAX)];


hmmm stack space?

> +		} else {
> +			ret = -ENOSYS;

that is almost always a wrong return value
> +	if (test_bit(FF_CONSTANT, dev->ff->flags))
> +		set_bit(FF_CONSTANT, dev->ffbit);
> +	if (test_bit(FF_SPRING, dev->ff->flags))
> +		set_bit(FF_SPRING, dev->ffbit);
> +	if (test_bit(FF_FRICTION, dev->ff->flags))
> +		set_bit(FF_FRICTION, dev->ffbit);
> +	if (test_bit(FF_DAMPER, dev->ff->flags))
> +		set_bit(FF_DAMPER, dev->ffbit);
> +	if (test_bit(FF_INERTIA, dev->ff->flags))

are you really sure you need atomic set_bit()'s here??
if so.. I think you have a race ;)


