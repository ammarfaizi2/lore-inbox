Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWAEN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWAEN64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWAEN64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:58:56 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:6060 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750706AbWAEN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:58:55 -0500
Subject: Re: oops pauser.
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105045212.GA15789@redhat.com>
References: <20060105045212.GA15789@redhat.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 08:58:53 -0500
Message-Id: <1136469533.21485.91.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments:
1. I think this is a good idea, since serial consoles can also change
timings.  I have seen several race conditions where the problem goes
away once I add a serial console.
2. Should this be a separate debugging option?
3. Shouldn't you have KERN____ in your printk statements?
4. Wouldn't printing out the message every second make the oops scroll
off the screen, defeating the purpose of the patch?

Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

On Wed, 2006-01-04 at 23:52 -0500, Dave Jones wrote:
> In my quest to get better debug data from users in Fedora bug reports,
> I came up with this patch.  A majority of users don't have serial
> consoles, so when an oops scrolls off the top of the screen,
> and locks up, they usually end up reporting a 2nd (or later) oops
> that isn't particularly helpful (or worse, some inconsequential
> info like 'sleeping whilst atomic' warnings)
> 
> With this patch, if we oops, there's a pause for a two minutes..
> which hopefully gives people enough time to grab a digital camera
> to take a screenshot of the oops.
> 
> It has an on-screen timer so the user knows what's going on,
> (and that it's going to come back to life [maybe] after the oops).
> 
> The one case this doesn't catch is the problem of oopses whilst
> in X. Previously a non-fatal oops would stall X momentarily,
> and then things continue. Now those cases will lock up completely
> for two minutes. Future patches could add some additional feedback
> during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- vanilla/arch/i386/kernel/traps.c	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15/arch/i386/kernel/traps.c	2006-01-04 23:42:46.000000000 -0500
> @@ -256,6 +271,15 @@ void show_registers(struct pt_regs *regs
>  		}
>  	}
>  	printk("\n");
> +	{
> +		int i;
> +		for (i=120;i>0;i--) {
> +			mdelay(1000);
> +			touch_nmi_watchdog();
> +			printk("Continuing in %d seconds. \r", i);
> +		}
> +		printk("\n");
> +	}
>  }	
>  
>  static void handle_BUG(struct pt_regs *regs)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

