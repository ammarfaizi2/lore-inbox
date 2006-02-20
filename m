Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWBTNjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWBTNjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWBTNjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:39:47 -0500
Received: from mail.renesas.com ([202.234.163.13]:9946 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1030203AbWBTNjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:39:46 -0500
Date: Mon, 20 Feb 2006 22:39:37 +0900 (JST)
Message-Id: <20060220.223937.957833198.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.16-rc3] m32r: __cmpxchg_u32 fix
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug of include/asm-m32r/system.h:__cmpxchg_u32().

  static __inline__ unsigned long
  __cmpxchg_u32(volatile unsigned int *p, unsigned int old, unsigned int new);

In __cmpxchg_u32(), the "old" value must not be changed to the previous "*p"
value.  But the former code modifies the previous "*p" value.

A deadlock at _atomic_dec_and_lock sometimes happened due to this bug.

Please apply this patch.

Thanks,

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/system.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc3/include/asm-m32r/system.h
===================================================================
--- linux-2.6.16-rc3.orig/include/asm-m32r/system.h	2006-02-17 22:02:08.701003359 +0900
+++ linux-2.6.16-rc3/include/asm-m32r/system.h	2006-02-17 22:04:13.304341309 +0900
@@ -239,7 +239,7 @@ __cmpxchg_u32(volatile unsigned int *p, 
 		"	bra	2f;		\n"
                 "       .fillinsn		\n"
 		"1:"
-			M32R_UNLOCK" %2, @%1;	\n"
+			M32R_UNLOCK" %0, @%1;	\n"
                 "       .fillinsn		\n"
 		"2:"
 			: "=&r" (retval)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

