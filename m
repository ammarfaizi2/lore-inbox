Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTGBEXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264687AbTGBEXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:23:30 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:7634 "HELO
	develer.com") by vger.kernel.org with SMTP id S264683AbTGBEX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:23:28 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 06:37:24 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
References: <200307020232.20726.bernie@develer.com> <200307020424.47629.bernie@develer.com> <16130.21283.122787.362837@wombat.chubb.wattle.id.au>
In-Reply-To: <16130.21283.122787.362837@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020637.24459.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 05:36, Peter Chubb wrote:

 > Bernardo> If there are architectures where gcc doesn't implement
 > Bernardo> divisions correctly, this issue should be solved in gcc, not
 > Bernardo> by adding a silly macro to the kernel.
 >
 > The issue is that on 32-bit platforms, 64bit divided by 32 bit is
 > handed off to a subroutine _udivdi3 which isn't linked into the
 > kernel, and  which in any case does a full 64 bit by 64-bit division
 > (which is slow).

 I see. It's ashaming that the gcc people didn't care special casing
the quite common 64/32 case in the x86 machine description or at least
in libgcc.

 > Using do_div() allows one to generate near-optimal code for a 64by32
 > bit division/remainder on platforms (e.g., IA32) which have problems,
 > and generating something sane for other platforms (e.g., IA64).

 I agree. I'd prefer to see it fixed in gcc, but until then...


 > Platforms that never expect to deal with a 64-bit number just redefine
 > the macro in terms of long.  Which means that printing out long longs
 > doesn't work properly on those architectures.

 A function which changes its semantics depending on the platform is
definitely a ugly hack.

 A cleaner way to address this problem would be using platform-specific
typedefs to reduce the size of specific objects to 32bits on smaller systems.


 In mm/vmscan.c:shrink_slab() you'll find this:

       long long delta;

       delta = scanned * shrinker->seeks;
       delta *= (*shrinker->shrinker)(0, gfp_mask);
       do_div(delta, pages + 1);
       shrinker->nr += delta;

 This is _BAD_ because delta will be 128bits on some 64bit systems
and 64bit, but truncated to 32bit in do_div(), on some other systems.

 Using at least uint64_t would solve the first problem, but anyone
looking at this code wouldn't realize the result could get truncated
by some do_div() implementations.

 What can we do about that? This time I don't have a clean solution to
advocate.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


