Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWEVFHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEVFHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 01:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWEVFHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 01:07:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:4814 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWEVFHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 01:07:12 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 14:46:52 +1000
Cc: linux-kernel@vger.kernel.org
Message-Id: <1060522044652.31268@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Subject: [PATCH 001 of 2] Prepare  for __copy_from_user_inatomic to not zero missed bytes.
References: <20060522143524.25410.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a problem with __copy_from_user_inatomic zeroing the tail of
the buffer in the case of an error.  As it is called in atomic
context, the error may be transient, so it results in zeros being
written where maybe they shouldn't be.

In the usage in filemap, this opens a window for a well timed read to
see data (zeros) which is not consistent with any ordering of reads
and writes.

Most cases where __copy_from_user_inatomic is called, a failure results
in __copy_from_user being called immediately.  As long as the latter
zeros the tail, the former doesn't need to.
However in *copy_from_user_iovec implementations (in both filemap 
and ntfs/file), it is assumed that copy_from_user_inatomic will zero the
tail.

This patch removes that assumption, so that after this patch it will
be safe for copy_from_user_inatomic to not zero the tail.

This patch also adds some commentary to filemap.h and asm-i386/uaccess.h.

After this patch, all architectures that might disable preempt when
kmap_atomic is called need to have their __copy_from_user_inatomic* "fixed".
This includes
 - powerpc
 - i386
 - mips
 - sparc

Interestingly 'frv' disables preempt in kmap_atomic, but its
copy_from_user doesn't expect faults and never zeros the tail...

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/ntfs/file.c             |   26 ++++++++++++++------------
 ./include/asm-i386/uaccess.h |    6 ++++++
 ./mm/filemap.c               |    8 ++------
 ./mm/filemap.h               |   26 ++++++++++++++++++--------
 4 files changed, 40 insertions(+), 26 deletions(-)

diff ./fs/ntfs/file.c~current~ ./fs/ntfs/file.c
--- ./fs/ntfs/file.c~current~	2006-05-22 11:20:26.000000000 +1000
+++ ./fs/ntfs/file.c	2006-05-22 11:20:26.000000000 +1000
@@ -1358,7 +1358,7 @@ err_out:
 	goto out;
 }
 
