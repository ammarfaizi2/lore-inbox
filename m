Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268922AbUHZORC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268922AbUHZORC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbUHZONo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:13:44 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:56387
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268990AbUHZOLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:11:41 -0400
Message-Id: <s12dfdac.061@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 26 Aug 2004 16:12:00 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: x86 build issue with software suspend code
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part4B6B2AA0.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part4B6B2AA0.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

A piece of code most like "copy-and-paste"d from x86_64 to i386 caused
the section named .data.nosave in arch/i386/power/swsusp.S to become
named .data.nosave.1 in arch/i386/power/built-in.o (due to an attribute
collision with an identically named section from arch/i386/power/cpu.c),
which finally ends up in no-where land (because it doesn't have even the
alloc bit set, and the linker script doesn't know about such a section
either), resulting in the two variables being accessed at (absolute)
addresses 0 and 8 (which shouldn't normally be accessible at all, but
perhaps are mapped for whatever reason at the point execution gets
there, since otherwise problems with this code path should have been
observed much earlier).

The below (also attached for the inline variant most certainly getting
incorrectly line wrapped) patch changes the attributes of the section to
match those of other instances of the section, so the renaming doesn't
happen anymore. It also adds alignment, decreases the fields from 8 to 4
bytes and applies these additional changes also to the appearant
original x86_64 code.

I'm slightly worried by the fact that ld lets both the attribute
collision and the relocation from and alloc section targeting targeting
a non-alloc one completely uncommented; I didn't check its code yet, so
I don't know whether perhaps some diagnostics could simply be turned on
for both of these.

Jan

diff -Napru linux-2.6.8.1/arch/i386/power/swsusp.S
2.6.8.1/arch/i386/power/swsusp.S
--- linux-2.6.8.1/arch/i386/power/swsusp.S	2004-08-14
12:55:19.000000000 +0200
+++ 2.6.8.1/arch/i386/power/swsusp.S	2004-08-26 15:54:35.420154440
+0200
@@ -89,9 +89,10 @@ copy_done:
 	popl %ebx
 	ret
 
-       .section .data.nosave
+       .section .data.nosave, "aw"
+       .align 4
 loop:
-       .quad 0
+       .long 0
 loop2:
-       .quad 0
+       .long 0
        .previous
diff -Napru linux-2.6.8.1/arch/x86_64/kernel/suspend_asm.S
2.6.8.1/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.8.1/arch/x86_64/kernel/suspend_asm.S	2004-08-14
12:56:22.000000000 +0200
+++ 2.6.8.1/arch/x86_64/kernel/suspend_asm.S	2004-08-26
15:54:56.446957880 +0200
@@ -117,7 +117,8 @@ ENTRY(do_magic)
 	addq	$8, %rsp
 	jmp	do_magic_resume_2
 
-	.section .data.nosave
+	.section .data.nosave, "aw"
+	.align 8
 loop:
 	.quad 0
 loop2:	


--=__Part4B6B2AA0.0__=
Content-Type: application/octet-stream; name="linux-x86-data_nosave.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-x86-data_nosave.patch"

ZGlmZiAtTmFwcnUgbGludXgtMi42LjguMS9hcmNoL2kzODYvcG93ZXIvc3dzdXNwLlMgMi42Ljgu
MS9hcmNoL2kzODYvcG93ZXIvc3dzdXNwLlMKLS0tIGxpbnV4LTIuNi44LjEvYXJjaC9pMzg2L3Bv
d2VyL3N3c3VzcC5TCTIwMDQtMDgtMTQgMTI6NTU6MTkuMDAwMDAwMDAwICswMjAwCisrKyAyLjYu
OC4xL2FyY2gvaTM4Ni9wb3dlci9zd3N1c3AuUwkyMDA0LTA4LTI2IDE1OjU0OjM1LjQyMDE1NDQ0
MCArMDIwMApAQCAtODksOSArODksMTAgQEAgY29weV9kb25lOgogCXBvcGwgJWVieAogCXJldAog
Ci0gICAgICAgLnNlY3Rpb24gLmRhdGEubm9zYXZlCisgICAgICAgLnNlY3Rpb24gLmRhdGEubm9z
YXZlLCAiYXciCisgICAgICAgLmFsaWduIDQKIGxvb3A6Ci0gICAgICAgLnF1YWQgMAorICAgICAg
IC5sb25nIDAKIGxvb3AyOgotICAgICAgIC5xdWFkIDAKKyAgICAgICAubG9uZyAwCiAgICAgICAg
LnByZXZpb3VzCmRpZmYgLU5hcHJ1IGxpbnV4LTIuNi44LjEvYXJjaC94ODZfNjQva2VybmVsL3N1
c3BlbmRfYXNtLlMgMi42LjguMS9hcmNoL3g4Nl82NC9rZXJuZWwvc3VzcGVuZF9hc20uUwotLS0g
bGludXgtMi42LjguMS9hcmNoL3g4Nl82NC9rZXJuZWwvc3VzcGVuZF9hc20uUwkyMDA0LTA4LTE0
IDEyOjU2OjIyLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjguMS9hcmNoL3g4Nl82NC9rZXJuZWwv
c3VzcGVuZF9hc20uUwkyMDA0LTA4LTI2IDE1OjU0OjU2LjQ0Njk1Nzg4MCArMDIwMApAQCAtMTE3
LDcgKzExNyw4IEBAIEVOVFJZKGRvX21hZ2ljKQogCWFkZHEJJDgsICVyc3AKIAlqbXAJZG9fbWFn
aWNfcmVzdW1lXzIKIAotCS5zZWN0aW9uIC5kYXRhLm5vc2F2ZQorCS5zZWN0aW9uIC5kYXRhLm5v
c2F2ZSwgImF3IgorCS5hbGlnbiA4CiBsb29wOgogCS5xdWFkIDAKIGxvb3AyOgkK

--=__Part4B6B2AA0.0__=--
