Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTAIGa5>; Thu, 9 Jan 2003 01:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAIGa4>; Thu, 9 Jan 2003 01:30:56 -0500
Received: from fmr01.intel.com ([192.55.52.18]:52707 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261645AbTAIGaw>;
	Thu, 9 Jan 2003 01:30:52 -0500
content-class: urn:content-classes:message
Subject: [PATCH][2.5] Clustered APIC setup for >8 CPU systems
Date: Wed, 8 Jan 2003 22:39:32 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E201@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2B7A9.DE691646"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.5] Clustered APIC setup for >8 CPU systems
Thread-Index: AcK3p8YeOsYyNjMxSdalozzrYNAuDAAAFMRAAABamSA=
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 09 Jan 2003 06:39:33.0228 (UTC) FILETIME=[DEA18AC0:01C2B7A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2B7A9.DE691646
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Support for more than 8 CPU non-numa, non-quad based systems. Resend.

Motivation:
The current APIC destination mode ("Flat Logical") used in linux kernel
has an upper limit of 8 CPUs. For more than 8 CPUs, either "Clustered
Logical" or "Physical" mode has to be used.

The attached patch adds support such systems by organizing them into
logical clusters, with each cluster having 4 CPUs.=20

The patch is made very simple and isolated, thanks to Martin J. Bligh's
patchsets, which has moved all APIC related functions into sub-arch
macros. Has zero impact on standard systems.=20

Please apply.

Thanks,
-Venkatesh

diff -urN linux-2.5.54.mod/arch/i386/Kconfig
linux-2.5.54.patch/arch/i386/Kconfig
--- linux-2.5.54.mod/arch/i386/Kconfig	2003-01-07 19:31:50.000000000
-0800
+++ linux-2.5.54.patch/arch/i386/Kconfig	2003-01-08
15:24:30.000000000 -0800
@@ -75,6 +75,14 @@
=20
 	  If you don't have one of these computers, you should say N
here.
=20
+config X86_BIGSMP
+	bool "Support for other sub-arch SMP systems with more than 8
CPUs"
+	help
+	  This option is needed for the systems that have more than 8
CPUs
+	  and if the system is not of any sub-arch type above.
+
+	  If you don't have such a system, you should say N here.
+
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
 #config X86_VISWS
diff -urN linux-2.5.54.mod/arch/i386/Makefile
linux-2.5.54.patch/arch/i386/Makefile
--- linux-2.5.54.mod/arch/i386/Makefile	2003-01-01 19:21:44.000000000
-0800
+++ linux-2.5.54.patch/arch/i386/Makefile	2003-01-08
15:24:30.000000000 -0800
@@ -64,6 +64,10 @@
 mflags-$(CONFIG_X86_NUMAQ)	:=3D -Iinclude/asm-i386/mach-numaq
 mcore-$(CONFIG_X86_NUMAQ)	:=3D mach-default
=20
+# BIGSMP subarch support
+mflags-$(CONFIG_X86_BIGSMP)	:=3D -Iinclude/asm-i386/mach-bigsmp
+mcore-$(CONFIG_X86_BIGSMP)	:=3D mach-default
+
 # default subarch .h files
 mflags-y +=3D -Iinclude/asm-i386/mach-default
=20
diff -urN linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_apic.h
linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_apic.h
1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_apic.h
2003-01-08 20:19:26.000000000 -0800
@@ -0,0 +1,106 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#define SEQUENTIAL_APICID
+#ifdef SEQUENTIAL_APICID
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) &
0x3)) |\
+		((phys_apic<<2) & (~0xf)) )
+#elif CLUSTERED_APICID
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) &
0x3)) |\
+		((phys_apic) & (~0xf)) )
+#endif
+
+#define no_balance_irq (1)
+#define esr_disable (1)
+
+static inline int apic_id_registered(void)
+{
+	        return (1);
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
+#define TARGET_CPUS	((cpu_online_map < 0xf)?cpu_online_map:0xf)
+
+#define APIC_BROADCAST_ID     (0x0f)
+#define check_apicid_used(bitmap, apicid) (0)
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+	id =3D xapic_phys_to_log_apicid(hard_smp_processor_id());
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val =3D apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val =3D calculate_ldr(val);
+	apic_write_around(APIC_LDR, val);
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		"Cluster", nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
+}
+
+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
+extern u8 raw_phys_apicid[];
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	return (int) raw_phys_apicid[mps_cpu];
+}
+
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)
+{
+	return (1ul << phys_apicid);
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+	        m->mpc_apicid,
+	        (m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+	        (m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+	        m->mpc_apicver);
+	return (m->mpc_apicid);
+}
+
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* For clustered we don't have a good way to do this yet - hack
*/
+	return (0x0F);
+}
+
+#define WAKE_SECONDARY_VIA_INIT
+
+static inline void setup_portio_remap(void)
+{
+}
+
+static inline int check_phys_apicid_present(int
boot_cpu_physical_apicid)
+{
+	return (1);
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_ipi.h
linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_ipi.h
--- linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_ipi.h
1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_ipi.h
2003-01-01 19:21:13.000000000 -0800
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	unsigned long mask =3D cpu_online_map & ~(1 <<
smp_processor_id());
+
+	if (mask)
+		send_IPI_mask(mask, vector);
+}
+
+static inline void send_IPI_all(int vector)
+{
+	send_IPI_mask(cpu_online_map, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */


 <<bigsmp.patch>>=20

------_=_NextPart_001_01C2B7A9.DE691646
Content-Type: application/octet-stream;
	name="bigsmp.patch"
Content-Transfer-Encoding: base64
Content-Description: bigsmp.patch
Content-Disposition: attachment;
	filename="bigsmp.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNS41NC5tb2QvYXJjaC9pMzg2L0tjb25maWcgbGludXgtMi41LjU0
LnBhdGNoL2FyY2gvaTM4Ni9LY29uZmlnCi0tLSBsaW51eC0yLjUuNTQubW9kL2FyY2gvaTM4Ni9L
Y29uZmlnCTIwMDMtMDEtMDcgMTk6MzE6NTAuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eC0yLjUu
NTQucGF0Y2gvYXJjaC9pMzg2L0tjb25maWcJMjAwMy0wMS0wOCAxNToyNDozMC4wMDAwMDAwMDAg
LTA4MDAKQEAgLTc1LDYgKzc1LDE0IEBACiAKIAkgIElmIHlvdSBkb24ndCBoYXZlIG9uZSBvZiB0
aGVzZSBjb21wdXRlcnMsIHlvdSBzaG91bGQgc2F5IE4gaGVyZS4KIAorY29uZmlnIFg4Nl9CSUdT
TVAKKwlib29sICJTdXBwb3J0IGZvciBvdGhlciBzdWItYXJjaCBTTVAgc3lzdGVtcyB3aXRoIG1v
cmUgdGhhbiA4IENQVXMiCisJaGVscAorCSAgVGhpcyBvcHRpb24gaXMgbmVlZGVkIGZvciB0aGUg
c3lzdGVtcyB0aGF0IGhhdmUgbW9yZSB0aGFuIDggQ1BVcworCSAgYW5kIGlmIHRoZSBzeXN0ZW0g
aXMgbm90IG9mIGFueSBzdWItYXJjaCB0eXBlIGFib3ZlLgorCisJICBJZiB5b3UgZG9uJ3QgaGF2
ZSBzdWNoIGEgc3lzdGVtLCB5b3Ugc2hvdWxkIHNheSBOIGhlcmUuCisKICMgVmlzdWFsIFdvcmtz
dGF0aW9uIHN1cHBvcnQgaXMgdXR0ZXJseSBicm9rZW4uCiAjIElmIHlvdSB3YW50IHRvIHNlZSBp
dCB3b3JraW5nIG1haWwgYW4gVlc1NDAgdG8gaGNoQGluZnJhZGVhZC5vcmcgOCkKICNjb25maWcg
WDg2X1ZJU1dTCmRpZmYgLXVyTiBsaW51eC0yLjUuNTQubW9kL2FyY2gvaTM4Ni9NYWtlZmlsZSBs
aW51eC0yLjUuNTQucGF0Y2gvYXJjaC9pMzg2L01ha2VmaWxlCi0tLSBsaW51eC0yLjUuNTQubW9k
L2FyY2gvaTM4Ni9NYWtlZmlsZQkyMDAzLTAxLTAxIDE5OjIxOjQ0LjAwMDAwMDAwMCAtMDgwMAor
KysgbGludXgtMi41LjU0LnBhdGNoL2FyY2gvaTM4Ni9NYWtlZmlsZQkyMDAzLTAxLTA4IDE1OjI0
OjMwLjAwMDAwMDAwMCAtMDgwMApAQCAtNjQsNiArNjQsMTAgQEAKIG1mbGFncy0kKENPTkZJR19Y
ODZfTlVNQVEpCTo9IC1JaW5jbHVkZS9hc20taTM4Ni9tYWNoLW51bWFxCiBtY29yZS0kKENPTkZJ
R19YODZfTlVNQVEpCTo9IG1hY2gtZGVmYXVsdAogCisjIEJJR1NNUCBzdWJhcmNoIHN1cHBvcnQK
K21mbGFncy0kKENPTkZJR19YODZfQklHU01QKQk6PSAtSWluY2x1ZGUvYXNtLWkzODYvbWFjaC1i
aWdzbXAKK21jb3JlLSQoQ09ORklHX1g4Nl9CSUdTTVApCTo9IG1hY2gtZGVmYXVsdAorCiAjIGRl
ZmF1bHQgc3ViYXJjaCAuaCBmaWxlcwogbWZsYWdzLXkgKz0gLUlpbmNsdWRlL2FzbS1pMzg2L21h
Y2gtZGVmYXVsdAogCmRpZmYgLXVyTiBsaW51eC0yLjUuNTQubW9kL2luY2x1ZGUvYXNtLWkzODYv
bWFjaC1iaWdzbXAvbWFjaF9hcGljLmggbGludXgtMi41LjU0LnBhdGNoL2luY2x1ZGUvYXNtLWkz
ODYvbWFjaC1iaWdzbXAvbWFjaF9hcGljLmgKLS0tIGxpbnV4LTIuNS41NC5tb2QvaW5jbHVkZS9h
c20taTM4Ni9tYWNoLWJpZ3NtcC9tYWNoX2FwaWMuaAkxOTY5LTEyLTMxIDE2OjAwOjAwLjAwMDAw
MDAwMCAtMDgwMAorKysgbGludXgtMi41LjU0LnBhdGNoL2luY2x1ZGUvYXNtLWkzODYvbWFjaC1i
aWdzbXAvbWFjaF9hcGljLmgJMjAwMy0wMS0wOCAyMDoxOToyNi4wMDAwMDAwMDAgLTA4MDAKQEAg
LTAsMCArMSwxMDYgQEAKKyNpZm5kZWYgX19BU01fTUFDSF9BUElDX0gKKyNkZWZpbmUgX19BU01f
TUFDSF9BUElDX0gKKworI2RlZmluZSBTRVFVRU5USUFMX0FQSUNJRAorI2lmZGVmIFNFUVVFTlRJ
QUxfQVBJQ0lECisjZGVmaW5lIHhhcGljX3BoeXNfdG9fbG9nX2FwaWNpZChwaHlzX2FwaWMpICgg
KDF1bCA8PCAoKHBoeXNfYXBpYykgJiAweDMpKSB8XAorCQkoKHBoeXNfYXBpYzw8MikgJiAofjB4
ZikpICkKKyNlbGlmIENMVVNURVJFRF9BUElDSUQKKyNkZWZpbmUgeGFwaWNfcGh5c190b19sb2df
YXBpY2lkKHBoeXNfYXBpYykgKCAoMXVsIDw8ICgocGh5c19hcGljKSAmIDB4MykpIHxcCisJCSgo
cGh5c19hcGljKSAmICh+MHhmKSkgKQorI2VuZGlmCisKKyNkZWZpbmUgbm9fYmFsYW5jZV9pcnEg
KDEpCisjZGVmaW5lIGVzcl9kaXNhYmxlICgxKQorCitzdGF0aWMgaW5saW5lIGludCBhcGljX2lk
X3JlZ2lzdGVyZWQodm9pZCkKK3sKKwkgICAgICAgIHJldHVybiAoMSk7Cit9CisKKyNkZWZpbmUg
QVBJQ19ERlJfVkFMVUUJKEFQSUNfREZSX0NMVVNURVIpCisjZGVmaW5lIFRBUkdFVF9DUFVTCSgo
Y3B1X29ubGluZV9tYXAgPCAweGYpP2NwdV9vbmxpbmVfbWFwOjB4ZikKKworI2RlZmluZSBBUElD
X0JST0FEQ0FTVF9JRCAgICAgKDB4MGYpCisjZGVmaW5lIGNoZWNrX2FwaWNpZF91c2VkKGJpdG1h
cCwgYXBpY2lkKSAoMCkKKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGNhbGN1bGF0ZV9s
ZHIodW5zaWduZWQgbG9uZyBvbGQpCit7CisJdW5zaWduZWQgbG9uZyBpZDsKKwlpZCA9IHhhcGlj
X3BoeXNfdG9fbG9nX2FwaWNpZChoYXJkX3NtcF9wcm9jZXNzb3JfaWQoKSk7CisJcmV0dXJuICgo
b2xkICYgfkFQSUNfTERSX01BU0spIHwgU0VUX0FQSUNfTE9HSUNBTF9JRChpZCkpOworfQorCisv
KgorICogU2V0IHVwIHRoZSBsb2dpY2FsIGRlc3RpbmF0aW9uIElELgorICoKKyAqIEludGVsIHJl
Y29tbWVuZHMgdG8gc2V0IERGUiwgTERSIGFuZCBUUFIgYmVmb3JlIGVuYWJsaW5nCisgKiBhbiBB
UElDLiAgU2VlIGUuZy4gIkFQLTM4OCA4MjQ4OURYIFVzZXIncyBNYW51YWwiIChJbnRlbAorICog
ZG9jdW1lbnQgbnVtYmVyIDI5MjExNikuICBTbyBoZXJlIGl0IGdvZXMuLi4KKyAqLworc3RhdGlj
IGlubGluZSB2b2lkIGluaXRfYXBpY19sZHIodm9pZCkKK3sKKwl1bnNpZ25lZCBsb25nIHZhbDsK
KworCWFwaWNfd3JpdGVfYXJvdW5kKEFQSUNfREZSLCBBUElDX0RGUl9WQUxVRSk7CisJdmFsID0g
YXBpY19yZWFkKEFQSUNfTERSKSAmIH5BUElDX0xEUl9NQVNLOworCXZhbCA9IGNhbGN1bGF0ZV9s
ZHIodmFsKTsKKwlhcGljX3dyaXRlX2Fyb3VuZChBUElDX0xEUiwgdmFsKTsKK30KKworc3RhdGlj
IGlubGluZSB2b2lkIGNsdXN0ZXJlZF9hcGljX2NoZWNrKHZvaWQpCit7CisJcHJpbnRrKCJFbmFi
bGluZyBBUElDIG1vZGU6ICAlcy4gIFVzaW5nICVkIEkvTyBBUElDc1xuIiwKKwkJIkNsdXN0ZXIi
LCBucl9pb2FwaWNzKTsKK30KKworc3RhdGljIGlubGluZSBpbnQgbXVsdGlfdGltZXJfY2hlY2so
aW50IGFwaWMsIGludCBpcnEpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50
IGFwaWNpZF90b19ub2RlKGludCBsb2dpY2FsX2FwaWNpZCkKK3sKKwlyZXR1cm4gMDsKK30KKwor
ZXh0ZXJuIHU4IHJhd19waHlzX2FwaWNpZFtdOworCitzdGF0aWMgaW5saW5lIGludCBjcHVfcHJl
c2VudF90b19hcGljaWQoaW50IG1wc19jcHUpCit7CisJcmV0dXJuIChpbnQpIHJhd19waHlzX2Fw
aWNpZFttcHNfY3B1XTsKK30KKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGFwaWNpZF90
b19jcHVfcHJlc2VudChpbnQgcGh5c19hcGljaWQpCit7CisJcmV0dXJuICgxdWwgPDwgcGh5c19h
cGljaWQpOworfQorCitzdGF0aWMgaW5saW5lIGludCBtcGNfYXBpY19pZChzdHJ1Y3QgbXBjX2Nv
bmZpZ19wcm9jZXNzb3IgKm0sIGludCBxdWFkKQoreworCXByaW50aygiUHJvY2Vzc29yICMlZCAl
bGQ6JWxkIEFQSUMgdmVyc2lvbiAlZFxuIiwKKwkgICAgICAgIG0tPm1wY19hcGljaWQsCisJICAg
ICAgICAobS0+bXBjX2NwdWZlYXR1cmUgJiBDUFVfRkFNSUxZX01BU0spID4+IDgsCisJICAgICAg
ICAobS0+bXBjX2NwdWZlYXR1cmUgJiBDUFVfTU9ERUxfTUFTSykgPj4gNCwKKwkgICAgICAgIG0t
Pm1wY19hcGljdmVyKTsKKwlyZXR1cm4gKG0tPm1wY19hcGljaWQpOworfQorCitzdGF0aWMgaW5s
aW5lIHVsb25nIGlvYXBpY19waHlzX2lkX21hcCh1bG9uZyBwaHlzX21hcCkKK3sKKwkvKiBGb3Ig
Y2x1c3RlcmVkIHdlIGRvbid0IGhhdmUgYSBnb29kIHdheSB0byBkbyB0aGlzIHlldCAtIGhhY2sg
Ki8KKwlyZXR1cm4gKDB4MEYpOworfQorCisjZGVmaW5lIFdBS0VfU0VDT05EQVJZX1ZJQV9JTklU
CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBzZXR1cF9wb3J0aW9fcmVtYXAodm9pZCkKK3sKK30KKwor
c3RhdGljIGlubGluZSBpbnQgY2hlY2tfcGh5c19hcGljaWRfcHJlc2VudChpbnQgYm9vdF9jcHVf
cGh5c2ljYWxfYXBpY2lkKQoreworCXJldHVybiAoMSk7Cit9CisKKyNlbmRpZiAvKiBfX0FTTV9N
QUNIX0FQSUNfSCAqLwpkaWZmIC11ck4gbGludXgtMi41LjU0Lm1vZC9pbmNsdWRlL2FzbS1pMzg2
L21hY2gtYmlnc21wL21hY2hfaXBpLmggbGludXgtMi41LjU0LnBhdGNoL2luY2x1ZGUvYXNtLWkz
ODYvbWFjaC1iaWdzbXAvbWFjaF9pcGkuaAotLS0gbGludXgtMi41LjU0Lm1vZC9pbmNsdWRlL2Fz
bS1pMzg2L21hY2gtYmlnc21wL21hY2hfaXBpLmgJMTk2OS0xMi0zMSAxNjowMDowMC4wMDAwMDAw
MDAgLTA4MDAKKysrIGxpbnV4LTIuNS41NC5wYXRjaC9pbmNsdWRlL2FzbS1pMzg2L21hY2gtYmln
c21wL21hY2hfaXBpLmgJMjAwMy0wMS0wMSAxOToyMToxMy4wMDAwMDAwMDAgLTA4MDAKQEAgLTAs
MCArMSwyNCBAQAorI2lmbmRlZiBfX0FTTV9NQUNIX0lQSV9ICisjZGVmaW5lIF9fQVNNX01BQ0hf
SVBJX0gKKworc3RhdGljIGlubGluZSB2b2lkIHNlbmRfSVBJX21hc2tfc2VxdWVuY2UoaW50IG1h
c2ssIGludCB2ZWN0b3IpOworCitzdGF0aWMgaW5saW5lIHZvaWQgc2VuZF9JUElfbWFzayhpbnQg
bWFzaywgaW50IHZlY3RvcikKK3sKKwlzZW5kX0lQSV9tYXNrX3NlcXVlbmNlKG1hc2ssIHZlY3Rv
cik7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBzZW5kX0lQSV9hbGxidXRzZWxmKGludCB2ZWN0
b3IpCit7CisJdW5zaWduZWQgbG9uZyBtYXNrID0gY3B1X29ubGluZV9tYXAgJiB+KDEgPDwgc21w
X3Byb2Nlc3Nvcl9pZCgpKTsKKworCWlmIChtYXNrKQorCQlzZW5kX0lQSV9tYXNrKG1hc2ssIHZl
Y3Rvcik7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBzZW5kX0lQSV9hbGwoaW50IHZlY3RvcikK
K3sKKwlzZW5kX0lQSV9tYXNrKGNwdV9vbmxpbmVfbWFwLCB2ZWN0b3IpOworfQorCisjZW5kaWYg
LyogX19BU01fTUFDSF9JUElfSCAqLwo=

------_=_NextPart_001_01C2B7A9.DE691646--
