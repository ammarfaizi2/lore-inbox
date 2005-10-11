Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVJKJor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVJKJor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVJKJor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:44:47 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:24455 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751438AbVJKJor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:44:47 -0400
Message-ID: <434B8915.3040706@cosmosbay.com>
Date: Tue, 11 Oct 2005 11:42:45 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>
Subject: Re: i386 spinlock fairness: bizarre test results
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
In-Reply-To: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 11 Oct 2005 11:42:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert a écrit :
>   After seeing Kirill's message about spinlocks I decided to do my own
> testing with the userspace program below; the results were very strange.
> 
>   When using the 'mov' instruction to do the unlock I was able to reproduce
> hogging of the spinlock by a single CPU even on Pentium II under some
> conditions, while using 'xchg' always allowed the other CPU to get the
> lock:
> 
> 
> parent CPU 1, child CPU 0, using mov instruction for unlock
> parent did: 34534 of 10000001 iterations
> CPU clocks:     2063591864
> 
> parent CPU 1, child CPU 0, using xchg instruction for unlock
> parent did: 5169760 of 10000001 iterations
> CPU clocks:     2164689784
> 
Hi Chuck

Thats interesting, because on my machines I get opposite results :

On a Xeon 2.0 GHz, Hyper Threading, I get better results (in the sense of 
fairness) with the MOV version

    parent CPU 1, child CPU 0, using mov instruction for unlock
    parent did: 5291346 of 10000001 iterations
    CPU clocks:     3.437.053.244

    parent CPU 1, child CPU 0, using xchg instruction for unlock
    parent did: 7732349 of 10000001 iterations
    CPU clocks:     3.408.285.308


On a dual Opteron 248 (2.2GHz) machine, I get bad fairness results regardless 
of MOV/XCHG (but less cycles per iteration). A lot of variations in the 
results (maybe because of NUMA effects ?), but xchg gives slightly better 
fairness.

    parent CPU 1, child CPU 0, using mov instruction for unlock
    parent did: 256810 of 10000001 iterations
    CPU clocks:      772.838.640

    parent CPU 1, child CPU 0, using xchg instruction for unlock
    parent did: 438280 of 10000001 iterations
    CPU clocks:     1.115.653.346

    parent CPU 1, child CPU 0, using xchg instruction for unlock
    parent did: 574501 of 10000001 iterations
    CPU clocks:     1.200.129.428


On a dual core Opteron 275 (2.2GHz), xchg is faster but unfair.

(threads running on the same physical CPU)
    parent CPU 1, child CPU 0, using mov instruction for unlock
    parent did: 4822270 of 10000001 iterations
    CPU clocks:      738.438.383

    parent CPU 1, child CPU 0, using xchg instruction for unlock
    parent did: 9702075 of 10000001 iterations
    CPU clocks:      561.457.724

Totally different results if affinity changed so that threads run on different 
physical cpus  : (XCHG is slower)

    parent CPU 0, child CPU 2, using mov instruction for unlock
    parent did: 1081522 of 10000001 iterations
    CPU clocks:      508.611.273

    parent CPU 0, child CPU 2, using xchg instruction for unlock
    parent did: 4310427 of 10000000 iterations
    CPU clocks:     1.074.170.246



For reference, if only one thread is running, the MOV version is also faster 
on both platforms :

[Xeon 2GHz]
    one thread, using mov instruction for unlock
    10000000 iterations
    CPU clocks:     1.278.879.528

[Xeon 2GHz]
    one thread, using xchg instruction for unlock
    10000000 iterations
    CPU clocks:     2.486.912.752

Of course Opterons are faster :) (less cycles per iteration)

[Opteron 248]
    one thread, using mov instruction for unlock
    10000000 iterations
    CPU clocks:      212.514.637

[Opteron 248]
    one thread, using xchg instruction for unlock
    10000000 iterations
    CPU clocks:      383.306.420

[Opteron 275]
    one thread, using mov instruction for unlock
    10000000 iterations
    CPU clocks:      208.472.009

[Opteron 275]
    one thread, using xchg instruction for unlock
    10000000 iterations
    CPU clocks:      417.502.675

In conclusion, I would say that for uncontended locks, MOV is faster. For 
contended locks, XCHG might be faster on some platforms (dual core Opterons, 
only if on the same physical CPU)

Eric

