Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155648-17483>; Mon, 10 May 1999 09:28:30 -0400
Received: by vger.rutgers.edu id <154905-17480>; Mon, 10 May 1999 09:28:08 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:13200 "EHLO artax.karlin.mff.cuni.cz" ident: "mikulas") by vger.rutgers.edu with ESMTP id <154777-17483>; Mon, 10 May 1999 09:25:48 -0400
Date: Mon, 10 May 1999 16:07:58 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.rutgers.edu
Subject: [patch] Core dump race
Message-ID: <Pine.LNX.3.96.990510155718.5232A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hello

I have found a race in core dumping. In binfmt_aout.c, binfmt_elf.c and
binfmt_aout32.c file->f_op->write is called without lock and so more
processes can get to VFS write function. This is the patch. I hope it
fixes the race. (but I can't reproduce it).

Mikulas

--- linux/fs/binfmt_aout.c.or	Mon May 10 15:21:05 1999
+++ linux/fs/binfmt_aout.c	Mon May 10 15:28:40 1999
@@ -58,8 +58,19 @@
  * These are the only things you should do on a core-file: use only these
  * macros to write out all the necessary info.
  */
-#define DUMP_WRITE(addr,nr) \
-while (file->f_op->write(file,(char *)(addr),(nr),&file->f_pos) != (nr)) goto close_coredump
+
+static int dump_write(struct file *file, const void *addr, int nr)
+{
+	int r;
+	down(&file->f_dentry->d_inode->i_sem);
+	r = file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+	up(&file->f_dentry->d_inode->i_sem);
+	return r;
+}
+
+#define DUMP_WRITE(addr, nr)	\
+	if (!dump_write(file, (void *)(addr), (nr))) \
+		goto close_coredump;
 
 #define DUMP_SEEK(offset) \
 if (file->f_op->llseek) { \
--- linux/fs/binfmt_elf.c.or	Mon May 10 15:21:14 1999
+++ linux/fs/binfmt_elf.c	Mon May 10 15:28:28 1999
@@ -927,7 +927,11 @@
  */
 static int dump_write(struct file *file, const void *addr, int nr)
 {
-	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+	int r;
+	down(&file->f_dentry->d_inode->i_sem);
+	r = file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+	up(&file->f_dentry->d_inode->i_sem);
+	return r;
 }
 
 static int dump_seek(struct file *file, off_t off)
--- linux/arch/sparc64/kernel/binfmt_aout32.c.or	Mon May 10 15:31:47 1999
+++ linux/arch/sparc64/kernel/binfmt_aout32.c	Mon May 10 15:28:33 1999
@@ -57,8 +57,19 @@
  * These are the only things you should do on a core-file: use only these
  * macros to write out all the necessary info.
  */
-#define DUMP_WRITE(addr,nr) \
-while (file->f_op->write(file,(char *)(addr),(nr),&file->f_pos) != (nr)) goto close_coredump
+
+static int dump_write(struct file *file, const void *addr, int nr)
+{
+	int r;
+	down(&file->f_dentry->d_inode->i_sem);
+	r = file->f_op->write(file, addr, nr, &file->f_pos) == nr;
+	up(&file->f_dentry->d_inode->i_sem);
+	return r;
+}
+
+#define DUMP_WRITE(addr, nr)	\
+	if (!dump_write(file, (void *)(addr), (nr))) \
+		goto close_coredump;
 
 #define DUMP_SEEK(offset) \
 if (file->f_op->llseek) { \


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
