Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVCNRS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVCNRS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCNRS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:18:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9891 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261631AbVCNRSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:18:39 -0500
Date: Mon, 14 Mar 2005 18:18:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>, paul.devriendt@amd.com
Cc: davej@codemonkey.org.uk, linux@brodo.de, linux-kernel@vger.kernel.org
Subject: Re: PowerNow-K8 and Winchester CPUs
Message-ID: <20050314171805.GA7865@elf.ucw.cz>
References: <20050314162426.GA2598@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314162426.GA2598@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Paul, can you comment on this one? I know that pn-k8 logic is quite
tricky... And BIOS tables are often wrong.
								Pavel

> I have a machine with an Athlon64 with a Winchester core. It has a max
> frequency of 2GHz, vid 0x6. The maximum vid allowed is 0x4. It has an
> intermediate vid 0x8. RVO is 3.
> 
> When transitioning (phase1) from vid 0x8 to vid 0x6, it first increases
> the vid to 6, and then proceeds increasing it three more steps. This of
> course fails, because it overflows the maximum allowed vid 0x4.
> 
> My first attempt to fix this was to limit the vid to the max vid while
> doing the rvo bump-up.
> 
> However, I believe that the real reason for the problem is that the
> condition to start doing the rvo bump is wrong.
> 
> This patch should fix it:
> 
> diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> --- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-03-14 17:20:17 +01:00
> +++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-03-14 17:20:17 +01:00
> @@ -286,7 +286,7 @@
>  			return 1;
>  	}
>  
> -	while ((rvosteps > 0)  && ((data->rvo + data->currvid) > reqvid)) {
> +	while ((rvosteps > 0) && ((data->currvid - data->rvo) > reqvid)) {
>  		if (data->currvid == 0) {
>  			rvosteps = 0;
>  		} else {
> 
> if I understand the original intent of the second test in the while()
> statement. 
> 
> Any comments? Is my understanding of that bit of code correct?
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
