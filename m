Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWH1JU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWH1JU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWH1JU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:61626 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932373AbWH1JUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:20:25 -0400
Message-ID: <44F2B557.6020403@suse.de>
Date: Mon, 28 Aug 2006 11:20:23 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andreas Kleen <ak@suse.de>
Subject: [patch] fix up smp alternatives on x86-64
Content-Type: multipart/mixed;
 boundary="------------050906040207010302050700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050906040207010302050700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Don't use alternative_smp() in for __raw_spin_lock.  gcc
sometimes generates rip-relative addressing, so we can't
simply copy the instruction to another place.

Replace some leftover "lock;" with LOCK_PREFIX.

Fillup space with 0x90 (nop) instead of 0x42, so
"objdump -d -j .smp_altinstr_replacement vmlinux" gives more
readable results.

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg

--------------050906040207010302050700
Content-Type: text/plain;
 name="smpalt-fixup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpalt-fixup"

Subject: fix up smp alternatives on x86-64

Don't use alternative_smp() in for __raw_spin_lock.  gcc
sometimes generates rip-relative addressing, so we can't
simply copy the instruction to another place.

Replace some leftover "lock;" with LOCK_PREFIX.

Fillup space with 0x90 (nop) instead of 0x42, so
"objdump -d -j .smp_altinstr_replacement vmlinux" gives more
readable results.

Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
Index: linux-2.6.17/include/asm-i386/alternative.h
===================================================================
--- linux-2.6.17.orig/include/asm-i386/alternative.h	2006-08-28 10:21:18.000000000 +0200
+++ linux-2.6.17/include/asm-i386/alternative.h	2006-08-28 10:22:59.000000000 +0200
@@ -122,7 +122,7 @@ static inline void alternatives_smp_swit
 		      ".previous\n"					\
 		      ".section .smp_altinstr_replacement,\"awx\"\n"   	\
 		      "663:\n\t" upinstr "\n"     /* replacement */	\
-		      "664:\n\t.fill 662b-661b,1,0x42\n" /* space for original */ \
+		      "664:\n\t.fill 662b-661b,1,0x90\n" /* space for original */ \
 		      ".previous" : args)
 
 #define LOCK_PREFIX \
Index: linux-2.6.17/include/asm-x86_64/alternative.h
===================================================================
--- linux-2.6.17.orig/include/asm-x86_64/alternative.h	2006-08-28 10:21:21.000000000 +0200
+++ linux-2.6.17/include/asm-x86_64/alternative.h	2006-08-28 10:23:13.000000000 +0200
@@ -136,7 +136,7 @@ static inline void alternatives_smp_swit
 		      ".previous\n"					\
 		      ".section .smp_altinstr_replacement,\"awx\"\n"	\
 		      "663:\n\t" upinstr "\n"     /* replacement */	\
-		      "664:\n\t.fill 662b-661b,1,0x42\n" /* space for original */ \
+		      "664:\n\t.fill 662b-661b,1,0x90\n" /* space for original */ \
 		      ".previous" : args)
 
 #define LOCK_PREFIX \
Index: linux-2.6.17/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6.17.orig/include/asm-x86_64/spinlock.h	2006-08-28 10:21:21.000000000 +0200
+++ linux-2.6.17/include/asm-x86_64/spinlock.h	2006-08-28 11:07:14.000000000 +0200
@@ -21,7 +21,7 @@
 
 #define __raw_spin_lock_string \
 	"\n1:\t" \
-	"lock ; decl %0\n\t" \
+	LOCK_PREFIX "decl %0\n\t" \
 	"js 2f\n" \
 	LOCK_SECTION_START("") \
 	"2:\t" \
@@ -40,10 +40,18 @@
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
+#if 0
+	/* gcc sometimes uses %(rip) addressing, so we can't
+	 * simply move around instructions ... */
 	alternative_smp(
 		__raw_spin_lock_string,
 		__raw_spin_lock_string_up,
 		"=m" (lock->slock) : : "memory");
+#else
+	__asm__ __volatile__(
+		__raw_spin_lock_string
+		: "=m" (lock->slock) : : "memory");
+#endif
 }
 
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
@@ -125,12 +133,12 @@ static inline int __raw_write_trylock(ra
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+	asm volatile(LOCK_PREFIX "incl %0" :"=m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0"
+	asm volatile(LOCK_PREFIX "lock ; addl $" RW_LOCK_BIAS_STR ",%0"
 				: "=m" (rw->lock) : : "memory");
 }
 

--------------050906040207010302050700--
