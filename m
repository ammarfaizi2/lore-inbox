Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTLBUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLBUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:16:54 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:23522 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S264353AbTLBUNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:13:43 -0500
Message-ID: <56090.200.212.156.130.1070392524.squirrel@webmail.ufam.edu.br>
Date: Tue, 2 Dec 2003 17:15:24 -0200 (BRST)
Subject: [Fwd: Re:Re: [PATCH 2.6.0-test11] Resident memory info in 
     fs/proc/task_mmu.c]
From: edjard@ufam.edu.br
To: linux-kernel@vger.kernel.org
Cc: torvads@osdl.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20031202171524_54471"
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20031202171524_54471
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

Thanks to Christian who helped us pointing some text mistyping.
We attached the file just in case.

>
> Why are you breaking the Coding style? Can you keep the standard
indentation
> please? This will make your patch much smaller and easier to see what
you actually changed.
>
> cheers
>
> Christian
>

We would appreciate any comments.

BR,

Edjard

--- linux-2.6.0-test11/fs/proc/task_mmu.c	2003-11-26 18:43:07.000000000 -0200
+++ linux/fs/proc/task_mmu.c	2003-12-02 13:58:10.000000000 -0200
@@ -3,42 +3,83 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>

+/**
+* Allan Bezerra (ajsb@dcc.fua.br) &
+* Bruna Moreira (brunampm@bol.com.br) &
+* Edjard Mota (edjard@ufam.edu.br) &
+* Mauricio Lin (mauriciolin@bol.com.br) &
+* Include a process PID physical memory size info in the /proc/PID/status
+*/
+
+void resident_mem_size(struct mm_struct *mm, unsigned long start_address,
unsigned long end_address, unsigned long *size)
+{
+	pgd_t *my_pgd;
+	pmd_t *my_pmd;
+	pte_t *my_pte;
+	unsigned long page;
+
+	for (page = start_address; page < end_address; page += PAGE_SIZE) {
+		my_pgd = pgd_offset(mm, page);
+		if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) continue;
+		my_pmd = pmd_offset(my_pgd, page);
+		if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) continue;
+		my_pte = pte_offset_map(my_pmd, page);
+		if (pte_present(*my_pte))
+			*size += PAGE_SIZE;
+	}
+}
+
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
 	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
 	struct vm_area_struct *vma;
-
+	unsigned long phys_data = 0, phys_stack = 0, phys_exec = 0, phys_lib =
0, phys_brk = 0;
 	down_read(&mm->mmap_sem);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
 		if (!vma->vm_file) {
 			data += len;
-			if (vma->vm_flags & VM_GROWSDOWN)
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_data);
+			if (vma->vm_flags & VM_GROWSDOWN){
 				stack += len;
+				resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_stack);
+			}
 			continue;
 		}
 		if (vma->vm_flags & VM_WRITE)
 			continue;
 		if (vma->vm_flags & VM_EXEC) {
 			exec += len;
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_exec);
 			if (vma->vm_flags & VM_EXECUTABLE)
 				continue;
 			lib += len;
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_lib);
 		}
 	}
+	resident_mem_size(mm, mm->start_brk, mm->brk, &phys_brk);
 	buffer += sprintf(buffer,
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
 		"VmRSS:\t%8lu kB\n"
 		"VmData:\t%8lu kB\n"
+		"RssData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
+		"RssStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"RssExe:\t%8lu kB\n"
+		"VmLib:\t%8lu kB\n"
+		"RssLib:\t%8lu kB\n"
+		"VmHeap:\t%8lu KB\n"
+		"RssHeap:\t%8lu KB\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
-		data - stack, stack,
-		exec - lib, lib);
+		data - stack, (phys_data - phys_stack) >> 10,
+		stack, phys_stack >> 10,
+		exec - lib, (phys_exec - phys_lib) >> 10,
+		lib,  phys_lib >> 10,
+		(mm->brk - mm->start_brk) >> 10, phys_brk >> 10);
 	up_read(&mm->mmap_sem);
 	return buffer;
 }

