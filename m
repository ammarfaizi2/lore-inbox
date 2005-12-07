Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVLGTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVLGTUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVLGTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:20:04 -0500
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:20372 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S964838AbVLGTUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:20:02 -0500
X-ORBL: [70.231.141.47]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:
	references:mime-version:content-type;
	b=JHtPi3Bh9XKPuRATthw/Wp57030nCjquBO4BTjLamGr7dHky8RrVketN6PG3P06Vy
	r4LmgP/xD0oQLJo/FqnKA==
Date: Wed, 7 Dec 2005 11:19:22 -0800 (PST)
From: Jeff Collins <jgcc@pacbell.net>
X-X-Sender: jgcc@sitka.jgcc.dyndns.org
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Clemens Koller <clemens.koller@anagramm.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <Pine.LNX.4.64.0512060900290.13220@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.63.0512071116420.5515@sitka.jgcc.dyndns.org>
References: <433A747E.3070705@anagramm.de> <4394260F.7020703@anagramm.de>
 <Pine.LNX.4.64.0512051246130.13220@montezuma.fsmlabs.com> <43957B94.1070604@anagramm.de>
 <Pine.LNX.4.64.0512060900290.13220@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, my PII Xeon 4 cpu system reaches the 
state of "Powered Down" and stops. (Running Slackware Linux 10.2
with 2.6.14.3 from kernel.org)

At this point, I can power off or hit the reset button
to restart.


Thank you for the patch.


Jeff

On Tue, 6 Dec 2005, Zwane Mwaikambo wrote:

> On Tue, 6 Dec 2005, Clemens Koller wrote:
>
>> Hello, Zwane!
>>
>>>> From what i hear it's this issue;
>>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=5203
>>
>> Yes it seems to be the same issue.
>> But who is Eric, mentioned in bugzilla? :-]
>> If it makes sense I can test his patch while/before he is pushing
>> it upstream.
>
> Eric is 'Eric Biederman', Jeff tested his patch but there appears to be a
> failure case when there is no power management callback installed. Could
> you please test the following patch?
>
> diff -r 3815424104b0 arch/i386/kernel/reboot.c
> --- a/arch/i386/kernel/reboot.c	Sat Dec  3 07:09:38 2005
> +++ b/arch/i386/kernel/reboot.c	Mon Dec  5 00:44:37 2005
> @@ -359,6 +359,10 @@
>
> 	if (pm_power_off)
> 		pm_power_off();
> -}
> -
> -
> +
> +	local_irq_disable();
> +	if (cpu_data[0].hlt_works_ok)
> +		while (1) halt();
> +	while (1);
> +}
> +
> diff -r 3815424104b0 arch/x86_64/kernel/reboot.c
> --- a/arch/x86_64/kernel/reboot.c	Sat Dec  3 07:09:38 2005
> +++ b/arch/x86_64/kernel/reboot.c	Mon Dec  5 00:44:37 2005
> @@ -159,5 +159,9 @@
> 	}
> 	if (pm_power_off)
> 		pm_power_off();
> +
> +	local_irq_disable();
> +	while (1)
> +		halt();
> }
>
>
