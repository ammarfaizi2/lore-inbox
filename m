Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbRHHTQB>; Wed, 8 Aug 2001 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268566AbRHHTPw>; Wed, 8 Aug 2001 15:15:52 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:46092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268564AbRHHTPh>; Wed, 8 Aug 2001 15:15:37 -0400
Date: Wed, 8 Aug 2001 12:14:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Mike Kravetz <mkravetz@sequent.com>, Hubertus Franke <frankeh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable Scheduling
In-Reply-To: <0108082106010A.00351@starship>
Message-ID: <Pine.LNX.4.33.0108081205240.867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Daniel Phillips wrote:
>
> write:
>
> 	inline int nr_running(void)
> 	{
> 	#ifdef CONFIG_SMP
> 		int i = 0, tot=nt_running(REALTIME_RQ);
> 		while (i < smp_num_cpus) {
> 			tot += nt_running(cpu_logical_map(i++));
> 		}
> 		return(tot);
> 	#else
> 		return nr_running;
> 	#endif
> 	}


Even more preferably, just have (in a header file)

	#ifdef CONFIG_SMP

	inline int nr_running(void)
	{
		...
	}

	.. other SMP cases ..

	#else

	#define nr_running() (__nr_running)

	.. other UP cases ..

	#endif

if you just cannot make an efficient function that just works for both.

No, we don't adhere to this everywhere. But we should (and largely _do_)
try to.

Having the #ifdef's outside the code tends to have two advantages:

 - it makes the code much more readable, and doesn't split things up.

 - you have to choose your abstraction interfaces more carefully, which in
   turn tends to make for better code.

Abstraction is nice - _especially_ when you have a compiler that sees
through the abstraction and can generate code as if it wasn't there.

		Linus

