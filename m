Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTDRLKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbTDRLKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:10:49 -0400
Received: from ns1.mol.ru ([212.8.224.2]:12502 "EHLO mailhub.mol.ru")
	by vger.kernel.org with ESMTP id S263021AbTDRLKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:10:47 -0400
Date: Fri, 18 Apr 2003 15:22:51 +0400 (MSD)
From: Arcady Stepanov <penguin@mol.ru>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/ipv4/route.c, kernel 2.4.20
Message-ID: <Pine.LNX.4.33.0304181500140.7345-100000@penguin-hole.mol.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

After upgrading a kernel from 2.4.19 to 2.4.20, I notice a bug
in ip_rt_acct_read() @ net/ipv4/route.c causing incorrect results
when reading route accounting information
from /proc/net/rt_acct pseudofile. Look at this example output from rtacct
utility:

[penguin@hq2 penguin]$ rtacct
Realm      BytesTo    PktsTo     BytesFrom  PktsFrom
unknown    2525573046 17491813   2696204488 15870526
macom.rus  2287217919 13724644   1092230247 14569843
macom.def  1670916923 15376790   3028924585 16093284
mol.arbat  476286103  884267     380803784  827802
mol.core   758578958  5083436    428582889  5382495
mol.dip    1953973432 3800121    279550530  3437570

-- [skipped] --

192        2525573046 17491813   2696204488 15870526
194        2287217919 13724644   1092230247 14569843
195        1670916923 15376790   3028924585 16093284
199        476286103  884267     380803784  827802
200        758578958  5083436    428582889  5382495
201        1953973432 3800121    279550530  3437570

-- [skipped] --

As you can see, all realms with numbers < 192 has a "twins" with
>= 192 with exactly same statistics data. Statistics for _real_ realms with 
numbers >= 192 becomes inaccessible. These results caused
by ip_rt_acct_read function, which has been completely owerwritten
in 2.4.20: New code completely ignores offset argument when copying stats data
in buffer.

The patch is trivial:

--- net/ipv4/route.c.orig	Sun Jan  5 15:29:10 2003
+++ net/ipv4/route.c	Fri Apr 18 10:11:23 2003
@@ -2422,7 +2422,7 @@
 /* This code sucks.  But you should have seen it before! --RR */
 
 /* IP route accounting ptr for this logical cpu number. */
-#define IP_RT_ACCT_CPU(i) (ip_rt_acct + cpu_logical_map(i) * 256)
+#define IP_RT_ACCT_CPU(i) ((u8*)ip_rt_acct + cpu_logical_map(i) * 256)
 
 static int ip_rt_acct_read(char *buffer, char **start, off_t offset,
 			   int length, int *eof, void *data)
@@ -2442,17 +2442,22 @@
 		*eof = 1;
 	}
 
-	/* Copy first cpu. */
 	*start = buffer;
-	memcpy(buffer, IP_RT_ACCT_CPU(0), length);
 
-	/* Add the other cpus in, one int at a time */
-	for (i = 1; i < smp_num_cpus; i++) {
-		unsigned int j;
-		for (j = 0; j < length/4; j++)
-			((u32*)buffer)[j] += ((u32*)IP_RT_ACCT_CPU(i))[j];
+	if (length > 0)
+	{
+		/* Copy first cpu. */
+		memcpy(buffer, IP_RT_ACCT_CPU(0) + offset, length);
+
+		/* Add the other cpus in, one int at a time */
+		for (i = 1; i < smp_num_cpus; i++) {
+			unsigned int j;
+			for (j = 0; j < length/4; j++)
+				((u32*)buffer)[j] += ((u32*)(IP_RT_ACCT_CPU(i) + offset))[j];
+		}
+		return length;
 	}
-	return length;
+	return 0;
 }
 #endif
 
It also cures a bug in pointer aritmetics in IP_RT_ACCT_CPU macro, which
will cause incorrect statistics output on SMP systems.

-- 
   BW, Arcady Stepanov (AS713-RIPE, AS28-RIPN).

   Micronic on-line Network Operating Center.
   email:noc@mol.ru; phone: +7 095 2320012

==========================================
 All that we can do is just survive
 All that we can do to help ourselves
 Is stay alive...
 
    Rush, "Red Sector A"
==========================================

