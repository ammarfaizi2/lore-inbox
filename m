Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVIHQFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVIHQFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVIHQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:05:45 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17260
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964886AbVIHQFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:05:44 -0400
Message-Id: <43207DB6020000780002453F@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:06:46 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] set stack pointer in init_tss and init_thread
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartECCE8286.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartECCE8286.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Set the stack pointer correctly in init_thread and init_tss.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/x86_64/kernel/init_task.c
2.6.13-x86_64-init/arch/x86_64/kernel/init_task.c
--- 2.6.13/arch/x86_64/kernel/init_task.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-x86_64-init/arch/x86_64/kernel/init_task.c	2005-03-17
13:20:48.000000000 +0100
@@ -44,6 +44,6 @@ EXPORT_SYMBOL(init_task);
  * section. Since TSS's are completely CPU-local, we want them
  * on exact cacheline boundaries, to eliminate cacheline ping-pong.
  */ 
-DEFINE_PER_CPU(struct tss_struct, init_tss)
____cacheline_maxaligned_in_smp;
+DEFINE_PER_CPU(struct tss_struct, init_tss)
____cacheline_maxaligned_in_smp = INIT_TSS;
 
 #define ALIGN_TO_4K __attribute__((section(".data.init_task")))
diff -Npru 2.6.13/include/asm-x86_64/processor.h
2.6.13-x86_64-init/include/asm-x86_64/processor.h
--- 2.6.13/include/asm-x86_64/processor.h	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-x86_64-init/include/asm-x86_64/processor.h	2005-09-01
11:32:12.000000000 +0200
@@ -254,7 +254,13 @@ struct thread_struct {
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
 } __attribute__((aligned(16)));
 
-#define INIT_THREAD  {}
+#define INIT_THREAD  { \
+	.rsp0 = (unsigned long)&init_stack + sizeof(init_stack) \
+}
+
+#define INIT_TSS  { \
+	.rsp0 = (unsigned long)&init_stack + sizeof(init_stack) \
+}
 
 #define INIT_MMAP \
 { &init_mm, 0, 0, NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1,
NULL, NULL }


--=__PartECCE8286.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-init.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-init.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClNldCB0aGUgc3RhY2sgcG9pbnRlciBjb3Jy
ZWN0bHkgaW4gaW5pdF90aHJlYWQgYW5kIGluaXRfdHNzLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJl
dWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL3g4Nl82
NC9rZXJuZWwvaW5pdF90YXNrLmMgMi42LjEzLXg4Nl82NC1pbml0L2FyY2gveDg2XzY0L2tlcm5l
bC9pbml0X3Rhc2suYwotLS0gMi42LjEzL2FyY2gveDg2XzY0L2tlcm5lbC9pbml0X3Rhc2suYwky
MDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1pbml0
L2FyY2gveDg2XzY0L2tlcm5lbC9pbml0X3Rhc2suYwkyMDA1LTAzLTE3IDEzOjIwOjQ4LjAwMDAw
MDAwMCArMDEwMApAQCAtNDQsNiArNDQsNiBAQCBFWFBPUlRfU1lNQk9MKGluaXRfdGFzayk7CiAg
KiBzZWN0aW9uLiBTaW5jZSBUU1MncyBhcmUgY29tcGxldGVseSBDUFUtbG9jYWwsIHdlIHdhbnQg
dGhlbQogICogb24gZXhhY3QgY2FjaGVsaW5lIGJvdW5kYXJpZXMsIHRvIGVsaW1pbmF0ZSBjYWNo
ZWxpbmUgcGluZy1wb25nLgogICovIAotREVGSU5FX1BFUl9DUFUoc3RydWN0IHRzc19zdHJ1Y3Qs
IGluaXRfdHNzKSBfX19fY2FjaGVsaW5lX21heGFsaWduZWRfaW5fc21wOworREVGSU5FX1BFUl9D
UFUoc3RydWN0IHRzc19zdHJ1Y3QsIGluaXRfdHNzKSBfX19fY2FjaGVsaW5lX21heGFsaWduZWRf
aW5fc21wID0gSU5JVF9UU1M7CiAKICNkZWZpbmUgQUxJR05fVE9fNEsgX19hdHRyaWJ1dGVfXygo
c2VjdGlvbigiLmRhdGEuaW5pdF90YXNrIikpKQpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2Fz
bS14ODZfNjQvcHJvY2Vzc29yLmggMi42LjEzLXg4Nl82NC1pbml0L2luY2x1ZGUvYXNtLXg4Nl82
NC9wcm9jZXNzb3IuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9wcm9jZXNzb3IuaAky
MDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1pbml0
L2luY2x1ZGUvYXNtLXg4Nl82NC9wcm9jZXNzb3IuaAkyMDA1LTA5LTAxIDExOjMyOjEyLjAwMDAw
MDAwMCArMDIwMApAQCAtMjU0LDcgKzI1NCwxMyBAQCBzdHJ1Y3QgdGhyZWFkX3N0cnVjdCB7CiAJ
dTY0IHRsc19hcnJheVtHRFRfRU5UUllfVExTX0VOVFJJRVNdOwogfSBfX2F0dHJpYnV0ZV9fKChh
bGlnbmVkKDE2KSkpOwogCi0jZGVmaW5lIElOSVRfVEhSRUFEICB7fQorI2RlZmluZSBJTklUX1RI
UkVBRCAgeyBcCisJLnJzcDAgPSAodW5zaWduZWQgbG9uZykmaW5pdF9zdGFjayArIHNpemVvZihp
bml0X3N0YWNrKSBcCit9CisKKyNkZWZpbmUgSU5JVF9UU1MgIHsgXAorCS5yc3AwID0gKHVuc2ln
bmVkIGxvbmcpJmluaXRfc3RhY2sgKyBzaXplb2YoaW5pdF9zdGFjaykgXAorfQogCiAjZGVmaW5l
IElOSVRfTU1BUCBcCiB7ICZpbml0X21tLCAwLCAwLCBOVUxMLCBQQUdFX1NIQVJFRCwgVk1fUkVB
RCB8IFZNX1dSSVRFIHwgVk1fRVhFQywgMSwgTlVMTCwgTlVMTCB9Cg==

--=__PartECCE8286.1__=--
