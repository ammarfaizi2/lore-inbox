Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVIAUYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVIAUYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVIAUYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:24:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58053 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030214AbVIAUYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:24:39 -0400
Date: Thu, 1 Sep 2005 22:22:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, ncunningham@cyclades.com,
       Pavel Machek <pavel@ucw.cz>, Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
Message-ID: <20050901202246.GB2027@openzaurus.ucw.cz>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor> <1125557333.12996.76.camel@localhost> <Pine.SOC.4.61.0509011030430.3232@math.ut.ee> <4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost> <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx> <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Hmm.  Looking at that bug report it specifies 2.6.11.  Does this
> >>problem really happen in 2.6.13?
> >>
> >>  
> >>
> >
> > I first noticed it in 2.6.11. It was fixed sometime during 2.6.13-rc
> > only to be killed of again in 2.6.13-rc7. The bugzilla now has a patch
> > for 2.6.13 which fixes the problem again.
> 
> Thanks.
> 
> This is clearly a code path I missed when I was fixing things.
> 
> When I made the final acpi change I checked for any other users
> of device_suspend and it seems I was blind and missed this one.
> Looking again...
> 
> The patch in the bug report looks correct.  However it is still
> a little incomplete.  In particular the reboot notifier is not
> being called, and since not everything has been converted into
> using shutdown methods that could lead to some other inconsistent
> behavior.
> 
> Does anyone have any problems with the patch below?
> If not I will send this off to Linus..

Yes. kernel_suspend is *way* too generic name.  kernel_suspend_off? kernel_powe_off_suspend?

> @@ -420,6 +421,15 @@ void kernel_power_off(void)
>  }
>  EXPORT_SYMBOL_GPL(kernel_power_off);
>  
> +int kernel_suspend(void)
> +{
> +	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
> +	system_state = SYSTEM_POWER_OFF;
> +	device_shutdown();
> +	return pm_ops->enter(PM_SUSPEND_DISK);
> +}
> +EXPORT_SYMBOL_GPL(kernel_suspend);
> +

Are you sure pm_ops exists in !CONFIG_PM case?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