------=_20031202171524_54471
Content-Type: application/octet-stream; name="physical_mem_status.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="physical_mem_status.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxMS9mcy9wcm9jL3Rhc2tfbW11LmMJMjAwMy0xMS0yNiAxODo0
MzowNy4wMDAwMDAwMDAgLTAyMDAKKysrIGxpbnV4L2ZzL3Byb2MvdGFza19tbXUuYwkyMDAzLTEy
LTAyIDEzOjU4OjEwLjAwMDAwMDAwMCAtMDIwMApAQCAtMyw0MiArMyw4MyBAQAogI2luY2x1ZGUg
PGxpbnV4L3NlcV9maWxlLmg+CiAjaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KIAorLyoqCisqIEFs
bGFuIEJlemVycmEgKGFqc2JAZGNjLmZ1YS5icikgJgorKiBCcnVuYSBNb3JlaXJhIChicnVuYW1w
bUBib2wuY29tLmJyKSAmCisqIEVkamFyZCBNb3RhIChlZGphcmRAdWZhbS5lZHUuYnIpICYKKyog
TWF1cmljaW8gTGluIChtYXVyaWNpb2xpbkBib2wuY29tLmJyKSAmCisqIEluY2x1ZGUgYSBwcm9j
ZXNzIFBJRCBwaHlzaWNhbCBtZW1vcnkgc2l6ZSBpbmZvIGluIHRoZSAvcHJvYy9QSUQvc3RhdHVz
CisqLworCit2b2lkIHJlc2lkZW50X21lbV9zaXplKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNp
Z25lZCBsb25nIHN0YXJ0X2FkZHJlc3MsIHVuc2lnbmVkIGxvbmcgZW5kX2FkZHJlc3MsIHVuc2ln
bmVkIGxvbmcgKnNpemUpIAoreworCXBnZF90ICpteV9wZ2Q7CisJcG1kX3QgKm15X3BtZDsKKwlw
dGVfdCAqbXlfcHRlOworCXVuc2lnbmVkIGxvbmcgcGFnZTsKKyAKKwlmb3IgKHBhZ2UgPSBzdGFy
dF9hZGRyZXNzOyBwYWdlIDwgZW5kX2FkZHJlc3M7IHBhZ2UgKz0gUEFHRV9TSVpFKSB7CisJCW15
X3BnZCA9IHBnZF9vZmZzZXQobW0sIHBhZ2UpOworCQlpZiAocGdkX25vbmUoKm15X3BnZCkgfHwg
cGdkX2JhZCgqbXlfcGdkKSkgY29udGludWU7CisJCW15X3BtZCA9IHBtZF9vZmZzZXQobXlfcGdk
LCBwYWdlKTsKKwkJaWYgKHBtZF9ub25lKCpteV9wbWQpIHx8IHBtZF9iYWQoKm15X3BtZCkpIGNv
bnRpbnVlOworCQlteV9wdGUgPSBwdGVfb2Zmc2V0X21hcChteV9wbWQsIHBhZ2UpOworCQlpZiAo
cHRlX3ByZXNlbnQoKm15X3B0ZSkpCisJCQkqc2l6ZSArPSBQQUdFX1NJWkU7CisJfQorfQorCiBj
aGFyICp0YXNrX21lbShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgY2hhciAqYnVmZmVyKQogewogCXVu
c2lnbmVkIGxvbmcgZGF0YSA9IDAsIHN0YWNrID0gMCwgZXhlYyA9IDAsIGxpYiA9IDA7CiAJc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7Ci0KKwl1bnNpZ25lZCBsb25nIHBoeXNfZGF0YSA9IDAs
IHBoeXNfc3RhY2sgPSAwLCBwaHlzX2V4ZWMgPSAwLCBwaHlzX2xpYiA9IDAsIHBoeXNfYnJrID0g
MDsKIAlkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7CiAJZm9yICh2bWEgPSBtbS0+bW1hcDsgdm1h
OyB2bWEgPSB2bWEtPnZtX25leHQpIHsKIAkJdW5zaWduZWQgbG9uZyBsZW4gPSAodm1hLT52bV9l
bmQgLSB2bWEtPnZtX3N0YXJ0KSA+PiAxMDsKIAkJaWYgKCF2bWEtPnZtX2ZpbGUpIHsKIAkJCWRh
dGEgKz0gbGVuOwotCQkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9HUk9XU0RPV04pCisJCQlyZXNp
ZGVudF9tZW1fc2l6ZShtbSwgdm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQsICZwaHlzX2RhdGEp
OworCQkJaWYgKHZtYS0+dm1fZmxhZ3MgJiBWTV9HUk9XU0RPV04pewogCQkJCXN0YWNrICs9IGxl
bjsKKwkJCQlyZXNpZGVudF9tZW1fc2l6ZShtbSwgdm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQs
ICZwaHlzX3N0YWNrKTsKKwkJCX0JCiAJCQljb250aW51ZTsKIAkJfQogCQlpZiAodm1hLT52bV9m
bGFncyAmIFZNX1dSSVRFKQogCQkJY29udGludWU7CiAJCWlmICh2bWEtPnZtX2ZsYWdzICYgVk1f
RVhFQykgewogCQkJZXhlYyArPSBsZW47CisJCQlyZXNpZGVudF9tZW1fc2l6ZShtbSwgdm1hLT52
bV9zdGFydCwgdm1hLT52bV9lbmQsICZwaHlzX2V4ZWMpOwogCQkJaWYgKHZtYS0+dm1fZmxhZ3Mg
JiBWTV9FWEVDVVRBQkxFKQogCQkJCWNvbnRpbnVlOwogCQkJbGliICs9IGxlbjsKKwkJCXJlc2lk
ZW50X21lbV9zaXplKG1tLCB2bWEtPnZtX3N0YXJ0LCB2bWEtPnZtX2VuZCwgJnBoeXNfbGliKTsK
IAkJfQogCX0KKwlyZXNpZGVudF9tZW1fc2l6ZShtbSwgbW0tPnN0YXJ0X2JyaywgbW0tPmJyaywg
JnBoeXNfYnJrKTsKIAlidWZmZXIgKz0gc3ByaW50ZihidWZmZXIsCiAJCSJWbVNpemU6XHQlOGx1
IGtCXG4iCiAJCSJWbUxjazpcdCU4bHUga0JcbiIKIAkJIlZtUlNTOlx0JThsdSBrQlxuIgogCQki
Vm1EYXRhOlx0JThsdSBrQlxuIgorCQkiUnNzRGF0YTpcdCU4bHUga0JcbiIKIAkJIlZtU3RrOlx0
JThsdSBrQlxuIgorCQkiUnNzU3RrOlx0JThsdSBrQlxuIgogCQkiVm1FeGU6XHQlOGx1IGtCXG4i
Ci0JCSJWbUxpYjpcdCU4bHUga0JcbiIsCisJCSJSc3NFeGU6XHQlOGx1IGtCXG4iCisJCSJWbUxp
YjpcdCU4bHUga0JcbiIKKwkJIlJzc0xpYjpcdCU4bHUga0JcbiIKKwkJIlZtSGVhcDpcdCU4bHUg
S0JcbiIKKwkJIlJzc0hlYXA6XHQlOGx1IEtCXG4iLAogCQltbS0+dG90YWxfdm0gPDwgKFBBR0Vf
U0hJRlQtMTApLAogCQltbS0+bG9ja2VkX3ZtIDw8IChQQUdFX1NISUZULTEwKSwKIAkJbW0tPnJz
cyA8PCAoUEFHRV9TSElGVC0xMCksCi0JCWRhdGEgLSBzdGFjaywgc3RhY2ssCi0JCWV4ZWMgLSBs
aWIsIGxpYik7CisJCWRhdGEgLSBzdGFjaywgKHBoeXNfZGF0YSAtIHBoeXNfc3RhY2spID4+IDEw
LCAKKwkJc3RhY2ssIHBoeXNfc3RhY2sgPj4gMTAsCisJCWV4ZWMgLSBsaWIsIChwaHlzX2V4ZWMg
LSBwaHlzX2xpYikgPj4gMTAsCisJCWxpYiwgIHBoeXNfbGliID4+IDEwLAorCQkobW0tPmJyayAt
IG1tLT5zdGFydF9icmspID4+IDEwLCBwaHlzX2JyayA+PiAxMCk7CiAJdXBfcmVhZCgmbW0tPm1t
YXBfc2VtKTsKIAlyZXR1cm4gYnVmZmVyOwogfQo=
------=_20031202171524_54471--

