Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUI1IDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUI1IDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUI1IDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 04:03:07 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:2978 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267633AbUI1IDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 04:03:00 -0400
Message-ID: <4159177F.7030803@yahoo.com.au>
Date: Tue, 28 Sep 2004 17:49:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu
Subject: Re: Stack traces in 2.6.9-rc2-mm4
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net> <20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es> <20040928072123.GA15177@elte.hu>
In-Reply-To: <20040928072123.GA15177@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * J.A. Magallon <jamagallon@able.es> wrote:
> 
> 
>>I got the same on another place...
>>
>>Sep 28 00:48:51 werewolf kernel: using smp_processor_id() in preemptible 
>>code: X/4012
>>Sep 28 00:48:51 werewolf kernel:  [smp_processor_id+135/141] 
>>smp_processor_id+0x87/0x8d
>>Sep 28 00:48:51 werewolf kernel:  [add_timer_randomness+314/365] 
>>add_timer_randomness+0x13a/0x16d
>>Sep 28 00:48:51 werewolf kernel:  [<b0206733>] 
>>add_timer_randomness+0x13a/0x16d
>>Sep 28 00:48:51 werewolf kernel:  [input_event+85/999] 
>>input_event+0x55/0x3e7
> 
> 
> the one below should fix this: a certain codepath in the random driver
> relied on vt_ioctl() being under the BKL and implicitly disabling
> preemption. The code wasnt buggy upstream but it's slighly unrobust so i
> think we want the fix upstream too, independently of the remove-bkl
> patch. This change has been in the -VP patchset for some time so it
> should work fine.
> 
> 	Ingo
> 
> --- linux/drivers/char/random.c.orig	
> +++ linux/drivers/char/random.c	
> @@ -807,10 +807,11 @@ static void add_timer_randomness(struct 
>  	long		delta, delta2, delta3;
>  	int		entropy = 0;
>  
> +	preempt_disable();
>  	/* if over the trickle threshold, use only 1 in 4096 samples */
>  	if ( random_state->entropy_count > trickle_thresh &&
>  	     (__get_cpu_var(trickle_count)++ & 0xfff))
> -		return;
> +		goto out;
>  

It looks like upstream code *is* buggy because that is a non-atomic
RMW operation on the per-cpu var, no? Hence you must disable preempt.
