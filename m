Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSLCBDL>; Mon, 2 Dec 2002 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLCBDK>; Mon, 2 Dec 2002 20:03:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21916 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265890AbSLCBDG>; Mon, 2 Dec 2002 20:03:06 -0500
Subject: [PATCH] linux-2.4.20_summit_A0 (4/4)
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1038877458.6878.29.camel@w-jstultz2.beaverton.ibm.com>
References: <1038877250.6884.21.camel@w-jstultz2.beaverton.ibm.com>
	 <1038877322.6884.24.camel@w-jstultz2.beaverton.ibm.com>
	 <1038877399.6878.27.camel@w-jstultz2.beaverton.ibm.com>
	 <1038877458.6878.29.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038877550.6878.32.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:05:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	4/4: CONFIG_X86_SUMMIT, auto-detection, cleanup

Please apply.

Thanks
-john


diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Dec  2 13:41:44 2002
+++ b/Documentation/Configure.help	Mon Dec  2 13:41:44 2002
@@ -246,13 +246,21 @@
 
   If unsure, say N.
 
-Multiquad support for NUMA systems
-CONFIG_MULTIQUAD
+Multiquad support for NUMAQ systems
+CONFIG_X86_NUMAQ
   This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
   multiquad box. This changes the way that processors are bootstrapped,
   and uses Clustered Logical APIC addressing mode instead of Flat Logical.
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
+
+Support for IBM Summit (EXA) systems
+CONFIG_X86_SUMMIT
+  This option is needed for IBM systems that use the Summit/EXA chipset.
+  (EXA: Extendable Xseries Architecture)In particular, it is needed for 
+  the x440 (even for the 4-CPU model).
+
+  If you don't have this computer, you may safely say N.
 
 IO-APIC support on uniprocessors
 CONFIG_X86_UP_IOAPIC
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Dec  2 13:41:43 2002
+++ b/arch/i386/config.in	Mon Dec  2 13:41:43 2002
@@ -216,7 +216,19 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+      #Platform Choices
+      bool ' Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
+      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+         define_bool CONFIG_X86_CLUSTERED_APIC y
+		 define_bool CONFIG_MULTIQUAD y
+      fi
+      bool ' IBM x440 (Summit/EXA) support' CONFIG_X86_SUMMIT
+      if [ "$CONFIG_X86_SUMMIT" = "y" ]; then
+         define_bool CONFIG_X86_CLUSTERED_APIC y
+      fi
+   fi
 fi
 
 bool 'Unsynced TSC support' CONFIG_X86_TSC_DISABLE
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Mon Dec  2 13:41:43 2002
+++ b/arch/i386/kernel/mpparse.c	Mon Dec  2 13:41:43 2002
@@ -67,8 +67,11 @@
 unsigned long phys_cpu_present_map;
 unsigned long logical_cpu_present_map;
 
+#ifdef CONFIG_X86_CLUSTERED_APIC
 unsigned char esr_disable = 0;
-
+unsigned char clustered_apic_mode = CLUSTERED_APIC_NONE;
+unsigned int apic_broadcast_id = APIC_BROADCAST_ID_APIC;
+#endif
 unsigned char raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
@@ -400,7 +403,7 @@
 
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
-	char str[16];
+	char oem[16], prod[14];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
@@ -425,14 +428,16 @@
 		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 		return 0;
 	}
-	memcpy(str,mpc->mpc_oem,8);
-	str[8]=0;
-	printk("OEM ID: %s ",str);
-
-	memcpy(str,mpc->mpc_productid,12);
-	str[12]=0;
-	printk("Product ID: %s ",str);
+	memcpy(oem,mpc->mpc_oem,8);
+	oem[8]=0;
+	printk("OEM ID: %s ",oem);
+
+	memcpy(prod,mpc->mpc_productid,12);
+	prod[12]=0;
+	printk("Product ID: %s ",prod);
 
+	detect_clustered_apic(oem, prod);
+	
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
 	/* save the local APIC address, it might be non-default,
@@ -512,9 +517,18 @@
 	}
 
 	if (clustered_apic_mode){
-		esr_disable = 1;
 		phys_cpu_present_map = logical_cpu_present_map;
 	}
+
+
+	printk("Enabling APIC mode: ");
+	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
+		printk("Clustered Logical.	");
+	else if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		printk("Physical.	");
+	else
+		printk("Flat.	");
+	printk("Using %d I/O APICs\n",nr_ioapics);
 
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
diff -Nru a/include/asm-i386/apicdef.h b/include/asm-i386/apicdef.h
--- a/include/asm-i386/apicdef.h	Mon Dec  2 13:41:43 2002
+++ b/include/asm-i386/apicdef.h	Mon Dec  2 13:41:43 2002
@@ -110,7 +110,12 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
+#ifdef CONFIG_X86_CLUSTERED_APIC
+#define MAX_IO_APICS 32
+#else
 #define MAX_IO_APICS 8
+#endif
+
 
 /*
  * The broadcast ID is 0xF for old APICs and 0xFF for xAPICs.  SAPICs
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Dec  2 13:41:43 2002
+++ b/include/asm-i386/mpspec.h	Mon Dec  2 13:41:43 2002
@@ -15,12 +15,13 @@
 
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
+ * xAPICs can have up to 256.  SAPICs have 16 ID bits.
  */
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_X86_CLUSTERED_APIC
 #define MAX_APICS 256
