Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280449AbRJaTwK>; Wed, 31 Oct 2001 14:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280450AbRJaTwA>; Wed, 31 Oct 2001 14:52:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19329 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280449AbRJaTvn>; Wed, 31 Oct 2001 14:51:43 -0500
Date: Wed, 31 Oct 2001 14:52:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0110312017460.29808-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.3.95.1011031143513.21250A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Tim Schmielau wrote:

> > > I would say that the race is so rare that it should not be handled,
> > > especially since it adds extra code in the timer interrupt.
> >
> 
> The expensive code in the timer interupt will be executed every
> 497.1 days, so that's bearable.

The expensive code in the timer interrupt will be executed every
timer interrupt! There is no magic way to connect two 32-bit long-words
to make a 64-bit object, no matter how well it's hidden by the 'C'
compiler. An increment of the low long-word won't magically bump the
high long-word. This takes code, and the simplist code to do it was
shown. This:
	adcl	$1,(jiffies)	# INCL won't set CY  4 clocks
	adcl	$0,(jiffies_hi) #                    4 clocks
... takes 8 clocks.
	This:
	incl	(jiffies)
... takes 2 clocks

Also gcc isn't as "kind" as this. It generates volumes of strange
code to bump a 'long long'.

That's 6 extra clocks every Hz or 600 clocks per second. By the time
you've reached the 497.1 days, you have wasted.... 0xffffffff/6 =
715,827,882 CPU clocks just so 'uptime' is correct?  I don't think
so. I'd reboot.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


