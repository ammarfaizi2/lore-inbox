Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSLCA6N>; Mon, 2 Dec 2002 19:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSLCA6N>; Mon, 2 Dec 2002 19:58:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:8676 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265830AbSLCA6M>;
	Mon, 2 Dec 2002 19:58:12 -0500
Subject: [PATCH] linux-2.4.20_summit_A0 (1/4)
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1038877250.6884.21.camel@w-jstultz2.beaverton.ibm.com>
References: <1038877250.6884.21.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038877322.6884.24.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:02:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	Part 1/4: Clustered apic tweaks

Please apply.

Thanks
-john

diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Mon Dec  2 11:36:17 2002
+++ b/arch/i386/kernel/apic.c	Mon Dec  2 11:36:17 2002
@@ -261,6 +261,14 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
+static unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+	
+	id = 1UL << smp_processor_id();
+	return (old & ~APIC_LDR_MASK)|SET_APIC_LOGICAL_ID(id);
+}
+
 void __init setup_local_APIC (void)
 {
 	unsigned long value, ver, maxlvt;
@@ -304,9 +312,7 @@
 		 * Set up the logical destination ID.
 		 */
 		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
+		apic_write_around(APIC_LDR, calculate_ldr(value));
 	}
 
 	/*
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Dec  2 11:36:17 2002
+++ b/arch/i386/kernel/io_apic.c	Mon Dec  2 11:36:17 2002
@@ -1067,7 +1067,7 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
+		if (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1086,7 +1086,7 @@
 			for (i = 0; i < 0xf; i++)
 				if (!(phys_id_present_map & (1 << i)))
 					break;
-			if (i >= 0xf)
+			if (i >= apic_broadcast_id)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Mon Dec  2 11:36:17 2002
+++ b/include/asm-i386/smpboot.h	Mon Dec  2 11:36:17 2002
@@ -41,6 +41,9 @@
 #endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+#define apic_broadcast_id (APIC_BROADCAST_ID_APIC)
+
+
 #define TRAMPOLINE_LOW phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0x8:0x467)
 #define TRAMPOLINE_HIGH phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0xa:0x469)
 




