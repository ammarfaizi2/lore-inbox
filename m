Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCTIWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCTIWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWCTIWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:22:12 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47070 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932222AbWCTIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:22:12 -0500
Date: Mon, 20 Mar 2006 09:22:08 +0100
Message-Id: <200603200822.k2K8M8i29761@inv.it.uc3m.es>
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: gmane.linux.kernel
In-Reply-To: <20060320061212.GG21493@w.ods.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060320061212.GG21493@w.ods.org> you wrote:
> On Sun, Mar 19, 2006 at 11:33:17AM -0800, Linus Torvalds wrote:
>> Of course, I shouldn't say "works", since it is still totally untested. It 
>> _looks_ good, and that statement expression usage is just _so_ ugly it's 
>> cute.

> #define for_each_cpu_mask(cpu, mask)			\
> 	for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++) {	\
> 		unsigned long __bits = (mask).bits[0] >> (cpu); \
> 		if (!__bits)				\
> 			break;				\
> 		if (!__bits & 1)			\
> 			continue;			\
> 		else

While that's slightly wrong (needs a closing } supplied by the user), it
does inspire me to point out that one can put the skips in the ordinary
statement part of the for and use the if else idea to make sure that the
for needs just one statement following (i.e.  no dangling } supplied by
the user)

#define for_each_cpu_mask(cpu, mask)                     \
        for ((cpu) = 0; (cpu) < NR_CPUS; (cpu)++)        \
            if (!((mask).bits[0] >> (cpu)) {             \
                break;                                   \   
            } else if (!((mask).bits[0] >> (cpu)) & 1) { \
                continue;                                \   
            } else

I expect common subexpression optimization in the compiler to remove the
repetition here.  If not, somebody else can think about it!




Peter
