Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWFOLL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWFOLL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWFOLL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:11:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3024 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030195AbWFOLL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:11:26 -0400
Date: Thu, 15 Jun 2006 12:11:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: [PATCH] m68k: bogus constraints in signal.h
Message-ID: <20060615111126.GJ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bfset and friends need "o", not "m" - they don't work with autodecrement
memory arguments.  bitops.h had it fixed, signal.h hadn't...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/signal.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

904a77fc8bfa159204cc895d672096e5d3a5a46e
diff --git a/include/asm-m68k/signal.h b/include/asm-m68k/signal.h
index b7b7ea2..f645162 100644
--- a/include/asm-m68k/signal.h
+++ b/include/asm-m68k/signal.h
@@ -156,13 +156,13 @@ #define __HAVE_ARCH_SIG_BITOPS
 
 static inline void sigaddset(sigset_t *set, int _sig)
 {
-	__asm__("bfset %0{%1,#1}" : "=m" (*set) : "id" ((_sig - 1) ^ 31)
+	__asm__("bfset %0{%1,#1}" : "=o" (*set) : "id" ((_sig - 1) ^ 31)
 		: "cc");
 }
 
 static inline void sigdelset(sigset_t *set, int _sig)
 {
-	__asm__("bfclr %0{%1,#1}" : "=m"(*set) : "id"((_sig - 1) ^ 31)
+	__asm__("bfclr %0{%1,#1}" : "=o"(*set) : "id"((_sig - 1) ^ 31)
 		: "cc");
 }
 
@@ -176,7 +176,7 @@ static inline int __gen_sigismember(sigs
 {
 	int ret;
 	__asm__("bfextu %1{%2,#1},%0"
-		: "=d"(ret) : "m"(*set), "id"((_sig-1) ^ 31));
+		: "=d"(ret) : "o"(*set), "id"((_sig-1) ^ 31));
 	return ret;
 }
 
-- 
1.3.GIT

