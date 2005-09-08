Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVIHQK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVIHQK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVIHQK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:10:29 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:65132
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964887AbVIHQK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:10:29 -0400
Message-Id: <43207ED00200007800024566@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 18:11:28 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] fix x86-64 condition to call nmi_watchdog_tick
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC9EBA7A0.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartC9EBA7A0.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Don't call nmi_watchdog_tick() when this isn't enabled.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/x86_64/kernel/io_apic.c
2.6.13-x86_64-watchdog-active/arch/x86_64/kernel/io_apic.c
--- 2.6.13/arch/x86_64/kernel/io_apic.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-x86_64-watchdog-active/arch/x86_64/kernel/io_apic.c	2005-09-01
11:32:11.000000000 +0200
@@ -1529,6 +1529,7 @@ static void setup_nmi (void)
 	 */ 
 	printk(KERN_INFO "activating NMI Watchdog ...");
 
+	nmi_active = 1;
 	enable_NMI_through_LVT0(NULL);
 
 	printk(" done.\n");
diff -Npru 2.6.13/arch/x86_64/kernel/traps.c
2.6.13-x86_64-watchdog-active/arch/x86_64/kernel/traps.c
--- 2.6.13/arch/x86_64/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-x86_64-watchdog-active/arch/x86_64/kernel/traps.c	2005-09-07
13:30:20.000000000 +0200
@@ -603,7 +603,7 @@ asmlinkage void default_do_nmi(struct pt
 		 * Ok, so this is none of the documented NMI sources,
 		 * so it must be the NMI watchdog.
 		 */
-		if (nmi_watchdog > 0) {
+		if (nmi_watchdog > 0 && nmi_active > 0) {
 			nmi_watchdog_tick(regs,reason);
 			return;
 		}
diff -Npru 2.6.13/include/asm-x86_64/apic.h
2.6.13-x86_64-watchdog-active/include/asm-x86_64/apic.h
--- 2.6.13/include/asm-x86_64/apic.h	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-x86_64-watchdog-active/include/asm-x86_64/apic.h	2005-09-01
11:32:12.000000000 +0200
@@ -103,6 +103,7 @@ extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
 
 extern unsigned int nmi_watchdog;
+extern int nmi_active;
 #define NMI_DEFAULT	-1
 #define NMI_NONE	0
 #define NMI_IO_APIC	1


--=__PartC9EBA7A0.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-watchdog-active.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-watchdog-active.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkRvbid0IGNhbGwgbm1pX3dhdGNoZG9nX3Rp
Y2soKSB3aGVuIHRoaXMgaXNuJ3QgZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNo
IDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC94ODZfNjQva2Vy
bmVsL2lvX2FwaWMuYyAyLjYuMTMteDg2XzY0LXdhdGNoZG9nLWFjdGl2ZS9hcmNoL3g4Nl82NC9r
ZXJuZWwvaW9fYXBpYy5jCi0tLSAyLjYuMTMvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMuYwky
MDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLXg4Nl82NC13YXRj
aGRvZy1hY3RpdmUvYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMuYwkyMDA1LTA5LTAxIDExOjMy
OjExLjAwMDAwMDAwMCArMDIwMApAQCAtMTUyOSw2ICsxNTI5LDcgQEAgc3RhdGljIHZvaWQgc2V0
dXBfbm1pICh2b2lkKQogCSAqLyAKIAlwcmludGsoS0VSTl9JTkZPICJhY3RpdmF0aW5nIE5NSSBX
YXRjaGRvZyAuLi4iKTsKIAorCW5taV9hY3RpdmUgPSAxOwogCWVuYWJsZV9OTUlfdGhyb3VnaF9M
VlQwKE5VTEwpOwogCiAJcHJpbnRrKCIgZG9uZS5cbiIpOwpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNo
L3g4Nl82NC9rZXJuZWwvdHJhcHMuYyAyLjYuMTMteDg2XzY0LXdhdGNoZG9nLWFjdGl2ZS9hcmNo
L3g4Nl82NC9rZXJuZWwvdHJhcHMuYwotLS0gMi42LjEzL2FyY2gveDg2XzY0L2tlcm5lbC90cmFw
cy5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0
LXdhdGNoZG9nLWFjdGl2ZS9hcmNoL3g4Nl82NC9rZXJuZWwvdHJhcHMuYwkyMDA1LTA5LTA3IDEz
OjMwOjIwLjAwMDAwMDAwMCArMDIwMApAQCAtNjAzLDcgKzYwMyw3IEBAIGFzbWxpbmthZ2Ugdm9p
ZCBkZWZhdWx0X2RvX25taShzdHJ1Y3QgcHQKIAkJICogT2ssIHNvIHRoaXMgaXMgbm9uZSBvZiB0
aGUgZG9jdW1lbnRlZCBOTUkgc291cmNlcywKIAkJICogc28gaXQgbXVzdCBiZSB0aGUgTk1JIHdh
dGNoZG9nLgogCQkgKi8KLQkJaWYgKG5taV93YXRjaGRvZyA+IDApIHsKKwkJaWYgKG5taV93YXRj
aGRvZyA+IDAgJiYgbm1pX2FjdGl2ZSA+IDApIHsKIAkJCW5taV93YXRjaGRvZ190aWNrKHJlZ3Ms
cmVhc29uKTsKIAkJCXJldHVybjsKIAkJfQpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS14
ODZfNjQvYXBpYy5oIDIuNi4xMy14ODZfNjQtd2F0Y2hkb2ctYWN0aXZlL2luY2x1ZGUvYXNtLXg4
Nl82NC9hcGljLmgKLS0tIDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQvYXBpYy5oCTIwMDUtMDgt
MjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LXdhdGNoZG9nLWFj
dGl2ZS9pbmNsdWRlL2FzbS14ODZfNjQvYXBpYy5oCTIwMDUtMDktMDEgMTE6MzI6MTIuMDAwMDAw
MDAwICswMjAwCkBAIC0xMDMsNiArMTAzLDcgQEAgZXh0ZXJuIHZvaWQgbm1pX3dhdGNoZG9nX2Rl
ZmF1bHQodm9pZCk7CiBleHRlcm4gaW50IHNldHVwX25taV93YXRjaGRvZyhjaGFyICopOwogCiBl
eHRlcm4gdW5zaWduZWQgaW50IG5taV93YXRjaGRvZzsKK2V4dGVybiBpbnQgbm1pX2FjdGl2ZTsK
ICNkZWZpbmUgTk1JX0RFRkFVTFQJLTEKICNkZWZpbmUgTk1JX05PTkUJMAogI2RlZmluZSBOTUlf
SU9fQVBJQwkxCg==

--=__PartC9EBA7A0.1__=--
