Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbUBXXQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUBXXQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:16:17 -0500
Received: from fmr06.intel.com ([134.134.136.7]:44249 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262526AbUBXXQN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:16:13 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Tue, 24 Feb 2004 15:15:18 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA2684@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP62b+YNygft82KT92E/c3K4V11cAAUNEzQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Adrian Bunk" <bunk@fs.tum.de>,
       "Herbert Poetzl" <herbert@13thfloor.at>,
       "Mikael Pettersson" <mikpe@csd.uu.se>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Feb 2004 23:15:18.0718 (UTC) FILETIME=[117F15E0:01C3FB2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Could you publish list of differences between amd64 and ia32e?
>
>I probably could took those two 300+ page documents and try to compare
>them by hand, but I believe you know already.
>								
>								Pavel

Other than the standard IA-32 differences (eg. HT, SSE3, Intel Enhanced
SpeedStep, etc.), there are few differences between the implementations
of 
IA-32e and AMD64. The software visible ones are:

Fast system calls:
  Syscall/sysret is supported only in 64-bit mode (not in compatibility 
  mode). Sysenter/Sysexit is supported in both 64-bit and compatible
mode.

CPUID:
  If you look at Table 2-8 of Volume 1, you will find IA-32e specific
things,
  including, GenuineIntel, HT, SSE3, monitor/mwait, Intel Enhanced
SpeedStep, 
  and cmpxchg16b.

  The function 8000_0001h doesn't duplicate standard-feature bits from 
  function 1 in EDX. It sets only the new features that are implemented.

MSRs:
  Not all MSRs are architectural, and IA-32e does not implement SYSCFG, 
  TOP_MEM, TOP_MEM2, for example. MSR usage should be vendor specific
and 
  be guarded with CPUID.Model

Fast-FXSAVE/FXRSTOR:
  IA-32e always saves all of the FP state on FXSAVE/FXRSTOR. Does not 
  support FXSAVE/FXRSTOR with reduced FP state.

Microcode Update:
  IA-32e supports microcode update as the 32-bit mode does, as you
already 
  found the discussions in the mailing list.

NX (No-Execute) bit:
  Initial implementation will not support the NX bit.

BSF/BSR when source is 0 & operand size is 32:
  In 64-bit mode, the processor sets ZF, and the upper 32 bits of 
  the destination are undefined. Should always check the ZF or do not
use 
  32-bit operand size.

Near branch with 66H prefix:
  As documented in PRM the behavior is implementation specific and
should 
  avoid using 66H prefix on near branches.

Not supported in IA-32e
=======================
  3DNow instructions (including prefecthw or prefetch with the opcode 0f
0d)

Thanks,
Jun

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz]
>Sent: Tuesday, February 24, 2004 5:25 AM
>To: Nakajima, Jun
>Cc: Linus Torvalds; Adrian Bunk; Herbert Poetzl; Mikael Pettersson;
Kernel
>Mailing List
>Subject: Re: Intel vs AMD x86-64
>
>Hi!
>
>> Sorry for the miscommunication. The page
>> http://www.intel.com/technology/64bitextensions/faq.htm says at the
>> _bottom_ at least:
>>
>> Q9: Is it possible to write software that will run on Intel's
processors
>> with 64-bit extension technology, and AMD's 64-bit capable
processors?
>> A9: With both companies designing entirely different architectures,
the
>> question is whether the operating system and software ported to each
>> processor will run on the other processor, and the answer is yes in
most
>> cases.
>
>Could you publish list of differences between amd64 and ia32e?
>
>I probably could took those two 300+ page documents and try to compare
>them by hand, but I believe you know already.
>								Pavel
>
>--
>When do you have a heart between your knees?
>[Johanka's followup: and *two* hearts?]
