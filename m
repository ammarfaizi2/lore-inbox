Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUHDBrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUHDBrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHDBrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:47:07 -0400
Received: from fmr06.intel.com ([134.134.136.7]:47785 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267186AbUHDBqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:46:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C479C4.C97AEA03"
Subject: [Patch 2.6.7]might-sleep-in-atomic while dumping elf
Date: Wed, 4 Aug 2004 09:45:57 +0800
Message-ID: <C0ECD887E2CBE349ACF9C483510BF8381C22DD@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 2.6.7]might-sleep-in-atomic while dumping elf
Thread-Index: AcR5xMRmc7JmFZ1XRk6GTY/FxblQuQ==
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: "David Mosberger" <davidm@napali.hpl.hp.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 04 Aug 2004 01:45:57.0984 (UTC) FILETIME=[C9D35E00:01C479C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C479C4.C97AEA03
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here is a patch to fix a problem of might-sleep-in-atomic which
David Mosberger mentioned at
http://www.gelato.unsw.edu.au/linux-ia64/0407/10526.html

On IA64 platform, a might-sleep-in-atomic warning raise while dumping a
multi-thread process.
That is because elf_cord_dump hold the tasklist_lock before kernel doing
a access_process_vm in elf_core_copy_task_regs,=20

This patch detached elf_core_copy_task_regs function from inside
tasklist_lock to remove the warning.

diff -Nraup a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	2004-06-24 09:25:07.000000000 +0800
+++ b/fs/binfmt_elf.c	2004-07-30 16:44:10.000000000 +0800
@@ -1216,6 +1216,7 @@ struct elf_thread_status
 	struct list_head list;
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
+	struct task_struct *thread;
 #ifdef ELF_CORE_COPY_XFPREGS
 	elf_fpxregset_t xfpu;		/* NT_PRXFPREG */
 #endif
@@ -1228,18 +1229,10 @@ struct elf_thread_status
  * we need to keep a linked list of every threads pr_status and then
  * create a single section for them in the final core file.
  */
-static int elf_dump_thread_status(long signr, struct task_struct * p,
struct list_head * thread_list)
+static int elf_dump_thread_status(long signr, struct elf_thread_status
*t)
 {
-
-	struct elf_thread_status *t;
 	int sz =3D 0;
-
-	t =3D kmalloc(sizeof(*t), GFP_ATOMIC);
-	if (!t)
-		return 0;
-	memset(t, 0, sizeof(*t));
-
-	INIT_LIST_HEAD(&t->list);
+	struct task_struct *p =3D t->thread;
 	t->num_notes =3D 0;
=20
 	fill_prstatus(&t->prstatus, p, signr);
@@ -1262,7 +1255,6 @@ static int elf_dump_thread_status(long s
 		sz +=3D notesize(&t->notes[2]);
 	}
 #endif=09
-	list_add(&t->list, thread_list);
 	return sz;
 }
=20
@@ -1333,22 +1325,32 @@ static int elf_core_dump(long signr, str
 		goto cleanup;
 #endif
=20
-	/* capture the status of all other threads */
 	if (signr) {
+		struct elf_thread_status *tmp;
 		read_lock(&tasklist_lock);
 		do_each_thread(g,p)
 			if (current->mm =3D=3D p->mm && current !=3D p) {
-				int sz =3D elf_dump_thread_status(signr,
p, &thread_list);
-				if (!sz) {
+				tmp =3D kmalloc(sizeof(*tmp), GFP_ATOMIC);
+				if (!tmp) {
 					read_unlock(&tasklist_lock);
 					goto cleanup;
-				} else
-					thread_status_size +=3D sz;
+				}
+				memset(tmp, 0, sizeof(*tmp));
+				INIT_LIST_HEAD(&tmp->list);
+				tmp->thread =3D p;
+				list_add(&tmp->list, &thread_list);
 			}
 		while_each_thread(g,p);
 		read_unlock(&tasklist_lock);
+		list_for_each(t, &thread_list) {
+			struct elf_thread_status *tmp =3D list_entry(t,
struct elf_thread_status, list);
+			int sz =3D elf_dump_thread_status(signr, tmp);
+			if (!sz)
+				goto cleanup;
+			else
+				thread_status_size +=3D sz;
+		}
 	}
-
 	/* now collect the dump for the current */
 	memset(prstatus, 0, sizeof(*prstatus));
 	fill_prstatus(prstatus, current, signr);




------_=_NextPart_001_01C479C4.C97AEA03
Content-Type: application/octet-stream;
	name="might_sleep_dump_elf.patch"
Content-Transfer-Encoding: base64
Content-Description: might_sleep_dump_elf.patch
Content-Disposition: attachment;
	filename="might_sleep_dump_elf.patch"

ZGlmZiAtTnJhdXAgYS9mcy9iaW5mbXRfZWxmLmMgYi9mcy9iaW5mbXRfZWxmLmMKLS0tIGEvZnMv
YmluZm10X2VsZi5jCTIwMDQtMDYtMjQgMDk6MjU6MDcuMDAwMDAwMDAwICswODAwCisrKyBiL2Zz
L2JpbmZtdF9lbGYuYwkyMDA0LTA3LTMwIDE2OjQ0OjEwLjAwMDAwMDAwMCArMDgwMApAQCAtMTIx
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
MiBAQCBzdGF0aWMgaW50IGVsZl9jb3JlX2R1bXAobG9uZyBzaWduciwgc3RyCiAJCWdvdG8gY2xl
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
X2xpc3QpIHsKKwkJCXN0cnVjdCBlbGZfdGhyZWFkX3N0YXR1cyAqdG1wID0gbGlzdF9lbnRyeSh0
LCBzdHJ1Y3QgZWxmX3RocmVhZF9zdGF0dXMsIGxpc3QpOworCQkJaW50IHN6ID0gZWxmX2R1bXBf
dGhyZWFkX3N0YXR1cyhzaWduciwgdG1wKTsKKwkJCWlmICghc3opCisJCQkJZ290byBjbGVhbnVw
OworCQkJZWxzZQorCQkJCXRocmVhZF9zdGF0dXNfc2l6ZSArPSBzejsKKwkJfQogCX0KLQogCS8q
IG5vdyBjb2xsZWN0IHRoZSBkdW1wIGZvciB0aGUgY3VycmVudCAqLwogCW1lbXNldChwcnN0YXR1
cywgMCwgc2l6ZW9mKCpwcnN0YXR1cykpOwogCWZpbGxfcHJzdGF0dXMocHJzdGF0dXMsIGN1cnJl
bnQsIHNpZ25yKTsK

------_=_NextPart_001_01C479C4.C97AEA03--
