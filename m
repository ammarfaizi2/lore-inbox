Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319281AbSH3BKV>; Thu, 29 Aug 2002 21:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319331AbSH3BKU>; Thu, 29 Aug 2002 21:10:20 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:55695 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319281AbSH3BKT>;
	Thu, 29 Aug 2002 21:10:19 -0400
Subject: [PATCH] i386 dynamic fixup SMP deadlock workaround
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MmbBEQ+WUKaQmloZjARt"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Aug 2002 03:14:39 +0200
Message-Id: <1030670079.1491.164.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MmbBEQ+WUKaQmloZjARt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch works around the deadlock that would happen if another CPU is
waiting with interrupts disabled for the CPU executing the fixup.

This is worked around by waiting up to 1000 iterations and emulating the
instruction if the other CPU still doesn't respond.

This patch is sent mostly for completeness since I think that at this
point it is better to just drop the idea of dynamic fixups and instead
do them at bootup (or module load) using a list of fixups in a separate
section: this way SMP becomes irrelevant.

In other words, dynamic fixups are cooler and slightly better due to
automatic support of compiler prefetches, modules and reduced size but
given the Intel erratas, the cost in stability becomes too much.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup_smp/arch/i386/kernel/fixup.c linux-2.5.32_fixup_smp_unlock/arch/i386/kernel/fixup.c
--- linux-2.5.32_fixup_smp/arch/i386/kernel/fixup.c	2002-08-29 00:01:15.000000000 +0200
+++ linux-2.5.32_fixup_smp_unlock/arch/i386/kernel/fixup.c	2002-08-30 02:57:22.000000000 +0200
@@ -54,7 +54,6 @@
    done and instructions are emulated if necessary.
 */
 u8 lock_fixup = 0;
-#define perform_fixup lock_fixup
 
 #ifdef CONFIG_SMP
 static spinlock_t smp_lock = SPIN_LOCK_UNLOCKED;
@@ -150,20 +149,29 @@ static inline void dynamic_fixup_send_IP
 	}
 }
 
-static void __dynamic_fixup_smp_lock(void)
+#define MAX_WAIT_ITERS 1000
+static unsigned __dynamic_fixup_smp_lock(void)
 {
+	int count;
 	local_irq_disable();
 	dynamic_fixup_smp_mask_lock();
 
 	dynamic_fixup_send_IPIs(DYNAMIC_FIXUP_SMP_LOCK_VECTOR);
-	while (smp_lock_spinning_cpus != cpu_online_map) {}
+
+	/* If MAX_WAIT_ITERS iterations elapse without the CPU stopping,
+	   we emulate to instruction; this is done to avoid deadlocks */
+	for(count = 0; (smp_lock_spinning_cpus != cpu_online_map) && (count < MAX_WAIT_ITERS); ++count) {}
+
+	return count < MAX_WAIT_ITERS;
 }
 
-static inline void dynamic_fixup_smp_lock(void)
+static inline unsigned dynamic_fixup_smp_lock(void)
 {
 	/* check if we are fixing up and we are smp */	
 	if(lock_fixup == 0xf0)
-		__dynamic_fixup_smp_lock();
+		return __dynamic_fixup_smp_lock();
+	else
+		return lock_fixup;
 }
 
 static inline void dynamic_fixup_smp_unlock(void)
@@ -176,7 +184,7 @@ static inline void dynamic_fixup_smp_unl
 	}
 }
 #else
-#define dynamic_fixup_smp_lock() do {} while(0)
+#define dynamic_fixup_smp_lock() lock_fixup
 #define dynamic_fixup_smp_unlock() do {} while(0)
 #endif
 
@@ -427,9 +435,10 @@ dynamic_fixup_start(void)
 void
 dynamic_fixup_x86_int(u32 ecx, u32 edx, u32 eax, u8 * eip)
 {
+	unsigned perform_fixup;
 	u8 *instr = eip - 2;
 	u32 value;
-	dynamic_fixup_smp_lock();
+	perform_fixup = dynamic_fixup_smp_lock();
 	value = atomic_read_unaligned32((u32 *) instr);
 	if ((value & 0xffff) == (0xcd | (DYNAMIC_FIXUP_VECTOR << 8))) {
 		switch ((u8) (value >> 16)) {
@@ -487,9 +496,10 @@ dynamic_fixup_x86_int(u32 ecx, u32 edx, 
 void
 dynamic_fixup_x86_int3(u32 ecx, u32 edx, u32 eax, u8 * eip)
 {
+	unsigned perform_fixup;
 	u8 *instr = eip - 1;
 	u32 value;
-	dynamic_fixup_smp_lock();
+	perform_fixup = dynamic_fixup_smp_lock();
 	value = atomic_read_unaligned32((u32 *) instr);
 	if ((u8) value == 0xcc) {
 		switch ((u8) (value >> 8)) {
@@ -554,7 +564,7 @@ modrm_length(u32 value)
 #define mod2 ((value >> 16) & 0xc0)
 
 static inline void
-handle_prefetch(decl_atomic u8 ** pinstr)
+handle_prefetch(decl_atomic unsigned perform_fixup, u8 ** pinstr)
 {
 	u8 *instr = *pinstr;
 	STAT_(prefetch);
@@ -572,9 +582,10 @@ handle_prefetch(decl_atomic u8 ** pinstr
 int
 dynamic_fixup_x86_ud(u8 ** pinstr)
 {
+	unsigned perform_fixup;
 	u8 *instr = *pinstr;
 	u32 value;
-	dynamic_fixup_smp_lock();
+	perform_fixup = dynamic_fixup_smp_lock();
 	value = atomic_read_unaligned32((u32 *) instr);
 	switch ((u8) value) {
 	case 0x0f:
@@ -594,14 +605,14 @@ dynamic_fixup_x86_ud(u8 ** pinstr)
 			switch (regop2) {
 			case 0:	/* prefetch */
 			case 1:	/* prefetchw */
-				handle_prefetch(want_atomic pinstr);
+				handle_prefetch(want_atomic perform_fixup, pinstr);
 				break;
 			}
 			break;
 		case 0x18:	/* Intel prefetch group 16 */
 			if (mod2 != MOD_REG) {
 				if (regop2 <= 3) {	/* prefetch{nta,t[012]} */
-					handle_prefetch(want_atomic pinstr);
+					handle_prefetch(want_atomic perform_fixup, pinstr);
 				}
 			}
 			break;


--=-MmbBEQ+WUKaQmloZjARt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bsb/djkty3ft5+cRAhS0AJ0Zq3U7I/REuR3+txeFEPFGSmpy1gCgnaWW
7r0Iat5IV2HTaMBTS8mTdqs=
=lXzT
-----END PGP SIGNATURE-----

--=-MmbBEQ+WUKaQmloZjARt--
