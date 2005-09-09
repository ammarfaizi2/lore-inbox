Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbVIIAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbVIIAhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVIIAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:37:11 -0400
Received: from fsmlabs.com ([168.103.115.128]:20378 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S965093AbVIIAhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:37:10 -0400
Date: Thu, 8 Sep 2005 17:43:48 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix i386 condition to call nmi_watchdog_tick
In-Reply-To: <432076F302000078000244B8@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.63.0509081052300.8052@r3000.fsmlabs.com>
References: <432076F302000078000244B8@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Jan Beulich wrote:

> diff -Npru 2.6.13/arch/i386/kernel/traps.c
> 2.6.13-i386-watchdog-active/arch/i386/kernel/traps.c
> --- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
> +0200
> +++
> 2.6.13-i386-watchdog-active/arch/i386/kernel/traps.c	2005-09-01
> 14:04:35.000000000 +0200
> @@ -611,7 +611,7 @@ static void default_do_nmi(struct pt_reg
>  		 * Ok, so this is none of the documented NMI sources,
>  		 * so it must be the NMI watchdog.
>  		 */
> -		if (nmi_watchdog) {
> +		if (nmi_watchdog && nmi_active > 0) {
>  			nmi_watchdog_tick(regs);
>  			return;
>  		}

I dislike this patch, and it's not your fault. The reason being is that 
there are a few systems (i have one such) which always reports "CPU stuck" 
during watchdog setup but then eventually the watchdog starts ticking 
during runtime. Unfortunately if this gets in you'll get lots of the 
following;

Uhhuh. NMI received for unknown reason 00 on CPU 1.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Uhhuh. NMI received for unknown reason 21 on CPU 0.

So, before the patch can go in, the "CPU stuck" systems probably need 
looking at. Since i have one, i'll have a look.

Thanks,
	Zwane

Ps. why is NMI watchdog perpetually broken?
