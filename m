Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLGMpf>; Thu, 7 Dec 2000 07:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLGMp0>; Thu, 7 Dec 2000 07:45:26 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:50442 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129352AbQLGMpR>; Thu, 7 Dec 2000 07:45:17 -0500
Date: Thu, 7 Dec 2000 14:27:20 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Broken NR_RESERVED_FILES
Message-ID: <Pine.LNX.4.30.0012071354070.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reserved fd's for superuser doesn't work. Patch for 2.2 is below,
kernel 2.4.x also has this problem, fix is similar. The default
NR_RESERVED_FILES value also had to be increased (e.g. ssh, login
needs 36, ls 16, man 45 fd's, etc).

BTW, I have an updated version of my reserved VM for superuser +
improved/fixed version of Rik's out of memory killer patch for 2.2
here,

http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_vm+oom_killer-5.diff

It fixes the potential deadlock when kernel threads were blocked to
try to free pages - more details about the patch are in a former
email, http://boudicca.tux.org/hypermail/linux-kernel/2000week48/0624.html

	Szaka

diff -ur linux-2.2.18pre21/fs/file_table.c linux/fs/file_table.c
--- linux-2.2.18pre21/fs/file_table.c	Tue Jan  4 13:12:23 2000
+++ linux/fs/file_table.c	Thu Dec  7 13:26:06 2000
@@ -71,30 +71,27 @@
 {
 	static int old_max = 0;
 	struct file * f;
+	int total_free;

-	if (nr_free_files > NR_RESERVED_FILES) {
-	used_one:
-		f = free_filps;
-		remove_filp(f);
-		nr_free_files--;
-	new_one:
-		memset(f, 0, sizeof(*f));
-		f->f_count = 1;
-		f->f_version = ++global_event;
-		f->f_uid = current->fsuid;
-		f->f_gid = current->fsgid;
-		put_inuse(f);
-		return f;
-	}
-	/*
-	 * Use a reserved one if we're the superuser
-	 */
-	if (nr_free_files && !current->euid)
-		goto used_one;
-	/*
-	 * Allocate a new one if we're below the limit.
-	 */
-	if (nr_files < max_files) {
+	total_free = max_files - nr_files + nr_free_files;
+	if (total_free > NR_RESERVED_FILES || (total_free && !current->euid)) {
+		if (nr_free_files) {
+		used_one:
+			f = free_filps;
+			remove_filp(f);
+			nr_free_files--;
+		new_one:
+			memset(f, 0, sizeof(*f));
+			f->f_count = 1;
+			f->f_version = ++global_event;
+			f->f_uid = current->fsuid;
+			f->f_gid = current->fsgid;
+			put_inuse(f);
+			return f;
+		}
+		/*
+		 * Allocate a new one if we're below the limit.
+	 	*/
 		f = kmem_cache_alloc(filp_cache, SLAB_KERNEL);
 		if (f) {
 			nr_files++;
diff -ur linux-2.2.18pre21/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.2.18pre21/include/linux/fs.h	Thu Nov  9 08:20:18 2000
+++ linux/include/linux/fs.h	Thu Dec  7 11:10:50 2000
@@ -51,7 +51,7 @@
 extern int max_super_blocks, nr_super_blocks;

 #define NR_FILE  4096	/* this can well be larger on a larger system */
-#define NR_RESERVED_FILES 10 /* reserved for root */
+#define NR_RESERVED_FILES 96 /* reserved for root */
 #define NR_SUPER 256

 #define MAY_EXEC 1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
