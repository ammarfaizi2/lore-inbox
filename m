Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbVIAVhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVIAVhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVIAVhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:37:45 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:36052 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030407AbVIAVho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:37:44 -0400
Message-ID: <4317749E.3020109@cosmosbay.com>
Date: Thu, 01 Sep 2005 23:37:34 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec
 values
References: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
In-Reply-To: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :
> All,
> 	I recently ran into a bug with an older kernel where xtime's tv_nsec
> field had accumulated more then 2 seconds worth of time. The timespec's
> tv_nsec is a signed long, however gettimeofday() treats it as an
> unsigned long. Thus when the failure occured, very strange and difficult
> to debug time problems occurred.
> 
> The main cause of the problem I was seeing is already fixed in mainline,
> however just to be safe, I figured the following patch would be wise.
> 
> I only audited i386 and x86_64, however other arches probably could have
> similar signed problems as well.
> 
> Please let me know if you have any further comments or feedback.

What happens on i386 when/if more than 4 seconds accumulate ?
That should happens too.
Maybe the real fix is elsewhere ?

> 
> thanks
> -john
> 
> linux-2.6.13_signed-tv_nsec_A0.patch
> ====================================
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -824,7 +824,7 @@ static void update_wall_time(unsigned lo
>  	do {
>  		ticks--;
>  		update_wall_time_one_tick();
> -		if (xtime.tv_nsec >= 1000000000) {
> +		if ((unsigned long)xtime.tv_nsec >= 1000000000) {
>  			xtime.tv_nsec -= 1000000000;
>  			xtime.tv_sec++;
>  			second_overflow();
> 

maybe here a :

while ((unsigned long)xtime.tv_nsec >= 1000000000) {
	xtime.tv_nsec -= 1000000000;
	xtime.tv_sec++;
	second_overflow();
	...
	}


Eric
