Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUFMPyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUFMPyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 11:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUFMPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 11:54:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:38082 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265195AbUFMPyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 11:54:18 -0400
Subject: Re: [PATCH] Fix ppc64 out_be64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: anton@au.ibm.com, linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <521xkk77xh.fsf@topspin.com>
References: <521xkk77xh.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1087141822.8210.176.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 10:50:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -static inline void out_be64(volatile unsigned long *addr, int val)
> +static inline void out_be64(volatile unsigned long *addr, unsigned long val)
>  {
> -	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
> +	__asm__ __volatile__("std %1,%0; sync" : "=m" (*addr) : "r" (val));
>  }

Ugh ? The syntax of std is std rS, ds(rA), so your fix doesn't look good to me,
and it definitely builds with the current syntax, though I agree the type
is indeed wrong. I also spotted another bug where we forgot to change an
eieio into sync in there though.

Does this totally untested patch works for you ?

===== include/asm-ppc64/io.h 1.18 vs edited =====
--- 1.18/include/asm-ppc64/io.h	2004-05-21 02:50:11 -05:00
+++ edited/include/asm-ppc64/io.h	2004-06-12 19:01:41 -05:00
@@ -307,7 +307,7 @@
 
 static inline void out_be32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio"
+	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
 			     : "=m" (*addr) : "r" (val));
 }
 
@@ -358,7 +358,7 @@
 
 static inline void out_be64(volatile unsigned long *addr, int val)
 {
-	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
 #ifndef CONFIG_PPC_ISERIES 


