Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWERFUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWERFUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWERFUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:20:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbWERFUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:20:39 -0400
Date: Wed, 17 May 2006 22:20:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
Message-Id: <20060517222007.2b606b1b.akpm@osdl.org>
In-Reply-To: <20060515211506.783939000@gmail.com>
References: <20060515211229.521198000@gmail.com>
	<20060515211506.783939000@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> Implement a new force feedback interface, in which all non-driver-specific
> operations are separated to a common module. This module handles effect type
> validations, effect timers, locking, etc.
> 
> As a result, support is added for gain and envelope for memoryless devices,
> periodic => rumble conversion for memoryless devices and rumble => periodic
> conversion for devices with periodic support instead of rumble support. Also
> the effect memory of devices is not emptied if the root user opens and closes
> the device while another user is using effects. This module also obsoletes
> some flawed locking and timer code in few ff drivers.
> 
> The module is named ff-effects. If INPUT_FF_EFFECTS is enabled, the force
> feedback drivers and interfaces (evdev) will be depending on it.
> 
> Userspace interface is left unaltered.
> 

Nice-looking patches.

>
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

Making these static inline functions would deuglify them a bit.

> +static int input_ff_effect_access(struct input_dev *dev, int id, int override)
> +{
> +	struct ff_device *ff = dev->ff;
> +	if (id < dev->ff_effects_max && id >= 0 && test_bit(FF_EFFECT_USED, ff->effects[id].flags))

Kernel does have an 80-columns rule, but input seems to have always spurned it.

> +static int input_ff_envelope_time(struct ff_effect_status *effect, struct ff_envelope *envelope, unsigned long *event_time)
> +{
> +	unsigned long fade_start;
> +	if (!envelope)
> +		return 0;
> +
> +	if (envelope->attack_length && time_after(effect->play_at + msecs_to_jiffies(envelope->attack_length), effect->adj_at)) {

Try using an 80-column wondow for a while ;)

> +		return value;
> +	}
> +
> +	difference = abs(value) - envelope_level;
> +
> +	debug("difference = %d", difference);
> +	debug("time_from_level = 0x%x", time_from_level);
> +	debug("time_of_envelope = 0x%x", time_of_envelope);
> +	if (difference < 0)
> +		difference = -((-difference) * time_from_level / time_of_envelope);
> +	else
> +		difference = difference * time_from_level / time_of_envelope;

You've checked there's no possibility of divide-by-zero here?

> +
> +static int input_ff_safe_sum(int a, int b, int limit) {

The opening brace goes in column zero, please.

> +	int c;
> +	if (!a)
> +		return b;
> +	c = a + b;
> +	if (c > limit)
> +		return limit;
> +	return c;
> +}
> +
> +static s8 input_ff_s8_sum(int a, int b) {

dittoes.

> +	int c;
> +	c = input_ff_safe_sum(a, b, 0x7f);
> +	if (c < -0x80)
> +		return -0x80;
> +	return c;
> +}
>
> ...
>
> +static void input_ff_timer(unsigned long timer_data)
> +{
> +	struct input_dev *dev = (struct input_dev *) timer_data;
> +	struct ff_device *ff = dev->ff;
> +	struct ff_effect effect;
> +	int i;
> +	unsigned long flags;
> +	int effects_pending;
> +	unsigned long effect_handled[NBITS(FF_EFFECTS_MAX)];

DECLARE_BITMAP would be more usual.  (Yes, it should have been called
DEFINE_BITMAP).

> +	int effect_type;
> +	int safety;
> +
> +	debug("timer: updating effects");
> +
> +	spin_lock_irqsave(&ff->atomiclock, flags);
> +
> +	memset(effect_handled, 0, sizeof(effect_handled));

You could take the lock after the memset.

> +int input_ff_erase(struct input_dev *dev, int id)
> +{
> +	struct ff_device *ff;
> +	unsigned long flags = 0;
> +	int ret;
> +	if (!test_bit(EV_FF, dev->evbit))
> +		return -EINVAL;
> +	mutex_lock(&dev->ff_lock);
> +	ff = dev->ff;
> +	if (!ff) {
> +		mutex_unlock(&dev->ff_lock);
> +		return -ENODEV;
> +	}
> +	spin_ff_cond_lock(ff, flags);
> +	ret = _input_ff_erase(dev, id, current->pid == 0);
> +	spin_ff_cond_unlock(ff, flags);
> +
> +	mutex_unlock(&dev->ff_lock);
> +	return ret;
> +}

Perhaps you meant `current->uid == 0' here.  There's no way in which pid
0 will call this code.

What's happening here anyway?  Why does this code need to know about pids?

Checking for uid==0 woud be a fishy thing to do as well.

> +static int input_ff_flush(struct input_dev *dev, struct file *file)
> +{
> +	struct ff_device *ff;
> +	unsigned long flags = 0;
> +	int i;
> +	debug("flushing now");
> +	mutex_lock(&dev->ff_lock);
> +	ff = dev->ff;
> +	if (!ff) {
> +		mutex_unlock(&dev->ff_lock);
> +		return -ENODEV;
> +	}
> +	spin_ff_cond_lock(ff, flags);
> +	for (i = 0; i < dev->ff_effects_max; i++) {
> +		_input_ff_erase(dev, i, 0);
> +	}

Unneeded braces.

> +	spin_ff_cond_unlock(ff, flags);
> +	mutex_unlock(&dev->ff_lock);
> +	return 0;
> +}
> +
> +
> +		ff->effects[id].flags[0] = 0;
> +		ff->effects[id].effect = *effect;
> +
> +		if (ff->driver->playback) {
> +			if (!test_bit(effect->type, ff->flags))
> +				input_ff_convert_effect(dev, effect);
> +			ret = ff->driver->upload(dev, effect, NULL);
> +			if (!ret)
> +				set_bit(FF_EFFECT_USED, ff->effects[id].flags);
> +			mutex_unlock(&dev->ff_lock);
> +			return ret;
> +		}
> +		set_bit(FF_EFFECT_USED, ff->effects[id].flags);
> +
> +	} else {
> +		id = effect->id;
> +
> +		ret = input_ff_effect_access(dev, id, 1);
> +		if (ret) {
> +			spin_ff_cond_unlock(ff, flags);
> +			mutex_unlock(&dev->ff_lock);
> +			return ret;
> +		}
> +
> +		if (effect->type != ff->effects[id].effect.type ||
> +				  (effect->type == FF_PERIODIC && effect->u.periodic.waveform !=
> +				  ff->effects[id].effect.u.periodic.waveform)) {
> +			spin_ff_cond_unlock(ff, flags);
> +			mutex_unlock(&dev->ff_lock);
> +			return -EINVAL;
> +		}
> +
> +		if (ff->driver->playback) {
> +			if (!test_bit(effect->type, ff->flags))
> +				input_ff_convert_effect(dev, effect);
> +			ret = ff->driver->upload(dev, effect, &ff->effects[id].effect);
> +			ff->effects[id].effect = *effect;
> +			mutex_unlock(&dev->ff_lock);
> +			return ret;

I think we're missing a spin_ff_cond_unlock() here?

> +		}
> +		ff->effects[id].effect = *effect;
> +		clear_bit(FF_EFFECT_PLAYING, ff->effects[id].flags);
> +
> +	}
> +
> +	spin_unlock_irqrestore(&ff->atomiclock, flags);
> +	mutex_unlock(&dev->ff_lock);
> +	return ret;
> +}

And here we have spin_unlock_irqrestore() instead of spin_ff_cond_unlock().

It would be best to convert this function to have a single return point. 
That tends to prevent problems like this from happening, and from creeping
in later on.

> +int input_ff_allocate(struct input_dev *dev)
> +{
> +	debug("allocating device");
> +	mutex_lock(&dev->ff_lock);
> +	if (dev->ff)
> +		printk(KERN_ERR "ff-effects: allocating to non-NULL pointer\n");
> +	dev->ff = kzalloc(sizeof(*dev->ff), GFP_KERNEL);
> +	if (!dev->ff) {
> +		mutex_unlock(&dev->ff_lock);
> +		return -ENOMEM;
> +	}
> +	spin_lock_init(&dev->ff->atomiclock);
> +	init_timer(&dev->ff->timer);
> +	dev->ff->timer.function = input_ff_timer;
> +	dev->ff->timer.data = (unsigned long) dev;
> +	dev->ff->event = input_ff_event;

setup_timer()

> +	mutex_unlock(&dev->ff_lock);
> +	debug("ff allocated");
> +	return 0;
> +}
> +
>
> ...
>
> Index: linux-2.6.17-rc4-git1/drivers/input/Kconfig
> ===================================================================
> --- linux-2.6.17-rc4-git1.orig/drivers/input/Kconfig	2006-03-20 07:53:29.000000000 +0200
> +++ linux-2.6.17-rc4-git1/drivers/input/Kconfig	2006-05-14 02:28:42.000000000 +0300
> @@ -24,6 +24,14 @@ config INPUT
>  
>  if INPUT
>  
> +config INPUT_FF_EFFECTS
> +	tristate "Force feedback effects"
> +	help
> +	  Say Y here if you want to be able to play force feedback effects.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ff-effects.

hm.  I'd have expected more dependencies than this.

>  comment "Userland interfaces"
>  
>  config INPUT_MOUSEDEV
> @@ -110,6 +118,7 @@ config INPUT_TSDEV_SCREEN_Y
>  
>  config INPUT_EVDEV
>  	tristate "Event interface"
> +	depends on INPUT_FF_EFFECTS || INPUT_FF_EFFECTS=n

Isn't that always true?

> +
> +struct ff_effect_status {
> +	pid_t owner;

This code is almost devoid of comments.  Those which it does have tend to
cover little low-level implementation details.  But it's the *big* things
which a reader is not able to learn from the implementation, and which
should be commented.  Like: why on earth does this code need to know about
pids?

> +#if defined(CONFIG_INPUT_FF_EFFECTS_MODULE) || defined(CONFIG_INPUT_FF_EFFECTS)

No, we shouldn't use CONFIG_FOO_MODULE.  We just don't know at compile-time
whether the user will later compile and insert a particular module.

> +		mutex_lock(&dev->ff_lock);
> +		del_timer_sync(&ff->timer);
> +		dev->flush = NULL;
> +		dev->ff = NULL;
> +		kfree(ff);
> +		mutex_unlock(&dev->ff_lock);

The kfree can be moved outside the lock.


