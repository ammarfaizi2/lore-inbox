Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTLaMkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLaMkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:40:19 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:54144 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264396AbTLaMkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:40:10 -0500
Date: Wed, 31 Dec 2003 13:40:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031231124032.GA367@ucw.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031230195303.F13556@flint.arm.linux.org.uk> <20031230230028.GA778@ucw.cz> <200312302045.38501.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312302045.38501.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 08:45:35PM -0500, Dmitry Torokhov wrote:
> On Tuesday 30 December 2003 06:00 pm, Vojtech Pavlik wrote:
> > On Tue, Dec 30, 2003 at 07:53:03PM +0000, Russell King wrote:
> > > So it looks like i8042 could do with hooking some power management
> > > to disable this timer before suspend and resume it afterwards.
> > >
> > > Vojtech?
> >
> > Agreed. There should already be some in -mm kernels, and I'll make sure
> > the timer is deleted before suspend. Thanks for finding this.
> 
> What about something like the patch below? (Now, I don't suspend my notebook
> so it has not been tested, just compiled.)
> 
> Dmitry
> 

I like it, see comments.

> +/*
> + * Do not add extra 'i8042.' prefix to all parameters if compiled into the kernel
> + */
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX /* empty */
> +
>  static unsigned int i8042_noaux;
>  module_param(i8042_noaux, bool, 0);

Well, I think it might be cleaner to just drop the i8042_ prefix and go
with the "i8042." prefix if that's the 2.6 way. It'll annoy a couple
people, but's it's the way to go in the future.

> -	i8042_ctr = i8042_initial_ctr;
> -
> -	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
> -		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
> +static int i8042_controller_suspend(void)
> +{
> +	del_timer_sync(&i8042_timer);
> +	i8042_controller_reset();
>  
> +	return 0;
>  }

Ok here we remove the timer.

> +/*
> + * Restart timer (for autorepeats)
> + */ 
> +	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>  

Note it's not for autorepeats. It's for problems with characters stuck
in the controller (like if the mouse sends a byte and the interface is
not enabled, blocking the controller indefinitely), we poll the
controller now and then making sure no characters are forgotten there.

> - * Resume handler for the new PM scheme (driver model)
> + * Suspend/resume handlers for the new PM scheme (driver model)
>   */
> +static int i8042_suspend(struct sys_device *dev, u32 state)
> +{
> +	return i8042_controller_suspend();
> +}
> +
>  static int i8042_resume(struct sys_device *dev)
>  {
>  	return i8042_controller_resume();
>  }
>  
>  static struct sysdev_class kbc_sysclass = {
> -       set_kset_name("i8042"),
> -       .resume = i8042_resume,
> +	set_kset_name("i8042"),
> +	.suspend = i8042_suspend,
> +	.resume = i8042_resume,
>  };

Good.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
