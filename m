Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUKUMRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUKUMRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 07:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUKUMRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 07:17:47 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:4226 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261643AbUKUMRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 07:17:44 -0500
Message-ID: <41A08765.7030402@ribosome.natur.cuni.cz>
Date: Sun, 21 Nov 2004 13:17:41 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041114
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	 <4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	 <20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	 <20041114170339.GB13733@dualathlon.random>	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>	 <419CD8C1.4030506@ribosome.natur.cuni.cz>	 <20041118131655.6782108e.akpm@osdl.org>	 <419D25B5.1060504@ribosome.natur.cuni.cz>	 <419D2987.8010305@cyberone.com.au>	 <419D383D.4000901@ribosome.natur.cuni.cz>	 <20041118160824.3bfc961c.akpm@osdl.org>	 <419E821F.7010601@ribosome.natur.cuni.cz>	 <1100946207.2635.202.camel@thomas> <419F2AB4.30401@ribosome.natur.cuni.cz>	 <1100957349.2635.213.camel@thomas>	 <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas>
In-Reply-To: <1101037999.23692.5.camel@thomas>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Sat, 2004-11-20 at 22:19 +0100, Martin MOKREJ© wrote:
> 
>>>It should only kill RNAsubopt and bash and touch nothing else.
>>
>>Yes, that's true, this patch has helped. Actually the other xterm got
>>closed, but that's because bash is the controlling application of it.
>>I believe that's expected.
>>
>>I'd prefer to get only RNAsubopt killed. ;) 
> 
> 
> Ok. To kill only RNAsubopt it might be neccecary to refine the criteria
> in the whom to kill selection.

Why can't the algorithm first find the asking for memory now.
When found, kernel should kill first it's children, wait some time,
then kill this process if still exists (it might exit itself when children
get closed).

You have said it's safer to kill that to send ENOMEM as happens
in 2.4, but I still don't undertand why kernel first doesn't send
ENOMEM, and only if that doesn't help it can start after those 5 seconds
OOM killer, and try to kill the very same application.
I don't get the idea why to kill immediately.

As it has happened to me in the past, that random OOM selection has killed
sshd or init, I believe the algorithm should be improved to not to try
to kill these. First of all, sshd is well tested, so it will never
be source of memleaks. Second, if the algorithm would really insist on
killing either of these, I personally prefer it rather do clean reboot
than a system in a state without sshd. I have to get to the console.
Actually, it's several kilometers for me. :(

> 
> 
>>And still, there weren't
>>that many changes to memory management between 2.6.9-rc1 and 2.6.9-rc2. ;)
>>I can test those VM changes separately, if someone would provide me with
>>those changes split into 2 or 3 patchsets.
> 
> 
> The oom trouble was definitly not invented there. The change between
> 2.6.9-rc1 and rc2 is justs triggering your special testcase.
> 
> Other testcases show the problems with earlier 2.6 kernels too.

It's a pitty no-one has time to at least figure out why those changes have
exposed this stupid random part of the algorithm. Before 2.6.9-rc2
OOM killer was also started in my tests, but it worked deterministically.
I wouldn't prefer extra algorithm to check what we kill now, I'd rather look
why we kill randomly since -rc2.

Of course your patch is still helpfull, sure.
Martin


