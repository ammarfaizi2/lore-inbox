Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUKPFi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUKPFi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUKPFi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:38:28 -0500
Received: from fmr18.intel.com ([134.134.136.17]:30857 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261888AbUKPFiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:38:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4CB9E.6B3702DA"
Subject: RE: [patch] Fix GDT re-load on ACPI resume
Date: Tue, 16 Nov 2004 13:37:53 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Fix GDT re-load on ACPI resume
Thread-Index: AcTLXK+OWKeRlsLlQTicDztMY8vXJAAQTeCg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Nickolai Zeldovich" <kolya@MIT.EDU>, <linux-kernel@vger.kernel.org>
Cc: <csapuntz@stanford.edu>, <hiroit@mcn.ne.jp>
X-OriginalArrivalTime: 16 Nov 2004 05:37:54.0191 (UTC) FILETIME=[6B7E09F0:01C4CB9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4CB9E.6B3702DA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>The ACPI resume code currently uses a real-mode 16-bit lgdt instruction
to
>reload the GDT.  This only restores the lower 24 bits of the GDT base
>address.  In recent kernels, the GDT seems to have moved out of the
lower
>16 megs, thereby causing the ACPI resume to fail -- an invalid GDT was
>being loaded.
>
>This simple patch adds the 0x66 prefix to lgdt, which forces it to load
>all 32 bits of the GDT base address, thereby removing any restrictions
on
>where the GDT can be placed in memory.  This makes ACPI resume work for
me
>on a Thinkpad T40 laptop.
>
>-- kolya
>
>--- linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 09:00:34
1.1
>+++ linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 20:33:27
>@@ -67,6 +67,8 @@
> 	movw	$0x0e00 + 'i', %fs:(0x12)
>
> 	# need a gdt
>+	.byte	0x66			# force 32-bit operands in case
>+					# the GDT is past 16 megabytes
> 	lgdt	real_save_gdt - wakeup_code
>
> 	movl	real_save_cr0 - wakeup_code, %eax
There is a patch from hiroit@mcn.ne.jp to fix the GDT issue. You can try
it.
Please cc 'acpi-devel@lists.sourceforge.net' for suspend/resume issue.

Thanks,
Shaohua

------_=_NextPart_001_01C4CB9E.6B3702DA
Content-Type: application/octet-stream;
	name="wakeup_gdt2.patch"
Content-Transfer-Encoding: base64
Content-Description: wakeup_gdt2.patch
Content-Disposition: attachment;
	filename="wakeup_gdt2.patch"

ZGlmZiAtTnJ1IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3NsZWVwLmMgYi9hcmNoL2kzODYva2Vy
bmVsL2FjcGkvc2xlZXAuYwotLS0gYS9hcmNoL2kzODYva2VybmVsL2FjcGkvc2xlZXAuYwkyMDA0
LTEwLTE1IDExOjI5OjE1LjAwMDAwMDAwMCArMDkwMAorKysgYi9hcmNoL2kzODYva2VybmVsL2Fj
cGkvc2xlZXAuYwkyMDA0LTEwLTE5IDAwOjU5OjMyLjAwMDAwMDAwMCArMDkwMApAQCAtMTcsNyAr
MTcsNyBAQAogCiBleHRlcm4gdm9pZCB6YXBfbG93X21hcHBpbmdzKHZvaWQpOwogCi1leHRlcm4g
dW5zaWduZWQgbG9uZyBGQVNUQ0FMTChhY3BpX2NvcHlfd2FrZXVwX3JvdXRpbmUodW5zaWduZWQg
bG9uZykpOworZXh0ZXJuIHVuc2lnbmVkIGxvbmcgRkFTVENBTEwoYWNwaV9jb3B5X3dha2V1cF9y
b3V0aW5lKHVuc2lnbmVkIGxvbmcsdW5zaWduZWQgbG9uZykpOwogCiBzdGF0aWMgdm9pZCBpbml0
X2xvd19tYXBwaW5nKHBnZF90ICpwZ2QsIGludCBwZ2RfbGltaXQpCiB7CkBAIC00MSw3ICs0MSw4
IEBACiAJCXJldHVybiAxOwogCWluaXRfbG93X21hcHBpbmcoc3dhcHBlcl9wZ19kaXIsIFVTRVJf
UFRSU19QRVJfUEdEKTsKIAltZW1jcHkoKHZvaWQgKikgYWNwaV93YWtldXBfYWRkcmVzcywgJndh
a2V1cF9zdGFydCwgJndha2V1cF9lbmQgLSAmd2FrZXVwX3N0YXJ0KTsKLQlhY3BpX2NvcHlfd2Fr
ZXVwX3JvdXRpbmUoYWNwaV93YWtldXBfYWRkcmVzcyk7CisJYWNwaV9jb3B5X3dha2V1cF9yb3V0
aW5lKGFjcGlfd2FrZXVwX2FkZHJlc3MsCisJCQkJIHZpcnRfdG9fcGh5cygodm9pZCAqKWFjcGlf
d2FrZXVwX2FkZHJlc3MpKTsKIAogCXJldHVybiAwOwogfQpkaWZmIC1OcnUgYS9hcmNoL2kzODYv
a2VybmVsL2FjcGkvd2FrZXVwLlMgYi9hcmNoL2kzODYva2VybmVsL2FjcGkvd2FrZXVwLlMKLS0t
IGEvYXJjaC9pMzg2L2tlcm5lbC9hY3BpL3dha2V1cC5TCTIwMDQtMDgtMTQgMTQ6MzY6MzEuMDAw
MDAwMDAwICswOTAwCisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvYWNwaS93YWtldXAuUwkyMDA0LTEw
LTE5IDA1OjI0OjQyLjAwMDAwMDAwMCArMDkwMApAQCAtODksNiArODksNyBAQAogcmVhbF9tYWdp
YzoJLmxvbmcgMAogdmlkZW9fbW9kZToJLmxvbmcgMAogdmlkZW9fZmxhZ3M6CS5sb25nIDAKK3Jl
YWxfZ2R0X3RhYmxlOiAuZmlsbCBHRFRfRU5UUklFUywgOCwgMAogCiBib2d1c19yZWFsX21hZ2lj
OgogCW1vdncJJDB4MGUwMCArICdCJywgJWZzOigweDEyKQpAQCAtMjEzLDYgKzIxNCw3IEBACiAj
CiAjIFBhcmFtZXRlcnM6CiAjICVlYXg6CXBsYWNlIHRvIGNvcHkgd2FrZXVwIHJvdXRpbmUgdG8K
KyMgJWVkeDogdGhlIHNlY29uZCBhcmd1bWVudCAocGh5c2ljYWwgYWRkcmVzcykKICMKICMgUmV0
dXJuZWQgYWRkcmVzcyBpcyBsb2NhdGlvbiBvZiBjb2RlIGluIGxvdyBtZW1vcnkgKHBhc3QgZGF0
YSBhbmQgc3RhY2spCiAjCkBAIC0yMjMsNiArMjI1LDkgQEAKIAlzbGR0CXNhdmVkX2xkdAogCXN0
cglzYXZlZF90c3MKIAorCSMgc2F2ZSB3YWtldXBfc3RhcnQgcGh5c2ljYWwgYWRkcmVzcyBpbiBl
Y3gKKwltb3ZsCSVlZHgsICVlY3gKKwogCW1vdmwgICAgJWNyMywgJWVkeAogCW1vdmwgICAgJWVk
eCwgcmVhbF9zYXZlX2NyMyAtIHdha2V1cF9zdGFydCAoJWVheCkKIAltb3ZsICAgICVjcjQsICVl
ZHgKQEAgLTIzMSw2ICsyMzYsMTYgQEAKIAltb3ZsCSVlZHgsIHJlYWxfc2F2ZV9jcjAgLSB3YWtl
dXBfc3RhcnQgKCVlYXgpCiAJc2dkdCAgICByZWFsX3NhdmVfZ2R0IC0gd2FrZXVwX3N0YXJ0ICgl
ZWF4KQogCisJIyBnZHQgYm9keSBtdXN0IGJlIGFkZHJlc3NhYmxlIGZyb20gcmVhbCBtb2RlIGJ5
CisJIyBjb3B5aW5nIGl0IHRvIHRoZSBsb3dlciBtZW0KKwlsZWEgICAgIHJlYWxfZ2R0X3RhYmxl
IC0gd2FrZXVwX3N0YXJ0ICglZWN4KSwgJWVjeAorCW1vdmwgICAgJWVjeCwgcmVhbF9zYXZlX2dk
dCArIDIgLSB3YWtldXBfc3RhcnQgKCVlYXgpCisJeG9yICAgICAlZWN4LCAlZWN4CisJbW92dyAg
ICBzYXZlZF9nZHQsICVjeAorCW1vdmwgICAgc2F2ZWRfZ2R0ICsgMiwgJWVzaQorCWxlYSAgICAg
cmVhbF9nZHRfdGFibGUgLSB3YWtldXBfc3RhcnQgKCVlYXgpLCAlZWRpCisJcmVwIG1vdnNiCisK
IAltb3ZsCXNhdmVkX3ZpZGVvbW9kZSwgJWVkeAogCW1vdmwJJWVkeCwgdmlkZW9fbW9kZSAtIHdh
a2V1cF9zdGFydCAoJWVheCkKIAltb3ZsCWFjcGlfdmlkZW9fZmxhZ3MsICVlZHgK

------_=_NextPart_001_01C4CB9E.6B3702DA--
