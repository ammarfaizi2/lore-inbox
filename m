Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbRF1XGN>; Thu, 28 Jun 2001 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbRF1XFx>; Thu, 28 Jun 2001 19:05:53 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:1987 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264830AbRF1XFt>;
	Thu, 28 Jun 2001 19:05:49 -0400
Date: Fri, 29 Jun 2001 01:05:06 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106282305.BAA17845@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, bernds@redhat.com
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using
Cc: FrankZhu@viatech.com.cn, linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 20:42:09 +0100 (BST), Alan Cox wrote:

>> > Intel specifically state that you cannot use CMOV without checking
>> > for it. Its actually a gcc/binutils tool bug. The CPU is right.
>> 
>> How is that a gcc bug?  You tell the compiler to generate cmov, you run
>> it on a CPU that doesn't have it, you get what you deserve.  There's
>> really nothing the tools can do about that.
>
>I tell gcc to buld for the 'i686' architecture definition. It in fact builds
>for the i686 architecture assuming an optional feature.

Here I have to disagree with you Alan. When you pass "-march=i686" to
gcc, you are _not_ saying "generate code for a CPUID family 6 CPU".
"-march=i686" actually means "target an Intel P6 family chip, given
what we currently know about them". The gcc info pages don't talk
about CPUID family codes, they talk about specific chip families.

As for CMOV being optional, show me an Intel P6 without CMOV and I'll
volunteer to update gcc's docs to warn that "bastard CMOV-less P6 users
should not use the -march=i686 option".

Taking Alan's formal standpoint, there is _no_ compiler-usable difference
between family 4, 5, and 6 processors, since the changes are limited
to system-level code, or useless (gcc doesn't need UD2), or are conditional
on specific CPUID feature bits (which gcc cannot or should not test).
The only guaranteed and useful distinction is "386" and "486 or better",
since the 486 added BSWAP/CMPXCHG/XADD.
[IA-32 manual set, Volume 3, Section 17.7.1 in the revision I have.]

Furthermore, any interpretation of the CPUID family code _must_ be
conditionalised on the CPUID vendor field. The fact that Intel attaches
some semantics to "family 6" doesn't restrict other vendors, since Intel
also defines "vendor == Intel" while the other vendors obviously have
"vendor != Intel", a blatant deviation from the IA-32 manuals.

The real problem is that the kernel generates "uname -m" based only
on the CPUID family code, which is meaningless unless we also know
the vendor name. So "uname -m" ought to be "${FAMILY}86-${VENDOR}",
giving us "686-Intel", "686-AMD", "686-Centaur", and so on.

Unfortunately, changing the output of "uname -m" also breaks lots
of user-space configuration tools out there ... I'm not sure we want
to do that only because VIA&Centaur in their infinite wisdom
decided to build a "family 6" chip without a CMOV instruction.

/Mikael
