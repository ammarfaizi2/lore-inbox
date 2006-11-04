Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965585AbWKDSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965585AbWKDSNE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbWKDSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:13:04 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51670 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S965585AbWKDSNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:13:01 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
References: <87d583f97t.fsf@debian.org> <20061104172954.GA3668@elte.hu>
	<Pine.LNX.4.64.0611040938490.25218@g5.osdl.org>
From: Falk Hueffner <falk@debian.org>
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
Date: Sat, 04 Nov 2006 19:12:59 +0100
In-Reply-To: <Pine.LNX.4.64.0611040938490.25218@g5.osdl.org> (Linus Torvalds's message of "Sat, 4 Nov 2006 09:41:43 -0800 (PST)")
Message-ID: <87bqnnjd1w.fsf@debian.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Falk - do you have a couple of the oopses (the more, the better: race 
> conditions tend to have subtle oopses, and with more oopses it is easier 
> to try to figure out the pattern) that you can point people at, so that we 
> can get an idea of what's going on.

I've got only one, it's perfectly reproducible with e.g. "fakeroot ls":

ksymoops 2.4.11 on alpha 2.6.19-rc4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.19-rc4/ (default)
     -m /src/linux-2.6.19-rc4/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov  4 19:00:23 juist kernel: Unable to handle kernel paging request at virtual address 0000025800000683
Nov  4 19:00:23 juist kernel: faked-sysv(2111): Oops 0
Nov  4 19:00:23 juist kernel: pc = [<fffffc0000322810>]  ra = [<fffffc0000322810>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
Nov  4 19:00:23 juist kernel: v0 = fffffc0000724c00  t0 = 0000000000000000  t1 = 0000000000000001
Nov  4 19:00:23 juist kernel: t2 = 00000000000003e8  t3 = fffffffffffffff5  t4 = fffffc006f36bde8
Nov  4 19:00:23 juist kernel: t5 = fffffc006f36bde8  t6 = 00000200001c41cc  t7 = fffffc006f368000
Nov  4 19:00:23 juist kernel: s0 = 000000000000000f  s1 = 0000025800000683  s2 = fffffc006fdf3e10
Nov  4 19:00:23 juist kernel: s3 = 0000000000000000  s4 = fffffc00006ca8e0  s5 = 0000000000000100
Nov  4 19:00:23 juist kernel: s6 = fffffc006f36bd78
Nov  4 19:00:23 juist kernel: a0 = 0000000000000007  a1 = fffffc006f36bda8  a2 = 0000000000000000
Nov  4 19:00:23 juist kernel: a3 = 0000000000000001  a4 = 0000000000000000  a5 = 000002000000cf80
Nov  4 19:00:23 juist kernel: t8 = 00000200001c41bc  t9 = 00000200001c41bc  t10= 000000007fffffff
Nov  4 19:00:23 juist kernel: t11= 00000200001c54d2  pv = fffffc00003229b0  at = 000000000749d915
Nov  4 19:00:23 juist kernel: gp = fffffc0000720200  sp = fffffc006f36bd78
Nov  4 19:00:23 juist kernel: Trace:
Nov  4 19:00:23 juist kernel: [<fffffc00003f8228>] expunge_all+0x58/0x90
Nov  4 19:00:23 juist kernel: [<fffffc00003f884c>] sys_msgctl+0x1cc/0x730
Nov  4 19:00:23 juist kernel: [<fffffc00003112a4>] entSys+0xa4/0xc0
Nov  4 19:00:23 juist kernel: Code: 47f0040a  b59e0020  b75e0000  47f2040c  4921f629  d35fff0a <a44a0000> 47e0040b 


>>RA;  fffffc0000322810 <try_to_wake_up+40/180>

>>PC;  fffffc0000322810 <try_to_wake_up+40/180>   <=====

Trace; fffffc00003f8228 <expunge_all+58/90>
Trace; fffffc00003f884c <sys_msgctl+1cc/730>
Trace; fffffc00003112a4 <entSys+a4/c0>

Code;  fffffc00003227f8 <try_to_wake_up+28/180>
0000000000000000 <_PC>:
Code;  fffffc00003227f8 <try_to_wake_up+28/180>
   0:   0a 04 f0 47       mov  a0,s1
Code;  fffffc00003227fc <try_to_wake_up+2c/180>
   4:   20 00 9e b5       stq  s3,32(sp)
Code;  fffffc0000322800 <try_to_wake_up+30/180>
   8:   00 00 5e b7       stq  ra,0(sp)
Code;  fffffc0000322804 <try_to_wake_up+34/180>
   c:   0c 04 f2 47       mov  a2,s3
Code;  fffffc0000322808 <try_to_wake_up+38/180>
  10:   29 f6 21 49       zapnot       s0,0xf,s0
Code;  fffffc000032280c <try_to_wake_up+3c/180>
  14:   0a ff 5f d3       bsr  ra,fffffffffffffc40 <_PC+0xfffffffffffffc40>
Code;  fffffc0000322810 <try_to_wake_up+40/180>   <=====
  18:   00 00 4a a4       ldq  t1,0(s1)   <=====
Code;  fffffc0000322814 <try_to_wake_up+44/180>
  1c:   0b 04 e0 47       mov  v0,s2


1 error issued.  Results may not be reliable.


-- 
	Falk
