Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130867AbQLECOa>; Mon, 4 Dec 2000 21:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131014AbQLECOX>; Mon, 4 Dec 2000 21:14:23 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61706 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130878AbQLECOO>; Mon, 4 Dec 2000 21:14:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre4 boot failure (better than pre3 and lower) 
In-Reply-To: Your message of "Mon, 04 Dec 2000 20:39:29 CDT."
             <20001204203929.A10058@animx.eu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Dec 2000 12:43:37 +1100
Message-ID: <3115.975980617@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000 20:39:29 -0500, 
Wakko Warner <wakko@animx.eu.org> wrote:
>Keith Owens wrote
>> Is there any chance of changing arch/alpha/kernel/traps.c to print
>> registers, trace and _raw_ code, in that order so it is more like other
>> architectures?  You can print the decoded instructions as well (prefix
>> Decode:, not Code:) as long as the raw code bytes are also available.
>> 
>> In the meantime, this patch to ksymoops 2.3.5 will pick up the change
>> to the trace lines.  It will still complain about a bad code line,
>> ksymoops is built for raw data.
>
>Didn't help much:
>Code: 40203001  addl t0,1,t0
>Warning (Oops_code): trailing garbage ignored on Code: line
>  Text: 'Code: 40203001  addl t0,1,t0'
>Trace:323658 323600 

Because the trace is printed after the code line, it is treated as part
of the next oops, confusing.  Even more of a problem, the trace
addresses only print the low word of the address, that should really be

Trace: fffffc0000323658 fffffc0000323600 

If somebody would change the Alpha oops text to print the registers,
the trace (with full addresses) and original code, in that order, then
ksymoops would have no problem.  I do not want to change ksymoops
because that might affect processing of logs for other architectures.
IMNSHO we need to be more consistent in the way that we print oops
logs, Alpha is quite different from the other architectures.

In the meantime, if you manually edit the oops log to this layout then
you will get a much better listing.

Unable to handle kernel paging request at virtual address 0000000000000010
swapper(53): Oops 0
pc = [<fffffc0000323270>]  ra = [<fffffc0000323658>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000485748
t2 = fffffc0009f5c560  t3 = fffffc000046cfb0  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc0000323600  s1 = 0000000000000000  s2 = fffffc0009f5c560
s3 = fffffc0009f5c560  s4 = fffffc0009eb0ac0  s5 = fffffc0009eb0ac0
s6 = fffffc0009eb0ac0
a0 = fffffc00004870c8  a1 = fffffc0009e00050  a2 = fffffc00004871c8
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc0000323600  at = 0000000000000000
gp = fffffc00004a3f58  sp = fffffc0009dffee0
Trace: fffffc0000323658  fffffc0000323600 
Code: 40203001 b82b0000 e42001fe b57e0148 a5480428 a0220008 a52a0028 

That last line may be incomplete, it is probably missing the failing
instruction.  To build a correct Code: line, extract the hex values for
the code bytes, enclose the failing instruction in < >, without the
leading '*'.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
