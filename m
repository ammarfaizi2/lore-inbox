Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRBNWiF>; Wed, 14 Feb 2001 17:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRBNWhz>; Wed, 14 Feb 2001 17:37:55 -0500
Received: from colorfullife.com ([216.156.138.34]:9995 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129400AbRBNWhp>;
	Wed, 14 Feb 2001 17:37:45 -0500
Message-ID: <3A8B08C7.BD79E3B4@colorfullife.com>
Date: Wed, 14 Feb 2001 23:37:59 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <200102092240.OAA15902@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------2BD94515AC96F0EBA3546C45"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2BD94515AC96F0EBA3546C45
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have another idea for sse, and this one is far safer:

only use sse prefetch, leave the string operations for the actual copy.
The prefetch operations only prefetch, don't touch the sse registers,
thus neither any reentency nor interrupt problems.

I tried the attached hack^H^H^H^Hpatch, and read(fd, buf, 4000000) from
user space got 7% faster (from 264768842 cycles to 246303748 cycles,
single cpu, noacpi, 'linux -b', fastest time from several thousand
runs).

The reason why this works is simple:

Intel Pentium III and P 4 have hardcoded "fast stringcopy" operations
that invalidate whole cachelines during write (documented in the most
obvious place: multiprocessor management, memory ordering)

The result is a very fast write, but the read is still slow.

--
	Manfred
--------------2BD94515AC96F0EBA3546C45
Content-Type: text/plain; charset=us-ascii;
 name="patch-sse-prefetchnta"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sse-prefetchnta"

--- 2.4/mm/filemap.c	Wed Feb 14 10:51:42 2001
+++ build-2.4/mm/filemap.c	Wed Feb 14 22:11:44 2001
@@ -1248,6 +1248,20 @@
 		size = count;
 
 	kaddr = kmap(page);
+	if (size > 128) {
+		int i;
+		__asm__ __volatile__(
+			"mov %1, %0\n\t"
+			: "=r" (i)
+			: "r" (kaddr+offset)); /* load tlb entry */
+		for(i=0;i<size;i+=64) {
+			__asm__ __volatile__(
+				"prefetchnta (%1, %0)\n\t"
+				"prefetchnta 32(%1, %0)\n\t"
+				: /* no output */
+				: "r" (i), "r" (kaddr+offset));
+		}
+	}
 	left = __copy_to_user(desc->buf, kaddr + offset, size);
 	kunmap(page);
 	

--------------2BD94515AC96F0EBA3546C45--

