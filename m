Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319576AbSIMJ0r>; Fri, 13 Sep 2002 05:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319578AbSIMJ0q>; Fri, 13 Sep 2002 05:26:46 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:46601 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319576AbSIMJ0o>;
	Fri, 13 Sep 2002 05:26:44 -0400
Date: Fri, 13 Sep 2002 18:23:50 +0900 (JST)
Message-Id: <20020913.182350.43012479.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D81A200.C1B6A293@digeo.com>
References: <3D80E139.ACC1719D@digeo.com>
	<20020913.162252.56050784.taka@valinux.co.jp>
	<3D81A200.C1B6A293@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I fixed the patch.

But I have one more question.

Please consider...
while a process sleep in copy_*_user() another one may call kmap_atomic
and kunmap_atomic. And the process will restart and might access the
wrong page as kunmap_atomic do nothing without CONFIG_DEBUG_HIGHMEM flag.
I mean it wouldn't any faults as another page is still kmapped.

In my guess it would cause a woeful result.
Is it my misunderstanding ?

> We're not allowed to schedule away inside atomic_kmap - must remain
> in the same task, on the same CPU etc.  So the pagefault handler
> will return immediately if we take a pagefault while copying to/from
> userspace while holding an atomic kmap.
> 
> So the code first touches the userspace page (via __get_user) to
> fault it in.  Now, there is a 99.999999% chance that the copy_*_user()
> will not fault - it will remain wholly atomic.
> 
> But there is the 0.0000001% chance that the VM will evict (or at least
> unmap) the page between the __get_user() and the completion of the 
> copy_*_user().  In this case, copy_*_user() will fail and will return
> a short copy.
> 
> Now, we could just touch the page with another __get_user() and retry
> the atomic kmap approach.  But I flipped a coin and decided to fall back
> to a regular sleeping kmap instead.  With a sleeping kmap, in a
> non-atomic region the kernel will actually take the fault, fix it up
> and the copy_*_user() will work OK.

Thank you,
Hirokazu Takahashi.



--- linux/mm/filemap.c.ORG	Wed Sep 11 19:48:00 2030
+++ linux/mm/filemap.c	Fri Sep 13 17:57:34 2030
@@ -1940,6 +1940,63 @@ filemap_copy_from_user(struct page *page
 	return left;
 }
 
+static inline int
+__filemap_copy_from_user_iovec(char *vaddr, 
+			const struct iovec *iov, size_t base, unsigned bytes)
+{
+	int left = 0;
+
+	while (bytes) {
+		char *buf = iov->iov_base + base;
+		int copy = min(bytes, iov->iov_len - base);
+		base = 0;
+		if ((left = __copy_from_user(vaddr, buf, copy)))
+			break;
+		bytes -= copy;
+		vaddr += copy;
+		iov++;
+	}
+	return left;
+}
+
+static inline int
+filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
+			const struct iovec *iov, size_t base, unsigned bytes)
+{
+	char *kaddr;
+	int left;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	left = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
+	kunmap_atomic(kaddr, KM_USER0);
+	if (left != 0) {
+		kaddr = kmap(page);
+		left = __filemap_copy_from_user_iovec(kaddr + offset, iov, base, bytes);
+		kunmap(page);
+	}
+	return left;
+}
+
+static inline void
+filemap_set_next_iovec(const struct iovec **iovp, size_t *basep, unsigned bytes)
+{
+	const struct iovec *iov = *iovp;
+	size_t base = *basep;
+
+	while (bytes) {
+		int copy = min(bytes, iov->iov_len - base);
+		bytes -= copy;
+		base += copy;
+		if (iov->iov_len == base) {
+			iov++;
+			base = 0;
+		}
+	}
+	*iovp = iov;
+	*basep = base;
+}
+
+
 /*
  * Write to a file through the page cache. 
  *
@@ -1968,9 +2025,8 @@ generic_file_write_nolock(struct file *f
 	unsigned	bytes;
 	time_t		time_now;
 	struct pagevec	lru_pvec;
-	struct iovec	*cur_iov;
-	unsigned	iov_bytes;	/* Cumulative count to the end of the
-					   current iovec */
+	const struct iovec *cur_iov = iov; /* current iovec */
+	unsigned	iov_base = 0;	   /* offset in the current iovec */
 	unsigned long	seg;
 	char		*buf;
 
@@ -2102,9 +2158,7 @@ generic_file_write_nolock(struct file *f
 		goto out_status;
 	}
 
-	cur_iov = (struct iovec *)iov;
-	iov_bytes = cur_iov->iov_len;
-	buf = cur_iov->iov_base;
+	buf = iov->iov_base;
 	do {
 		unsigned long index;
 		unsigned long offset;
@@ -2115,8 +2169,6 @@ generic_file_write_nolock(struct file *f
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
-		if (bytes + written > iov_bytes)
-			bytes = iov_bytes - written;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2144,7 +2196,12 @@ generic_file_write_nolock(struct file *f
 				vmtruncate(inode, inode->i_size);
 			break;
 		}
-		page_fault = filemap_copy_from_user(page, offset, buf, bytes);
+
+		if (nr_segs == 1) {
+			page_fault = filemap_copy_from_user(page, offset, buf, bytes);
+		} else {
+			page_fault = filemap_copy_from_user_iovec(page, offset, cur_iov, iov_base, bytes);
+		}
 		status = a_ops->commit_write(file, page, offset, offset+bytes);
 		if (unlikely(page_fault)) {
 			status = -EFAULT;
@@ -2157,11 +2214,8 @@ generic_file_write_nolock(struct file *f
 				count -= status;
 				pos += status;
 				buf += status;
-				if (written == iov_bytes && count) {
-					cur_iov++;
-					iov_bytes += cur_iov->iov_len;
-					buf = cur_iov->iov_base;
-				}
+				if (nr_segs > 1)
+					filemap_set_next_iovec(&cur_iov, &iov_base, status);
 			}
 		}
 		if (!PageReferenced(page))
