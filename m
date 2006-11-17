Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755806AbWKQTcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbWKQTcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbWKQTcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:32:04 -0500
Received: from [151.97.230.35] ([151.97.230.35]:4836 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1755806AbWKQTcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:32:00 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] Make x86_64 udelay() round up instead of down - try2
Date: Fri, 17 Nov 2006 20:30:47 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Message-Id: <20061117193047.13096.60874.stgit@americanbeauty.home.lan>
In-Reply-To: <20061101163043.GA2602@elf.ucw.cz>
References: <20061101163043.GA2602@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Port two patches from i386 to x86_64 delay.c to make sure all rounding is done
upward instead of downward.

There is no sign in commit messages that the mismatch was done on purpose, and
"delay() guarantees sleeping at least for the specified time" is still a valid
rule IMHO.

The original x86 patches are both from pre-GIT era, i.e.:

"[PATCH] round up  in __udelay()" in commit
54c7e1f5cc6771ff644d7bc21a2b829308bd126f

"[PATCH] add 1 in __const_udelay()" in commit
42c77a9801b8877d8b90f65f75db758822a0bccc

(both commits are from the BK repository converted to git).

Changes from try1:
* fixed the code, compile tested against warnings;
* now it is a real round up rather than "round down and add 1"

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/lib/delay.c    |    4 ++--
 include/asm-x86_64/delay.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86_64/lib/delay.c b/arch/x86_64/lib/delay.c
index 50be909..b488743 100644
--- a/arch/x86_64/lib/delay.c
+++ b/arch/x86_64/lib/delay.c
@@ -40,13 +40,13 @@ EXPORT_SYMBOL(__delay);
 
 inline void __const_udelay(unsigned long xloops)
 {
-	__delay((xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32);
+	__delay((xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy + (1UL << 32) - 1) >> 32);
 }
 EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
+	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
 }
 EXPORT_SYMBOL(__udelay);
 
diff --git a/include/asm-x86_64/delay.h b/include/asm-x86_64/delay.h
index 65f64ac..40146f6 100644
--- a/include/asm-x86_64/delay.h
+++ b/include/asm-x86_64/delay.h
@@ -16,7 +16,7 @@ extern void __const_udelay(unsigned long
 extern void __delay(unsigned long loops);
 
 #define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c6ul)) : \
+	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
 	__udelay(n))
 
 #define ndelay(n) (__builtin_constant_p(n) ? \
