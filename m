Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264866AbUEUXFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbUEUXFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUEUXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:03:25 -0400
Received: from twin.jikos.cz ([213.151.79.26]:35985 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S264853AbUEUW6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:58:31 -0400
Date: Fri, 21 May 2004 00:16:06 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: linux-kernel@vger.kernel.org
cc: pekkas@netcore.fi, davem@redhat.com
Subject: [PATCH] IPv6 can't be built as module additionally
Message-ID: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It is not possible to build ipv6 for already compiled and running kernel, 
recompilation of whole kernel, even if building as a module, is typically 
a must. This is because ipv6-specific functions in drivers/char/random.c 
are inside #ifdefs, and as random.c is almost always built directly into 
kernel, recompilation of whole kernel can't be avoided. The corresponding 
functions for IPv4 in random.c are not inside those ifdefs, and I think 
that IPv6 shouldn't be either. Recompiling whole kernel just because I 
want to build ipv6 module is quite annoying. The following patch removes 
those ifdefs and makes additional compilation of ipv6 module possible.

--- drivers/char/random.c.old	Mon May 10 04:32:00 2004
+++ drivers/char/random.c	Thu May 20 23:58:27 2004
@@ -2146,8 +2146,6 @@
 	/* Alternative: return sum of all words? */
 }
 
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-
 static __u32 twothirdsMD4Transform (__u32 const buf[4], __u32 const in[12])
 {
 	__u32	a = buf[0], b = buf[1], c = buf[2], d = buf[3];
@@ -2197,7 +2195,6 @@
 	return buf[1] + b;	/* "most hashed" word */
 	/* Alternative: return sum of all words? */
 }
-#endif
 
 #undef ROUND
 #undef F
@@ -2271,7 +2268,6 @@
 	return keyptr;
 }
 
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 __u32 secure_tcpv6_sequence_number(__u32 *saddr, __u32 *daddr,
 				   __u16 sport, __u16 dport)
 {
@@ -2309,7 +2305,6 @@
 }
 
 EXPORT_SYMBOL(secure_ipv6_id);
-#endif
 
 
 __u32 secure_tcp_sequence_number(__u32 saddr, __u32 daddr,

-- 
JiKos.
