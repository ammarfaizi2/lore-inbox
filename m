Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRIFBH7>; Wed, 5 Sep 2001 21:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbRIFBHt>; Wed, 5 Sep 2001 21:07:49 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:41231 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S272369AbRIFBHn>; Wed, 5 Sep 2001 21:07:43 -0400
Date: Thu, 6 Sep 2001 02:04:51 +0100 (BST)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Machine Check Exception thinko.
Message-ID: <Pine.LNX.4.31.0109060153500.9882-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
 The values printed by the bluesmoke exception handler are bogus.
We're printing the address twice, instead of the address + the misc
register as the intel spec defines. (I guess the reports we've had
where the two values reported differing are down to the CPU being
in a sorry state).

I'm surprised I didn't notice this whilst doing my recent
'use the MSR #defines' diff, and thought for a second I had introduced it
with that patch, but I checked, and this bug existed before I did that,
I just 'reimplemented' it.

If this patch is correct, and I'm not missing something here, all
previously hand-decoded reports on Linux-kernel have been incorrect.
(oops!)

As a side-note, I'm interested in any dumped Machine Check Exception logs,
as I've started a tool to parse these into plaintext, and the more real
world test cases the better.

Patch below.

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux-ac/arch/i386/kernel/bluesmoke.c linux-dj/arch/i386/kernel/bluesmoke.c
--- linux-ac/arch/i386/kernel/bluesmoke.c	Thu Sep  6 01:10:08 2001
+++ linux-dj/arch/i386/kernel/bluesmoke.c	Thu Sep  6 01:19:03 2001
@@ -38,7 +38,7 @@
 			high&=~(1<<31);
 			if(high&(1<<27))
 			{
-				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
+				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
 				printk("[%08x%08x]", alow, ahigh);
 			}
 			if(high&(1<<26))


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .



