Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTIVNdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbTIVNdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:33:13 -0400
Received: from cibs9.sns.it ([192.167.206.29]:56590 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263147AbTIVNdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:33:07 -0400
Date: Mon, 22 Sep 2003 15:32:23 +0200 (CEST)
From: venom@sns.it
To: Kronos <kronos@kronoz.cjb.net>
cc: davej@codemonkey.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix Athlon MCA
In-Reply-To: <20030921143934.GA1867@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.43.0309221531220.20921-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing this message too on all my athlons, also if it seems harmless.
Will try this patch tomorrow.

bests

Luigi

On Sun, 21 Sep 2003, Kronos wrote:

> Date: Sun, 21 Sep 2003 16:39:34 +0200
> From: Kronos <kronos@kronoz.cjb.net>
> To: davej@codemonkey.org.uk
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] Fix Athlon MCA
>
> Hi,
> on boot I'm seeing a lot of messages like this:
>
> MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
> Bank 0: d47fa0000000bfee
>
> This messages go away if I revert cset 1.1119.9.1. AFAIK you were trying
> to decrease the logging level. After reading IA32 Architecture Software
> Developers Manual, vol3 - chapter 14.5 "Machine-Check Initialization" I
> think that the right way to do it is this:
>
> --- linux-2.6/arch/i386/kernel/cpu/mcheck/k7.c~	Sat Aug  9 06:37:27 2003
> +++ linux-2.6/arch/i386/kernel/cpu/mcheck/k7.c	Sun Sep 21 00:36:39 2003
> @@ -81,8 +81,9 @@
>  		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>  	nr_mce_banks = l & 0xff;
>
> -	for (i=1; i<nr_mce_banks; i++) {
> -		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
> +	for (i=0; i<nr_mce_banks; i++) {
> +		if (i)
> +			wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
>  		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
>  	}
>
>
> We really want to clean all MC*_STATUS. I'm currently running linux 2.6.0-t5
> + this patch and I don't see the MCE messages on boot anymore.
>
> Luca
> --
> Reply-To: kronos@kronoz.cjb.net
> Home: http://kronoz.cjb.net
> "L'abilita` politica e` l'abilita` di prevedere quello che
>  accadra` domani, la prossima settimana, il prossimo mese e
>  l'anno prossimo. E di essere cosi` abili, piu` tardi,
>  da spiegare  perche' non e` accaduto."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