-#else /* !CONFIG_MULTIQUAD */
+#else
 #define MAX_APICS 16
-#endif /* CONFIG_MULTIQUAD */
+#endif
 
 #define MAX_MPC_ENTRY 1024
 
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Mon Dec  2 13:41:43 2002
+++ b/include/asm-i386/smpboot.h	Mon Dec  2 13:41:43 2002
@@ -8,40 +8,42 @@
 	CLUSTERED_APIC_NUMAQ
 };
 
-#ifdef CONFIG_MULTIQUAD
- #define clustered_apic_mode (CLUSTERED_APIC_NUMAQ)
-#else /* !CONFIG_MULTIQUAD */
- #define clustered_apic_mode (CLUSTERED_APIC_NONE)
-#endif /* CONFIG_MULTIQUAD */
-
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_X86_CLUSTERED_APIC
+extern unsigned int apic_broadcast_id;
+extern unsigned char clustered_apic_mode;
 extern unsigned char esr_disable;
-static inline int target_cpus(void)
+extern unsigned char int_delivery_mode;
+extern unsigned int int_dest_addr_mode;
+static inline void detect_clustered_apic(char* oem, char* prod)
 {
-	switch(clustered_apic_mode){
-		case CLUSTERED_APIC_NUMAQ:
-			/* Broadcast intrs to local quad only. */
-			return APIC_BROADCAST_ID_APIC;
-		default:
+	/*
+	 * Can't recognize Summit xAPICs at present, so use the OEM ID.
+	 */
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(prod, "VIGIL SMP", 9)){
+		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode = APIC_DEST_PHYSICAL;
+		int_delivery_mode = dest_Fixed;
+		esr_disable = 1;
+	}
+	else if (!strncmp(oem, "IBM NUMA", 8)){
+		clustered_apic_mode = CLUSTERED_APIC_NUMAQ;
+		apic_broadcast_id = APIC_BROADCAST_ID_APIC;
+		int_dest_addr_mode = APIC_DEST_LOGICAL;
+		int_delivery_mode = dest_LowestPrio;
+		esr_disable = 1;
 	}
-	return cpu_online_map;
 }
-#ifdef CONFIG_X86_IO_APIC
-extern unsigned char int_delivery_mode;
-extern unsigned int int_dest_addr_mode;
 #define	INT_DEST_ADDR_MODE (int_dest_addr_mode)
 #define	INT_DELIVERY_MODE (int_delivery_mode)
-#endif /* CONFIG_X86_IO_APIC */
-#else /* CONFIG_X86_LOCAL_APIC */
+#else /* CONFIG_X86_CLUSTERED_APIC */
+#define apic_broadcast_id (APIC_BROADCAST_ID_APIC)
+#define clustered_apic_mode (CLUSTERED_APIC_NONE)
 #define esr_disable (0)
-#define target_cpus() (0x01)
-#ifdef CONFIG_X86_IO_APIC
+#define detect_clustered_apic(x,y)
 #define INT_DEST_ADDR_MODE (APIC_DEST_LOGICAL)	/* logical delivery */
 #define INT_DELIVERY_MODE (dest_LowestPrio)
-#endif /* CONFIG_X86_IO_APIC */
-#endif /* CONFIG_X86_LOCAL_APIC */
-
-#define apic_broadcast_id (APIC_BROADCAST_ID_APIC)
+#endif /* CONFIG_X86_CLUSTERED_APIC */
 #define BAD_APICID 0xFFu
 
 #define TRAMPOLINE_LOW phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0x8:0x467)
@@ -93,4 +95,23 @@
 #define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
 #endif /* CONFIG_MULTIQUAD */
 
+#ifdef CONFIG_X86_CLUSTERED_APIC
+static inline int target_cpus(void)
+{
+	static int cpu;
+	switch(clustered_apic_mode){
+		case CLUSTERED_APIC_NUMAQ:
+			/* Broadcast intrs to local quad only. */
+			return APIC_BROADCAST_ID_APIC;
+		case CLUSTERED_APIC_XAPIC:
+			/*round robin the interrupts*/
+			cpu = (cpu+1)%smp_num_cpus;
+			return cpu_to_physical_apicid(cpu);
+		default:
+	}
+	return cpu_online_map;
+}
+#else
+#define target_cpus() (0x01)
+#endif
 #endif



