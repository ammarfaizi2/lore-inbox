Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSJCMfl>; Thu, 3 Oct 2002 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJCMfl>; Thu, 3 Oct 2002 08:35:41 -0400
Received: from kim.it.uu.se ([130.238.12.178]:43189 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263267AbSJCMfk>;
	Thu, 3 Oct 2002 08:35:40 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.15056.287602.502467@kim.it.uu.se>
Date: Thu, 3 Oct 2002 14:40:48 +0200
To: vamsi@in.ibm.com
Cc: linux-kernel@vger.kernel.org, richardj_moore@uk.ibm.com,
       grundym@us.ibm.com, vamsi_krishna@in.ibm.com,
       suparna <bsuparna@in.ibm.com>
Subject: Re: [rfc] [patch] kernel hooks
In-Reply-To: <20021003175600.A17884@in.ibm.com>
References: <20021003175600.A17884@in.ibm.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vamsi Krishna S . writes:
 > Hooks are implemented as fast and slim-line insertions to kernel 
 > space code. When not active that have practically no overhead to
 > the kernel. Optimized versions are implemented on ia32, ppc, 
 > ppc64, s390, s390x archs, where they expand to:
 > 	movl $0, %reg
 > 	     ^x
 > 	testl %reg, %reg
 > 	jz out
 > 	call out exits
 > 	out:
 > 
 > Hooks are armed by editing the number at ^x above to a non-zero 
 > value so that the exits will be now be called out. 
...
 > +static inline void activate_asm_hook(struct hook *hook)
 > +{
 > +	unsigned char *addr = (unsigned char *) (hook->hook_addr);
 > +	addr[2] = 1;
 > +	flush_icache_range(addr + 2, addr + 2);
 > +	return;
 > +}

You just triggered Intel's "Unsynchronised Cross-Modifying Code
Operations Can Cause Unexpected Instruction Execution Results"
Erratum, which affects _every_ multiprocessor Intel P6 box.
It's Pentium 3 Erratum E49 if you want to look it up; the other
Intel P6s have it too, but with different numbers.

In short, the only safe way to do this sort of thing is to force
all other processors to wait on a barrier first, then modify the
code, then release the barrier.

On a general note, I wish people would pay more attention to Intel's
and AMD's errata documents. There are a number of things documented
in Intel's IA32 manual set which simply do not work in the real world
due to errata. Unsync cross-modifying code is one, the PAT is another.

/Mikael
