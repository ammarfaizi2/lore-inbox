Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131044AbQLFBme>; Tue, 5 Dec 2000 20:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131185AbQLFBmP>; Tue, 5 Dec 2000 20:42:15 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:778 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S131179AbQLFBly>;
	Tue, 5 Dec 2000 20:41:54 -0500
Date: Tue, 5 Dec 2000 17:11:19 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: tulip-ethernet 2.2.17-2.2.18preN http nethangs fixed
Message-ID: <Pine.SUN.3.96.1001205163816.8029A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is solved.

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers







(just kidding)
It was the cache alignment setting in tulip.c (saved me sifting through
the bowels of the pci code to find it).

I choose "486" for the cpu in "make config" for the kernel for a Cyrix
5x86 running on an Asus sp3 with sis496 pci 2.0 bus (it has been
wonderfully stable for 5 years this way, why rock the boat).

The .90 driver in 2.0.38 detects the "486" and sets the cache alignment to
0x01a0480. The .91g-ppc driver in 2.2.15+ doesn't check to see if we're
running a 486 or lower, it simply sets CSR0 to 0x01A08000 if __i386__
is defined. Using "static int csr0 = 0x01A00000 | 0x4800;" and
recompiling fixed the http-induced kernel deadlocks that I was seeing.

I could send a patch, but I don't know if the variable that the code
in .90 was using is defined in 2.2.1x, etc, whether it is deprecated,
various stuff that anyone maintaining 2.2.x pci ethernet drivers probably
already knows.

But that fixed it.

--

make config for 5x86 note:

Both the AMD and Cyrix, different as they are, should be 486 IIRC. The
AMD certainly does not implement the p5 instruction set. The Cyrix might
benefit from 586 instruction scheduling, but I'd have to see it to believe
it, and it certainly won't help the AMD5x86, which is merely a fast 486dx
with a bigger cache. If your gcc specs file considers "-m586" to mean both
-mcpu=i586 and -march=i586, you are doomed if you compile with that flag
for sure for the AMD, and maybe for the Cyrix 5x86 too. Who knows whether
the p5 instructions all worked in the m1sc, even if that logic was on the
chip before they hacked the m1sc to use the narrow 486 memory bus? IIRC
Cyrix never claimed that you could run p5 binaries on it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
