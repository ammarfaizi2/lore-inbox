Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWFGMot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFGMot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFGMot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:44:49 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:6727 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750701AbWFGMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:44:48 -0400
Message-ID: <4486CA3D.6000400@bigpond.net.au>
Date: Wed, 07 Jun 2006 22:44:45 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest> <448688B2.2030206@jp.fujitsu.com>
In-Reply-To: <448688B2.2030206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 7 Jun 2006 12:44:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAEDA Naoaki wrote:
> Peter Williams wrote:
> 
>> 4. Overhead Measurements.  To measure the implications for overhead
>> introduced by these patches kernbench was used on a dual 500Mhz
>> Centrino SMP system.  Runs were done for a kernel without these
>> patches applied, one with the patches applied but no caps being used
>> and one with the patches applied and running kernbench with a soft cap
>> of zero (which would be inherited by all its children).
>>
>> Average Optimal -j 8 Load Run:
>>
>>                   Vanilla          Patch Applied    Soft Cap 0%
>>
>> Elapsed Time      1056.1   (1.92)  1048.2   (0.62)  1064.1   (1.59)
>> User Time         1908.1   (1.09)  1895.2   (1.30)  1926.6   (1.39)
>> System Time        181.7   (0.60)   177.5   (0.74)   173.8   (1.07)
>> Percent CPU        197.6   (0.55)   197.0   (0)      197.0   (0)
>> Context Switches 49253.6 (136.31) 48881.4  (92.03) 92490.8 (163.71)
>> Sleeps           28038.8 (228.11) 28136.0 (250.65) 25769.4 (280.40)
> 
> I tried to run kernbench with hard cap, and then it spent a very
> long time on "Cleaning souce tree..." phase. Because this phase
> is not CPU hog, my expectation is that it act as without cap.
> 
> That can be reproduced by just running "make clean" on top of a
> kernel source tree with hard cap.
> 
> % /usr/bin/time make clean
> 1.62user 0.29system 0:01.90elapsed 101%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+68539minor)pagefaults 0swaps
> 
>   # Without cap, it returns almost immediately
> 
> % ~/withcap.sh  -C 900 /usr/bin/time make clean
> 1.61user 0.29system 1:26.17elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
> 
>   # With 90% hard cap, it takes about 1.5 minutes.

This is harder capping than I would expect.  I'll look into probable 
causes.  It could be caused by the simplification I made to the 
calculation of sinbin time.

> 
> % ~/withcap.sh  -C 100 /usr/bin/time make clean
> 1.64user 0.34system 3:31.48elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+68538minor)pagefaults 0swaps
> 
>   # It became worse with 10% hard cap.

And so it should.

> 
> % ~/withcap.sh  -c 900 /usr/bin/time make clean
> 1.63user 0.28system 0:01.89elapsed 100%CPU (0avgtext+0avgdata 
> 0maxresident)k
> 0inputs+0outputs (0major+68537minor)pagefaults 0swaps
> 
>   # It doesn't happen with soft cap.

That's because soft caps allow you to go over the cap if no other tasks 
want the CPU.

Thanks for the feedback,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
