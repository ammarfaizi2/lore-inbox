Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSHGSIO>; Wed, 7 Aug 2002 14:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSHGSIO>; Wed, 7 Aug 2002 14:08:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10958 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318734AbSHGSIL>;
	Wed, 7 Aug 2002 14:08:11 -0400
Date: Wed, 7 Aug 2002 20:10:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Julliard <julliard@winehq.com>
Subject: [patch] tls-2.5.30-A1
Message-ID: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1048705827-1028743337=:22133"
Content-ID: <Pine.LNX.4.44.0208072002260.22133@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1048705827-1028743337=:22133
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0208072002261.22133@localhost.localdomain>


the attached patch (against BK-curr + Luca Barbieri's two TLS patches)  
does two things:

 - it implements a second TLS entry for Wine's purposes.

Alexandre suggested that Wine would need two TLS entries, one for glibc
(in %gs), and one for the Win32 API (in %fs). The constant selector is
also a speedup for switches to/from 16-bit mode.

i left the possibility open to add even more TLS entries, but i find it
very unlikely to happen. So the code does not iterate over an array of TLS
descriptors, for performance reasons. This can be changed anytime without
affecting the userspace interface.

 - the patch adds the get_thread_area() system-call.

the get_thread_area() call is needed by debuggers, to be able to read the
TLS settings of a threaded application, without having to assume anything
about what was loaded. The get_thread_area() call does not expose any
segmentation details - it returns the TLS info in the same format as
passed to the set_thread_area() call.

i've also attached tls.c which shows off both extensions. These extensions
are source and binary-compatible with any potential TLS code.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Wed Aug  7 19:16:45 2002
+++ linux/arch/i386/kernel/process.c	Wed Aug  7 19:40:27 2002
@@ -839,6 +839,7 @@
 asmlinkage int sys_set_thread_area(unsigned long base, unsigned long flags)
 {
 	struct thread_struct *t = &current->thread;
+	struct desc_struct *desc;
 	int writable = 0;
 	int cpu;
 
@@ -848,21 +849,62 @@
 
 	if (flags & TLS_FLAG_WRITABLE)
 		writable = 1;
+	desc = &t->tls_desc1;
+	if (flags & TLS_FLAG_ENTRY2)
+		desc = &t->tls_desc2;
 
 	/*
 	 * We must not get preempted while modifying the TLS.
 	 */
 	cpu = get_cpu();
 
-        t->tls_desc.a = ((base & 0x0000ffff) << 16) | 0xffff;
+        desc->a = ((base & 0x0000ffff) << 16) | 0xffff;
 
-        t->tls_desc.b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
+        desc->b = (base & 0xff000000) | ((base & 0x00ff0000) >> 16) |
 				0xf0000 | (writable << 9) | (1 << 15) |
 					(1 << 22) | (1 << 23) | 0x7000;
 
 	load_TLS_desc(t, cpu);
 	put_cpu();
 
-	return TLS_ENTRY*8 + 3;
+	if (flags & TLS_FLAG_ENTRY2)
+		return TLS_ENTRY2*8 + 3;
+	else
+		return TLS_ENTRY1*8 + 3;
+}
+
+/*
+ * Get the current Thread-Local Storage area:
+ */
+
+#define GET_BASE(desc) \
+(	(((desc).a >> 16) & 0x0000ffff) | \
+	(((desc).b << 16) & 0x00ff0000) | \
+	( (desc).b        & 0xff000000)	)
+
+#define GET_WRITABLE(desc) \
+	(((desc).b >> 9)  & 0x00000001)
+
+asmlinkage int sys_get_thread_area(unsigned long *ubase, unsigned long *uflags,
+					unsigned long flags)
+{
+	struct thread_struct *thread = &current->thread;
+	unsigned long base, flg;
+
+	if (flags & ~TLS_FLAGS_MASK)
+		return -EINVAL;
+
+	if (flags & TLS_FLAG_ENTRY2) {
+		base = GET_BASE(thread->tls_desc2);
+		flg = GET_WRITABLE(thread->tls_desc2) | TLS_FLAG_ENTRY2;
+	} else {
+		base = GET_BASE(thread->tls_desc1);
+		flg = GET_WRITABLE(thread->tls_desc1) | TLS_FLAG_ENTRY1;
+	}
+	if (copy_to_user(ubase, &base, sizeof(base)))
+		return -EFAULT;
+	if (copy_to_user(uflags, &flg, sizeof(flg)))
+		return -EFAULT;
+	return 0;
 }
 
--- linux/arch/i386/kernel/entry.S.orig	Wed Aug  7 19:18:33 2002
+++ linux/arch/i386/kernel/entry.S	Wed Aug  7 19:18:21 2002
@@ -753,6 +753,7 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_get_thread_area
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/include/asm-i386/processor.h.orig	Wed Aug  7 19:22:57 2002
+++ linux/include/asm-i386/processor.h	Wed Aug  7 19:27:01 2002
@@ -376,8 +376,8 @@
 	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
 /* IO permissions */
 	unsigned long	*ts_io_bitmap;
-/* TLS cached descriptor */
-	struct desc_struct tls_desc;
+/* TLS cached descriptors */
+	struct desc_struct tls_desc1, tls_desc2;
 };
 
 #define INIT_THREAD  {						\
