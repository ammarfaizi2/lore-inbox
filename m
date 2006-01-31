Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWAaDaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWAaDaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWAaDaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:30:15 -0500
Received: from mail7.hitachi.co.jp ([133.145.228.42]:20702 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1030310AbWAaDaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:30:13 -0500
Message-ID: <43DED9E1.6070203@sdl.hitachi.co.jp>
Date: Tue, 31 Jan 2006 12:30:41 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][0/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
References: <43DE0A3A.4090404@sdl.hitachi.co.jp> <20060130125137.509df714.akpm@osdl.org>
In-Reply-To: <20060130125137.509df714.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060606080402090502060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606080402090502060306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, Andrew

Andrew Morton wrote:
> Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
> 
>>I would like to propose the kprobe-booster and kretprobe-booster
>> to reduce overhead of kprobes and kretprobes.
>> They have already been discussed on the SystemTap ML.
> 
> 
> Do you have performance testing results for this change?
> 

Yes, I have. I measured the overhead of probes by measuring the
processing time of gettimeofday systemcall. Details are described
later.

 From the result, current kprobe has about 1.3 usec/probe(*)
overhead, and kprobe-booster patch reduces it to 0.6 usec/probe(*).
Also current kretprobe has about 2.0 usec/probe(*) overhead.
Kprobe-booster patch reduces it to 1.3 usec/probe(*), and
the combination of both kprobe-booster patch and kretprobe-booster
patch reduces it to 0.9 usec/probe(*).

I expect the combination of both patches can reduce half of
a probing overhead.

(*) performance number strongly depends on the processor model.


Description of measurement:
==========================
I measured the processing time of sys_gettimeofday()
systemcall on linux-2.6.16-rc1 in 3 cases below;

(A) Not-probed
(B) Probed by a kprobe at the top of do_gettimeofday()
(C) Probed by a kretprobe at the end of do_gettimeofday()

Here is machine spec;
Processor: Pentium4 3.06GHz
Memory: 1024MB
Kernel Configuration: defconfig + CONFIG_KPROBES

I used a non-operation probe functions described below:

---
static int probe_pre_handler (struct kprobe * kp,
                              struct pt_regs * regs)
{
        return 0;
}
---
static int probe_ret_handler (struct kretprobe_instance * ri,
                              struct pt_regs * regs)
{
        return 0;
}
---

I attach a micro benchmark (called gtodbench) to measure
the processing time of sys_gettimeofday() systemcall.
This micro benchmark repeats gettimeofday system call for 10
or specified seconds and counts the number of call.
After that, it calculates average processing time.

Results of measurement:
======================
The results of normal linux-2.6.16-rc1:
(A) 264 nsec/call
(B) 1534 nsec/call
(C) 2245 nsec/call
The overhead of kprobes is 1270 nsec/call(equal to (B) - (A))
The overhead of kretprobes is 1981 nsec/call(equal to (C) - (A))

The results of linux-2.6.16-rc1 with only kprobe-booster patch:
(A) 264 nsec/call
(B) 837 nsec/call
(C) 1585 nsec/call
The overhead of kprobes is 573 nsec/call(equal to (B) - (A))
The overhead of kretprobes is 1321 nsec/call(equal to (C) - (A))
kprobe-booster patch also improves the performance of kretprobe,
because kretprobe is implemented on kprobe.

The results of linux-2.6.16-rc1 with only kretprobe-booster patch:
(A) 264 nsec/call
(B) 1548 nsec/call
(C) 1832 nsec/call
The overhead of kprobes is 1284 nsec/call(equal to (B) - (A))
The overhead of kretprobes is 1568 nsec/call(equal to (C) - (A))
In the other hand, kretprobe-booster does not improbe the
performance of kprobe.

The results of linux-2.6.16-rc1 with the combination of both
kretprobe-booster and kprobe-booster:
(A) 264 nsec/call
(B) 836 nsec/call
(C) 1182 nsec/call
The overhead of kprobes is 572 nsec/call(equal to (B) - (A))
The overhead of kretprobes is 918 nsec/call(equal to (C) - (A))

Best regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp




--------------060606080402090502060306
Content-Type: text/plain;
 name="gtodbench.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gtodbench.c"

/*
 gettimeofday micro benchmark for measurement system call performance
 
 Copyright (C) HITACHI,LTD. 2005,2006
 WRITTEN BY HITACHI SYSTEMS DEVELOPMENT LABORATORY,
 Created by M.Hiramatsu <hiramatu@sdl.hitachi.co.jp>
  
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
	struct timeval tv, otv;
	int sec=10;
	unsigned long count;
	struct rusage usage;
	
	if(argc == 2) sec = atoi(argv[1]);
	gettimeofday(&otv,NULL);
	count = 0;
	do {
		gettimeofday(&tv,NULL);
		count ++;
	} while ( (sec - (tv.tv_sec - otv.tv_sec))*1000 >
		  (tv.tv_usec - otv.tv_usec)/1000 );
	getrusage(RUSAGE_SELF, &usage);
	tv = usage.ru_stime;
	tv.tv_sec += usage.ru_utime.tv_sec;
	tv.tv_usec += usage.ru_utime.tv_usec;
	fprintf(stderr, "gettimeofday was called %u times per %d sec: %d nsec per call\n",
	       count, sec, (tv.tv_sec*1000*1000 + tv.tv_usec)/(count/1000));
	return 0;
}

--------------060606080402090502060306--
