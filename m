Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJYRnA>; Fri, 25 Oct 2002 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJYRnA>; Fri, 25 Oct 2002 13:43:00 -0400
Received: from fmr02.intel.com ([192.55.52.25]:21953 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261508AbSJYRm5>; Fri, 25 Oct 2002 13:42:57 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB1EF28F7B@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'Mario Smarduch'" <cms063@email.mot.com>,
       IA64 Linux Mail Group <linux-ia64@linuxia64.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fixing /proc/kcore
Date: Fri, 25 Oct 2002 10:49:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C27C4E.CD496DB0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C27C4E.CD496DB0
Content-Type: text/plain;
	charset="utf-7"

/proc/kcore is what you need, but it is broken on ia64 (and
has been since the dawn of time for access to region 5) because
it assumes that all kernel virtual addresses are above PAGE+AF8-OFFSET.
This isn't true on ia64, VMALLOC+AF8-START is smaller than PAGE+AF8-OFFSET.

Attached is a patch (applies to 2.4.19 and to 2.5.39) that fixes the
assumption.  After applying you'll be able to use:

	+ACM- gdb vmlinux /proc/kcore

and happily ask gdb to examine addresses in region 5.

-Tony Luck



-----Original Message-----
From: Mario Smarduch +AFs-mailto:cms063+AEA-email.mot.com+AF0-
Sent: Friday, October 25, 2002 7:36 AM
To: IA64 Linux Mail Group
Subject: +AFs-Linux-ia64+AF0- Debugger/Analysis tool for IA64 Kernel Reg 5


Hi,
    I'm wondering if there is a tool available (gdb or some crash
analysis
tool) that can be used to disassemble/dump region 5 pages? We recently
have ported LiS and OpenSS7 stacks to IA-64 and it was painful without
being able to debug the Reg 5 memory, but we'll still be doing more
work.
We currently just have a crude tool that gets the reg 7 address from a
reg 5 address and then we use gdb, this is pretty cumbersome.....

- Mario.


------_=_NextPart_000_01C27C4E.CD496DB0
Content-Type: application/octet-stream;
	name="kcore.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kcore.patch"

diff -ru ../../REF/linux-2.5.39-ia64-020928/fs/proc/kcore.c =
aegl-kcore/fs/proc/kcore.c=0A=
--- ../../REF/linux-2.5.39-ia64-020928/fs/proc/kcore.c	Fri Sep 27 =
14:48:35 2002=0A=
+++ aegl-kcore/fs/proc/kcore.c	Fri Oct 25 08:25:31 2002=0A=
@@ -99,6 +99,12 @@=0A=
 }=0A=
 #else /* CONFIG_KCORE_AOUT */=0A=
 =0A=
+#if VMALLOC_START < PAGE_OFFSET=0A=
+#define	KCORE_BASE	VMALLOC_START=0A=
+#else=0A=
+#define	KCORE_BASE	PAGE_OFFSET=0A=
+#endif=0A=
+=0A=
 #define roundup(x, y)  ((((x)+((y)-1))/(y))*(y))=0A=
 =0A=
 /* An ELF note in memory */=0A=
@@ -118,7 +124,7 @@=0A=
 	struct vm_struct *m;=0A=
 =0A=
 	*num_vma =3D 0;=0A=
-	size =3D ((size_t)high_memory - PAGE_OFFSET + PAGE_SIZE);=0A=
+	size =3D ((size_t)high_memory - KCORE_BASE + PAGE_SIZE);=0A=
 	if (!vmlist) {=0A=
 		*elf_buflen =3D PAGE_SIZE;=0A=
 		return (size);=0A=
@@ -126,15 +132,15 @@=0A=
 =0A=
 	for (m=3Dvmlist; m; m=3Dm->next) {=0A=
 		try =3D (size_t)m->addr + m->size;=0A=
-		if (try > size)=0A=
-			size =3D try;=0A=
+		if (try > KCORE_BASE + size)=0A=
+			size =3D try - KCORE_BASE;=0A=
 		*num_vma =3D *num_vma + 1;=0A=
 	}=0A=
 	*elf_buflen =3D	sizeof(struct elfhdr) + =0A=
 			(*num_vma + 2)*sizeof(struct elf_phdr) + =0A=
 			3 * sizeof(struct memelfnote);=0A=
 	*elf_buflen =3D PAGE_ALIGN(*elf_buflen);=0A=
-	return (size - PAGE_OFFSET + *elf_buflen);=0A=
+	return size + *elf_buflen;=0A=
 }=0A=
 =0A=
 =0A=
@@ -237,7 +243,7 @@=0A=
 	offset +=3D sizeof(struct elf_phdr);=0A=
 	phdr->p_type	=3D PT_LOAD;=0A=
 	phdr->p_flags	=3D PF_R|PF_W|PF_X;=0A=
-	phdr->p_offset	=3D dataoff;=0A=
+	phdr->p_offset	=3D PAGE_OFFSET - KCORE_BASE + dataoff;=0A=
 	phdr->p_vaddr	=3D PAGE_OFFSET;=0A=
 	phdr->p_paddr	=3D __pa(PAGE_OFFSET);=0A=
 	phdr->p_filesz	=3D phdr->p_memsz =3D ((unsigned long)high_memory - =
PAGE_OFFSET);=0A=
@@ -254,7 +260,7 @@=0A=
 =0A=
 		phdr->p_type	=3D PT_LOAD;=0A=
 		phdr->p_flags	=3D PF_R|PF_W|PF_X;=0A=
-		phdr->p_offset	=3D (size_t)m->addr - PAGE_OFFSET + dataoff;=0A=
+		phdr->p_offset	=3D (size_t)m->addr - KCORE_BASE + dataoff;=0A=
 		phdr->p_vaddr	=3D (size_t)m->addr;=0A=
 		phdr->p_paddr	=3D __pa(m->addr);=0A=
 		phdr->p_filesz	=3D phdr->p_memsz	=3D m->size;=0A=
@@ -385,9 +391,9 @@=0A=
 	/*=0A=
 	 * Fill the remainder of the buffer from kernel VM space.=0A=
 	 * We said in the ELF header that the data which starts=0A=
-	 * at 'elf_buflen' is virtual address PAGE_OFFSET. --rmk=0A=
+	 * at 'elf_buflen' is virtual address KCORE_BASE. --rmk=0A=
 	 */=0A=
-	start =3D PAGE_OFFSET + (*fpos - elf_buflen);=0A=
+	start =3D KCORE_BASE + (*fpos - elf_buflen);=0A=
 	if ((tsz =3D (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)=0A=
 		tsz =3D buflen;=0A=
 		=0A=

------_=_NextPart_000_01C27C4E.CD496DB0--
