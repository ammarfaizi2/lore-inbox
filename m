Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTGBDBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 23:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGBDBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 23:01:08 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:44998 "HELO
	develer.com") by vger.kernel.org with SMTP id S264607AbTGBDBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 23:01:04 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 05:15:17 +0200
User-Agent: KMail/1.5.9
References: <200307020232.20726.bernie@develer.com> <200307020424.47629.bernie@develer.com> <20030701193250.1cbd4af9.akpm@digeo.com>
In-Reply-To: <20030701193250.1cbd4af9.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020515.17722.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 04:32, you wrote:

 > >  By the way, what do you think about getting rid of the do_div()
 > > macro altogether?
 >
 > I think we leave it the way it is because 64-bit divides are slow.

 Wait! It's not documented at all that do_div() really does a
64bit/32bit division with 32bit remainder.

  rem = (unsigned long)div % (unsigned)base;
  div = (unsigned long)div / (unsigned)base;

What the generic version really does on 64bit architectures is a
64bit/32bit division, since "long" is usually 64bit.

What's worse, it has different semantics on different architectures:

 alpha     64/32 -> 64q + 32r (generic)
 arm       64/32 -> 64q + 32r (asm function call)
 arm26     32/32 -> 32q + 32r (generic)
 cris      32/32 -> 32q + 32r (generic)
 h8300     32/32 -> 32q + 32r (generic)
 i386      64/32 -> 64q + 32r (inline asm + C for 64bit case)
 ia64      64/32 -> 64q + 32r (generic)
 m68k      64/32 -> 64q + 32r (inline asm + C for 64bit case)
 m68knommu 32/32 -> 32q + 32r (generic)
 mips      64/32 -> 64q + 32r (inline asm)
 mips64    64/32 -> 64q + 32r (generic)
 parisc    64/32 -> 64q + 32r (inline C)
 ppc       64/32 -> 64q + 32r (inline C + call for 64bit case)
 ppc64     64/32 -> 64q + 32r (generic)
 s390      64/32 -> 64q + 32r (generic for s390x, otherwise inline asm)
 sh        32/32 -> 32q + 32r (generic)
 sparc     32/32 -> 32q + 32r (generic)
 sparc64   64/32 -> 64q + 32r (generic)
 um        like host
 v850      32/32 -> 32q + 32r (generic)
 x86_64    64/32 -> 64q + 32r (generic)
 
 This table might be incorrect for some architectures I'm not familiar with.


 > It is very easy to go accidentally adding 64-bit divides.  Say, by
 > changing the disk indexing to use 64-bit sector numbers as we did
 > earlier in 2.5.
 > By requiring an explicit do_div we are made aware of all those 64-bit
 > divides and are made to think about them.

 Nothing in div64.h prevents one from using the normal C syntax for
making divisions between long long numbers.

 Besides, using the macros is much slower on some architectures. gcc cannot
see through blocks of inline asm, therefore it won't be able to do proper
constant propagation and dead code elimination.

 > Why 64-bit divides in particular were victimised in this manner is a
 > matter for speculation ;)

 Let me guess: perhaps older gcc versions (pre 2.95) had some bugs
with long long and somone decided to fix the problem that way ;-)

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


