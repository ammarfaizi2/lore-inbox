Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVAMXS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVAMXS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVAMWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:09:54 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:41221 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261742AbVAMV62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:28 -0500
Subject: [patch 07/11] uml: move code from ubd_user to ubd_kern
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:01:03 +0100
Message-Id: <20050113210103.61B8B1FEF4@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most code of ubd_user.c already uses the os_* functions, so it can be moved to
ubd_kern.c. This patch simply moves the code without any hidden changes.

The only change is inside io_thread(): since it calls signal(), I created a
little function in ubd_user.c which just calls signal() with the right
parameters.

In a later patch (send together) I'll do some changes, to fix the usage of
errno (which makes this code break when moved in a kernelspace file) and for
some other little cleanups.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c |  365 ++++++++++++++++++++++++++
 linux-2.6.11-paolo/arch/um/drivers/ubd_user.c |  304 ---------------------
 linux-2.6.11-paolo/arch/um/include/ubd_user.h |   59 ----
 3 files changed, 369 insertions(+), 359 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd_user-shrink arch/um/drivers/ubd_kern.c
--- linux-2.6.11/arch/um/drivers/ubd_kern.c~uml-ubd_user-shrink	2005-01-13 05:38:15.739083784 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_kern.c	2005-01-13 05:38:15.761080440 +0100
@@ -53,6 +53,62 @@
 #include "os.h"
 #include "mem.h"
 #include "mem_kern.h"
+#include "cow.h"
+
+enum ubd_req { UBD_READ, UBD_WRITE, UBD_MMAP };
+
+struct io_thread_req {
+	enum ubd_req op;
+	int fds[2];
+	unsigned long offsets[2];
+	unsigned long long offset;
+	unsigned long length;
+	char *buffer;
+	int sectorsize;
+	unsigned long sector_mask;
+	unsigned long long cow_offset;
+	unsigned long bitmap_words[2];
+	int map_fd;
+	unsigned long long map_offset;
+	int error;
+};
+
+extern int open_ubd_file(char *file, struct openflags *openflags,
+			 char **backing_file_out, int *bitmap_offset_out,
+			 unsigned long *bitmap_len_out, int *data_offset_out,
+			 int *create_cow_out);
+extern int create_cow_file(char *cow_file, char *backing_file,
+			   struct openflags flags, int sectorsize,
+			   int alignment, int *bitmap_offset_out,
+			   unsigned long *bitmap_len_out,
+			   int *data_offset_out);
+extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
+extern int read_ubd_fs(int fd, void *buffer, int len);
+extern int write_ubd_fs(int fd, char *buffer, int len);
+extern void do_io(struct io_thread_req *req);
+
+static inline int ubd_test_bit(__u64 bit, unsigned char *data)
+{
+	__u64 n;
+	int bits, off;
+
+	bits = sizeof(data[0]) * 8;
+	n = bit / bits;
+	off = bit % bits;
+	return((data[n] & (1 << off)) != 0);
+}
+
+static inline void ubd_set_bit(__u64 bit, unsigned char *data)
+{
+	__u64 n;
+	int bits, off;
+
+	bits = sizeof(data[0]) * 8;
+	n = bit / bits;
+	off = bit % bits;
+	data[n] |= (1 << off);
+}
+/*End stuff from ubd_user.h*/
 
 #define DRIVER_NAME "uml-blkdev"
 
@@ -1287,6 +1343,315 @@ static int ubd_remapper_setup(void)
 
 __initcall(ubd_remapper_setup);
 
