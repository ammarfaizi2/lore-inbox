Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUHECxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUHECxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267308AbUHECxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:53:20 -0400
Received: from fmr05.intel.com ([134.134.136.6]:5560 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S267301AbUHECxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:53:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C47A97.54780510"
Subject: RE: [Patch 2.6.7]might-sleep-in-atomic while dumping elf
Date: Thu, 5 Aug 2004 10:53:04 +0800
Message-ID: <C0ECD887E2CBE349ACF9C483510BF8381C22DF@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 2.6.7]might-sleep-in-atomic while dumping elf
Thread-Index: AcR6dHLkQeBXcgxQTbGxdF/AxHcqlgAG+vqA
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <davidm@napali.hpl.hp.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 05 Aug 2004 02:53:05.0423 (UTC) FILETIME=[54C789F0:01C47A97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C47A97.54780510
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks,
This is the patch that deals with the format issue and removed the
return check of elf_dump_thread_status.

I think it's hard to drop the tasklist_lock  while we allocate the
memory unless we totally reorganize the elf_core_dump related functions
and data structures.

Zou Nan hai
-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]=20
Sent: Thursday, August 05, 2004 6:47 AM
To: Zou, Nanhai
Cc: linux-kernel@vger.kernel.org; davidm@napali.hpl.hp.com; Luck, Tony
Subject: Re: [Patch 2.6.7]might-sleep-in-atomic while dumping elf

"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>
> Here is a patch to fix a problem of might-sleep-in-atomic which
> David Mosberger mentioned at
> http://www.gelato.unsw.edu.au/linux-ia64/0407/10526.html
>=20
> On IA64 platform, a might-sleep-in-atomic warning raise while dumping
a
> multi-thread process.
> That is because elf_cord_dump hold the tasklist_lock before kernel
doing
> a access_process_vm in elf_core_copy_task_regs,=20
>=20
> This patch detached elf_core_copy_task_regs function from inside
> tasklist_lock to remove the warning.

