Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHaQ50>; Sat, 31 Aug 2002 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSHaQ50>; Sat, 31 Aug 2002 12:57:26 -0400
Received: from ppp-217-133-221-247.dialup.tiscali.it ([217.133.221.247]:60034
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317694AbSHaQ5Z>; Sat, 31 Aug 2002 12:57:25 -0400
Subject: [PATCH] Fix panic if pnpbios is enabled and speed up its check in
	do_trap
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-djuxB/rqjsQf1WyVkGK6"
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Aug 2002 19:01:45 +0200
Message-Id: <1030813305.1458.17.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-djuxB/rqjsQf1WyVkGK6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes the pnpbios CS check to check for the correct values
(it wasn't up to date with the various GDT reshuffles), moves it inside
the kernel mode check, modifies it so that it takes less instructions
and marks it with unlikely().

Note that the 2.5.32 version of this check will cause the kernel to
always panic since it checks for the kernel segments and will thus
decide to jump to the pnpbios fault handler without being in pnpbios.
pnpbios_core.c instead seems to use the correct values.

diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/traps.c linux-2.5.32_pnpbelow/arch/i386/kernel/traps.c
--- linux-2.5.32/arch/i386/kernel/traps.c	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_pnpbelow/arch/i386/kernel/traps.c	2002-08-31 18:43:06.000000000 +0200
@@ -311,21 +311,6 @@ static void inline do_trap(int trapnr, i
 	if (vm86 && regs->eflags & VM_MASK)
 		goto vm86_trap;
 
-#ifdef CONFIG_PNPBIOS		
-	if (regs->xcs == 0x60 || regs->xcs == 0x68)
-	{
-		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
-		extern u32 pnp_bios_is_utter_crap;
-		pnp_bios_is_utter_crap = 1;
-		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
-		__asm__ volatile(
-			"movl %0, %%esp\n\t"
-			"jmp *%1\n\t"
-			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
-		panic("do_trap: can't hit this");
-	}
-#endif	
-
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
 
@@ -341,7 +326,23 @@ static void inline do_trap(int trapnr, i
 	}
 
 	kernel_trap: {
-		unsigned long fixup = search_exception_table(regs->eip);
+		unsigned long fixup;
+#ifdef CONFIG_PNPBIOS
+		if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
+		{
+			extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
+			extern u32 pnp_bios_is_utter_crap;
+			pnp_bios_is_utter_crap = 1;
+			printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
+			__asm__ volatile(
+				"movl %0, %%esp\n\t"
+				"jmp *%1\n\t"
+				: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
+			panic("do_trap: can't hit this");
+		}
+#endif	
+		
+		fixup = search_exception_table(regs->eip);
 		if (fixup)
 			regs->eip = fixup;
 		else	


--=-djuxB/rqjsQf1WyVkGK6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cPZ5djkty3ft5+cRAtFLAKDC8X5n0EjAqXdDDRyV8qOi5Y4/IwCcCjBX
22Lzb3Mo4GTa8m5uz4RuXXg=
=6GIZ
-----END PGP SIGNATURE-----

--=-djuxB/rqjsQf1WyVkGK6--