+static int same_backing_files(char *from_cmdline, char *from_cow, char *cow)
+{
+	struct uml_stat buf1, buf2;
+	int err;
+
+	if(from_cmdline == NULL) return(1);
+	if(!strcmp(from_cmdline, from_cow)) return(1);
+
+	err = os_stat_file(from_cmdline, &buf1);
+	if(err < 0){
+		printk("Couldn't stat '%s', err = %d\n", from_cmdline, -err);
+		return(1);
+	}
+	err = os_stat_file(from_cow, &buf2);
+	if(err < 0){
+		printk("Couldn't stat '%s', err = %d\n", from_cow, -err);
+		return(1);
+	}
+	if((buf1.ust_dev == buf2.ust_dev) && (buf1.ust_ino == buf2.ust_ino))
+		return(1);
+
+	printk("Backing file mismatch - \"%s\" requested,\n"
+	       "\"%s\" specified in COW header of \"%s\"\n",
+	       from_cmdline, from_cow, cow);
+	return(0);
+}
+
+static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
+{
+	unsigned long modtime;
+	long long actual;
+	int err;
+
+	err = os_file_modtime(file, &modtime);
+	if(err < 0){
+		printk("Failed to get modification time of backing file "
+		       "\"%s\", err = %d\n", file, -err);
+		return(err);
+	}
+
+	err = os_file_size(file, &actual);
+	if(err < 0){
+		printk("Failed to get size of backing file \"%s\", "
+		       "err = %d\n", file, -err);
+		return(err);
+	}
+
+  	if(actual != size){
+		/*__u64 can be a long on AMD64 and with %lu GCC complains; so
+		 * the typecast.*/
+		printk("Size mismatch (%llu vs %llu) of COW header vs backing "
+		       "file\n", (unsigned long long) size, actual);
+		return(-EINVAL);
+	}
+	if(modtime != mtime){
+		printk("mtime mismatch (%ld vs %ld) of COW header vs backing "
+		       "file\n", mtime, modtime);
+		return(-EINVAL);
+	}
+	return(0);
+}
+
+int read_cow_bitmap(int fd, void *buf, int offset, int len)
+{
+	int err;
+
+	err = os_seek_file(fd, offset);
+	if(err < 0)
+		return(err);
+
+	err = os_read_file(fd, buf, len);
+	if(err < 0)
+		return(err);
+
+	return(0);
+}
+
+int open_ubd_file(char *file, struct openflags *openflags,
+		  char **backing_file_out, int *bitmap_offset_out,
+		  unsigned long *bitmap_len_out, int *data_offset_out,
+		  int *create_cow_out)
+{
+	time_t mtime;
+	unsigned long long size;
+	__u32 version, align;
+	char *backing_file;
+	int fd, err, sectorsize, same, mode = 0644;
+
+	fd = os_open_file(file, *openflags, mode);
+	if(fd < 0){
+		if((fd == -ENOENT) && (create_cow_out != NULL))
+			*create_cow_out = 1;
+                if(!openflags->w ||
+                   ((errno != EROFS) && (errno != EACCES))) return(-errno);
+		openflags->w = 0;
+		fd = os_open_file(file, *openflags, mode);
+		if(fd < 0)
+			return(fd);
+        }
+
+	err = os_lock_file(fd, openflags->w);
+	if(err < 0){
+		printk("Failed to lock '%s', err = %d\n", file, -err);
+		goto out_close;
+	}
+
+	if(backing_file_out == NULL) return(fd);
+
+	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
+			      &size, &sectorsize, &align, bitmap_offset_out);
+	if(err && (*backing_file_out != NULL)){
+		printk("Failed to read COW header from COW file \"%s\", "
+		       "errno = %d\n", file, -err);
+		goto out_close;
+	}
+	if(err) return(fd);
+
+	if(backing_file_out == NULL) return(fd);
+
+	same = same_backing_files(*backing_file_out, backing_file, file);
+
+	if(!same && !backing_file_mismatch(*backing_file_out, size, mtime)){
+		printk("Switching backing file to '%s'\n", *backing_file_out);
+		err = write_cow_header(file, fd, *backing_file_out,
+				       sectorsize, align, &size);
+		if(err){
+			printk("Switch failed, errno = %d\n", -err);
+			return(err);
+		}
+	}
+	else {
+		*backing_file_out = backing_file;
+		err = backing_file_mismatch(*backing_file_out, size, mtime);
+		if(err) goto out_close;
+	}
+
+	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
+		  bitmap_len_out, data_offset_out);
+
+        return(fd);
+ out_close:
+	os_close_file(fd);
+	return(err);
+}
+
+int create_cow_file(char *cow_file, char *backing_file, struct openflags flags,
+		    int sectorsize, int alignment, int *bitmap_offset_out,
+		    unsigned long *bitmap_len_out, int *data_offset_out)
+{
+	int err, fd;
+
+	flags.c = 1;
+	fd = open_ubd_file(cow_file, &flags, NULL, NULL, NULL, NULL, NULL);
+	if(fd < 0){
+		err = fd;
+		printk("Open of COW file '%s' failed, errno = %d\n", cow_file,
+		       -err);
+		goto out;
+	}
+
+	err = init_cow_file(fd, cow_file, backing_file, sectorsize, alignment,
+			    bitmap_offset_out, bitmap_len_out,
+			    data_offset_out);
+	if(!err)
+		return(fd);
+	os_close_file(fd);
+ out:
+	return(err);
+}
+
+/* XXX Just trivial wrappers around os_read_file and os_write_file */
+int read_ubd_fs(int fd, void *buffer, int len)
+{
+	return(os_read_file(fd, buffer, len));
+}
+
+int write_ubd_fs(int fd, char *buffer, int len)
+{
+	return(os_write_file(fd, buffer, len));
+}
+
+static int update_bitmap(struct io_thread_req *req)
+{
+	int n;
+
+	if(req->cow_offset == -1)
+		return(0);
+
+	n = os_seek_file(req->fds[1], req->cow_offset);
+	if(n < 0){
+		printk("do_io - bitmap lseek failed : err = %d\n", -n);
+		return(1);
+	}
+
+	n = os_write_file(req->fds[1], &req->bitmap_words,
+		          sizeof(req->bitmap_words));
+	if(n != sizeof(req->bitmap_words)){
+		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
+		       req->fds[1]);
+		return(1);
+	}
+
+	return(0);
+}
+
+void do_io(struct io_thread_req *req)
+{
+	char *buf;
+	unsigned long len;
+	int n, nsectors, start, end, bit;
+	int err;
+	__u64 off;
+
+	if(req->op == UBD_MMAP){
+		/* Touch the page to force the host to do any necessary IO to
+		 * get it into memory
+		 */
+		n = *((volatile int *) req->buffer);
+		req->error = update_bitmap(req);
+		return;
+	}
+
+	nsectors = req->length / req->sectorsize;
+	start = 0;
+	do {
+		bit = ubd_test_bit(start, (unsigned char *) &req->sector_mask);
+		end = start;
+		while((end < nsectors) &&
+		      (ubd_test_bit(end, (unsigned char *)
+				    &req->sector_mask) == bit))
+			end++;
+
+		off = req->offset + req->offsets[bit] +
+			start * req->sectorsize;
+		len = (end - start) * req->sectorsize;
+		buf = &req->buffer[start * req->sectorsize];
+
+		err = os_seek_file(req->fds[bit], off);
+		if(err < 0){
+			printk("do_io - lseek failed : err = %d\n", -err);
+			req->error = 1;
+			return;
+		}
+		if(req->op == UBD_READ){
+			n = 0;
+			do {
+				buf = &buf[n];
+				len -= n;
+				n = os_read_file(req->fds[bit], buf, len);
+				if (n < 0) {
+					printk("do_io - read failed, err = %d "
+					       "fd = %d\n", -n, req->fds[bit]);
+					req->error = 1;
+					return;
+				}
+			} while((n < len) && (n != 0));
+			if (n < len) memset(&buf[n], 0, len - n);
+		}
+		else {
+			n = os_write_file(req->fds[bit], buf, len);
+			if(n != len){
+				printk("do_io - write failed err = %d "
+				       "fd = %d\n", -n, req->fds[bit]);
+				req->error = 1;
+				return;
+			}
+		}
+
+		start = end;
+	} while(start < nsectors);
+
+	req->error = update_bitmap(req);
+}
+
+/* Changed in start_io_thread, which is serialized by being called only
+ * from ubd_init, which is an initcall.
+ */
+int kernel_fd = -1;
+
+/* Only changed by the io thread */
+int io_count = 0;
+
+int io_thread(void *arg)
+{
+	struct io_thread_req req;
+	int n;
+
+	ignore_sigwinch_sig();
+	while(1){
+		n = os_read_file(kernel_fd, &req, sizeof(req));
+		if(n != sizeof(req)){
+			if(n < 0)
+				printk("io_thread - read failed, fd = %d, "
+				       "err = %d\n", kernel_fd, -n);
+			else {
+				printk("io_thread - short read, fd = %d, "
+				       "length = %d\n", kernel_fd, n);
+			}
+			continue;
+		}
+		io_count++;
+		do_io(&req);
+		n = os_write_file(kernel_fd, &req, sizeof(req));
+		if(n != sizeof(req))
+			printk("io_thread - write failed, fd = %d, err = %d\n",
+			       kernel_fd, -n);
+	}
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -puN arch/um/drivers/ubd_user.c~uml-ubd_user-shrink arch/um/drivers/ubd_user.c
--- linux-2.6.11/arch/um/drivers/ubd_user.c~uml-ubd_user-shrink	2005-01-13 05:38:15.756081200 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ubd_user.c	2005-01-13 05:38:15.762080288 +0100
@@ -26,311 +26,9 @@
 #include <endian.h>
 #include <byteswap.h>
 
-static int same_backing_files(char *from_cmdline, char *from_cow, char *cow)
+void ignore_sigwinch_sig(void)
 {
-	struct uml_stat buf1, buf2;
-	int err;
-
-	if(from_cmdline == NULL) return(1);
-	if(!strcmp(from_cmdline, from_cow)) return(1);
-
-	err = os_stat_file(from_cmdline, &buf1);
-	if(err < 0){
-		printk("Couldn't stat '%s', err = %d\n", from_cmdline, -err);
-		return(1);
-	}
-	err = os_stat_file(from_cow, &buf2);
-	if(err < 0){
-		printk("Couldn't stat '%s', err = %d\n", from_cow, -err);
-		return(1);
-	}
-	if((buf1.ust_dev == buf2.ust_dev) && (buf1.ust_ino == buf2.ust_ino))
-		return(1);
-
-	printk("Backing file mismatch - \"%s\" requested,\n"
-	       "\"%s\" specified in COW header of \"%s\"\n",
-	       from_cmdline, from_cow, cow);
-	return(0);
-}
-
-static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
-{
-	unsigned long modtime;
-	long long actual;
-	int err;
-
-	err = os_file_modtime(file, &modtime);
-	if(err < 0){
-		printk("Failed to get modification time of backing file "
-		       "\"%s\", err = %d\n", file, -err);
-		return(err);
-	}
-
-	err = os_file_size(file, &actual);
-	if(err < 0){
-		printk("Failed to get size of backing file \"%s\", "
-		       "err = %d\n", file, -err);
-		return(err);
-	}
-
-  	if(actual != size){
-		printk("Size mismatch (%ld vs %ld) of COW header vs backing "
-		       "file\n", size, actual);
-		return(-EINVAL);
-	}
-	if(modtime != mtime){
-		printk("mtime mismatch (%ld vs %ld) of COW header vs backing "
-		       "file\n", mtime, modtime);
-		return(-EINVAL);
-	}
-	return(0);
-}
-
-int read_cow_bitmap(int fd, void *buf, int offset, int len)
-{
-	int err;
-
-	err = os_seek_file(fd, offset);
-	if(err < 0)
-		return(err);
-
-	err = os_read_file(fd, buf, len);
-	if(err < 0)
-		return(err);
-
-	return(0);
-}
-
-int open_ubd_file(char *file, struct openflags *openflags, 
-		  char **backing_file_out, int *bitmap_offset_out, 
-		  unsigned long *bitmap_len_out, int *data_offset_out, 
-		  int *create_cow_out)
-{
-	time_t mtime;
-	unsigned long long size;
-	__u32 version, align;
-	char *backing_file;
-	int fd, err, sectorsize, same, mode = 0644;
-
-	fd = os_open_file(file, *openflags, mode);
-	if(fd < 0){
-		if((fd == -ENOENT) && (create_cow_out != NULL))
-			*create_cow_out = 1;
-                if(!openflags->w ||
-                   ((errno != EROFS) && (errno != EACCES))) return(-errno);
-		openflags->w = 0;
-		fd = os_open_file(file, *openflags, mode);
-		if(fd < 0)
-			return(fd);
-        }
-
-	err = os_lock_file(fd, openflags->w);
-	if(err < 0){
-		printk("Failed to lock '%s', err = %d\n", file, -err);
-		goto out_close;
-	}
-
-	if(backing_file_out == NULL) return(fd);
-
-	err = read_cow_header(file_reader, &fd, &version, &backing_file, &mtime,
-			      &size, &sectorsize, &align, bitmap_offset_out);
-	if(err && (*backing_file_out != NULL)){
-		printk("Failed to read COW header from COW file \"%s\", "
-		       "errno = %d\n", file, -err);
-		goto out_close;
-	}
-	if(err) return(fd);
-
-	if(backing_file_out == NULL) return(fd);
-	
-	same = same_backing_files(*backing_file_out, backing_file, file);
-
-	if(!same && !backing_file_mismatch(*backing_file_out, size, mtime)){
-		printk("Switching backing file to '%s'\n", *backing_file_out);
-		err = write_cow_header(file, fd, *backing_file_out,
-				       sectorsize, align, &size);
-		if(err){
-			printk("Switch failed, errno = %d\n", -err);
-			return(err);
-		}
-	}
-	else {
-		*backing_file_out = backing_file;
-		err = backing_file_mismatch(*backing_file_out, size, mtime);
-		if(err) goto out_close;
-	}
-
-	cow_sizes(version, size, sectorsize, align, *bitmap_offset_out,
-		  bitmap_len_out, data_offset_out);
-
-        return(fd);
- out_close:
-	os_close_file(fd);
-	return(err);
-}
-
-int create_cow_file(char *cow_file, char *backing_file, struct openflags flags,
-		    int sectorsize, int alignment, int *bitmap_offset_out,
-		    unsigned long *bitmap_len_out, int *data_offset_out)
-{
-	int err, fd;
-
-	flags.c = 1;
-	fd = open_ubd_file(cow_file, &flags, NULL, NULL, NULL, NULL, NULL);
-	if(fd < 0){
-		err = fd;
-		printk("Open of COW file '%s' failed, errno = %d\n", cow_file,
-		       -err);
-		goto out;
-	}
-
-	err = init_cow_file(fd, cow_file, backing_file, sectorsize, alignment,
-			    bitmap_offset_out, bitmap_len_out,
-			    data_offset_out);
-	if(!err)
-		return(fd);
-	os_close_file(fd);
- out:
-	return(err);
-}
-
-/* XXX Just trivial wrappers around os_read_file and os_write_file */
-int read_ubd_fs(int fd, void *buffer, int len)
-{
-	return(os_read_file(fd, buffer, len));
-}
-
-int write_ubd_fs(int fd, char *buffer, int len)
-{
-	return(os_write_file(fd, buffer, len));
-}
-
-static int update_bitmap(struct io_thread_req *req)
-{
-	int n;
-
-	if(req->cow_offset == -1)
-		return(0);
-
-	n = os_seek_file(req->fds[1], req->cow_offset);
-	if(n < 0){
-		printk("do_io - bitmap lseek failed : err = %d\n", -n);
-		return(1);
-	}
-
-	n = os_write_file(req->fds[1], &req->bitmap_words,
-		          sizeof(req->bitmap_words));
-	if(n != sizeof(req->bitmap_words)){
-		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
-		       req->fds[1]);
-		return(1);
-	}
-
-	return(0);
-}
-
-void do_io(struct io_thread_req *req)
-{
-	char *buf;
-	unsigned long len;
-	int n, nsectors, start, end, bit;
-	int err;
-	__u64 off;
-
-	if(req->op == UBD_MMAP){
-		/* Touch the page to force the host to do any necessary IO to
-		 * get it into memory
-		 */
-		n = *((volatile int *) req->buffer);
-		req->error = update_bitmap(req);
-		return;
-	}
-
-	nsectors = req->length / req->sectorsize;
-	start = 0;
-	do {
-		bit = ubd_test_bit(start, (unsigned char *) &req->sector_mask);
-		end = start;
-		while((end < nsectors) && 
-		      (ubd_test_bit(end, (unsigned char *) 
-				    &req->sector_mask) == bit))
-			end++;
-
-		off = req->offset + req->offsets[bit] + 
-			start * req->sectorsize;
-		len = (end - start) * req->sectorsize;
-		buf = &req->buffer[start * req->sectorsize];
-
-		err = os_seek_file(req->fds[bit], off);
-		if(err < 0){
-			printk("do_io - lseek failed : err = %d\n", -err);
-			req->error = 1;
-			return;
-		}
-		if(req->op == UBD_READ){
-			n = 0;
-			do {
-				buf = &buf[n];
-				len -= n;
-				n = os_read_file(req->fds[bit], buf, len);
-				if (n < 0) {
-					printk("do_io - read failed, err = %d "
-					       "fd = %d\n", -n, req->fds[bit]);
-					req->error = 1;
-					return;
-				}
-			} while((n < len) && (n != 0));
-			if (n < len) memset(&buf[n], 0, len - n);
-		}
-		else {
-			n = os_write_file(req->fds[bit], buf, len);
-			if(n != len){
-				printk("do_io - write failed err = %d "
-				       "fd = %d\n", -n, req->fds[bit]);
-				req->error = 1;
-				return;
-			}
-		}
-
-		start = end;
-	} while(start < nsectors);
-
-	req->error = update_bitmap(req);
-}
-
-/* Changed in start_io_thread, which is serialized by being called only
- * from ubd_init, which is an initcall.
- */
-int kernel_fd = -1;
-
-/* Only changed by the io thread */
-int io_count = 0;
-
-int io_thread(void *arg)
-{
-	struct io_thread_req req;
-	int n;
-
 	signal(SIGWINCH, SIG_IGN);
-	while(1){
-		n = os_read_file(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req)){
-			if(n < 0)
-				printk("io_thread - read failed, fd = %d, "
-				       "err = %d\n", kernel_fd, -n);
-			else {
-				printk("io_thread - short read, fd = %d, "
-				       "length = %d\n", kernel_fd, n);
-			}
-			continue;
-		}
-		io_count++;
-		do_io(&req);
-		n = os_write_file(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req))
-			printk("io_thread - write failed, fd = %d, err = %d\n",
-			       kernel_fd, -n);
-	}
 }
 
 int start_io_thread(unsigned long sp, int *fd_out)
