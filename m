Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbUJWOD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUJWOD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUJWOD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:03:27 -0400
Received: from relay03.pair.com ([209.68.5.17]:39941 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261191AbUJWODY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:03:24 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417A64AB.5010606@cybsft.com>
Date: Sat, 23 Oct 2004 09:03:23 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <41798BD6.6060207@cybsft.com> <20041023103247.GE30270@elte.hu>
In-Reply-To: <20041023103247.GE30270@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Oct 22 14:37:14 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
>>Oct 22 14:37:14 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
>>Oct 22 14:37:14 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
>>Oct 22 14:37:14 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
>>Oct 22 14:37:14 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
>>Oct 22 14:37:14 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
>>Oct 22 14:37:14 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
> 
> 
> does the patch below fix these?
> 
> 	Ingo
> 

I will try reproducing it here (at home). Otherwise it'll have to wait 
till Monday.

> --- linux/net/802/psnap.c.orig
> +++ linux/net/802/psnap.c
> @@ -55,7 +55,7 @@ static int snap_rcv(struct sk_buff *skb,
>  		.type = __constant_htons(ETH_P_SNAP),
>  	};
>  
> -	rcu_read_lock();
> +	rcu_read_lock_spin(&snap_lock);
>  	proto = find_snap_client(skb->h.raw);
>  	if (proto) {
>  		/* Pass the frame on. */
> @@ -68,7 +68,7 @@ static int snap_rcv(struct sk_buff *skb,
>  		rc = 1;
>  	}
>  
> -	rcu_read_unlock();
> +	rcu_read_unlock_spin(&snap_lock);
>  	return rc;
>  }
>  
> 

