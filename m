Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422992AbWJZJu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWJZJu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423049AbWJZJu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:50:57 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:11741 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1422992AbWJZJu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:50:56 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, Magnus Damm <magnus@valinux.co.jp>,
       Dave Anderson <anderson@redhat.com>, ebiederm@xmission.com
Date: Thu, 26 Oct 2006 18:49:57 +0900
Message-Id: <20061026094957.3410.45001.sendpatchset@localhost>
Subject: [PATCH] Kdump: Align 64-bit ELF crash notes correctly (x86_64, powerpc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump: Align 64-bit ELF crash notes correctly (x86_64, powerpc)

The current ELF code aligns data to 32-bit addresses, regardless if ELFCLASS32
or ELFCLASS64 is used. This works well for the 32-bit case, but for 64-bit 
notes we should (of course) align to 64-bit addresses. At least if we intend 
to follow the "ELF-64 Object File Format, Version 1.5 Draft 2, May 27, 1998".

Unfortunately this change affects 3 pieces of code:
- The regular Linux kernel: See x86_64 and powerpc changes below.
- The "crash" kernel: Needs to align properly when merging notes, see below.
- The utilities that read the vmcore files: Crash, GDB and so on.

I am sure that this change will cause all sorts of trouble if someone is using
a certain combination of kernels and tools, but I believe the best long-term
solution is simply to fix this properly as soon as possible and live with the 
fact that 64-bit vmcore files may have been broken up until now.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Compiles on x86_64, powerpc code only dry-coded.
 Applies on top of 2.6.19-rc3.

 arch/powerpc/kernel/crash.c |   18 +++++++++++-------
 arch/x86_64/kernel/crash.c  |   14 +++++++-------
 fs/proc/vmcore.c            |    4 ++--
 3 files changed, 20 insertions(+), 16 deletions(-)

--- 0001/arch/powerpc/kernel/crash.c
+++ work/arch/powerpc/kernel/crash.c	2006-10-26 17:09:33.000000000 +0900
@@ -41,12 +41,16 @@
 #define DBG(fmt...)
 #endif
 
+#define ELF_ALIGN(x) ((x + (sizeof(elf_addr_t) - 1)) \
+                        & ~(sizeof(elf_addr_t) - 1))
+
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
+static unsigned char *
+append_elf_note(unsigned char *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
 {
 	struct elf_note note;
@@ -55,16 +59,16 @@ static u32 *append_elf_note(u32 *buf, ch
 	note.n_descsz = data_len;
 	note.n_type   = type;
 	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
+	buf += ELF_ALIGN(sizeof(note));
 	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
+	buf += ELF_ALIGN(note.n_namesz);
 	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
+	buf += ELF_ALIGN(note.n_descsz);
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+static void final_note(unsigned char *buf)
 {
 	struct elf_note note;
 
@@ -77,7 +81,7 @@ static void final_note(u32 *buf)
 static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
-	u32 *buf;
+	unsigned char *buf;
 
 	if ((cpu < 0) || (cpu >= NR_CPUS))
 		return;
@@ -89,7 +93,7 @@ static void crash_save_this_cpu(struct p
 	 * squirrelled away.  ELF notes happen to provide
 	 * all of that that no need to invent something new.
 	 */
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	buf = (unsigned char *)per_cpu_ptr(crash_notes, cpu);
 	if (!buf) 
 		return;
 
--- 0002/arch/x86_64/kernel/crash.c
+++ work/arch/x86_64/kernel/crash.c	2006-10-26 16:58:18.000000000 +0900
@@ -28,7 +28,7 @@
 /* This keeps a track of which one is crashing cpu. */
 static int crashing_cpu;
 
-static u32 *append_elf_note(u32 *buf, char *name, unsigned type,
+static u64 *append_elf_note(u64 *buf, char *name, unsigned type,
 						void *data, size_t data_len)
 {
 	struct elf_note note;
@@ -37,16 +37,16 @@ static u32 *append_elf_note(u32 *buf, ch
 	note.n_descsz = data_len;
 	note.n_type   = type;
 	memcpy(buf, &note, sizeof(note));
-	buf += (sizeof(note) +3)/4;
+	buf += (sizeof(note) + 7) / 8;
 	memcpy(buf, name, note.n_namesz);
-	buf += (note.n_namesz + 3)/4;
+	buf += (note.n_namesz + 7) / 8;
 	memcpy(buf, data, note.n_descsz);
-	buf += (note.n_descsz + 3)/4;
+	buf += (note.n_descsz + 7) / 8;
 
 	return buf;
 }
 
-static void final_note(u32 *buf)
+static void final_note(u64 *buf)
 {
 	struct elf_note note;
 
@@ -59,7 +59,7 @@ static void final_note(u32 *buf)
 static void crash_save_this_cpu(struct pt_regs *regs, int cpu)
 {
 	struct elf_prstatus prstatus;
-	u32 *buf;
+	u64 *buf;
 
 	if ((cpu < 0) || (cpu >= NR_CPUS))
 		return;
@@ -72,7 +72,7 @@ static void crash_save_this_cpu(struct p
 	 * all of that, no need to invent something new.
 	 */
 
-	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
+	buf = (u64*)per_cpu_ptr(crash_notes, cpu);
 
 	if (!buf)
 		return;
--- 0001/fs/proc/vmcore.c
+++ work/fs/proc/vmcore.c	2006-10-26 17:31:36.000000000 +0900
@@ -256,8 +256,8 @@ static int __init merge_note_headers_elf
 			if (nhdr_ptr->n_namesz == 0)
 				break;
 			sz = sizeof(Elf64_Nhdr) +
-				((nhdr_ptr->n_namesz + 3) & ~3) +
-				((nhdr_ptr->n_descsz + 3) & ~3);
+				((nhdr_ptr->n_namesz + 7) & ~7) +
+				((nhdr_ptr->n_descsz + 7) & ~7);
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
