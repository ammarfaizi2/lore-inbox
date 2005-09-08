Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVIHQGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVIHQGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVIHQGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:06:55 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:31852
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964822AbVIHQGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:06:54 -0400
Message-Id: <43207DFC0200007800024543@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:07:56 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] add and handle NMI_VECTOR
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartA684C8CC.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartA684C8CC.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Declare NMI_VECTOR and handle it in the IPI sending code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/include/asm-x86_64/hw_irq.h
2.6.13-x86_64-nmi-ipi/include/asm-x86_64/hw_irq.h
--- 2.6.13/include/asm-x86_64/hw_irq.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-nmi-ipi/include/asm-x86_64/hw_irq.h	2005-03-16
12:24:42.000000000 +0100
@@ -26,6 +26,7 @@
 struct hw_interrupt_type;
 #endif
 
+#define NMI_VECTOR		0x02
 /*
  * IDT vectors usable for external interrupt sources start
  * at 0x20:
diff -Npru 2.6.13/include/asm-x86_64/ipi.h
2.6.13-x86_64-nmi-ipi/include/asm-x86_64/ipi.h
--- 2.6.13/include/asm-x86_64/ipi.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-nmi-ipi/include/asm-x86_64/ipi.h	2005-09-01
11:32:12.000000000 +0200
@@ -31,9 +31,20 @@
 
 static inline unsigned int __prepare_ICR (unsigned int shortcut, int
vector, unsigned int dest)
 {
-	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
-	if (vector == KDB_VECTOR)
-		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
+	unsigned int icr = shortcut | dest;
+
+	switch (vector) {
+	default:
+		icr |= APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		/*
+		 * Setup KDB IPI to be delivered as an NMI
+		 */
+	case KDB_VECTOR:
+		icr |= APIC_DM_NMI;
+		break;
+	}
 	return icr;
 }
 


--=__PartA684C8CC.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-nmi-ipi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-nmi-ipi.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkRlY2xhcmUgTk1JX1ZFQ1RPUiBhbmQgaGFu
ZGxlIGl0IGluIHRoZSBJUEkgc2VuZGluZyBjb2RlLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxp
Y2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS14
ODZfNjQvaHdfaXJxLmggMi42LjEzLXg4Nl82NC1ubWktaXBpL2luY2x1ZGUvYXNtLXg4Nl82NC9o
d19pcnEuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9od19pcnEuaAkyMDA1LTA4LTI5
IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC1ubWktaXBpL2luY2x1
ZGUvYXNtLXg4Nl82NC9od19pcnEuaAkyMDA1LTAzLTE2IDEyOjI0OjQyLjAwMDAwMDAwMCArMDEw
MApAQCAtMjYsNiArMjYsNyBAQAogc3RydWN0IGh3X2ludGVycnVwdF90eXBlOwogI2VuZGlmCiAK
KyNkZWZpbmUgTk1JX1ZFQ1RPUgkJMHgwMgogLyoKICAqIElEVCB2ZWN0b3JzIHVzYWJsZSBmb3Ig
ZXh0ZXJuYWwgaW50ZXJydXB0IHNvdXJjZXMgc3RhcnQKICAqIGF0IDB4MjA6CmRpZmYgLU5wcnUg
Mi42LjEzL2luY2x1ZGUvYXNtLXg4Nl82NC9pcGkuaCAyLjYuMTMteDg2XzY0LW5taS1pcGkvaW5j
bHVkZS9hc20teDg2XzY0L2lwaS5oCi0tLSAyLjYuMTMvaW5jbHVkZS9hc20teDg2XzY0L2lwaS5o
CTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LW5t
aS1pcGkvaW5jbHVkZS9hc20teDg2XzY0L2lwaS5oCTIwMDUtMDktMDEgMTE6MzI6MTIuMDAwMDAw
MDAwICswMjAwCkBAIC0zMSw5ICszMSwyMCBAQAogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGlu
dCBfX3ByZXBhcmVfSUNSICh1bnNpZ25lZCBpbnQgc2hvcnRjdXQsIGludCB2ZWN0b3IsIHVuc2ln
bmVkIGludCBkZXN0KQogewotCXVuc2lnbmVkIGludCBpY3IgPSAgQVBJQ19ETV9GSVhFRCB8IHNo
b3J0Y3V0IHwgdmVjdG9yIHwgZGVzdDsKLQlpZiAodmVjdG9yID09IEtEQl9WRUNUT1IpCi0JCWlj
ciA9IChpY3IgJiAofkFQSUNfVkVDVE9SX01BU0spKSB8IEFQSUNfRE1fTk1JOworCXVuc2lnbmVk
IGludCBpY3IgPSBzaG9ydGN1dCB8IGRlc3Q7CisKKwlzd2l0Y2ggKHZlY3RvcikgeworCWRlZmF1
bHQ6CisJCWljciB8PSBBUElDX0RNX0ZJWEVEIHwgdmVjdG9yOworCQlicmVhazsKKwljYXNlIE5N
SV9WRUNUT1I6CisJCS8qCisJCSAqIFNldHVwIEtEQiBJUEkgdG8gYmUgZGVsaXZlcmVkIGFzIGFu
IE5NSQorCQkgKi8KKwljYXNlIEtEQl9WRUNUT1I6CisJCWljciB8PSBBUElDX0RNX05NSTsKKwkJ
YnJlYWs7CisJfQogCXJldHVybiBpY3I7CiB9CiAK

--=__PartA684C8CC.1__=--
