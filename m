Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275958AbTHOMzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275975AbTHOMzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:55:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25484 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S275958AbTHOMzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:55:05 -0400
Date: Fri, 15 Aug 2003 14:54:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815125459.GA15600@ucw.cz>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16188.54799.675256.608570@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:46:07PM +1000, Neil Brown wrote:
> On Friday August 15, vojtech@suse.cz wrote:
> > 
> > My proposed solution is to do an input_report_key(pressed) immediately
> > followed by input_report_key(released) for these keys straight in
> > atkbd.c. Possibly based on some flag in the scancode->keycode table for
> > that scancode.
> 
> Something like this?
> 
> I use bit 32 in the keycode setting to mean "don't expect an 'up'
> event".
> It seems to work (though some of the keys actually generate 'down'
> events for both the down and up transitions, so it seems that the key
> is pressed twice. 

Now that is suspicious. This smells of some scancode mangling happening.
Can you try with i8042_direct=1? And with both i8042_direct=1 and atkbd_set=3? 

> I'm happy that that is just a buggy keyboard and I
> can work around it).
> 
> NeilBrown
> 
> 
>  ----------- Diffstat output ------------
>  ./drivers/input/evdev.c          |   13 ++++++++++---
>  ./drivers/input/keyboard/atkbd.c |    7 +++++++
>  ./include/linux/input.h          |    1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff ./drivers/input/evdev.c~current~ ./drivers/input/evdev.c
> --- ./drivers/input/evdev.c~current~	2003-08-15 21:31:47.000000000 +1000
> +++ ./drivers/input/evdev.c	2003-08-15 21:35:00.000000000 +1000
> @@ -233,15 +233,22 @@ static int evdev_ioctl(struct inode *ino
>  		case EVIOCGKEYCODE:
>  			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
>  			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
> -			if (put_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
> +			u = (dev->keycode_noup && test_bit(t, dev->keycode_noup)) ? (1<<31) : 0;
> +			if (put_user(u | INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
>  			return 0;
>  
>  		case EVIOCSKEYCODE:
>  			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
>  			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
>  			u = INPUT_KEYCODE(dev, t);
> -			if (get_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
> -
> +			if (get_user(i, ((int *) arg) + 1)) return -EFAULT;
> +			INPUT_KEYCODE(dev, t) = i;
> +			if (dev->keycode_noup) {
> +				if (i & (1<<31))
> +					set_bit(t, dev->keycode_noup);
> +				else
> +					clear_bit(t, dev->keycode_noup);
> +			}
>  			for (i = 0; i < dev->keycodemax; i++)
>  				if(INPUT_KEYCODE(dev, t) == u) break;
>  			if (i == dev->keycodemax) clear_bit(u, dev->keybit);
> 
> diff ./drivers/input/keyboard/atkbd.c~current~ ./drivers/input/keyboard/atkbd.c
> --- ./drivers/input/keyboard/atkbd.c~current~	2003-08-15 21:35:00.000000000 +1000
> +++ ./drivers/input/keyboard/atkbd.c	2003-08-15 22:12:50.000000000 +1000
> @@ -112,6 +112,7 @@ static unsigned char atkbd_set3_keycode[
>  
>  struct atkbd {
>  	unsigned char keycode[512];
> +	unsigned long keycode_noup[NBITS(512)];
>  	struct input_dev dev;
>  	struct serio *serio;
>  	char name[64];
> @@ -198,6 +199,10 @@ static irqreturn_t atkbd_interrupt(struc
>  			input_regs(&atkbd->dev, regs);
>  			input_report_key(&atkbd->dev, atkbd->keycode[code], !atkbd->release);
>  			input_sync(&atkbd->dev);
> +			if (!atkbd->release && test_bit(code, atkbd->keycode_noup)) {
> +				input_report_key(&atkbd->dev, atkbd->keycode[code], 0);
> +				input_sync(&atkbd->dev);
> +			}
>  	}
>  
>  	atkbd->release = 0;
> @@ -512,6 +517,7 @@ static void atkbd_connect(struct serio *
>  	atkbd->dev.keycode = atkbd->keycode;
>  	atkbd->dev.keycodesize = sizeof(unsigned char);
>  	atkbd->dev.keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
> +	atkbd->dev.keycode_noup = atkbd->keycode_noup;
>  	atkbd->dev.event = atkbd_event;
>  	atkbd->dev.private = atkbd;
>  
> @@ -549,6 +555,7 @@ static void atkbd_connect(struct serio *
>  		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
>  	else
>  		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
> +	memset(atkbd->keycode_noup, 0, sizeof(atkbd->keycode_noup));
>  
>  	atkbd->dev.name = atkbd->name;
>  	atkbd->dev.phys = atkbd->phys;
> 
> diff ./include/linux/input.h~current~ ./include/linux/input.h
> --- ./include/linux/input.h~current~	2003-08-15 21:31:47.000000000 +1000
> +++ ./include/linux/input.h	2003-08-15 21:35:00.000000000 +1000
> @@ -778,6 +778,7 @@ struct input_dev {
>  	unsigned int keycodemax;
>  	unsigned int keycodesize;
>  	void *keycode;
> +	unsigned long *keycode_noup;
>  
>  	unsigned int repeat_key;
>  	struct timer_list timer;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
