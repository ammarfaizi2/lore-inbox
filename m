Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130648AbRCITkc>; Fri, 9 Mar 2001 14:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbRCITkW>; Fri, 9 Mar 2001 14:40:22 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:50854 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S130648AbRCITkK>; Fri, 9 Mar 2001 14:40:10 -0500
Date: Fri, 9 Mar 2001 19:40:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Andersen <andersee@debian.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysinfo() >= 4GB ram+swap
Message-ID: <Pine.LNX.4.21.0103091937320.1133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. To maximize compatibility, sys_sysinfo() tries to replace page
   counts by byte counts if no overflow: but its checks forget the
   most likely overflow.  Just try adding a few 2GB swaps to your
   system, watching sysinfo() output as you do so.
2. It nicely defends the caller by doing the overflow test on total
   rather than individual fields: but it's wrong to add on totalhigh,
   that's included in totalram on all HIGHMEM arches (i386 ppc sparc).
3. Comment says it's dividing values by mem_unit: no, multiplying.

Patch below against 2.4.3-pre3, 2.4.2-ac17, or any 2.4.[0123] tree:
looks more than it really is, used goto rather than further nesting.

--- 2.4.3-pre3/kernel/info.c	Tue Sep  5 21:57:57 2000
+++ linux/kernel/info.c	Fri Mar  9 18:16:03 2001
@@ -33,41 +33,46 @@
 	si_swapinfo(&val);
 
 	{
-		/* If the sum of all the available memory (i.e. ram + swap +
-		 * highmem) is less then can be stored in a 32 bit unsigned long
-		 * then we can be binary compatible with 2.2.x kernels.  If not,
-		 * well, who cares since in that case 2.2.x was broken anyways...
+		unsigned long mem_total, sav_total;
+		unsigned int mem_unit, bitcount;
+
+		/* If the sum of all the available memory (i.e. ram + swap)
+		 * is less than can be stored in a 32 bit unsigned long then
+		 * we can be binary compatible with 2.2.x kernels.  If not,
+		 * well, in that case 2.2.x was broken anyways...
 		 *
 		 *  -Erik Andersen <andersee@debian.org> */
 
-		unsigned long mem_total = val.totalram + val.totalswap;
-		if ( !(mem_total < val.totalram || mem_total < val.totalswap)) {
-			unsigned long mem_total2 = mem_total + val.totalhigh; 
-			if (!(mem_total2 < mem_total || mem_total2 < val.totalhigh))
-			{
-				/* If mem_total did not overflow.  Divide all memory values by
-				 * mem_unit and set mem_unit=1.  This leaves things compatible with
-				 * 2.2.x, and also retains compatibility with earlier 2.4.x
-				 * kernels...  */
-
-				int bitcount = 0;
-				while (val.mem_unit > 1) 
-				{
-					bitcount++;
-					val.mem_unit >>= 1;
-				}
-				val.totalram <<= bitcount;
-				val.freeram <<= bitcount;
-				val.sharedram <<= bitcount;
-				val.bufferram <<= bitcount;
-				val.totalswap <<= bitcount;
-				val.freeswap <<= bitcount;
-				val.totalhigh <<= bitcount;
-				val.freehigh <<= bitcount;
-			}
+		mem_total = val.totalram + val.totalswap;
+		if (mem_total < val.totalram || mem_total < val.totalswap)
+			goto out;
+		bitcount = 0;
+		mem_unit = val.mem_unit;
+		while (mem_unit > 1) {
+			bitcount++;
+			mem_unit >>= 1;
+			sav_total = mem_total;
+			mem_total <<= 1;
+			if (mem_total < sav_total)
+				goto out;
 		}
-	}
 
+		/* If mem_total did not overflow, multiply all memory values by
+		 * val.mem_unit and set it to 1.  This leaves things compatible
+		 * with 2.2.x, and also retains compatibility with earlier 2.4.x
+		 * kernels...  */
+
+		val.mem_unit = 1;
+		val.totalram <<= bitcount;
+		val.freeram <<= bitcount;
+		val.sharedram <<= bitcount;
+		val.bufferram <<= bitcount;
+		val.totalswap <<= bitcount;
+		val.freeswap <<= bitcount;
+		val.totalhigh <<= bitcount;
+		val.freehigh <<= bitcount;
+	}
+out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
 	return 0;