-static size_t __ntfs_copy_from_user_iovec(char *vaddr,
+static size_t __ntfs_copy_from_user_iovec_inatomic(char *vaddr,
 		const struct iovec *iov, size_t iov_ofs, size_t bytes)
 {
 	size_t total = 0;
@@ -1376,10 +1376,6 @@ static size_t __ntfs_copy_from_user_iove
 		bytes -= len;
 		vaddr += len;
 		if (unlikely(left)) {
-			/*
-			 * Zero the rest of the target like __copy_from_user().
-			 */
-			memset(vaddr, 0, bytes);
 			total -= left;
 			break;
 		}
@@ -1420,11 +1416,13 @@ static inline void ntfs_set_next_iovec(c
  * pages (out to offset + bytes), to emulate ntfs_copy_from_user()'s
  * single-segment behaviour.
  *
- * We call the same helper (__ntfs_copy_from_user_iovec()) both when atomic and
- * when not atomic.  This is ok because __ntfs_copy_from_user_iovec() calls
- * __copy_from_user_inatomic() and it is ok to call this when non-atomic.  In
- * fact, the only difference between __copy_from_user_inatomic() and
- * __copy_from_user() is that the latter calls might_sleep().  And on many
+ * We call the same helper (__ntfs_copy_from_user_iovec_inatomic()) both
+ * when atomic and when not atomic.  This is ok because
+ * __ntfs_copy_from_user_iovec_inatomic() calls __copy_from_user_inatomic()
+ * and it is ok to call this when non-atomic.
+ * Infact, the only difference between __copy_from_user_inatomic() and
+ * __copy_from_user() is that the latter calls might_sleep() and the former
+ * should not zero the tail of the buffer on error.  And on many
  * architectures __copy_from_user_inatomic() is just defined to
  * __copy_from_user() so it makes no difference at all on those architectures.
  */
@@ -1441,14 +1439,18 @@ static inline size_t ntfs_copy_from_user
 		if (len > bytes)
 			len = bytes;
 		kaddr = kmap_atomic(*pages, KM_USER0);
-		copied = __ntfs_copy_from_user_iovec(kaddr + ofs,
+		copied = __ntfs_copy_from_user_iovec_inatomic(kaddr + ofs,
 				*iov, *iov_ofs, len);
 		kunmap_atomic(kaddr, KM_USER0);
 		if (unlikely(copied != len)) {
 			/* Do it the slow way. */
 			kaddr = kmap(*pages);
-			copied = __ntfs_copy_from_user_iovec(kaddr + ofs,
+			copied = __ntfs_copy_from_user_iovec_inatomic(kaddr + ofs,
 					*iov, *iov_ofs, len);
+			/*
+			 * Zero the rest of the target like __copy_from_user().
+			 */
+			memset(kaddr + ofs + copied, 0, len - copied);
 			kunmap(*pages);
 			if (unlikely(copied != len))
 				goto err_out;

diff ./include/asm-i386/uaccess.h~current~ ./include/asm-i386/uaccess.h
--- ./include/asm-i386/uaccess.h~current~	2006-05-22 11:20:26.000000000 +1000
+++ ./include/asm-i386/uaccess.h	2006-05-22 11:20:26.000000000 +1000
@@ -458,6 +458,12 @@ __copy_to_user(void __user *to, const vo
  *
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
+ *
+ * An alternate version - __copy_from_user_inatomic() - may be called from
+ * atomic context and will fail rather than sleep.  In this case the
+ * uncopied bytes will *NOT* be padded with zeros.  See fs/filemap.h
+ * for explanation of why this is needed.
+ * FIXME this isn't implimented yet EMXIF
  */
 static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)

diff ./mm/filemap.c~current~ ./mm/filemap.c
--- ./mm/filemap.c~current~	2006-05-22 11:20:26.000000000 +1000
+++ ./mm/filemap.c	2006-05-22 11:20:26.000000000 +1000
@@ -1804,7 +1804,7 @@ int remove_suid(struct dentry *dentry)
 EXPORT_SYMBOL(remove_suid);
 
 size_t
-__filemap_copy_from_user_iovec(char *vaddr, 
+__filemap_copy_from_user_iovec_inatomic(char *vaddr,
 			const struct iovec *iov, size_t base, size_t bytes)
 {
 	size_t copied = 0, left = 0;
@@ -1820,12 +1820,8 @@ __filemap_copy_from_user_iovec(char *vad
 		vaddr += copy;
 		iov++;
 
-		if (unlikely(left)) {
-			/* zero the rest of the target like __copy_from_user */
-			if (bytes)
-				memset(vaddr, 0, bytes);
+		if (unlikely(left))
 			break;
-		}
 	}
 	return copied - left;
 }

diff ./mm/filemap.h~current~ ./mm/filemap.h
--- ./mm/filemap.h~current~	2006-05-22 11:20:26.000000000 +1000
+++ ./mm/filemap.h	2006-05-22 11:20:26.000000000 +1000
@@ -16,15 +16,23 @@
 #include <linux/uaccess.h>
 
 size_t
-__filemap_copy_from_user_iovec(char *vaddr,
-			       const struct iovec *iov,
-			       size_t base,
-			       size_t bytes);
+__filemap_copy_from_user_iovec_inatomic(char *vaddr,
+					const struct iovec *iov,
+					size_t base,
+					size_t bytes);
 
 /*
  * Copy as much as we can into the page and return the number of bytes which
  * were sucessfully copied.  If a fault is encountered then clear the page
  * out to (offset+bytes) and return the number of bytes which were copied.
+ *
+ * NOTE: For this to work reliably we really want copy_from_user_inatomic_nocache
+ * to *NOT* zero any tail of the buffer that it failed to copy.  If it does,
+ * and if the following non-atomic copy succeeds, then there is a small window
+ * where the target page contains neither the data before the write, nor the
+ * data after the write (it contains zero).  A read at this time will see
+ * data that is inconsistent with any ordering of the read and the write.
+ * (This has been detected in practice).
  */
 static inline size_t
 filemap_copy_from_user(struct page *page, unsigned long offset,
@@ -60,13 +68,15 @@ filemap_copy_from_user_iovec(struct page
 	size_t copied;
 
 	kaddr = kmap_atomic(page, KM_USER0);
-	copied = __filemap_copy_from_user_iovec(kaddr + offset, iov,
-						base, bytes);
+	copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
+							 base, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
 	if (copied != bytes) {
 		kaddr = kmap(page);
-		copied = __filemap_copy_from_user_iovec(kaddr + offset, iov,
-							base, bytes);
+		copied = __filemap_copy_from_user_iovec_inatomic(kaddr + offset, iov,
+								 base, bytes);
+		if (bytes - copied)
+			memset(kaddr + offset + copied, 0, bytes - copied);
 		kunmap(page);
 	}
 	return copied;
