Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268038AbTBMNgl>; Thu, 13 Feb 2003 08:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTBMNgl>; Thu, 13 Feb 2003 08:36:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21257 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268038AbTBMNgk>; Thu, 13 Feb 2003 08:36:40 -0500
Date: Thu, 13 Feb 2003 14:46:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030213134630.GB27708@atrey.karlin.mff.cuni.cz>
References: <200302091407.PAA14076@kim.it.uu.se> <20030210110108.GE2838@atrey.karlin.mff.cuni.cz> <20030210115034.GF22600@compsoc.man.ac.uk> <20030210200606.GE154@elf.ucw.cz> <20030211111231.GG53481@compsoc.man.ac.uk> <20030211120059.GB892@elf.ucw.cz> <15947.41003.250547.617866@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15947.41003.250547.617866@kim.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is my modified version of Pavel's latest patch to convert
> apm/apic/nmi to the driver model. It's a minimalistic patch,

It looks good.

> intendended ONLY to convert the old-fashioned PM support code
> to the driver model. It seems to work for me, except that
> initiating a suspend (via apm --suspend) triggers a BUG_ON
> somewhere in ide-disk.c, which prevents the suspend and causes a
> hang at shutdown.

If you want to workaround that hang, 

> @@ -1263,6 +1264,11 @@
>  		}
>  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
>  	}
> +
> +	device_suspend(3, SUSPEND_NOTIFY);
> +	device_suspend(3, SUSPEND_SAVE_STATE);
Kill these two lines ^

> +	device_suspend(3, SUSPEND_DISABLE);
> +
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
>  
> @@ -1283,6 +1289,8 @@
>  	if (err != APM_SUCCESS)
>  		apm_error("suspend", err);
>  	err = (err == APM_SUCCESS) ? 0 : -EIO;
> +	device_resume(RESUME_RESTORE_STATE);
This line ^

> +	device_resume(RESUME_ENABLE);
>  	pm_send_all(PM_RESUME, (void *)0);
>  	queue_event(APM_NORMAL_RESUME, NULL);
>   out:
> @@ -1396,6 +1404,8 @@
>  				write_seqlock_irq(&xtime_lock);
>  				set_time();
>  				write_sequnlock_irq(&xtime_lock);
> +				device_resume(RESUME_RESTORE_STATE);
And this line ^.

Its not right thing to do, but it should make it work for you.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
