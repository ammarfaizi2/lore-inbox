Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276734AbRJKTSh>; Thu, 11 Oct 2001 15:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276702AbRJKTS2>; Thu, 11 Oct 2001 15:18:28 -0400
Received: from colorfullife.com ([216.156.138.34]:32775 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276736AbRJKTSP>;
	Thu, 11 Oct 2001 15:18:15 -0400
Message-ID: <3BC5F092.6492A8B3@colorfullife.com>
Date: Thu, 11 Oct 2001 21:18:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tommy Faasen <faasen@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: SMP debugging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The way I look at the output is that the kernel only looks
> what the specs ofthe first cpu are and asumes that the second
> is the same.

Correct, that part of the Intel MP specification: if 2 different cpus
are
used, then the capabilities of the second cpu must be a subset of the
capabilities of the first cpu. (IIRC)

Probably you must edit smpboot.c or init.c and clear the capabilities of
cpu0 that cpu1 doesn't have.

> Invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c010c784>]    Not tainted
> EFLAGS: 00010206

Could you run the oops through ksymoops?

> processor 0:
> flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
>		pse36 mmx fxsr
> processor 1:
> flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx

Ok, cpu0 support fxsr, cpu1 doesn't.
fxsr is used for the thread switching.
It seems that this causes an oops during the first thread switch.

Could you try what happens if you replace
linux/include/asm-i386/processor.h:
- #define cpu_has_fxsr        (test_bit(X86_FEATURE_FXSR,
boot_cpu_data.x86_capability))
+ #define cpu_has_fxsr		(0)

If that doesn't work, then check where X86_FEATURE_FXSR is used.

--
	Manfred
