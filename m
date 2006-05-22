Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWEVQMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWEVQMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWEVQMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:12:49 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:43499 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750911AbWEVQMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:12:49 -0400
Message-ID: <4471E2F6.1040709@gmail.com>
Date: Mon, 22 May 2006 19:12:38 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: + input-new-force-feedback-interface.patch added to -mm tree
References: <200605180446.k4I4kFxs007658@shell0.pdx.osdl.net> <1147963441.2866.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1147963441.2866.5.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-05-17 at 21:46 -0700, akpm@osdl.org wrote:
> 
>>+
>>+#ifdef DEBUG
>>+#define debug(format, arg...) printk(KERN_DEBUG "ff-effects: " format "\n" , ## arg)
>>+#else
>>+#define debug(format, arg...) do {} while (0)
>>+#endif
> 
> 
> please just use the existing prdebug() thing for this, no need to invent
> your own ;)

Couldn't find any info on that one, are you sure you spelled it correctly?

> 
>>+
>>+EXPORT_SYMBOL(input_ff_allocate);
>>+EXPORT_SYMBOL(input_ff_register);
>>+EXPORT_SYMBOL(input_ff_upload);
>>+EXPORT_SYMBOL(input_ff_erase);
> 
> 
> should these be _GPL exports?
> 

Well, I don't know. When should EXPORT_SYMBOLs be EXPORT_SYMBOL_GPLs?

> 
>>+
>>+#define spin_ff_cond_lock(_ff, _flags)					  \
>>+	do {								  \
>>+		if (!_ff->driver->playback)				  \
>>+			spin_lock_irqsave(&_ff->atomiclock, _flags);	  \
>>+	} while (0);
>>+
>>+#define spin_ff_cond_unlock(_ff, _flags)					  \
>>+	do {								  \
>>+		if (!_ff->driver->playback)				  \
>>+			spin_unlock_irqrestore(&_ff->atomiclock, _flags); \
>>+	} while (0);
> 
> 
> 
> hmmm conditional locking like this always makes me very nervous... what
> is preventing ->playback from changing halfway a locked sequence?

Well, it's never changed, locked or not. But maybe we can get rid of
this condlocking alltogether, see my reply for Andrew Morton.

> 
>>+	if (!events) {
>>+		debug("no actions");
>>+		del_timer(&ff->timer);
> 
> 
> are you really sure you don't need del_timer_sync() here?
> 

Yes, this function is also called from inside the timer in question and
del_timer_sync() would block.

> 
> 
>>+static void input_ff_timer(unsigned long timer_data)
>>+{
>>+	struct input_dev *dev = (struct input_dev *) timer_data;
>>+	struct ff_device *ff = dev->ff;
>>+	struct ff_effect effect;
>>+	int i;
>>+	unsigned long flags;
>>+	int effects_pending;
>>+	unsigned long effect_handled[NBITS(FF_EFFECTS_MAX)];
> 
> 
> 
> hmmm stack space?
> 

I count 76 bytes (x86), is that too much?

>>+		} else {
>>+			ret = -ENOSYS;
> 
> 
> that is almost always a wrong return value
> 

It's returned when the device is mem-capable but driver doesn't
implement set_gain() but sets FF_GAIN or when driver doesn't implement
set_autocenter() but sets FF_AUTOCENTER. But yes, if that happens, it's
a driver bug, so maybe this is not correct use for -ENOSYS. Probably
there should be BUG() too here.

>>+	if (test_bit(FF_CONSTANT, dev->ff->flags))
>>+		set_bit(FF_CONSTANT, dev->ffbit);
>>+	if (test_bit(FF_SPRING, dev->ff->flags))
>>+		set_bit(FF_SPRING, dev->ffbit);
>>+	if (test_bit(FF_FRICTION, dev->ff->flags))
>>+		set_bit(FF_FRICTION, dev->ffbit);
>>+	if (test_bit(FF_DAMPER, dev->ff->flags))
>>+		set_bit(FF_DAMPER, dev->ffbit);
>>+	if (test_bit(FF_INERTIA, dev->ff->flags))
> 
> 
> are you really sure you need atomic set_bit()'s here??
> if so.. I think you have a race ;)

Well, I'm not. Is there an alternative?


-- 
Anssi Hannula

