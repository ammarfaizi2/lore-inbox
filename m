Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319477AbSIMHZu>; Fri, 13 Sep 2002 03:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319522AbSIMHZu>; Fri, 13 Sep 2002 03:25:50 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:25097 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319477AbSIMHZr>;
	Fri, 13 Sep 2002 03:25:47 -0400
Date: Fri, 13 Sep 2002 16:22:52 +0900 (JST)
Message-Id: <20020913.162252.56050784.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D80E139.ACC1719D@digeo.com>
References: <3D7EFF0F.89F7D585@digeo.com>
	<20020912.220041.82105437.taka@valinux.co.jp>
	<3D80E139.ACC1719D@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I updated the writev patch which may be easy to understand.
How about it?

But I have one question, Could let me know if you have any idea,
why does filemap_copy_from_user() try to call kamp()+__copy_from_user()
again after the first trial get fault.

Is there any meanings?

> > a_ops->prepare_write() and a_ops->commit_write will have a
> > penalty when I/O size isn't PAGE_SIZE.
> > With following patch generic_file_write_nolock() will try to
> > make each I/O size become PAGE_SIZE.
> > 
> 
> Certainly makes a lot of sense.  If an application has a large
> number of small objects which are to be appended to a file, and
> they are not contiguous in user memory then this patch makes
> writev() a very attractive way of doing that.  Tons faster.
> 
> However I'd be a little concerned over the increased work which a boring
> old write() has to do.  Perhaps we could add a special code path
> for it:

Thank you, 
Hirokazu Takahashi.


--- linux/mm/filemap.c.ORG	Wed Sep 11 19:48:00 2030
+++ linux/mm/filemap.c	Fri Sep 13 16:08:51 2030
@@ -1940,6 +1940,48 @@ filemap_copy_from_user(struct page *page
 	return left;
 }
 
+static inline int
+filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
+			const struct iovec *iov, size_t base, unsigned bytes)
+{
+	char *kaddr;
+	int left = 0;
+
+	kaddr = kmap_atomic(page, KM_USER0);
+	while (bytes) {
+		char *buf = iov->iov_base + base;
+		int copy = min(bytes, iov->iov_len - base);
+		base = 0;
+		if ((left = __copy_from_user(kaddr + offset, buf, copy)))
+			break;
+		bytes -= copy;
+		offset += copy;
+		iov++;
+	}
+	kunmap_atomic(kaddr, KM_USER0);
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
@@ -1968,9 +2010,8 @@ generic_file_write_nolock(struct file *f
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
 
@@ -2102,9 +2143,7 @@ generic_file_write_nolock(struct file *f
 		goto out_status;
 	}
 
-	cur_iov = (struct iovec *)iov;
-	iov_bytes = cur_iov->iov_len;
-	buf = cur_iov->iov_base;
+	buf = iov->iov_base;
 	do {
 		unsigned long index;
 		unsigned long offset;
@@ -2115,8 +2154,6 @@ generic_file_write_nolock(struct file *f
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
-		if (bytes + written > iov_bytes)
-			bytes = iov_bytes - written;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2144,7 +2181,12 @@ generic_file_write_nolock(struct file *f
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
@@ -2157,11 +2199,8 @@ generic_file_write_nolock(struct file *f
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
