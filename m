Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSJMUlY>; Sun, 13 Oct 2002 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJMUlX>; Sun, 13 Oct 2002 16:41:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:16512 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261662AbSJMUku>; Sun, 13 Oct 2002 16:40:50 -0400
Date: Sun, 13 Oct 2002 13:42:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 [4/4]
Message-ID: <40000000.1034541739@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch originally by James Cleverdon

This patch adds the config options (and associated help entry) for the
Summit machines, and adds support to autodetect them (iff the config
option is enabled) from mpparse.c

------------------------------

diff -urpN -X /home/fletch/.diff.exclude summit-3/arch/i386/Config.help summit-4/arch/i386/Config.help
--- summit-3/arch/i386/Config.help	Fri Oct 11 18:03:30 2002
+++ summit-4/arch/i386/Config.help	Sat Oct 12 11:42:45 2002
@@ -65,6 +65,12 @@ CONFIG_X86_NUMAQ
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+CONFIG_X86_SUMMIT
+  This option is needed for IBM systems that use the Summit/EXA chipset.
+  In particular, it is needed for the x440.
+
+  If you don't have one of these computers, you should say N here.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -urpN -X /home/fletch/.diff.exclude summit-3/arch/i386/config.in summit-4/arch/i386/config.in
--- summit-3/arch/i386/config.in	Fri Oct 11 18:03:30 2002
+++ summit-4/arch/i386/config.in	Sat Oct 12 11:50:02 2002
@@ -172,7 +172,8 @@ else
   if [ "$CONFIG_X86_NUMA" = "y" ]; then
      #Platform Choices
      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
-     if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+     bool 'IBM x440 (Summit/EXA) support' CONFIG_X86_SUMMIT
+     if [ "$CONFIG_X86_NUMAQ" = "y" -o "$CONFIG_X86_SUMMIT" = "y" ]; then
         define_bool CONFIG_CLUSTERED_APIC y
      fi
      # Common NUMA Features
diff -urpN -X /home/fletch/.diff.exclude summit-3/arch/i386/kernel/mpparse.c summit-4/arch/i386/kernel/mpparse.c
--- summit-3/arch/i386/kernel/mpparse.c	Fri Oct 11 18:20:09 2002
+++ summit-4/arch/i386/kernel/mpparse.c	Sat Oct 12 12:27:10 2002
@@ -306,6 +306,18 @@ static void __init MP_translation_info (
 		numnodes = m->trans_quad+1;
 }
 
+void __init smp_cluster_apic_check(void)
+{
+	static const char *mode_names[] = {
+		"Flat", "Clustered NUMA-Q", "Clustered xAPIC", "???"
+	};
+
+	if (clustered_apic_mode)
+		esr_disable = 1;
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+			mode_names[clustered_apic_mode], nr_ioapics);
+}
+
 /*
  * Read/parse the MPC oem tables
  */
@@ -359,6 +371,7 @@ static void __init smp_read_mpc_oem(stru
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
 	char str[16];
+	char oem[10];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
@@ -383,14 +396,17 @@ static int __init smp_read_mpc(struct mp
 		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 		return 0;
 	}
-	memcpy(str,mpc->mpc_oem,8);
-	str[8]=0;
-	printk("OEM ID: %s ",str);
+	memcpy(oem,mpc->mpc_oem,8);
+	oem[8]=0;
+	printk("OEM ID: %s ",oem);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
 	printk("Product ID: %s ",str);
 
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
+		clustered_apic = CLUSTERED_APIC_XAPIC;
+
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
 	/* 
@@ -468,6 +484,7 @@ static int __init smp_read_mpc(struct mp
 		}
 		++mpc_record;
 	}
+	smp_cluster_apic_check();
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;

