Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbRFGOlf>; Thu, 7 Jun 2001 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbRFGOlZ>; Thu, 7 Jun 2001 10:41:25 -0400
Received: from i0563.vwr.wanadoo.nl ([194.134.210.54]:7552 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S262658AbRFGOlP>; Thu, 7 Jun 2001 10:41:15 -0400
Date: Thu, 7 Jun 2001 16:41:22 +0200
From: Remi Turk <remi@a2zis.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010607164122.A815@localhost.localdomain>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200106071100.NAA11961@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106071100.NAA11961@harpo.it.uu.se>; from mikpe@csd.uu.se on Thu, Jun 07, 2001 at 01:00:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 01:00:15PM +0200, Mikael Pettersson wrote:
> On Wed, 6 Jun 2001 22:42:53 +0200, Remi Turk wrote:
> 
> Try the patch below. Reboot. Run 'apm -S' (or --standby) at the
> console. Did you see output from both send_event and apic_pm_callback?
> If so, repeat by pressing your power-switch-as-standby button. You
> should see the same output -- if not, something APM-related is broken.

apm --standby works fine now:
	send_event: event 9
	apic_pm_callback: rqst 0 data 3
	nmi_pm_callback: rqst 0 data 3
and on resume:
	send_event: event 11
	apic_pm_callback: rqst 1 data 0
	nmi_pm_callback: rqst 1 data 0

apm --suspend also does what it should (and already did):
	send_event: event 10
	apic_pm_callback: rqst 0 data 3
	nmi_pm_callback: rqst 0 data 3
and on resume:
	send_event: event 3
	apic_pm_callback: rqst 1 data 0
	nmi_pm_callback: rqst 1 data 0

My "standbybutton" still hardlocks however.
Should I dig up some more info about my mainboard/BIOS?

> FYI, the patch below to apm.c:send_event() [w/o the printk] prevents
> my ASUS P3B-F from hanging hard if I invoke apm standby in a UP-APIC
> enabled kernel. (Actually, standby doesn't do much on my box since
> it wakes up after 1 second or so. I don't know why, perhaps a hub->nic
> link beat? 'suspend' works ok, however. Oh, and I have to disable
Try "sleep 2; apm --standby" or paste the newline with your mouse.
It works for me - my keyboard probably still sends data when my
system is already going into standby.

> RedHat's worthless 'kudzu' crap, otherwise 'suspend' won't work.)
It slows down booting a few seconds, and besides, I usually
know it when I add hardware, so kudzu is one of the first
packages I remove when installing.

> 
> /Mikael
>
>  	case APM_USER_SUSPEND:
> +	case APM_SYS_STANDBY:
> +	case APM_USER_STANDBY:
>  		/* map all suspends to ACPI D3 */
>  		if (pm_send_all(PM_SUSPEND, (void *)3)) {
>  			if (event == APM_CRITICAL_SUSPEND) {
> @@ -932,6 +935,7 @@
>  		break;
>  	case APM_NORMAL_RESUME:
>  	case APM_CRITICAL_RESUME:
> +	case APM_STANDBY_RESUME:
>  		/* map all resumes to ACPI D0 */

It locked when suspending so I don't expect the added
"case APM_STANDBY_RESUME" to make any difference.
printk() doesn't seem to be logical too, and I tried the
"case APM_SYS_STANDBY" and "case APM_SYS_SUSPEND" yesterday
(didn't make a difference) so it looks like the mdelay()
does it.

-- 
Linux 2.4.6-pre1 #1 Wed Jun 6 18:25:37 CEST 2001
