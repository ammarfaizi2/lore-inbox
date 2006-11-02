Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752808AbWKBKVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbWKBKVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbWKBKVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:21:36 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:33976 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1752809AbWKBKV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:21:26 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Magnus Damm <magnus@valinux.co.jp>, Horms <horms@verge.net.au>,
       Dave Anderson <anderson@redhat.com>, ebiederm@xmission.com
Date: Thu, 02 Nov 2006 19:19:49 +0900
Message-Id: <20061102101949.452.23441.sendpatchset@localhost>
In-Reply-To: <20061102101942.452.73192.sendpatchset@localhost>
References: <20061102101942.452.73192.sendpatchset@localhost>
Subject: [PATCH 02/02] Elf: Align elf notes properly
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf: Align elf notes properly

The kernel currently contains several elf note aligment implementations. Most
implementations follow the spec on 32-bit platforms, but none current aligns
the notes correctly on 64-bit platforms. This patch tries to fix this by
interpreting the 64-bit and 32-bit elf specs as the following:

offset bytes name
0      4     n_namesz -+                  -+
4      4     n_descsz  | elf note header   |
8      4     n_type   -+                   | elf note entry size - N4
12     N1    name                          |
N2     N3    desc                         -+

WS = word size in bytes (4 for 32 bit, 8 for 64 bit)
N1 = roundup(n_namesz + sizeof(elf note header), WS) - sizeof(elf note header)
N2 = sizeof(elf note header) + N1
N3 = roundup(n_descsz, WS)
N4 = sizeof(elf note header) + N1 + N2

The elf note header contains three 32-bit values on 32-bit and 64-bit systems. 
The header is followed by name and desc data together with padding. The 
alignment and padding varies depending on the word size.

I base my interpretation on the following:

TIS Elf spec v1.2
http://refspecs.freestandards.org/elf/elf.pdf

- Each elf note entry should be an array of 4-byte words.  (Page 42)
- Name should be terminated with a '\0'                    (Page 42)
- Desc and the next note should be aligned to 32 bits.     (Page 42)
- The example shows that the '\0' is included in n_namesz. (Page 43)

ELF-64 Object File Format, Version 1.5 Draft 2
http://www.busybox.net/cgi-bin/viewcvs.cgi/trunk/docs/elf-64-gen.pdf?rev=15356

- Each elf note entry should be an array of 8-byte words.  (Page 13)
- Name contains a NULL-terminated string.                  (Page 13)
- Desc and the next note should be aligned to 64 bits.     (Page 14)
- "The (name) length does not include the terminating null or the padding"
                                                           (Page 14)

The last line is kind of interesting since it conflicts with the 32-bit
example. I'm ignoring that and treating n_namesz the same regardless of 
word size. So n_namesz is used in the same fashion for both 32-bit and
64-bit platforms in this patch and the calculations above.

This patch fixes the following:

- i386: 32-bit crash notes aligns elf note header to 32-bit size
  This is basically a no-op because 12 is already aligned to 4.
  Use roundup() and sizeof(elf_addr_t).

- mips: The terminating NULL was not included in n_namesz.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).

- powerpc: 32-bit aligment is used regardless of word size.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).
  
- x86_64: 32-bit aligment is used regardless of word size.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).
  
- binfmt_elf / binfmt_elf_fdpic: 32-bit aligment is always used.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).

- kcore: 32-bit aligment is always used, elf_buflen calculation seems wrong.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).

- vmcore: 32-bit aligment is used for both 32-bit and 64-bit code.
  Use roundup(sizeof(elf note header) + n_namesz, sizeof(elf_addr_t)).
  Use sizeof(elf_addr_t).

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19-rc4.

 arch/i386/kernel/crash.c    |   16 ++++++++--------
 arch/mips/kernel/irixelf.c  |   12 ++++++------
 arch/powerpc/kernel/crash.c |   16 ++++++++--------
 arch/x86_64/kernel/crash.c  |   18 +++++++++---------
 fs/binfmt_elf.c             |   11 ++++++-----
 fs/binfmt_elf_fdpic.c       |   10 +++++-----
 fs/proc/kcore.c             |   26 ++++++++++++++------------
 fs/proc/vmcore.c            |   11 +++++------
 8 files changed, 61 insertions(+), 59 deletions(-)

