Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVL0X7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVL0X7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVL0X7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:59:17 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:10232 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932405AbVL0X7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:59:16 -0500
Message-ID: <43B1D551.5050503@bigpond.net.au>
Date: Wed, 28 Dec 2005 10:59:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
References: <20051227190918.65c2abac@localhost> <20051227224846.6edcff88@localhost>
In-Reply-To: <20051227224846.6edcff88@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 27 Dec 2005 23:59:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Tue, 27 Dec 2005 19:09:18 +0100
> Paolo Ornati <ornati@fastwebnet.it> wrote:
> 
> 
>>Hello,
>>
>>I've found an easy-to-reproduce-for-me test case that shows a totally
>>wrong priority calculation: basically a CPU-intensitive process gets
>>better priority than a disk-intensitive one (dd if=bigfile
>>of=/dev/null ...).
>>
>>Seems impossible, isn't it?
>>
>>---- THE NUMBERS with 2.6.15-rc7 -----
>>
>>The test-case is the Xvid encoding of dvd-ripped track with transcode
>>(using "dvd::rip" interface). The copied-and-pasted command line is
>>this:
>>
>>mkdir -m 0775 -p '/home/paolo/tmp/test/tmp' &&
>>cd /home/paolo/tmp/test/tmp && dr_exec transcode -H 10 -a 2 -x vob,null
>>-i /home/paolo/tmp/test/vob/003 -w 1198,50 -b 128,0,0 -s 1.972
>>--a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 1 -y xvid4,null
>>-o /dev/null --print_status 20 && echo DVDRIP_SUCCESS mkdir -m 0775 -p
>>'/home/paolo/tmp/test/tmp' && cd /home/paolo/tmp/test/tmp && dr_exec
>>transcode -H 10 -a 2 -x vob -i /home/paolo/tmp/test/vob/003 -w 1198,50
>>-b 128,0,0 -s 1.972 --a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 2 -y
>>xvid4 -o /home/paolo/tmp/test/avi/003/test-003.avi --print_status 20 &&
>>echo DVDRIP_SUCCESS
>>
>>
>>Here there is a TOP snapshot while running it:
>>
>>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>> 5721 paolo     16   0  115m  18m 2428 R 84.4  3.7   0:15.11 transcode
>> 5736 paolo     25   0 50352 4516 1912 R  8.4  0.9   0:01.53 tcdecode
>> 5725 paolo     15   0  115m  18m 2428 S  4.6  3.7   0:00.84 transcode
>> 5738 paolo     18   0  115m  18m 2428 S  0.8  3.7   0:00.15 transcode
>> 5734 paolo     25   0 20356 1140  920 S  0.6  0.2   0:00.12 tcdemux
>> 5731 paolo     25   0 47312 2540 1996 R  0.4  0.5   0:00.08 tcdecode
>> 5319 root      15   0  166m  16m 2584 S  0.2  3.2   0:25.06 X
>> 5444 paolo     16   0 87116  22m  15m R  0.2  4.6   0:04.05 konsole
>> 5716 paolo     16   0 10424 1160  876 R  0.2  0.2   0:00.06 top
>> 5735 paolo     25   0 22364 1436  932 S  0.2  0.3   0:00.01 tcextract
>>
>>
>>DD running alone:
>>
>>paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
>>128+0 records in
>>128+0 records out
>>
>>real    0m4.052s
>>user    0m0.000s
>>sys     0m0.209s
>>
>>DD while transcoding:
>>
>>paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
>>128+0 records in
>>128+0 records out
>>
>>real    0m26.121s
>>user    0m0.001s
>>sys     0m0.255s
>>
>>---------------------------------------
>>
>>I've tried older kernels finding that 2.6.11 is the first affected.
>>
>>Going on with testing...
>>
>>        2.6.11-rc[1-5]:
>>2.6.11-rc3 bad
>>2.6.11-rc1 bad
>>
>>        2.6.10-bk[1-14]
>>2.6.10-bk7 good
>>2.6.10-bk11 good
>>2.6.10-bk13 bad
>>2.6.10-bk12 bad
>>
>>So the problem was introduced with:
>>	>> 2.6.10-bk12 09-Jan-2005 <<
>>
>>The exact behaviour is different with 2.6.11/12/13/14... for example:
>>with 2.6.11 the priority of "transcode" is initially set to ~25 and go
>>down to 17/18 when running DD.
>>
>>The problem doesn't seem 100% reproducible with every kernel, sometimes
>>a "BAD" kernel looks "GOOD"... or maybe it was me confused by too
>>much compile/install/reboot/test work ;)
>>
>>Other INFO:
>>- I'm on x86_64
>>- preemption ON/OFF doesn't make any differences
>>
>>
>>Can anyone reproduce this?
>>IOW: is this affecting only my machine?
>>
> 
> 
> Hello Con and Ingo... I've found that the above problem goes away
> by reverting this:
> 
> http://linux.bkbits.net:8080/linux-2.6/cset@41e054c6pwNQXzErMxvfh4IpLPXA5A?nav=index.html|src/|src/include|src/include/linux|related/include/linux/sched.h
> 
> --------------------------------------------------
> 
> [PATCH] sched: remove_interactive_credit
> 
> Special casing tasks by interactive credit was helpful for preventing fully
> cpu bound tasks from easily rising to interactive status.
> 
> However it did not select out tasks that had periods of being fully cpu
> bound and then sleeping while waiting on pipes, signals etc.  This led to a
> more disproportionate share of cpu time.
> 
> Backing this out will no longer special case only fully cpu bound tasks,
> and prevents the variable behaviour that occurs at startup before tasks
> declare themseleves interactive or not, and speeds up application startup
> slightly under certain circumstances.  It does cost in interactivity
> slightly as load rises but it is worth it for the fairness gains.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> --------------------------------------------------
> 
> 
> Maybe this change has revealed a scheduler weakness ?
> 
> I'm glad to test any patch or give more data :)
> 
> Bye,
> 

Any chance of you applying the PlugSched patches and seeing how the 
other schedulers that it contains handle this situation?

The patch at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.6-for-2.6.15-rc5.patch?download>

should apply without problems to the 2.6.15-rc7 kernel.

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
don't change the default when you build the kernel the default scheduler
will be ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
