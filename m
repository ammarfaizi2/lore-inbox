Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRJYXDs>; Thu, 25 Oct 2001 19:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276639AbRJYXDc>; Thu, 25 Oct 2001 19:03:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10982 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276628AbRJYXDJ>; Thu, 25 Oct 2001 19:03:09 -0400
Date: Thu, 25 Oct 2001 16:03:54 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
Reply-To: "Martin J. Bligh" <fletch@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Patch to read/parse the MPC oem tables
Message-ID: <3298454519.1004025834@[10.10.1.2]>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will parse the OEM extensions to the mps tables
(if present). This gives me a mapping to tell which device
lies in which NUMA node (the current code just guesses).

Patch is against 2.4.13 - if it looks OK, please could you add it? 

Thanks,

Martin.

Binary files virgin-2.4.13/arch/i386/kernel/.mpparse.c.swp and linux-2.4.13/arch/i386/kernel/.mpparse.c.swp differ
diff -urN virgin-2.4.13/arch/i386/kernel/mpparse.c linux-2.4.13/arch/i386/kernel/mpparse.c
--- virgin-2.4.13/arch/i386/kernel/mpparse.c	Thu Oct  4 18:42:54 2001
+++ linux-2.4.13/arch/i386/kernel/mpparse.c	Thu Oct 25 10:13:18 2001
@@ -36,6 +36,7 @@
  */
 int apic_version [MAX_APICS];
 int mp_bus_id_to_type [MAX_MP_BUSSES];
+int mp_bus_id_to_node [MAX_MP_BUSSES];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_current_pci_id;
 
@@ -55,6 +56,7 @@
 
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
+unsigned int boot_cpu_logical_apicid = -1U;
 /* Internal processor count */
 static unsigned int num_processors;
 
@@ -118,18 +120,37 @@
 	return n;
 }
 
+/* 
+ * Have to match translation table entries to main table entries by counter
+ * hence the mpc_record variable .... can't see a less disgusting way of
+ * doing this ....
+ */
+static int mpc_record; 
+static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY];
+
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
-	int ver;
+	int ver, quad, logical_apicid;
 
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
 
-	printk("Processor #%d %s APIC version %d\n",
-		m->mpc_apicid,
-		mpc_family(	(m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
-				(m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
-		m->mpc_apicver);
+	if (clustered_apic_mode) {
+		quad = translation_table[mpc_record]->trans_quad;
+		logical_apicid = (quad << 4) + 
+			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
+		printk("Processor #%d %s APIC version %d (quad %d, apic %d)\n",
+			m->mpc_apicid,
+			mpc_family((m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
+				   (m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
+			m->mpc_apicver, quad, logical_apicid);
+	} else {
+		printk("Processor #%d %s APIC version %d\n",
+			m->mpc_apicid,
+			mpc_family((m->mpc_cpufeature & CPU_FAMILY_MASK)>>8 ,
+				   (m->mpc_cpufeature & CPU_MODEL_MASK)>>4),
+			m->mpc_apicver);
+	}
 
 	if (m->mpc_featureflag&(1<<0))
 		Dprintk("    Floating point unit present.\n");
@@ -181,6 +202,7 @@
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
+		boot_cpu_logical_apicid = logical_apicid;
 	}
 
 	num_processors++;
@@ -192,12 +214,11 @@
 	}
 	ver = m->mpc_apicver;
 
-	if (clustered_apic_mode)
-		/* Crude temporary hack. Assumes processors are sequential */
-		phys_cpu_present_map |= 1 << (num_processors-1);
-	else
+	if (clustered_apic_mode) {
+		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
+	} else {
 		phys_cpu_present_map |= 1 << m->mpc_apicid;
-
+	}
 	/*
 	 * Validate version
 	 */
@@ -214,7 +235,13 @@
 
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
-	Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
+	
+	if (clustered_apic_mode) {
+		mp_bus_id_to_node[m->mpc_busid] = translation_table[mpc_record]->trans_quad;
+		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, mp_bus_id_to_node[m->mpc_busid]);
+	} else {
+		Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
+	}
 
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
@@ -286,6 +313,62 @@
 			BUG();
 }
 
+static void __init MP_translation_info (struct mpc_config_translation *m)
+{
+	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, 
+		m->trans_quad, m->trans_global, m->trans_local);
+
+	if (mpc_record >= MAX_MPC_ENTRY) 
+		printk("MAX_MPC_ENTRY exceeded!\n");
+	translation_table[mpc_record] = m; /* stash this for later */
+}
+
+/*
+ * Read/parse the MPC oem tables
+ */
+
+static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable, \
+	unsigned short oemsize)
+{
+	int count = sizeof (*oemtable); /* the header size */
+	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
+	
+	printk("Found an OEM MPC table at %08lx - parsing it ... \n", (u_long) oemtable);
+	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
+	{
+		printk("SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
+			oemtable->oem_signature[0],
+			oemtable->oem_signature[1],
+			oemtable->oem_signature[2],
+			oemtable->oem_signature[3]);
+		return;
+	}
+	if (mpf_checksum((unsigned char *)oemtable,oemtable->oem_length))
+	{
+		printk("SMP oem mptable: checksum error!\n");
+		return;
+	}
+	while (count < oemtable->oem_length) {
+		switch (*oemptr) {
+			case MP_TRANSLATION:
+			{
+				struct mpc_config_translation *m=
+					(struct mpc_config_translation *)oemptr;
+				MP_translation_info(m);
+				oemptr += sizeof(*m);
+				count += sizeof(*m);
+				++mpc_record;
+				break;
+			}
+			default:
+			{
+				printk("Unrecognised OEM table entry type! - %d\n", (int) *oemptr);
+				return;
+			}
+		}
+       }
+}
+
 /*
  * Read/parse the MPC
  */