--- 0002/arch/i386/kernel/crash.c
+++ work/arch/i386/kernel/crash.c	2006-11-02 16:59:52.000000000 +0900
@@ -31,7 +31,8 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
+static unsigned char *
+append_elf_note(unsigned char *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
 {
 	struct elf_note note;
@@ -40,16 +41,15 @@ static u32 *append_elf_note(u32 *buf, ch
 	note.n_descsz = data_len;
 	note.n_type   = type;
 	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
+	memcpy(buf + sizeof(note), name, note.n_namesz);
+	buf += roundup(sizeof(note) + note.n_namesz, sizeof(elf_addr_t));
 	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
+	buf += roundup(note.n_descsz, sizeof(elf_addr_t));
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+static void final_note(unsigned char *buf)
 {
 	struct elf_note note;
 
@@ -62,7 +62,7 @@ static void final_note(u32 *buf)
 static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
-	u32 *buf;
+	unsigned char *buf;
 
 	if ((cpu < 0) || (cpu >= NR_CPUS))
 		return;
@@ -74,7 +74,7 @@ static void crash_save_this_cpu(struct p
 	 * squirrelled away.  ELF notes happen to provide
 	 * all of that, so there is no need to invent something new.
 	 */
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	buf = (unsigned char *)per_cpu_ptr(crash_notes, cpu);
 	if (!buf)
 		return;
 	memset(&prstatus, 0, sizeof(prstatus));
--- 0003/arch/mips/kernel/irixelf.c
+++ work/arch/mips/kernel/irixelf.c	2006-11-02 16:59:52.000000000 +0900
@@ -1008,9 +1008,9 @@ static int notesize(struct memelfnote *e
 {
 	int sz;
 
-	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name), 4);
-	sz += roundup(en->datasz, 4);
+	sz = roundup(sizeof(struct elf_note) + strlen(en->name) + 1, 
+		     sizeof(elf_addr_t));
+	sz += roundup(en->datasz, sizeof(elf_addr_t));
 
 	return sz;
 }
@@ -1028,16 +1028,16 @@ static int writenote(struct memelfnote *
 {
 	struct elf_note en;
 
-	en.n_namesz = strlen(men->name);
+	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
 	DUMP_WRITE(&en, sizeof(en));
 	DUMP_WRITE(men->name, en.n_namesz);
 	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, sizeof(elf_addr_t)));
 	DUMP_WRITE(men->data, men->datasz);
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, sizeof(elf_addr_t)));
 
 	return 1;
 
--- 0001/arch/powerpc/kernel/crash.c
+++ work/arch/powerpc/kernel/crash.c	2006-11-02 16:59:52.000000000 +0900
@@ -46,7 +46,8 @@ int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
+static unsigned char *
+append_elf_note(unsigned char *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
 {
 	struct elf_note note;
@@ -55,16 +56,15 @@ static u32 *append_elf_note(u32 *buf, ch
 	note.n_descsz = data_len;
 	note.n_type   = type;
 	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
+	memcpy(buf + sizeof(note), name, note.n_namesz);
+	buf += roundup(sizeof(note) + note.n_namesz, sizeof(elf_addr_t));
 	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
+	buf += roundup(note.n_descsz, sizeof(elf_addr_t));
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+static void final_note(unsigned char *buf)
 {
 	struct elf_note note;
 
@@ -77,7 +77,7 @@ static void final_note(u32 *buf)
 static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
-	u32 *buf;
+	unsigned char *buf;
 
 	if ((cpu < 0) || (cpu >= NR_CPUS))
 		return;
@@ -89,7 +89,7 @@ static void crash_save_this_cpu(struct p
 	 * squirrelled away.  ELF notes happen to provide
 	 * all of that that no need to invent something new.
 	 */
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	buf = (unsigned char *)per_cpu_ptr(crash_notes, cpu);
 	if (!buf) 
 		return;
 
--- 0002/arch/x86_64/kernel/crash.c
+++ work/arch/x86_64/kernel/crash.c	2006-11-02 16:59:52.000000000 +0900
@@ -28,8 +28,9 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type,
-						void *data, size_t data_len)
+static unsigned char *
+append_elf_note(unsigned char *buf, char *name, unsigned type, void *data,
+							       size_t data_len)
 {
 	struct elf_note note;
 
@@ -37,16 +38,15 @@ static u32 *append_elf_note(u32 *buf, ch
 	note.n_descsz = data_len;
 	note.n_type   = type;
 	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
-	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
+	memcpy(buf + sizeof(note), name, note.n_namesz);
+	buf += roundup(sizeof(note) + note.n_namesz, sizeof(elf_addr_t));
 	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
+	buf += roundup(note.n_descsz, sizeof(elf_addr_t));
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+static void final_note(unsigned char *buf)
 {
 	struct elf_note note;
 
@@ -59,7 +59,7 @@ static void final_note(u32 *buf)
 static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
-	u32 *buf;
+	unsigned char *buf;
 
 	if ((cpu < 0) || (cpu >= NR_CPUS))
 		return;
@@ -72,7 +72,7 @@ static void crash_save_this_cpu(struct p
 	 * all of that, no need to invent something new.
 	 */
 
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	buf = (unsigned char *)per_cpu_ptr(crash_notes, cpu);
 
 	if (!buf)
 		return;
--- 0003/fs/binfmt_elf.c
+++ work/fs/binfmt_elf.c	2006-11-02 16:59:52.000000000 +0900
@@ -1204,9 +1204,9 @@ static int notesize(struct memelfnote *e
 {
 	int sz;
 
-	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name) + 1, 4);
-	sz += roundup(en->datasz, 4);
+	sz = roundup(sizeof(struct elf_note) + strlen(en->name) + 1, 
+		     sizeof(elf_addr_t));
+	sz += roundup(en->datasz, sizeof(elf_addr_t));
 
 	return sz;
 }
@@ -1216,8 +1216,9 @@ static int notesize(struct memelfnote *e
 
 static int alignfile(struct file *file, loff_t *foffset)
 {
-	static const char buf[4] = { 0, };
-	DUMP_WRITE(buf, roundup(*foffset, 4) - *foffset, foffset);
+	static const char buf[sizeof(elf_addr_t)] = { 0, };
+	DUMP_WRITE(buf, roundup(*foffset, 
+				sizeof(elf_addr_t)) - *foffset, foffset);
 	return 1;
 }
 
--- 0003/fs/binfmt_elf_fdpic.c
+++ work/fs/binfmt_elf_fdpic.c	2006-11-02 16:59:52.000000000 +0900
@@ -1220,9 +1220,9 @@ static int notesize(struct memelfnote *e
 {
 	int sz;
 
-	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name) + 1, 4);
-	sz += roundup(en->datasz, 4);
+	sz = roundup(sizeof(struct elf_note) + strlen(en->name) + 1, 
+		     sizeof(elf_addr_t));
+	sz += roundup(en->datasz, sizeof(elf_addr_t));
 
 	return sz;
 }
@@ -1245,9 +1245,9 @@ static int writenote(struct memelfnote *
 	DUMP_WRITE(&en, sizeof(en));
 	DUMP_WRITE(men->name, en.n_namesz);
 	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, sizeof(elf_addr_t)));
 	DUMP_WRITE(men->data, men->datasz);
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)file->f_pos, sizeof(elf_addr_t)));
 
 	return 1;
 }
--- 0002/fs/proc/kcore.c
+++ work/fs/proc/kcore.c	2006-11-02 16:59:52.000000000 +0900
@@ -22,6 +22,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#define CORE_STR "CORE"
 
 static int open_kcore(struct inode * inode, struct file * filp)
 {
@@ -82,10 +83,11 @@ static size_t get_kcore_size(int *nphdr,
 	}
 	*elf_buflen =	sizeof(struct elfhdr) + 
 			(*nphdr + 2)*sizeof(struct elf_phdr) + 
-			3 * (sizeof(struct elf_note) + 4) +
-			sizeof(struct elf_prstatus) +
-			sizeof(struct elf_prpsinfo) +
-			sizeof(struct task_struct);
+		3 * roundup(sizeof(struct elf_note) + strlen(CORE_STR) + 1, 
+			    sizeof(elf_addr_t)) +
+		roundup(sizeof(struct elf_prstatus), sizeof(elf_addr_t)) +
+		roundup(sizeof(struct elf_prpsinfo), sizeof(elf_addr_t)) +
+		roundup(sizeof(struct task_struct), sizeof(elf_addr_t));
 	*elf_buflen = PAGE_ALIGN(*elf_buflen);
 	return size + *elf_buflen;
 }
@@ -99,9 +101,9 @@ static int notesize(struct memelfnote *e
 {
 	int sz;
 
-	sz = sizeof(struct elf_note);
-	sz += roundup((strlen(en->name) + 1), 4);
-	sz += roundup(en->datasz, 4);
+	sz = roundup(sizeof(struct elf_note) + strlen(en->name) + 1, 
+		     sizeof(elf_addr_t));
+	sz += roundup(en->datasz, sizeof(elf_addr_t));
 
 	return sz;
 } /* end notesize() */
@@ -124,9 +126,9 @@ static char *storenote(struct memelfnote
 	DUMP_WRITE(men->name, en.n_namesz);
 
 	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	bufp = (char*) roundup((unsigned long)bufp,4);
+	bufp = (char*) roundup((unsigned long)bufp, sizeof(elf_addr_t));
 	DUMP_WRITE(men->data, men->datasz);
-	bufp = (char*) roundup((unsigned long)bufp,4);
+	bufp = (char*) roundup((unsigned long)bufp, sizeof(elf_addr_t));
 
 #undef DUMP_WRITE
 
@@ -210,7 +212,7 @@ static void elf_kcore_store_hdr(char *bu
 	nhdr->p_offset	= offset;
 
 	/* set up the process status */
-	notes[0].name = "CORE";
+	notes[0].name = CORE_STR;
 	notes[0].type = NT_PRSTATUS;
 	notes[0].datasz = sizeof(struct elf_prstatus);
 	notes[0].data = &prstatus;
@@ -221,7 +223,7 @@ static void elf_kcore_store_hdr(char *bu
 	bufp = storenote(&notes[0], bufp);
 
 	/* set up the process info */
-	notes[1].name	= "CORE";
+	notes[1].name	= CORE_STR;
 	notes[1].type	= NT_PRPSINFO;
 	notes[1].datasz	= sizeof(struct elf_prpsinfo);
 	notes[1].data	= &prpsinfo;
@@ -238,7 +240,7 @@ static void elf_kcore_store_hdr(char *bu
 	bufp = storenote(&notes[1], bufp);
 
 	/* set up the task structure */
-	notes[2].name	= "CORE";
+	notes[2].name	= CORE_STR;
 	notes[2].type	= NT_TASKSTRUCT;
 	notes[2].datasz	= sizeof(struct task_struct);
 	notes[2].data	= current;
--- 0001/fs/proc/vmcore.c
+++ work/fs/proc/vmcore.c	2006-11-02 17:01:12.000000000 +0900
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/user.h>
@@ -255,9 +256,8 @@ static int __init merge_note_headers_elf
 		for (j = 0; j < max_sz; j += sz) {
 			if (nhdr_ptr->n_namesz == 0)
 				break;
-			sz = sizeof(Elf64_Nhdr) +
-				((nhdr_ptr->n_namesz + 3) & ~3) +
-				((nhdr_ptr->n_descsz + 3) & ~3);
+			sz = roundup(sizeof(Elf64_Nhdr) + nhdr_ptr->n_namesz, 
+				     8) + roundup(nhdr_ptr->n_descsz, 8);
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
@@ -336,9 +336,8 @@ static int __init merge_note_headers_elf
 		for (j = 0; j < max_sz; j += sz) {
 			if (nhdr_ptr->n_namesz == 0)
 				break;
-			sz = sizeof(Elf32_Nhdr) +
-				((nhdr_ptr->n_namesz + 3) & ~3) +
-				((nhdr_ptr->n_descsz + 3) & ~3);
+			sz = roundup(sizeof(Elf32_Nhdr) + nhdr_ptr->n_namesz, 
+				     4) + roundup(nhdr_ptr->n_descsz, 4);
 			real_sz += sz;
 			nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
 		}
