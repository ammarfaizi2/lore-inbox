Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131078AbQLJRLE>; Sun, 10 Dec 2000 12:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbQLJRKy>; Sun, 10 Dec 2000 12:10:54 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:49929 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131078AbQLJRKm>; Sun, 10 Dec 2000 12:10:42 -0500
Date: Sun, 10 Dec 2000 18:52:59 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] NR_RESERVED_FILES broken in 2.4 too
Message-ID: <Pine.LNX.4.30.0012101803390.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> > On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > > Read the whole get_empty_filp function, especially this part,
> > I have read the whole function, including the above code, of course. The
> > new_one label has nothing to do with freelists -- it adds the file to the
> > anon_list, where the new arrivales from the slab cache go. The goto
> > new_one above is there simply to initialize the structure with sane
> > initial values
> OK, 2.2 has put_inuse(f); instead of putting it to anon_list, so 2.4
> seems ok.

Back to common sense ;) Nevertheless what you wrote additionally
get_empty_filp returns an allocated file struct that gets to be used.
So ignoring your four emails arguing kernel is ok, I downloaded
2.4-test11-pre7 and tried it out.

root# echo  1024 > /proc/sys/fs/file-max

Unpatched kernel,

user% ./fd-exhaustion   # e.g. while(1) open("/dev/null",...);
root# cat /proc/sys/fs/file-nr
cat: /proc/sys/fs/file-nr: Too many open files in system

The above happens even with increased NR_RESERVED_FILES to 96 [no
wonder, get_empty_filp is broken].

With the patch below,

user% ./fd-exhaustion
root# cat /proc/sys/fs/file-nr
946     0       1024
 or
1024   78       1024
 or
something that also works

The patch also has a fix not to allocate potentially more file
structs than NR_FILES on SMP.

Unfortunately NR_RESERVED_FILES needs to be increased to be useful
[i.e. e.g. to make ssh|login+ps|kill work for superuser]. Other way
would be to more aggressively free unused file structs if kernel is
short on free fd's.

> > There are even books (Understanding the Linux
> > Kernel by Bovet et all) which describe this freelist in the
> > current context so your patch will require updates to the books.

Checked this part of the book, ok for 2.0 but not for 2.[24].

	Szaka

diff -ur linux-2.4.0-test12-pre7/fs/file_table.c linux/fs/file_table.c
--- linux-2.4.0-test12-pre7/fs/file_table.c	Fri Dec  8 08:17:12 2000
+++ linux/fs/file_table.c	Sun Dec 10 17:05:55 2000
@@ -32,39 +32,36 @@
 {
 	static int old_max = 0;
 	struct file * f;
+	int total_free;

 	file_list_lock();
-	if (files_stat.nr_free_files > NR_RESERVED_FILES) {
-	used_one:
-		f = list_entry(free_list.next, struct file, f_list);
-		list_del(&f->f_list);
-		files_stat.nr_free_files--;
-	new_one:
-		memset(f, 0, sizeof(*f));
-		atomic_set(&f->f_count,1);
-		f->f_version = ++event;
-		f->f_uid = current->fsuid;
-		f->f_gid = current->fsgid;
-		list_add(&f->f_list, &anon_list);
-		file_list_unlock();
-		return f;
-	}
-	/*
-	 * Use a reserved one if we're the superuser
-	 */
-	if (files_stat.nr_free_files && !current->euid)
-		goto used_one;
-	/*
-	 * Allocate a new one if we're below the limit.
-	 */
-	if (files_stat.nr_files < files_stat.max_files) {
+	total_free = files_stat.max_files - files_stat.nr_files + files_stat.nr_free_files;
+	if (total_free > NR_RESERVED_FILES || (total_free && !current->euid)) {
+		if (files_stat.nr_free_files) {
+			/* used_one */
+			f = list_entry(free_list.next, struct file, f_list);
+			list_del(&f->f_list);
+			files_stat.nr_free_files--;
+		new_one:
+			memset(f, 0, sizeof(*f));
+			atomic_set(&f->f_count,1);
+			f->f_version = ++event;
+			f->f_uid = current->fsuid;
+			f->f_gid = current->fsgid;
+			list_add(&f->f_list, &anon_list);
+			file_list_unlock();
+			return f;
+		}
+		/*
+	 	 * Allocate a new one if we're below the limit.
+	 	 */
+		files_stat.nr_files++;
 		file_list_unlock();
 		f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
 		file_list_lock();
-		if (f) {
-			files_stat.nr_files++;
+		if (f)
 			goto new_one;
-		}
+		files_stat.nr_files--;
 		/* Big problems... */
 		printk("VFS: filp allocation failed\n");

diff -ur linux-2.4.0-test12-pre7/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.4.0-test12-pre7/include/linux/fs.h	Fri Dec  8 15:06:55 2000
+++ linux/include/linux/fs.h	Sun Dec 10 17:37:52 2000
@@ -57,7 +57,7 @@
 extern int leases_enable, dir_notify_enable, lease_break_time;

 #define NR_FILE  8192	/* this can well be larger on a larger system */
-#define NR_RESERVED_FILES 10 /* reserved for root */
+#define NR_RESERVED_FILES 96 /* reserved for root */
 #define NR_SUPER 256

 #define MAY_EXEC 1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
