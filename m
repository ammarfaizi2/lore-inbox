Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQKROrt>; Sat, 18 Nov 2000 09:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQKROrk>; Sat, 18 Nov 2000 09:47:40 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:5059 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S130159AbQKROr2>; Sat, 18 Nov 2000 09:47:28 -0500
Message-ID: <3A168F08.F124A76A@didntduck.org>
Date: Sat, 18 Nov 2000 09:15:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <20001118014019.18006.qmail@web3404.mail.yahoo.com> <8v4vep$15d$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <20001118014019.18006.qmail@web3404.mail.yahoo.com>,
> =?iso-8859-1?q?Markus=20Schoder?=  <markus_schoder@yahoo.de> wrote:
> >The following small program (linked against glibc 2.1.3) reliably
> >freezes my system (Athlon Thunderbird CPU) with at least kernels
> >2.4.0-test10 and 2.4.0-test11-pre5.  Even the SysRq keys do not work
> >after the freeze.
> >
> >Older kernels (e.g. 2.3.40) seem to work.  Any Ideas?
> 
> It certainly doesn't happen for me on any of the machines I work with,
> but it wouldn't compile as-is for me, so I exchanged the FPU setting
> with a simpler
> 
>         asm("fldcw %0": :"m" (0));
> 
> which should do the equivalent (ie unmask divide by zero errors). Does
> that make a difference for you?
> 
> Can you try to figure out where it started happening? Ie try test9 and
> back too, to figure out what might be bringing it on...
> 
> I sure as hell hope this isn't an Athlon issue.  Can other people try
> the test-program and see if we have a pattern (ie "it happens only on
> Athlons", or "Linus is on drugs and it happens for everybody else").
> 
> Thanks,
> 
>                 Linus

I get Floating Point Exception (core dumped), but I needed to use the
modified program below to keep GCC from optimizing the division away as
a constant.  This is on test11-pre5.

--------------
#define _GNU_SOURCE

#include <fenv.h>
#include <unistd.h>

double a =1.0, b = 0.0;
int
main(void)
{
  double c;
  asm("fldcw %0": :"m" (0));
 // fesetenv(FE_NOMASK_ENV);
  c = a / b;
  sleep(10);
  return a;
}
--------------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 2
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 748.000573
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1494.22

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
