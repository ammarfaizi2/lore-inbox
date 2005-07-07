Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVGGEO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVGGEO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 00:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGGEO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 00:14:56 -0400
Received: from [195.23.16.24] ([195.23.16.24]:58001 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261762AbVGGEO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 00:14:56 -0400
Message-ID: <1120709518.42ccab8ed77cf@webmail.grupopie.com>
Date: Thu,  7 Jul 2005 05:11:58 +0100
From: "" <pmarques@grupopie.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: "" <akpm@osdl.org>, "" <davej@redhat.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
References: <20050706.125719.08321870.davem@davemloft.net> <20050706205315.GC27630@redhat.com> <20050706181220.3978d7f6.akpm@osdl.org> <20050706.190758.71090134.davem@davemloft.net>
In-Reply-To: <20050706.190758.71090134.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.91.240
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "David S. Miller" <davem@davemloft.net>:

> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 6 Jul 2005 18:12:20 -0700
> 
> > ouch.   What do we do?  Default to off?  Default to off on xmeta?
> 
> Good question.  Whatever security is gained by the va randomization
> stuff is definitely not worth a 0.23 --> 3.0 second performance
> regression.

Well, I tested the exact same script on my P4 2.8GHz and didn't notice a
significant regression. So maybe this is really Transmeta specific.

Also, this workload probably represents the worst scenario to trigger this: the
script does more than 100 fork / execs with each exec'ed program doing very
little work and exiting.

I can do some more tests (tomorrow) to see if different workloads are also
significantly affected, but I suspect that simply running one "normal" process
(or a few) will not show this problem.

Anyway, I still find this to be a little weird. My understanding of the Linux
memory management is still limited, so correct me if I'm wrong:

 - once we exec one program for the first time, the executable file is mmap'ed
in memory and pages are faulted in as they are executed (modulo prefaulting,
read-ahead, etc.).

 - these same pages are kept as pagecache even after the process exits(*)

 - on the next execution, these pages are already in memory as pagecache, and
are simply mapped to the process address space. The virtual address is
different because of randomization, but the physical addresses are the same.

 - why does the Transmeta interpreter "re-compiles" the code that is on the same
physical address? Interpreter bug?

I'm just pointing this out, because the machine I'm working on isn't exactly
"new", and it might have an old version of the interpreter. This can possibly
mean that newer Transmetas might not show this problem at all.

This is the cpuinfo of the machine in question:

processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5600
stepping        : 3
cpu MHz         : 530.696
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1028.09

and the relevant part of the dmesg output:

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.1.2, 533 MHz
CPU: Code Morphing Software revision 4.2.7-8-278
CPU: 20011004 02:04 official release 4.2.7#7
CPU serial number disabled.
CPU: After all inits, caps: 0080893f 0081813f 0000000e 00000000 00000000
00000000 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03

So, if there is someone out there with newer Transmetas available that also want
to test this to see if there is a regression, I can build a small testcase to
see how it goes.

--
Paulo Marques - www.grupopie.com

(*) by the way, during the tests the machine always had more than 70Mb of free
memory, so I see no reason for it to dump pagecache

