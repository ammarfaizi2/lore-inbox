Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWISXgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWISXgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 19:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWISXgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 19:36:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31222 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWISXgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 19:36:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
	b=QhZIIAzhVj7jnDdyhho/7s9QKHwRwdyHsFgYDB/tLuMpACd9gthT7G/35FbT0Q7Ke
	tSLgaf7IgB4NGYOKcY8qA==
Message-ID: <45107ECE.5040603@google.com>
Date: Tue, 19 Sep 2006 16:35:42 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
References: <1158274508.14473.88.camel@localhost.localdomain> <20060915001151.75f9a71b.akpm@osdl.org>
In-Reply-To: <20060915001151.75f9a71b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070508020608090602040904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070508020608090602040904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

As Andrew points out, the logic is a bit hacky and using a flag in 
current->flags to determine whether we have done the retry or not already.

I too think the right approach to being able to handle these kinds of 
retries in a more general fashion is to introduce a struct 
pagefault_args along the page faulting path.  Within it, we could 
introduce a reason for the retry so the higher levels would be able to 
better understand what to do.

struct pagefault_args {
   u32 reason;
};

#define PAGEFAULT_MAYRETRY_IO         0x1
#define PAGEFAULT_RETRY_IO            0x2
#define PAGEFAULT_RETRY_SIGNALPENDING 0x4

do_page_fault could for example set PAGEFAULT_MAYRETRY_IO, letting a 
nopage implementation drop locks for IO and signalling back up to 
do_page_fault by also setting PAGEFAULT_RETRY_IO.

PAGEFAULT_RETRY_SIGNALPENDING could be set to tell do_page_fault to 
deliver the signal and replay the faulting instruction (as opposed to 
the "goto retry" in the patch attached).

Mike Waychison