--- linux/include/asm-i386/unistd.h.orig	Wed Aug  7 19:18:45 2002
+++ linux/include/asm-i386/unistd.h	Wed Aug  7 19:18:58 2002
@@ -248,6 +248,7 @@
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
 #define __NR_set_thread_area	243
+#define __NR_get_thread_area	244
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- linux/include/asm-i386/desc.h.orig	Wed Aug  7 19:20:57 2002
+++ linux/include/asm-i386/desc.h	Wed Aug  7 19:51:13 2002
@@ -12,7 +12,7 @@
  *   3 - kernel data segment
  *   4 - user code segment		<==== new cacheline
  *   5 - user data segment
- *   6 - Thread-Local Storage (TLS) segment
+ *   6 - Thread-Local Storage (TLS) segment #1
  *   7 - LDT
  *   8 - APM BIOS support		<==== new cacheline
  *   9 - APM BIOS support
@@ -23,12 +23,13 @@
  *  14 - PNPBIOS support
  *  15 - PNPBIOS support
  *  16 - PNPBIOS support		<==== new cacheline
- *  17 - not used
+ *  17 - TLS segment #2
  *  18 - not used
  *  19 - not used
  */
 #define TSS_ENTRY 1
-#define TLS_ENTRY 6
+#define TLS_ENTRY1 6
+#define TLS_ENTRY2 17
 #define LDT_ENTRY 7
 /*
  * The interrupt descriptor table has room for 256 idt's,
@@ -86,13 +87,16 @@
 	_set_tssldt_desc(&cpu_gdt_table[cpu][LDT_ENTRY], (int)addr, ((size << 3)-1), 0x82);
 }
 
-#define TLS_FLAGS_MASK			0x00000001
+#define TLS_FLAGS_MASK			0x00000003
 
 #define TLS_FLAG_WRITABLE		0x00000001
+#define TLS_FLAG_ENTRY1			0x00000000
+#define TLS_FLAG_ENTRY2			0x00000002
 
 static inline void load_TLS_desc(struct thread_struct *t, unsigned int cpu)
 {
-	cpu_gdt_table[cpu][TLS_ENTRY] = t->tls_desc;
+	cpu_gdt_table[cpu][TLS_ENTRY1] = t->tls_desc1;
+	cpu_gdt_table[cpu][TLS_ENTRY2] = t->tls_desc2;
 }
 
 static inline void clear_LDT(void)

--8323328-1048705827-1028743337=:22133
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="tls.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208072002170.22133@localhost.localdomain>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="tls.c"

I2luY2x1ZGUgPGFzbS9sZHQuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0KI2luY2x1ZGUgPHNpZ25hbC5oPg0K
I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2lu
Y2x1ZGUgPHB0aHJlYWQuaD4NCiNpbmNsdWRlIDxhc20vc2lnY29udGV4dC5o
Pg0KDQovKg0KICogVExTIGZ1bmN0aW9uYWxpdHkgdGVzdGluZyB1dGlsaXR5
Lg0KICovDQojZGVmaW5lIFRMU19GTEFHU19NQVNLICAgICAgICAgICAgICAg
ICAgMHgwMDAwMDAwMw0KDQojZGVmaW5lIFRMU19GTEFHX1dSSVRBQkxFICAg
ICAgICAgICAgICAgMHgwMDAwMDAwMQ0KI2RlZmluZSBUTFNfRkxBR19FTlRS
WTIgICAgICAgICAgICAgICAgIDB4MDAwMDAwMDINCg0KI2RlZmluZSBfX05S
X3NldF90aHJlYWRfYXJlYSAyNDMNCl9zeXNjYWxsMihpbnQsIHNldF90aHJl
YWRfYXJlYSwgdW5zaWduZWQgaW50LCBiYXNlLCB1bnNpZ25lZCBpbnQsIGZs
YWdzKQ0KDQojZGVmaW5lIF9fTlJfZ2V0X3RocmVhZF9hcmVhIDI0NA0KX3N5
c2NhbGwzKGludCwgZ2V0X3RocmVhZF9hcmVhLCB1bnNpZ25lZCBpbnQgKiwg
dWJhc2UsIHVuc2lnbmVkIGludCAqLCB1ZmxhZ3MsIHVuc2lnbmVkIGludCwg
ZmxhZ3MpDQoNCnN0YXRpYyBpbmxpbmUgdm9pZCBpbml0c2VnIChpbnQgc2Vn
KQ0Kew0KCWFzbSAoIm1vdiAldzAsJSVmcyIgOiA6ICJyIiAoc2VnKSk7DQp9
DQoNCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciBfX3JlYWRzZWcgKHVu
c2lnbmVkIG9mZnNldCkNCnsNCgl1bnNpZ25lZCBjaGFyIHJlczsNCg0KCWFz
bSAoImZzOyBtb3ZiICglMSksJSVhbCIgOiAiPWEiIChyZXMpIDogInIiIChv
ZmZzZXQpKTsNCg0KCXJldHVybiByZXM7DQp9DQoNCnN0YXRpYyBpbmxpbmUg
dm9pZCBfX3dyaXRlc2VnICh1bnNpZ25lZCBvZmZzZXQsIHVuc2lnbmVkIGNo
YXIgYikNCnsNCglhc20gKCJmczsgbW92YiAlYjEsKCUwKSIgOiA6ICJyIiAo
b2Zmc2V0KSwgInIiIChiKSk7DQp9DQoNCnN0YXRpYyB2b2lkIHJlYWRzZWcg
KHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjKQ0Kew0KCSooY2hhciAqKWRz
dCA9IF9fcmVhZHNlZygodW5zaWduZWQgaW50KXNyYyk7DQp9DQoNCnN0YXRp
YyB2b2lkIHdyaXRlc2VnICh2b2lkICpkc3QsIHVuc2lnbmVkIGNoYXIgdmFs
dWUpDQp7DQoJX193cml0ZXNlZygodW5zaWduZWQgaW50KWRzdCwgdmFsdWUp
Ow0KfQ0KDQp1bnNpZ25lZCBjaGFyIHByZV9kYXRhCQlbNDA5Nl0gPSB7IFsg
MCAuLi4gNDA5NSBdID0gMzMgfTsNCnVuc2lnbmVkIGNoYXIgZGF0YQkJWzQw
OTZdID0geyBbIDAgLi4uIDQwOTUgXSA9IDQ0IH07DQp1bnNpZ25lZCBjaGFy
IHBvc3RfZGF0YQkJWzQwOTZdID0geyBbIDAgLi4uIDQwOTUgXSA9IDU1IH07
DQoNCmludCBtYWluICh2b2lkKQ0Kew0KCXVuc2lnbmVkIGludCBiYXNlLCBm
bGFnczsNCglpbnQgc2VnLCByZXQ7DQoJdW5zaWduZWQgY2hhciByZXN1bHQ7
DQoNCglkYXRhWzBdID0gMTIzOw0KCWRhdGFbNDA5Nl0gPSAyMTA7DQoNCgli
YXNlID0gMDsNCg0KCXByaW50ZigiXG5kb2luZyBzZXRfdGhyZWFkX2FyZWEo
MHglMDh4LCB3cml0YWJsZSk6XG4iLCBiYXNlKTsNCglzZWcgPSBzZXRfdGhy
ZWFkX2FyZWEoYmFzZSwgVExTX0ZMQUdfV1JJVEFCTEUpOw0KCXByaW50Zigi
PT09PT4gZ290IEdEVCBzZWxlY3RvcjogMHgleCIsIHNlZyk7DQoJaWYgKHNl
ZyAhPSA1MSkgew0KCQlwcmludGYoIiBFUlJPUjogaW5jb3JyZWN0IHNlbGVj
dG9yIVxuIik7DQoJCWV4aXQoLTEpOw0KCX0gZWxzZQ0KCQlwcmludGYoIiAt
LS0gVEVTVCBQQVNTRUQuXG4iKTsNCg0KCWluaXRzZWcoc2VnKTsNCglwcmlu
dGYoIlxucmVhZGluZyBmaXJzdCBieXRlIG9mIFsweCUwOHhdIFRMUzpcbiIs
IGJhc2UpOw0KDQoJcmVhZHNlZyAoJnJlc3VsdCwgJmRhdGEpOw0KCWlmIChy
ZXN1bHQgPT0gMTIzKQ0KCQlwcmludGYoIj09PT0+ICVkIC0tLSBURVNUIFBB
U1NFRC5cblxuIiwgcmVzdWx0KTsNCgllbHNlDQoJCXByaW50ZigiPT09PT4g
JWQgLS0tIFRFU1QgRkFJTFVSRSFcblxuIiwgcmVzdWx0KTsNCg0KCWJhc2Ug
PSAodW5zaWduZWQgaW50KSZkYXRhOw0KDQoJcHJpbnRmKCJkb2luZyBzZXRf
dGhyZWFkX2FyZWEoMHglMDh4LCB3cml0YWJsZSwgZW50cnkyKTpcbiIsIGJh
c2UpOw0KCXNlZyA9IHNldF90aHJlYWRfYXJlYShiYXNlLCBUTFNfRkxBR19X
UklUQUJMRSB8IFRMU19GTEFHX0VOVFJZMik7DQoJaW5pdHNlZyhzZWcpOw0K
CXByaW50ZigiPT09PT4gZ290IEdEVCBzZWxlY3RvcjogMHgleCIsIHNlZyk7
DQoJaWYgKHNlZyAhPSAweDhiKSB7DQoJCXByaW50ZigiIEVSUk9SOiBpbmNv
cnJlY3Qgc2VsZWN0b3IhXG4iKTsNCgkJZXhpdCgtMSk7DQoJfSBlbHNlDQoJ
CXByaW50ZigiIC0tLSBURVNUIFBBU1NFRC5cbiIpOw0KDQoJcHJpbnRmKCJj
b250ZXh0LXN3aXRjaGluZyBvbmNlIC4uLlxuIik7DQoJc2xlZXAoMSk7DQoJ
cHJpbnRmKCJcbnJlYWRpbmcgZmlyc3QgYnl0ZSBvZiA0SyBbMHglMDh4XSBU
TFM6XG4iLCBiYXNlKTsNCg0KCXJlYWRzZWcgKCZyZXN1bHQsIDApOw0KCWlm
IChyZXN1bHQgPT0gMTIzKQ0KCQlwcmludGYoIj09PT0+ICVkIC0tLSBURVNU
IFBBU1NFRC5cblxuIiwgcmVzdWx0KTsNCgllbHNlDQoJCXByaW50ZigiPT09
PT4gJWQgLS0tIFRFU1QgRkFJTFVSRSFcblxuIiwgcmVzdWx0KTsNCg0KCXBy
aW50ZigicmVhZGluZyBsYXN0IGJ5dGUgb2YgNDA5NyBieXRlIFsweCUwOHhd
IFRMUzpcbiIsIGJhc2UpOw0KDQoJcmVhZHNlZyAoJnJlc3VsdCwgKHZvaWQg
Kik0MDk2KTsNCglpZiAocmVzdWx0ID09IDIxMCkNCgkJcHJpbnRmKCI9PT09
PiAlZCAtLS0gVEVTVCBQQVNTRUQuXG5cbiIsIHJlc3VsdCk7DQoJZWxzZQ0K
CQlwcmludGYoIj09PT0+ICVkIC0tLSBURVNUIEZBSUxVUkUhXG5cbiIsIHJl
c3VsdCk7DQoNCglwcmludGYoIndyaXRpbmcgbGFzdCBieXRlIG9mIDQwOTcg
Ynl0ZSBbMHglMDh4XSBUTFM6XG4iLCBiYXNlKTsNCgl3cml0ZXNlZyAoKHZv
aWQgKik0MDk2LCAyMzQpOw0KCXJlYWRzZWcgKCZyZXN1bHQsICh2b2lkICop
NDA5Nik7DQoJaWYgKHJlc3VsdCA9PSAyMzQpDQoJCXByaW50ZigiPT09PT4g
JWQgLS0tIFRFU1QgUEFTU0VELlxuIiwgcmVzdWx0KTsNCgllbHNlDQoJCXBy
aW50ZigiPT09PT4gJWQgLS0tIFRFU1QgRkFJTFVSRSEuXG4iLCByZXN1bHQp
Ow0KDQoJcHJpbnRmKCJcbnJlYWRpbmcgYnl0ZSBvdXRzaWRlIG9mIHRoZSBU
TFMgKHNob3VsZCBub3QgY29yZWR1bXApLi4uXG5cbiIpOw0KCXJlYWRzZWcg
KCZyZXN1bHQsICh2b2lkICopNDA5Nyk7DQoJcHJpbnRmKCJyZXN1bHQ6ICVk
LlxuIiwgcmVzdWx0KTsNCg0KCXByaW50ZigiZG9pbmcgZ2V0X3RocmVhZF9h
cmVhKDB4JTA4eCwgd3JpdGFibGUsIGVudHJ5Mik6XG4iLCBiYXNlKTsNCgli
YXNlID0gZmxhZ3MgPSAxMjM0Ow0KCXJldCA9IGdldF90aHJlYWRfYXJlYSgm
YmFzZSwgJmZsYWdzLCBUTFNfRkxBR19XUklUQUJMRSB8IFRMU19GTEFHX0VO
VFJZMik7DQoJaWYgKCFyZXQpDQoJCXByaW50ZigiPT09PT4gWyUwOHgsICVk
XSAlZCAtLS0gVEVTVCBQQVNTRUQuXG4iLCBiYXNlLCBmbGFncywgcmV0KTsN
CgllbHNlDQoJCXByaW50ZigiPT09PT4gWyUwOHgsICVkXSAlZCAtLS0gVEVT
VCBGQUlMVVJFIS5cbiIsIGJhc2UsIGZsYWdzLCByZXQpOw0KDQoJcmV0dXJu
IDA7DQp9DQo=
--8323328-1048705827-1028743337=:22133--