hm, OK, no worse than what we had there before :(

That GFP_ATOMIC allocation of one 824-byte-on-x86 structure for each
thread looks really, really nasty.  It could easily chew up 100% of the
page
reserves and fail.  I wonder if it is safe to drop the tasklist_lock
while we=20
allocate the memory?

You're still testing for a zero return from elf_dump_thread_status().  I
think that with your changes, that is no longer possible, is it?

Please edit in 80-col xterms.  You'll find that a layout such as the
below
becomes more agreeable.


+		list_for_each(t, &thread_list) {
+			struct elf_thread_status *tmp;
+			int sz;
+
+			tmp =3D list_entry(t, struct elf_thread_status,
list);
+			sz =3D elf_dump_thread_status(signr, tmp);



------_=_NextPart_001_01C47A97.54780510
Content-Type: application/octet-stream;
	name="might_sleep_dump_elf.patch"
Content-Transfer-Encoding: base64
Content-Description: might_sleep_dump_elf.patch
Content-Disposition: attachment;
	filename="might_sleep_dump_elf.patch"

ZGlmZiAtTnJhdXAgYS9mcy9iaW5mbXRfZWxmLmMgYi9mcy9iaW5mbXRfZWxmLmMKLS0tIGEvZnMv
YmluZm10X2VsZi5jCTIwMDQtMDgtMDQgMDI6MzA6MjcuOTA3MDIyNjI4IC0wNzAwCisrKyBiL2Zz
L2JpbmZtdF9lbGYuYwkyMDA0LTA4LTA0IDAyOjMyOjI0LjExNDA1MjQ1NCAtMDcwMApAQCAtMTIx
Niw2ICsxMjE2LDcgQEAgc3RydWN0IGVsZl90aHJlYWRfc3RhdHVzCiAJc3RydWN0IGxpc3RfaGVh
ZCBsaXN0OwogCXN0cnVjdCBlbGZfcHJzdGF0dXMgcHJzdGF0dXM7CS8qIE5UX1BSU1RBVFVTICov
CiAJZWxmX2ZwcmVnc2V0X3QgZnB1OwkJLyogTlRfUFJGUFJFRyAqLworCXN0cnVjdCB0YXNrX3N0
cnVjdCAqdGhyZWFkOwogI2lmZGVmIEVMRl9DT1JFX0NPUFlfWEZQUkVHUwogCWVsZl9mcHhyZWdz
ZXRfdCB4ZnB1OwkJLyogTlRfUFJYRlBSRUcgKi8KICNlbmRpZgpAQCAtMTIyOCwxOCArMTIyOSwx
MCBAQCBzdHJ1Y3QgZWxmX3RocmVhZF9zdGF0dXMKICAqIHdlIG5lZWQgdG8ga2VlcCBhIGxpbmtl
ZCBsaXN0IG9mIGV2ZXJ5IHRocmVhZHMgcHJfc3RhdHVzIGFuZCB0aGVuCiAgKiBjcmVhdGUgYSBz
aW5nbGUgc2VjdGlvbiBmb3IgdGhlbSBpbiB0aGUgZmluYWwgY29yZSBmaWxlLgogICovCi1zdGF0
aWMgaW50IGVsZl9kdW1wX3RocmVhZF9zdGF0dXMobG9uZyBzaWduciwgc3RydWN0IHRhc2tfc3Ry
dWN0ICogcCwgc3RydWN0IGxpc3RfaGVhZCAqIHRocmVhZF9saXN0KQorc3RhdGljIGludCBlbGZf
ZHVtcF90aHJlYWRfc3RhdHVzKGxvbmcgc2lnbnIsIHN0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cyAq
dCkKIHsKLQotCXN0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cyAqdDsKIAlpbnQgc3ogPSAwOwotCi0J
dCA9IGttYWxsb2Moc2l6ZW9mKCp0KSwgR0ZQX0FUT01JQyk7Ci0JaWYgKCF0KQotCQlyZXR1cm4g
MDsKLQltZW1zZXQodCwgMCwgc2l6ZW9mKCp0KSk7Ci0KLQlJTklUX0xJU1RfSEVBRCgmdC0+bGlz
dCk7CisJc3RydWN0IHRhc2tfc3RydWN0ICpwID0gdC0+dGhyZWFkOwogCXQtPm51bV9ub3RlcyA9
IDA7CiAKIAlmaWxsX3Byc3RhdHVzKCZ0LT5wcnN0YXR1cywgcCwgc2lnbnIpOwpAQCAtMTI2Miw3
ICsxMjU1LDYgQEAgc3RhdGljIGludCBlbGZfZHVtcF90aHJlYWRfc3RhdHVzKGxvbmcgcwogCQlz
eiArPSBub3Rlc2l6ZSgmdC0+bm90ZXNbMl0pOwogCX0KICNlbmRpZgkKLQlsaXN0X2FkZCgmdC0+
bGlzdCwgdGhyZWFkX2xpc3QpOwogCXJldHVybiBzejsKIH0KIApAQCAtMTMzMywyMiArMTMyNSwz
MSBAQCBzdGF0aWMgaW50IGVsZl9jb3JlX2R1bXAobG9uZyBzaWduciwgc3RyCiAJCWdvdG8gY2xl
YW51cDsKICNlbmRpZgogCi0JLyogY2FwdHVyZSB0aGUgc3RhdHVzIG9mIGFsbCBvdGhlciB0aHJl
YWRzICovCiAJaWYgKHNpZ25yKSB7CisJCXN0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cyAqdG1wOwog
CQlyZWFkX2xvY2soJnRhc2tsaXN0X2xvY2spOwogCQlkb19lYWNoX3RocmVhZChnLHApCiAJCQlp
ZiAoY3VycmVudC0+bW0gPT0gcC0+bW0gJiYgY3VycmVudCAhPSBwKSB7Ci0JCQkJaW50IHN6ID0g
ZWxmX2R1bXBfdGhyZWFkX3N0YXR1cyhzaWduciwgcCwgJnRocmVhZF9saXN0KTsKLQkJCQlpZiAo
IXN6KSB7CisJCQkJdG1wID0ga21hbGxvYyhzaXplb2YoKnRtcCksIEdGUF9BVE9NSUMpOworCQkJ
CWlmICghdG1wKSB7CiAJCQkJCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsKIAkJCQkJZ290
byBjbGVhbnVwOwotCQkJCX0gZWxzZQotCQkJCQl0aHJlYWRfc3RhdHVzX3NpemUgKz0gc3o7CisJ
CQkJfQorCQkJCW1lbXNldCh0bXAsIDAsIHNpemVvZigqdG1wKSk7CisJCQkJSU5JVF9MSVNUX0hF
QUQoJnRtcC0+bGlzdCk7CisJCQkJdG1wLT50aHJlYWQgPSBwOworCQkJCWxpc3RfYWRkKCZ0bXAt
Pmxpc3QsICZ0aHJlYWRfbGlzdCk7CiAJCQl9CiAJCXdoaWxlX2VhY2hfdGhyZWFkKGcscCk7CiAJ
CXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsKKwkJbGlzdF9mb3JfZWFjaCh0LCAmdGhyZWFk
X2xpc3QpIHsKKwkJCXN0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cyAqdG1wOworCQkJaW50IHN6Owor
CQkJdG1wID0gbGlzdF9lbnRyeSh0LCBzdHJ1Y3QgZWxmX3RocmVhZF9zdGF0dXMsIGxpc3QpOwor
CQkJc3ogPSBlbGZfZHVtcF90aHJlYWRfc3RhdHVzKHNpZ25yLCB0bXApOworCQkJdGhyZWFkX3N0
YXR1c19zaXplICs9IHN6OworCQl9CiAJfQotCiAJLyogbm93IGNvbGxlY3QgdGhlIGR1bXAgZm9y
IHRoZSBjdXJyZW50ICovCiAJbWVtc2V0KHByc3RhdHVzLCAwLCBzaXplb2YoKnByc3RhdHVzKSk7
CiAJZmlsbF9wcnN0YXR1cyhwcnN0YXR1cywgY3VycmVudCwgc2lnbnIpOwo=

------_=_NextPart_001_01C47A97.54780510--