diff -puN arch/um/include/ubd_user.h~uml-ubd_user-shrink arch/um/include/ubd_user.h
--- linux-2.6.11/arch/um/include/ubd_user.h~uml-ubd_user-shrink	2005-01-13 05:38:15.757081048 +0100
+++ linux-2.6.11-paolo/arch/um/include/ubd_user.h	2005-01-13 05:38:15.762080288 +0100
@@ -7,63 +7,10 @@
 #ifndef __UM_UBD_USER_H
 #define __UM_UBD_USER_H
 
-#include "os.h"
-
-enum ubd_req { UBD_READ, UBD_WRITE, UBD_MMAP };
-
-struct io_thread_req {
-	enum ubd_req op;
-	int fds[2];
-	unsigned long offsets[2];
-	unsigned long long offset;
-	unsigned long length;
-	char *buffer;
-	int sectorsize;
-	unsigned long sector_mask;
-	unsigned long long cow_offset;
-	unsigned long bitmap_words[2];
-	int map_fd;
-	unsigned long long map_offset;
-	int error;
-};
-
-extern int open_ubd_file(char *file, struct openflags *openflags, 
-			 char **backing_file_out, int *bitmap_offset_out, 
-			 unsigned long *bitmap_len_out, int *data_offset_out,
-			 int *create_cow_out);
-extern int create_cow_file(char *cow_file, char *backing_file, 
-			   struct openflags flags, int sectorsize, 
-			   int alignment, int *bitmap_offset_out,
-			   unsigned long *bitmap_len_out,
-			   int *data_offset_out);
-extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
-extern int read_ubd_fs(int fd, void *buffer, int len);
-extern int write_ubd_fs(int fd, char *buffer, int len);
+extern void ignore_sigwinch_sig(void);
 extern int start_io_thread(unsigned long sp, int *fds_out);
-extern void do_io(struct io_thread_req *req);
-
-static inline int ubd_test_bit(__u64 bit, unsigned char *data)
-{
-	__u64 n;
-	int bits, off;
-
-	bits = sizeof(data[0]) * 8;
-	n = bit / bits;
-	off = bit % bits;
-	return((data[n] & (1 << off)) != 0);
-}
-
-static inline void ubd_set_bit(__u64 bit, unsigned char *data)
-{
-	__u64 n;
-	int bits, off;
-
-	bits = sizeof(data[0]) * 8;
-	n = bit / bits;
-	off = bit % bits;
-	data[n] |= (1 << off);
-}
-
+extern int io_thread(void *arg);
+extern int kernel_fd;
 
 #endif
 
_
