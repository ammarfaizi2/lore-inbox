Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274842AbRIZFla>; Wed, 26 Sep 2001 01:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274843AbRIZFlU>; Wed, 26 Sep 2001 01:41:20 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:44446 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274842AbRIZFlK>; Wed, 26 Sep 2001 01:41:10 -0400
Message-ID: <3BB16AB5.7D8F1030@kegel.com>
Date: Tue, 25 Sep 2001 22:42:13 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow core dumping via a fifo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solaris doesn't mind if ./core is a fifo; it happily dumps core
through the fifo.  (Or so I've heard.)  
Here's a patch to 2.4.9 that gives Linux this same ability.
To test it, try
  mkfifo core
  cat core > core2 &
  cat
  (hit ^\ to force a core dump in 2nd cat)
You should have a usable core file in 'core2'.

This is only my second patch ever, so be kind... I'm sure there's something
wrong with it, somewhere, but it did seem to work in my quick tests.

This is also a preliminary step towards what I described in my earlier
post today ("remote core dumping").
- Dan

--- linux/fs/exec.c.orig	Tue Sep 25 15:01:27 2001
+++ linux/fs/exec.c	Tue Sep 25 22:11:45 2001
@@ -954,7 +954,7 @@
 	if (d_unhashed(file->f_dentry))
 		goto close_fail;
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode) && !S_ISFIFO(inode->i_mode))
 		goto close_fail;
 	if (!file->f_op)
 		goto close_fail;
--- linux/fs/binfmt_elf.c.orig	Tue Sep 25 16:35:18 2001
+++ linux/fs/binfmt_elf.c	Tue Sep 25 22:14:42 2001
@@ -864,18 +864,51 @@
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
  */
-static int dump_write(struct file *file, const void *addr, int nr)
+static int dump_write(struct file *file, const void *addr, int nr, loff_t *p_my_f_pos)
 {
+	*p_my_f_pos += nr;
+	/* note: if file is a fifo, file->f_pos is always zero, but fifo_write
+	 * requires the 4th arg to be &file->f_pos.  So we punt and maintain
+	 * our own position variable, *p_my_f_pos.
+	 */
 	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
 }
 
-static int dump_seek(struct file *file, off_t off)
+/* write count zeroes to file; return 1 on success, 0 on failure */
+static int dump_write_zeroes(struct file *file, int count, loff_t *p_my_f_pos)
 {
-	if (file->f_op->llseek) {
+	char buf[256];
+
+	if (count == 0)
+		return 1;
+
+	if (count < 0) {
+		BUG();
+		return 0;
+	}
+	memset(buf, 0, sizeof(buf));
+	while (count > 0) {
+		int nr = min(int, sizeof(buf), count);
+		int ret;
+		ret = file->f_op->write(file, buf, nr, &file->f_pos);
+		if (ret != nr)
+			return 0;
+		*p_my_f_pos += nr;
+		count -= nr;
+	}
+	return 1;
+}
+
+static int dump_seek(struct file *file, loff_t off, loff_t *p_my_f_pos)
+{
+	if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
+		if (!dump_write_zeroes(file, (int)(off - *p_my_f_pos), p_my_f_pos))
+			return 0;
+	} else if (file->f_op->llseek) {
 		if (file->f_op->llseek(file, off, 0) != off)
 			return 0;
-	} else
-		file->f_pos = off;
+		*p_my_f_pos = off;
+	} 
 	return 1;
 }
 
@@ -950,11 +983,11 @@
 #endif
 
 #define DUMP_WRITE(addr, nr)	\
-	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
+	do { if (!dump_write(file, (addr), (nr), p_my_f_pos)) return 0; } while(0)
 #define DUMP_SEEK(off)	\
-	do { if (!dump_seek(file, (off))) return 0; } while(0)
+	do { if (!dump_seek(file, (off), p_my_f_pos)) return 0; } while(0)
 
-static int writenote(struct memelfnote *men, struct file *file)
+static int writenote(struct memelfnote *men, struct file *file, loff_t *p_my_f_pos)
 {
 	struct elf_note en;
 
@@ -965,9 +998,9 @@
 	DUMP_WRITE(&en, sizeof(en));
 	DUMP_WRITE(men->name, en.n_namesz);
 	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)*p_my_f_pos, 4));	/* XXX */
 	DUMP_WRITE(men->data, men->datasz);
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_SEEK(roundup((unsigned long)*p_my_f_pos, 4));	/* XXX */
 
 	return 1;
 }
@@ -975,10 +1008,10 @@
 #undef DUMP_SEEK
 
 #define DUMP_WRITE(addr, nr)	\
-	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
+	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr), &my_f_pos)) \
 		goto end_coredump;
 #define DUMP_SEEK(off)	\
-	if (!dump_seek(file, (off))) \
+	if (!dump_seek(file, (off), &my_f_pos)) \
 		goto end_coredump;
 /*
  * Actual dumper
@@ -1003,6 +1036,7 @@
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
+	loff_t my_f_pos = 0;
 
 	segs = current->mm->map_count;
 
@@ -1186,20 +1220,21 @@
 	}
 
 	for(i = 0; i < numnote; i++)
-		if (!writenote(&notes[i], file))
+		if (!writenote(&notes[i], file, &my_f_pos))
 			goto end_coredump;
 
-	set_fs(fs);
-
 	DUMP_SEEK(dataoff);
 
+	set_fs(fs);
+
 	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
 
 		if (!maydump(vma))
 			continue;
 #ifdef DEBUG
-		printk("elf_core_dump: writing %08lx %lx\n", addr, len);
+		printk("elf_core_dump: writing %08lx %lx\n", 
+			vma->vm_start, vma->vm_end - vma->vm_start);
 #endif
 		for (addr = vma->vm_start;
 		     addr < vma->vm_end;
@@ -1217,17 +1252,19 @@
 			pte = pte_offset(pmd, addr);
 			if (pte_none(*pte)) {
 nextpage_coredump:
-				DUMP_SEEK (file->f_pos + PAGE_SIZE);
+				set_fs(KERNEL_DS);
+				DUMP_SEEK (my_f_pos + PAGE_SIZE);
+				set_fs(fs);
 			} else {
 				DUMP_WRITE((void*)addr, PAGE_SIZE);
 			}
 		}
 	}
 
-	if ((off_t) file->f_pos != offset) {
+	if ((off_t) my_f_pos != offset) {
 		/* Sanity check */
-		printk("elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
-		       (off_t) file->f_pos, offset);
+		printk("elf_core_dump: my_f_pos (%ld) != offset (%ld)\n",
+		       (long) my_f_pos, (long) offset);
 	}
 
  end_coredump:
