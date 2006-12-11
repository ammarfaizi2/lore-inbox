Return-Path: <linux-kernel-owner+w=401wt.eu-S1750706AbWLKW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWLKW7a (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWLKW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:59:30 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:35034 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750706AbWLKW73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:59:29 -0500
Date: Mon, 11 Dec 2006 23:58:06 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: [PATCH] Introduce jiffies_32 and related compare functions
In-reply-to: <457DCC60.3050006@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Message-id: <457DE27E.5000100@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Q9iG/GgRhe0eQp3l3Z2L9g)"
References: <200612112027.kBBKR4nG006298@shell0.pdx.osdl.net>
 <457DCC60.3050006@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Q9iG/GgRhe0eQp3l3Z2L9g)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Some subsystems dont need more than 32bits timestamps.

See for example net/ipv4/inetpeer.c and include/net/tcp.h :
#define tcp_time_stamp            ((__u32)(jiffies))


Because most timeouts should work with 'normal jiffies' that are 32bits on 
32bits platforms, it makes sense to be able to use only 32bits to store them 
and not 64 bits, to save ram.

This patch introduces jiffies_32, and related comparison functions 
time_after32(), time_before32(), time_after_eq32() and time_before_eq32().

I plan to use this infrastructure in network code for example (struct 
dst_entry comes to mind).

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary_(ID_Q9iG/GgRhe0eQp3l3Z2L9g)
Content-type: text/plain; name=jiffies_32.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=jiffies_32.patch

--- linux-2.6.19/include/linux/jiffies.h	2006-12-12 00:32:00.000000000 +0100
+++ linux-2.6.19-ed/include/linux/jiffies.h	2006-12-12 00:41:40.000000000 +0100
@@ -80,6 +80,11 @@
  */
 extern u64 __jiffy_data jiffies_64;
 extern unsigned long volatile __jiffy_data jiffies;
+/*
+ * Some subsystems need small deltas and can store 32 bits timestamps
+ * instead of 'long', to save space on 64bits platforms.
+ */
+#define jiffies_32 ((u32)jiffies)
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
@@ -131,6 +136,22 @@ static inline u64 get_jiffies_64(void)
 #define time_before_eq64(a,b)	time_after_eq64(b,a)
 
 /*
+ * Same as above, but does so with 32bits types.
+ * These must be used when using jiffies_32
+ */
+#define time_after32(a,b)	\
+	(typecheck(__u32, a) &&	\
+	 typecheck(__u32, b) && \
+	 ((__s32)(b) - (__s32)(a) < 0))
+#define time_before32(a,b)	time_after32(b,a)
+
+#define time_after_eq32(a,b)	\
+	(typecheck(__u32, a) && \
+	 typecheck(__u32, b) && \
+	 ((__s32)(a) - (__s32)(b) >= 0))
+#define time_before_eq32(a,b)	time_after_eq32(b,a)
+
+/*
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */

--Boundary_(ID_Q9iG/GgRhe0eQp3l3Z2L9g)--