@@ -330,6 +413,13 @@
 	/* save the local APIC address, it might be non-default */
 	mp_lapic_addr = mpc->mpc_lapic;
 
+	if (clustered_apic_mode && mpc->mpc_oemptr) {
+		/* We need to process the oem mpc tables to tell us which quad things are in ... */
+		mpc_record = 0;
+		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
+		mpc_record = 0;
+	}
+
 	/*
 	 *	Now process the configuration blocks.
 	 */
@@ -381,7 +471,13 @@
 				count+=sizeof(*m);
 				break;
 			}
+			default:
+			{
+				count = mpc->mpc_length;
+				break;
+			}
 		}
+		++mpc_record;
 	}
 	if (clustered_apic_mode && nr_ioapics > 2) {
 		/* don't initialise IO apics on secondary quads */
diff -urN virgin-2.4.13/include/asm-i386/mpspec.h linux-2.4.13/include/asm-i386/mpspec.h
--- virgin-2.4.13/include/asm-i386/mpspec.h	Thu Oct  4 18:42:54 2001
+++ linux-2.4.13/include/asm-i386/mpspec.h	Thu Oct 25 14:31:12 2001
@@ -16,7 +16,13 @@
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
+#ifdef CONFIG_MULTIQUAD
+#define MAX_APICS 256
+#else /* !CONFIG_MULTIQUAD */
 #define MAX_APICS 16
+#endif /* CONFIG_MULTIQUAD */
+
+#define MAX_MPC_ENTRY 1024
 
 struct intel_mp_floating
 {
@@ -55,6 +61,7 @@
 #define	MP_IOAPIC	2
 #define	MP_INTSRC	3
 #define	MP_LINTSRC	4
+#define	MP_TRANSLATION  192
 
 struct mpc_config_processor
 {
@@ -144,6 +151,27 @@
 	unsigned char mpc_destapiclint;
 };
 
+struct mp_config_oemtable
+{
+	char oem_signature[4];
+#define MPC_OEM_SIGNATURE "_OEM"
+	unsigned short oem_length;	/* Size of table */
+	char  oem_rev;			/* 0x01 */
+	char  oem_checksum;
+	char  mpc_oem[8];
+};
+
+struct mpc_config_translation
+{
+        unsigned char mpc_type;
+        unsigned char trans_len;
+        unsigned char trans_type;
+        unsigned char trans_quad;
+        unsigned char trans_global;
+        unsigned char trans_local;
+        unsigned short trans_reserved;
+};
+
 /*
  *	Default configurations
  *
@@ -156,7 +184,12 @@
  *	7	2 CPU MCA+PCI
  */
 
-#define MAX_IRQ_SOURCES 256
+#ifdef CONFIG_MULTIQUAD
+#define MAX_IRQ_SOURCES 512
+#else /* !CONFIG_MULTIQUAD */
+#define MAX_IRQ_SOURCES 128
+#endif /* CONFIG_MULTIQUAD */
+
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,



