Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271589AbRHUIEL>; Tue, 21 Aug 2001 04:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271590AbRHUIEC>; Tue, 21 Aug 2001 04:04:02 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32197 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271589AbRHUIDs>; Tue, 21 Aug 2001 04:03:48 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Andersen <andersee@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] sysinfo compatibility
Organisation: SAP LinuxLab
Date: 21 Aug 2001 10:03:11 +0200
Message-ID: <m3lmkd6ds0.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Alan,

sysinfo does use a new mem_unit field if ram+swap > MAX_ULONG. That
breaks 2.2 compatibility for a lot machines.

I think it is more resonable to use the mem_unit field only if one of
ram or swap is bigger than MAX_ULONG. (And 2.2 was only broken in that
case)

The appended patch implements that (and makes the logic a little bit
easier)

Greetings
		Christoph

diff -uNr 2.4.9/kernel/info.c 2.4.9-sysinfo/kernel/info.c
--- 2.4.9/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ 2.4.9-sysinfo/kernel/info.c	Wed Jul  4 16:56:23 2001
@@ -16,6 +16,7 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	unsigned int mem_unit;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
@@ -32,47 +33,36 @@
 	si_meminfo(&val);
 	si_swapinfo(&val);
 
-	{
-		unsigned long mem_total, sav_total;
-		unsigned int mem_unit, bitcount;
-
-		/* If the sum of all the available memory (i.e. ram + swap)
-		 * is less than can be stored in a 32 bit unsigned long then
-		 * we can be binary compatible with 2.2.x kernels.  If not,
-		 * well, in that case 2.2.x was broken anyways...
-		 *
-		 *  -Erik Andersen <andersee@debian.org> */
-
-		mem_total = val.totalram + val.totalswap;
-		if (mem_total < val.totalram || mem_total < val.totalswap)
-			goto out;
-		bitcount = 0;
-		mem_unit = val.mem_unit;
-		while (mem_unit > 1) {
-			bitcount++;
-			mem_unit >>= 1;
-			sav_total = mem_total;
-			mem_total <<= 1;
-			if (mem_total < sav_total)
-				goto out;
-		}
-
-		/* If mem_total did not overflow, multiply all memory values by
-		 * val.mem_unit and set it to 1.  This leaves things compatible
-		 * with 2.2.x, and also retains compatibility with earlier 2.4.x
-		 * kernels...  */
+	/*
+	 * If the the available memory or swap is less than can be
+	 * stored in a 32 bit unsigned long then we can be binary
+	 * compatible with 2.2.x kernels.  If not, well, in that case
+	 * 2.2.x was broken anyways...
+	 *
+	 *  -Erik Andersen <andersee@debian.org> 
+	 */
+
+	mem_unit = val.mem_unit;
+	if (val.totalram  * mem_unit > val.totalram &&
+	    val.totalswap * mem_unit > val.totalswap) {
+
+		/*
+		 * If mem_total did not overflow, multiply all memory
+		 * values by val.mem_unit and set it to 1.  This
+		 * leaves things compatible with 2.2.x, and also
+		 * retains compatibility with earlier 2.4.x kernels...
+		 */
 
 		val.mem_unit = 1;
-		val.totalram <<= bitcount;
-		val.freeram <<= bitcount;
-		val.sharedram <<= bitcount;
-		val.bufferram <<= bitcount;
-		val.totalswap <<= bitcount;
-		val.freeswap <<= bitcount;
-		val.totalhigh <<= bitcount;
-		val.freehigh <<= bitcount;
+		val.totalram  *= mem_unit;
+		val.freeram   *= mem_unit;
+		val.sharedram *= mem_unit;
+		val.bufferram *= mem_unit;
+		val.totalswap *= mem_unit;
+		val.freeswap  *= mem_unit;
+		val.totalhigh *= mem_unit;
+		val.freehigh  *= mem_unit;
 	}
-out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
 	return 0;