Andrew Morton wrote:
> On Fri, 15 Sep 2006 08:55:08 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> 
>>in mm.h:
>>
>> #define NOPAGE_SIGBUS   (NULL)
>> #define NOPAGE_OOM      ((struct page *) (-1))
>>+#define NOPAGE_RETRY	((struct page *) (-2))
>>
>>and in memory.c, in do_no_page():
>>
>>
>>        /* no page was available -- either SIGBUS or OOM */
>>        if (new_page == NOPAGE_SIGBUS)
>>                return VM_FAULT_SIGBUS;
>>        if (new_page == NOPAGE_OOM)
>>                return VM_FAULT_OOM;
>>+       if (new_page == NOPAGE_RETRY)
>>+               return VM_FAULT_MINOR;
> 
> 
> Google are using such a patch (Mike owns it).
> 
> It is to reduce mmap_sem contention with threaded apps.  If one thread
> takes a major pagefault, it will perform a synchronous disk read while
> holding down_read(mmap_sem).  This causes any other thread which wishes to
> perform any mmap/munmap/mprotect/etc (which does down_write(mmap_sem)) to
> block behind that disk IO.  As you can understand, that can be pretty bad
> in the right circumstances.
> 
> The patch modifies filemap_nopage() to look to see if it needs to block on
> the page coming uptodate and if so, it does up_read(mmap_sem);
> wait_on_page_locked(); return NOPAGE_RETRY.  That causes the top-level
> do_page_fault() code to rerun the entire pagefault.
> 
> It hasn't been submitted for upstream yet because
> 
> a) To avoid livelock possibilities (page reclaim, looping FADV_DONTNEED,
>    etc) it only does the retry a single time.  After that it falls back to
>    the traditional synchronous-read-inside-mmap_sem approach.  A flag in
>    current->flags is used to detect the second attempt.  It keeps the patch
>    simple, but is a bit hacky.
> 
>    To resolve this cleanly I'm thinking we change all the pagefault code
>    everywhere: instantiate a new `struct pagefault_args' in do_page_fault()
>    and pass that all around the place.  So all the pagefault code, all the
>    ->nopage handlers etc will take a single argument.
> 
>    This will, I hope, result in less code, faster code and less stack
>    consumption.  It could also be used for things like the
>    lock-the-page-in-filemap_nopage() proposal: the ->nopage()
>    implementation could set a boolean in pagefault_args indicating whether
>    the page has been locked.
> 
>    And, of course, fielmap_nopage could set another boolean in
>    pagefault_args to indicate that it has already tried to rerun the
>    pagefault once.
> 
> b) It could be more efficient.  Most of the time, there's no need to
>    back all the way out of the pagefault handler and rerun the whole thing.
>    Because most of the time, nobody changed anything in the mm_struct.  We
>    _could_ just retake the mmap_sem after the page comes uptodate and, if
>    nothing has changed, proceed.  I see two ways of doing this:
> 
>    - The simple way: look to see if any other processes are sharing
>      this mm_struct.  If not, just do the synchronous read inside mmap_sem.
> 
>    - The better way: put a sequence counter in the mm_struct,
>      increment that in every place where down_write(mmap_sem) is performed.
>       The pagefault code then can re-take the mmap_sem for reading and look
>      to see if the sequence counter is unchanged.  If it is, proceed.  If
>      it _has_ changed then drop mmap_sem again and return NOPAGE_RETRY.
> 
> otoh, maybe using another bit in page->flags is a good compromise ;)
> 
> Mike, could you whip that patch out please?


--------------070508020608090602040904
Content-Type: text/plain;
 name="mmap_sem_drop_for_faults-2.6.18-rc7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmap_sem_drop_for_faults-2.6.18-rc7.patch"

	Allow major faults to drop the mmap_sem read lock while waiting for IO to complete.  This is done by flagging in current->flags that the caller can tolerate a retry in the ->nopage path.
	
	Benchmarks indicate that this double data structure walking in the case of a major fault results in << 1% performance hit. (test was to balloon and drain the page cache, followed by 64 threads faulting in pages off disk in reverse order).
	
	Signed-off-by: Mike Waychison <mikew@google.com>

Differences ...

 arch/i386/mm/fault.c   |   30 ++++++++++++++++++++++++++----
 arch/x86_64/mm/fault.c |   30 ++++++++++++++++++++++++++----
 include/linux/mm.h     |    2 ++
 include/linux/sched.h  |    1 +
 mm/filemap.c           |   22 +++++++++++++++++++++-
 mm/memory.c            |    4 ++++
 6 files changed, 80 insertions(+), 9 deletions(-)

Index: linux-2.6.18-rc7/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.18-rc7.orig/arch/i386/mm/fault.c	2006-09-19 16:04:21.000000000 -0700
+++ linux-2.6.18-rc7/arch/i386/mm/fault.c	2006-09-19 16:08:15.000000000 -0700
@@ -325,8 +325,8 @@ static inline int vmalloc_fault(unsigned
  *	bit 3 == 1 means use of reserved bit detected
  *	bit 4 == 1 means fault was an instruction fetch
  */
-fastcall void __kprobes do_page_fault(struct pt_regs *regs,
-				      unsigned long error_code)
+static inline void __do_page_fault(struct pt_regs *regs,
+				   unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -407,7 +407,7 @@ fastcall void __kprobes do_page_fault(st
 			goto bad_area_nosemaphore;
 		down_read(&mm->mmap_sem);
 	}
-
+retry:
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -461,7 +461,15 @@ good_area:
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
 		case VM_FAULT_MINOR:
-			tsk->min_flt++;
+			/*
+			 * If we had to retry (PF_FAULT_MAYRETRY cleared), then
+			 * the page originally wasn't up to date before the
+			 * retry, but now it is.
+			 */
+			if (!(current->flags & PF_FAULT_MAYRETRY))
+				tsk->maj_flt++;
+			else
+				tsk->min_flt++;
 			break;
 		case VM_FAULT_MAJOR:
 			tsk->maj_flt++;
@@ -470,6 +478,12 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_RETRY:
+			if (current->flags & PF_FAULT_MAYRETRY) {
+				current->flags &= ~PF_FAULT_MAYRETRY;
+				goto retry;
+			}
+			BUG();
 		default:
 			BUG();
 	}
@@ -625,6 +639,14 @@ do_sigbus:
 	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
 }
 
+fastcall void __kprobes do_page_fault(struct pt_regs *regs,
+				      unsigned long error_code)
+{
+	current->flags |= PF_FAULT_MAYRETRY;
+	__do_page_fault(regs, error_code);
+	current->flags &= ~PF_FAULT_MAYRETRY;
+}
+
 #ifndef CONFIG_X86_PAE
 void vmalloc_sync_all(void)
 {
Index: linux-2.6.18-rc7/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.18-rc7.orig/arch/x86_64/mm/fault.c	2006-09-19 16:04:28.000000000 -0700
+++ linux-2.6.18-rc7/arch/x86_64/mm/fault.c	2006-09-19 16:09:02.000000000 -0700
@@ -336,8 +336,8 @@ int exception_trace = 1;
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
-asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
-					unsigned long error_code)
+static inline void __do_page_fault(struct pt_regs *regs,
+				   unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -435,7 +435,7 @@ asmlinkage void __kprobes do_page_fault(
 			goto bad_area_nosemaphore;
 		down_read(&mm->mmap_sem);
 	}
-
+retry:
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -481,13 +481,27 @@ good_area:
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
 	case VM_FAULT_MINOR:
-		tsk->min_flt++;
+		/*
+		 * If we had to retry (PF_FAULT_MAYRETRY cleared), then the
+		 * page originally wasn't up to date before the retry, but now
+		 * it is.
+		 */
+		if (!(current->flags & PF_FAULT_MAYRETRY))
+			tsk->maj_flt++;
+		else
+			tsk->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
 	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
+	case VM_FAULT_RETRY:
+		if (current->flags & PF_FAULT_MAYRETRY) {
+			current->flags &= ~PF_FAULT_MAYRETRY;
+			goto retry;
+		}
+		BUG();
 	default:
 		goto out_of_memory;
 	}
@@ -613,6 +627,14 @@ do_sigbus:
 	return;
 }
 
+asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
+					unsigned long error_code)
+{
+	current->flags |= PF_FAULT_MAYRETRY;
+	__do_page_fault(regs, error_code);
+	current->flags &= ~PF_FAULT_MAYRETRY;
+}
+
 DEFINE_SPINLOCK(pgd_lock);
 struct page *pgd_list;
 
Index: linux-2.6.18-rc7/include/linux/mm.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/mm.h	2006-09-19 16:04:53.000000000 -0700
+++ linux-2.6.18-rc7/include/linux/mm.h	2006-09-19 16:05:33.000000000 -0700
@@ -623,6 +623,7 @@ static inline int page_mapped(struct pag
  */
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
+#define NOPAGE_RETRY	((struct page *) (-2))
 
 /*
  * Different kinds of faults, as returned by handle_mm_fault().
@@ -633,6 +634,7 @@ static inline int page_mapped(struct pag
 #define VM_FAULT_SIGBUS	0x01
 #define VM_FAULT_MINOR	0x02
 #define VM_FAULT_MAJOR	0x03
+#define VM_FAULT_RETRY	0x04
 
 /* 
  * Special case for get_user_pages.
Index: linux-2.6.18-rc7/mm/filemap.c
===================================================================
--- linux-2.6.18-rc7.orig/mm/filemap.c	2006-09-19 16:04:55.000000000 -0700
+++ linux-2.6.18-rc7/mm/filemap.c	2006-09-19 16:05:33.000000000 -0700
@@ -1486,7 +1486,27 @@ page_not_uptodate:
 		majmin = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 	}
-	lock_page(page);
+
+	if (!(current->flags & PF_FAULT_MAYRETRY)) {
+		lock_page(page);
+	} else if (TestSetPageLocked(page)) {
+		struct mm_struct *mm = area->vm_mm;
+
+		/*
+		 * Page is already locked by someone else.
+		 *
+		 * We don't want to be holding down_read(mmap_sem)
+		 * inside lock_page(), so use wait_on_page_locked() here.
+		 */
+		up_read(&mm->mmap_sem);
+		wait_on_page_locked(page);
+		down_read(&mm->mmap_sem);
+		/*
+		 * The VMA tree may have changed at this point.
+		 */
+		page_cache_release(page);
+		return NOPAGE_RETRY;
+	}
 
 	/* Did it get unhashed while we waited for it? */
 	if (!page->mapping) {
Index: linux-2.6.18-rc7/mm/memory.c
===================================================================
--- linux-2.6.18-rc7.orig/mm/memory.c	2006-09-19 16:04:55.000000000 -0700
+++ linux-2.6.18-rc7/mm/memory.c	2006-09-19 16:05:33.000000000 -0700
@@ -2122,6 +2122,10 @@ retry:
 		return VM_FAULT_SIGBUS;
 	if (new_page == NOPAGE_OOM)
 		return VM_FAULT_OOM;
+	/* page may be available, but we have to restart the process because
+	 * mmap_sem was dropped during the ->nopage */
+	if (new_page == NOPAGE_RETRY)
+		return VM_FAULT_RETRY;
 
 	/*
 	 * Should we do an early C-O-W break?
Index: linux-2.6.18-rc7/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/sched.h	2006-09-19 16:04:54.000000000 -0700
+++ linux-2.6.18-rc7/include/linux/sched.h	2006-09-19 16:10:01.000000000 -0700
@@ -1054,6 +1054,7 @@ static inline void put_task_struct(struc
 #define PF_SWAPWRITE	0x00800000	/* Allowed to write to swap */
 #define PF_SPREAD_PAGE	0x01000000	/* Spread page cache over cpuset */
 #define PF_SPREAD_SLAB	0x02000000	/* Spread some slab caches over cpuset */
+#define PF_FAULT_MAYRETRY 0x04000000	/* I may drop mmap_sem during fault */
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
 #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
 

--------------070508020608090602040904--
