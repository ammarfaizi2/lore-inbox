Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWAUXGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWAUXGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWAUXGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:06:47 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:42388 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751211AbWAUXGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:06:46 -0500
Message-ID: <43D2BE83.1020200@bigpond.net.au>
Date: Sun, 22 Jan 2006 10:06:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and 2.6.16-rc1-mm1
References: <43D00887.6010409@bigpond.net.au> <20060121114616.4a906b4f@localhost>
In-Reply-To: <20060121114616.4a906b4f@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 21 Jan 2006 23:06:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Fri, 20 Jan 2006 08:45:43 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>Modifications have been made to spa_ws to (hopefully) address the issues 
>>raised by Paolo Ornati recently and a new entitlement based 
>>interpretation of "nice" scheduler, spa_ebs, which is a cut down version 
>>of the Zaphod schedulers "eb" mode has been added as this mode of Zaphod 
>>performed will for Paolo's problem when he tried it at my request. 
>>Paolo, could you please give these a test drive on your problem?
> 
> 
> ---- spa_ws: the problem is still here
> 
> (sched_fooler)
> ./a.out 3000 & ./a.out 4307 &
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5573 paolo     34   0  2396  292  228 R 59.0  0.1   0:24.51 a.out
>  5572 paolo     34   0  2392  288  228 R 40.7  0.1   0:16.94 a.out
>  5580 paolo     35   0  4948 1468  372 R  0.3  0.3   0:00.04 dd
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5573 paolo     34   0  2396  292  228 R 59.3  0.1   0:59.65 a.out
>  5572 paolo     33   0  2392  288  228 R 40.3  0.1   0:41.32 a.out
>  5440 paolo     28   0 86652  21m  15m S  0.3  4.4   0:03.34 konsole
>  5580 paolo     37   0  4948 1468  372 R  0.3  0.3   0:00.10 dd
> 
> 
> (real life - transcode)
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5585 paolo     33   0  115m  18m 2432 S 90.0  3.7   0:38.04 transcode
>  5599 paolo     37   0 50996 4472 1872 R  9.1  0.9   0:04.03 tcdecode
>  5610 paolo     37   0  4948 1468  372 R  0.6  0.3   0:00.19 dd
> 
> 
> DD test takes ages in both cases.
> 
> What exactly have you done to spa_ws?

I added a "nice aware" version of the throughput bonuses from spa_svr 
and renamed them fairness bonus.  They don't appear to be working :-(

34 is the priority value that ordinary tasks should end up with i.e. if 
they don't look like interactive tasks or CPU hogs.  If they look like 
interactive tasks they should get a lower one via the interactive bonus 
mechanism and if they look like CPU hogs they should get a higher one 
via the same mechanism.  In addition to this tasks will get bonuses if 
they seem to be being treated unfairly i.e. spending too much time on 
run queues waiting for CPU access.

Looking at your numbers the transcode task has the priority that I'd 
expect it to have but tcdecode and dd seem to have had their priorities 
adjusted in the wrong direction.   It's almost like they'd been 
(incorrectly, obviously) identified as CPU hogs :-(.  I'll look into this.

> 
> 
> ---- spa_ebs: great! (as expected)
> 
> (sched_fooler)
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5418 paolo     34   0  2392  288  228 R 51.4  0.1   1:06.47 a.out
>  5419 paolo     34   0  2392  288  228 R 43.7  0.1   0:54.60 a.out
>  5448 paolo     11   0  4952 1468  372 D  3.0  0.3   0:00.12 dd
> 
> (transcode)
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5456 paolo     34   0  115m  18m 2432 R 51.9  3.7   0:23.34 transcode
>  5470 paolo     12   0 51000 4472 1872 S  5.7  0.9   0:02.38 tcdecode
>  5480 paolo     11   0  4948 1468  372 D  3.5  0.3   0:00.33 dd
> 
> Very good DD test performance in both cases.

Good.  How do you find the interactive responsiveness with this one?

Thanks for testing
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
