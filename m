Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVAaTHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVAaTHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVAaTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:07:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62623 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261318AbVAaTGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:06:25 -0500
Date: Mon, 31 Jan 2005 20:06:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] annotate /proc/<PID>/maps with [heap]/[stack]/[vdso] markers
Message-ID: <20050131190604.GA4423@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes the /proc/<PID>/maps file easier to parse (both for
humans and for applications), by annotating the heap, stack and vdso
mappings with [heap], [stack] and [vdso] markers.

It makes it easier/faster to determine at a quick glance whether an
application has a secure VM layout, and it also makes it easier for
tools to determine whether e.g. the heap or stack is executable or not.

new maps file, on a patched kernel:

 001c4000-001d9000 r-xp 00000000 03:01 19954      /lib/ld-2.3.3.so
 001d9000-001db000 rw-p 00014000 03:01 19954      /lib/ld-2.3.3.so
 001dd000-002fb000 r-xp 00000000 03:01 19960      /lib/tls/libc-2.3.3.so
 002fb000-002fd000 r--p 0011d000 03:01 19960      /lib/tls/libc-2.3.3.so
 002fd000-002ff000 rw-p 0011f000 03:01 19960      /lib/tls/libc-2.3.3.so
 002ff000-00301000 rw-p 002ff000 00:00 0
 08048000-0804c000 r-xp 00000000 03:01 31968      /bin/cat
 0804c000-0804d000 rw-p 00003000 03:01 31968      /bin/cat
 0804d000-0806e000 rw-p 0804d000 00:00 0          [heap]
 b7dbc000-b7dbd000 r--p 009d1000 03:01 83628      /usr/lib/locale/locale-archive
 b7dbd000-b7dc4000 r--p 0097d000 03:01 83628      /usr/lib/locale/locale-archive
 b7dc4000-b7df1000 r--p 0094a000 03:01 83628      /usr/lib/locale/locale-archive
 b7df1000-b7ff1000 r--p 00000000 03:01 83628      /usr/lib/locale/locale-archive
 b7ff1000-b7ff2000 rw-p b7ff1000 00:00 0
 bffeb000-c0000000 rw-p bffeb000 00:00 0          [stack]
 ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

Tested on x86, but should work on all architectures.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- fs/proc/task_mmu.c.orig
+++ fs/proc/task_mmu.c
@@ -77,9 +77,18 @@ out:
 	return result;
 }
 
+static void pad_len_spaces(struct seq_file *m, int len)
+{
+	len = 25 + sizeof(void*) * 6 - len;
+	if (len < 1)
+		len = 1;
+	seq_printf(m, "%*c", len, ' ');
+}
+
 static int show_map(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *map = v;
+	struct mm_struct *mm = map->vm_mm;
 	struct file *file = map->vm_file;
 	int flags = map->vm_flags;
 	unsigned long ino = 0;
@@ -102,12 +117,31 @@ static int show_map(struct seq_file *m, 
 			map->vm_pgoff << PAGE_SHIFT,
 			MAJOR(dev), MINOR(dev), ino, &len);
 
+	/*
+	 * Print the dentry name for named mappings, and a
+	 * special [heap] marker for the heap:
+	 */
 	if (map->vm_file) {
-		len = 25 + sizeof(void*) * 6 - len;
-		if (len < 1)
-			len = 1;
-		seq_printf(m, "%*c", len, ' ');
+		pad_len_spaces(m, len);
 		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
+	} else {
+		if (mm) {
+			if (map->vm_start <= mm->start_brk &&
+						map->vm_end >= mm->brk) {
+				pad_len_spaces(m, len);
+				seq_puts(m, "[heap]");
+			} else {
+				if (map->vm_start <= mm->start_stack &&
+					map->vm_end >= mm->start_stack) {
+
+					pad_len_spaces(m, len);
+					seq_puts(m, "[stack]");
+				}
+			}
+		} else {
+			pad_len_spaces(m, len);
+			seq_puts(m, "[vdso]");
+		}
 	}
 	seq_putc(m, '\n');
 	return 0;

