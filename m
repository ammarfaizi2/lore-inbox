Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSJPXE0>; Wed, 16 Oct 2002 19:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSJPXEZ>; Wed, 16 Oct 2002 19:04:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28800 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261485AbSJPXEO>;
	Wed, 16 Oct 2002 19:04:14 -0400
Subject: [PATCH] linux-2.4.20-pre11_clustered-apic-tweaks_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, James <jamesclv@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 16:02:08 -0700
Message-Id: <1034809328.19981.219.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, all, 

	Originally I was going to send a larger patch that had the rest of the
needed changes for summit, but I've gone through and split that up even
more. This is similar to the earlier cleanup I sent you (although this
one compiles & boots on UP properly :), and just moves some code around
in preparation for further changes. 

	Again,  this code originally comes from James Cleverdon's summit patch,
which I have been chopping/crushing/blending up into hopefully more
easily digestible pieces. Thus I deserve none of the credit, and all the
blame for this. 

please consider for acceptance.

thanks
-john

diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Wed Oct 16 15:52:39 2002
+++ b/arch/i386/kernel/apic.c	Wed Oct 16 15:52:39 2002
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
--- a/arch/i386/kernel/io_apic.c	Wed Oct 16 15:52:39 2002
+++ b/arch/i386/kernel/io_apic.c	Wed Oct 16 15:52:39 2002
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
--- a/include/asm-i386/smpboot.h	Wed Oct 16 15:52:39 2002
+++ b/include/asm-i386/smpboot.h	Wed Oct 16 15:52:39 2002
@@ -41,6 +41,9 @@
 #endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+#define apic_broadcast_id (APIC_BROADCAST_ID_APIC)
+
+
 #define TRAMPOLINE_LOW phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0x8:0x467)
 #define TRAMPOLINE_HIGH phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0xa:0x469)
 



