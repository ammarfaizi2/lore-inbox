Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSHKAUo>; Sat, 10 Aug 2002 20:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSHKAUo>; Sat, 10 Aug 2002 20:20:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48658 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317387AbSHKAUm>;
	Sat, 10 Aug 2002 20:20:42 -0400
Message-ID: <3D55B109.CA52DB9C@zip.com.au>
Date: Sat, 10 Aug 2002 17:34:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D5464E3.74ED07CC@zip.com.au> <Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
>  - do_page_fault() already does an
> 
>         if (in_interrupt() || !mm)
>                 goto no_context;
> 
>    and the fact is, the "in_interrupt()" should really be an
>    "preempt_count()", since it's illegal to take a page fault not just in
>    interrupts, but while non-preemptible in general.
> 

gargh.  preempt_disable (and, hence, kmap_atomic) do not bump
the preempt counter with CONFIG_PREEMPT=n.

Is there a plan to change this?

If not, I don't think it's worth making this change just for
the highmem read/write thing (calculating `current' at each
spin_lock site...)   I just open coded it.

This works.  I still need to do the other architectures' fault
handlers, do writes and test it for more than seven seconds.

 arch/i386/mm/fault.c    |    6 +++---
 include/linux/preempt.h |   14 ++++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

--- 2.5.30/arch/i386/mm/fault.c~atomic-copy_user	Sat Aug 10 14:44:03 2002
+++ 2.5.30-akpm/arch/i386/mm/fault.c	Sat Aug 10 14:44:52 2002
@@ -189,10 +189,10 @@ asmlinkage void do_page_fault(struct pt_
 	info.si_code = SEGV_MAPERR;
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an interrupt, have no user context or are running in an
+	 * atomic region then we must not take the fault..
 	 */
-	if (in_interrupt() || !mm)
+	if (preempt_count() || !mm)
 		goto no_context;
 
 #ifdef CONFIG_X86_REMOTE_DEBUG
--- 2.5.30/include/linux/preempt.h~atomic-copy_user	Sat Aug 10 16:18:50 2002
+++ 2.5.30-akpm/include/linux/preempt.h	Sat Aug 10 16:20:16 2002
@@ -5,19 +5,29 @@
 
 #define preempt_count() (current_thread_info()->preempt_count)
 
+#define inc_preempt_count() \
+do { \
+	preempt_count()++; \
+} while (0)
+
+#define dec_preempt_count() \
+do { \
+	preempt_count()--; \
+} while (0)
+
 #ifdef CONFIG_PREEMPT
 
 extern void preempt_schedule(void);
 
 #define preempt_disable() \
 do { \
-	preempt_count()++; \
+	inc_preempt_count(); \
 	barrier(); \
 } while (0)
 
 #define preempt_enable_no_resched() \
 do { \
-	preempt_count()--; \
+	dec_preempt_count(); \
 	barrier(); \
 } while (0)
 






 filemap.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 49 insertions(+), 2 deletions(-)

--- 2.5.30/mm/filemap.c~kmap_atomic_reads	Sat Aug 10 17:09:47 2002
+++ 2.5.30-akpm/mm/filemap.c	Sat Aug 10 17:27:35 2002
@@ -1020,7 +1020,37 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
-int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+/*
+ * Fault a userspace page into pagetables.  Return non-zero on EFAULT.
+ * FIXME: this assumes that two userspace pages are always sufficient.  That's
+ * not true if PAGE_CACHE_SIZE > PAGE_SIZE.
+ */
+static inline int fault_in_page_writeable(char *uaddr, int size)
+{
+	int ret;
+
+	/*
+	 * Writing zeroes into userspace here is OK, because we know that if
+	 * the zero gets there, we'll be overwriting it.
+	 */
+	ret = __put_user(0, uaddr);
+	if (ret == 0) {
+		char *end = uaddr + size - 1;
+
+		/*
+		 * If the page was already mapped, this will get a cache miss
+		 * for sure, so try to avoid doing it.  This is only useful if
+		 * userspace is doing page-aligned IO, which is rare.  Lose it?
+		 */
+		if (((unsigned long)uaddr & PAGE_MASK) !=
+				((unsigned long)end & PAGE_MASK))
+		 	ret = __put_user(0, end);
+	}
+	return ret;
+}
+
+int file_read_actor(read_descriptor_t *desc, struct page *page,
+			unsigned long offset, unsigned long size)
 {
 	char *kaddr;
 	unsigned long left, count = desc->count;
@@ -1028,14 +1058,31 @@ int file_read_actor(read_descriptor_t * 
 	if (size > count)
 		size = count;
 
+	/*
+	 * Faults on the destination of a read are common, so do it before
+	 * taking the kmap.
+	 */
+	if (!fault_in_page_writeable(desc->buf, size)) {
+		kaddr = kmap_atomic(page, KM_USER0);
+		inc_preempt_count();	/* An atomic copy_to_user */
+		left = __copy_to_user(desc->buf, kaddr + offset, size);
+		dec_preempt_count();
+		kunmap_atomic(kaddr, KM_USER0);
+		if (left == 0)
+			goto success;
+		printk("%s: Unexpected page fault\n", __FUNCTION__);
+	}
+
+	/* Do it the slow way */
 	kaddr = kmap(page);
 	left = __copy_to_user(desc->buf, kaddr + offset, size);
 	kunmap(page);
-	
+
 	if (left) {
 		size -= left;
 		desc->error = -EFAULT;
 	}
+success:
 	desc->count = count - size;
 	desc->written += size;
 	desc->buf += size;

.
