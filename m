Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWEVSBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWEVSBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWEVSBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:01:06 -0400
Received: from amdext4.amd.com ([163.181.251.6]:18828 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751105AbWEVSBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:01:04 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
Date: Mon, 22 May 2006 13:00:30 -0500
User-Agent: KMail/1.8
cc: "Hugh Dickins" <hugh@veritas.com>,
       "Linux Memory Management" <linux-mm@kvack.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
 <200605081432.40287.raybry@mpdtxmail.amd.com>
 <2F9DB20EAB953ECFD816E9BF@[10.1.1.4]>
In-Reply-To: <2F9DB20EAB953ECFD816E9BF@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200605221300.30998.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 22 May 2006 18:01:54.0675 (UTC)
 FILETIME=[CF515430:01C67DC9]
X-WSS-ID: 686F231227K1233818-01-01
Content-Type: multipart/mixed;
 boundary="Boundary-00=_+wfcEpvu7wB+2Ow"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+wfcEpvu7wB+2Ow
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 16 May 2006 16:09, Dave McCracken wrote:
> --On Monday, May 08, 2006 14:32:39 -0500 Ray Bryant
>
> <raybry@mpdtxmail.amd.com> wrote:
> > On Saturday 06 May 2006 10:25, Hugh Dickins wrote:
> > <snip>
> >
> >> How was Ray Bryant's shared,anonymous,fork,munmap,private bug of
> >> 25 Jan resolved?  We didn't hear the end of that.
> >
> > I never heard anything back from Dave, either.
>
> My apologies.  As I recall your problem looked to be a race in an area
> where I was redoing the concurrency control.  I intended to ask you to
> retest when my new version came out.  Unfortunately the new version took
> awhile, and by the time I sent it out I forgot to ask you about it.
>
> I believe your problem should be fixed in recent versions.  If not, I'll
> make another pass at it.
>
> Dave McCracken
>

Dave,

I'm sending you a test case and a small kernel patch (see attachments).   The 
patch applies to 2.6.17-rc1, on top of your patches from 4/10/2006 (I'm 
assuming these the most recent ones.).   

What the patch does is to add a system call that will return the pfn and ptep 
for a given virtual address.   What the test program does (I think :-) ) is 
to create a mmap'd shared region, then fork off a child.   The child then 
re-mmaps() private a portion of the region.  Call it without arguments for 
now, that should map 512 pte's and share them between the parent and 1 child.
[Later on we can try more pages and more children.  (e. g. 
./shpt_test1 128 64).]

At this point, what I expect to have happened is that in at the  shared region 
address in the child, there will be a number of pages that are still shared 
with the parent, hence have the same pfn and ptep as they used to, followed 
by a set of pages in the re-mmapped() region where the pfn's and ptep's are 
different, because that set of pages is no longer shared.

What I find is that the re-mapped() region, the pfn's are different, but the 
ptep's have not changed.   Hence, we've modified the parent address space
rather than getting our own copy of that part of the address space.

Now I'm not positive as to what the semantics SHOULD be here, so that may be 
the error involved, but it seems to me that if I mmap() the region private in 
the child, I should get a nice new private copy, and the pte's should no 
longer be shared with the parent.   Is that the way you guys understand the
semantics of this? 

Anyway take a look at my test case and see if it makes any sense to you.
If it turns out my test case is in error, the mea culpa, and I'll fix the 
problems and try again.

Best Regards,

Ray
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

--Boundary-00=_+wfcEpvu7wB+2Ow
Content-Type: text/x-diff;
 charset=iso-8859-1;
 name=add-sys_get_vminfo.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=add-sys_get_vminfo.patch

Index: linux-2.6.17-rc1-ptsh/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-ptsh.orig/mm/memory.c
+++ linux-2.6.17-rc1-ptsh/mm/memory.c
@@ -2463,3 +2463,80 @@ int in_gate_area_no_task(unsigned long a
 }
 
 #endif	/* __HAVE_ARCH_GATE_AREA */
+
+#define VMINFO_RESULTS 3
+asmlinkage long
+sys_get_vminfo(pid_t pid, unsigned long addr,  long *user_addr)
+{
+	int ret;
+	struct page *p;
+	struct task_struct *task = NULL;
+	struct mm_struct *mm = NULL;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep = NULL;
+	unsigned long results[VMINFO_RESULTS];
+
+	if (pid >= 0) {
+		read_lock(&tasklist_lock);
+		task = find_task_by_pid(pid);
+		if (task) {
+			task_lock(task);
+			mm = task->mm;
+			if (mm)
+				atomic_inc(&mm->mm_users);
+		} else {
+			read_unlock(&tasklist_lock);
+			return -ESRCH;
+		}
+		read_unlock(&tasklist_lock);
+	} else
+		return -1;
+
+	ret = get_user_pages(task, mm, addr, 1, 0, 0, &p, NULL);
+	results[0] = 0;
+	results[1] = -1;
+	if (ret >= 0) {
+		results[0] = page_to_pfn(p);
+		results[1] = page_to_nid(p);
+		put_page(p);
+	} else
+		ret = EINVAL;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		goto no_page_table;
+
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+		goto no_page_table;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		goto no_page_table;
+
+	ptep = pte_offset_map(pmd, addr);
+	pte_unmap(ptep);
+
+	if (mm)
+		mmput(mm);
+
+	task_unlock(task);
+
+copy_vminfo_to_user:
+	results[2] = (unsigned long) ptep;
+
+	if (copy_to_user(user_addr, results, VMINFO_RESULTS*sizeof(long)))
+		ret = -EFAULT;
+
+	return ret;
+
+no_page_table:
+	ptep = NULL;
+
+	ret = ENOMEM;
+
+	goto copy_vminfo_to_user;
+
+}
Index: linux-2.6.17-rc1-ptsh/include/asm-x86_64/unistd.h
===================================================================
--- linux-2.6.17-rc1-ptsh.orig/include/asm-x86_64/unistd.h
+++ linux-2.6.17-rc1-ptsh/include/asm-x86_64/unistd.h
@@ -611,8 +611,10 @@ __SYSCALL(__NR_set_robust_list, sys_set_
 __SYSCALL(__NR_get_robust_list, sys_get_robust_list)
 #define __NR_splice		275
 __SYSCALL(__NR_splice, sys_splice)
-
-#define __NR_syscall_max __NR_splice
+#define __NR_get_vminfo		276
+__SYSCALL(__NR_get_vminfo, sys_get_vminfo)
+ 
+#define __NR_syscall_max __NR_get_vminfo
 
 #ifndef __NO_STUBS
 

--Boundary-00=_+wfcEpvu7wB+2Ow
Content-Type: text/x-csrc;
 charset=iso-8859-1;
 name=shpt_test1.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=shpt_test1.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <asm/atomic.h>

#define PAGE_SIZE 4096
#define INITIAL_HOLE 50
#define ADDR  (0x00002aaaaaf00000UL)
#define ADDR1 (ADDR + INITIAL_HOLE*PAGE_SIZE)
#define MAX_NCHILD 128
#define PAGES_PER_PTE_PAGE 512

#define PAGE_SIZE_IN_KB (PAGE_SIZE/1024)

/*
 *  Now test what happens if we create a shared region under the shpt
 *  kernel and then the children remap part of the shared region.  We
 *  use a hacked kernel with an additional system call (get_viminfo())
 *  [see below for details] to make sure that each child gets its own
 *  pfn in this case and that the shared paget table entries are no
 *  longer shared.   This test was suggested by Christoph Lamater @ SGI.
 */

static inline long timeval_diff_in_ms(struct timeval *a, struct timeval *b) {
   if (a->tv_usec > b->tv_usec) {
   	// borrow
	a->tv_sec--;
	a->tv_usec += 1000000;
   }
   return(1000 * (b->tv_sec - a->tv_sec) + (b->tv_usec - a->tv_usec)/1000);
}

long get_pte_kb()
{
	FILE *f;
	int err;
	long parameter;
	char str[128];

	f = fopen("/proc/meminfo", "r");
        if (!f) {
		printf("fopen() error in %s\n", __FUNCTION__);
		perror("fopen");
		exit(-1);
	 }

	while (1) {
		parameter = -1;
                err = fscanf(f, "%s %ld", str, &parameter);
                if (err == EOF  || !strcmp(str, "PageTables:"))
                        break;
        }

	return parameter;
}

/* 
 * hacked in system call to return the following info for a virtual address:
 * results[0] = pfn of virtual address "addr"
 * results[1] = nodeid where pfn lives (for NUMA boxen)
 * results[2] = address of the pte
 *
 * Note well, this assumes the page has already been faulted in
 * If this hasn't happended, the system call results are undefined.
 */
#define __NR_get_vminfo 276
static inline long get_vminfo(pid_t pid, void *addr, long *results)
{
	return (syscall(__NR_get_vminfo,pid,addr,results));
}

main(int argc, char **argv)
{
	char *pages, *pages1;
	int count;
	int errors, pc, nchild, child;
	long shared_region_size, i, remapped_region_size;
	long starting_pte_kb, ending_pte_kb;
	pid_t pid[MAX_NCHILD];
	void *addr = (void *) ADDR;
	void *addr1= (void *) ADDR1;
	atomic_t *atom = (atomic_t *) (addr + 8);
	volatile long *flag = (long *) (addr + 16);
	struct timeval start, forkend, end;
	long results[3];
	long *page_pfn, *page_ptep;
	int pfn_should_match_dont=0, ptep_should_match_dont=0;
	int pfn_shouldnt_match_do=0, ptep_shouldnt_match_do=0;

	setbuf(stdout, NULL);
	printf("Main starts......\n");

	printf("argc=%d\n", argc);
	/* first arg is the number of pte pages to use */
	if (argc == 1)
		pc = 1;
	else
		sscanf(argv[1], "%d", &pc);

	/* second arg is the number of threads to create */
	if (argc < 3)
		nchild = 1;
	else
		sscanf(argv[2], "%d", &nchild);

	/* find out how many pages of pte's we've already used */
	/* (we'll subtract this off of the number we get after */
	/*  the children are all forked, below.) ............. */
	starting_pte_kb = get_pte_kb();

	pc = PAGES_PER_PTE_PAGE * pc;
	if (nchild > MAX_NCHILD)
		nchild = MAX_NCHILD;
	printf("Number of pages to map: %d nchild: %d\n", pc, nchild);

	shared_region_size = (long)pc * (long)PAGE_SIZE;

	printf("Shared region size: %5.2f GB\n", shared_region_size/(1024.0*1024.0*1024.0));

	pages = (char *)mmap(addr, shared_region_size,
		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, 0, 0);

	if (pages ==  MAP_FAILED) {
		printf("mmap() failed.\n");
		perror("mmap");
		exit(999);
	}

	printf("mapped region starts at: %p\n", pages);

	/* initialize the communication flags in the shared region */
	atomic_set(atom, 0);
	*flag = 0;

	printf("writing data..........\n");
	errors = 0;
	/* initialize the first byte of page N to N */
	for(i=0; i<shared_region_size; i+=PAGE_SIZE) {
		pages[i] = (char) (i/PAGE_SIZE);
	}
	/* paranoia check. ........................ */
	for(i=0; i<shared_region_size; i+=PAGE_SIZE) {
		if(pages[i] != (char) (i/PAGE_SIZE))
			errors++;
	}
	printf("done writing data...... errors=%d\n", errors);

	printf("Forking.....\n");
	gettimeofday(&start, NULL);
	for(child=0;child<nchild;child++) {
		if (pid[child]=fork()) {
			if ((nchild < 16) || ((child % 16) == 0))
				printf("parent (pid:%d) created child #%3d: pid:%d\n", getpid(), child, pid[child]);
		} else {
			char tmp, rc;
			int tests = 0;
			errors = 0;
			/* check to make sure child sees same data as above */
			/* also record pfn and pte addresses for later comparison */
			page_pfn = (long *) malloc(pc*sizeof(long));
			page_ptep= (long *) malloc(pc*sizeof(long));
			if (!page_pfn || !page_ptep) {
				printf("Ack, PID: %d couldn't allocate both page_pfn (%p) and page_pte (%p)\n",
					getpid(), page_pfn, page_ptep);
				perror("mmap");
				atomic_add(1, atom);
				exit(-1);
			} else
				printf("PID: %d page_pfn:%p page_pte:%p\n",
					getpid(), page_pfn, page_ptep);
			for(i=0; i<shared_region_size; i+=PAGE_SIZE) {
				if(pages[i] != (char) (i/PAGE_SIZE))
					errors++;
				rc = get_vminfo(getpid(), &pages[i], results);
				if (rc >= 0) {
					page_pfn[i/PAGE_SIZE] = results[0];
					page_ptep[i/PAGE_SIZE] = results[2];
				}
				else
					printf("PID:%d i=%d vmaddr:%p returned %d\n",
						getpid(), i, &pages[i], rc);
			}
			if (errors > 0)
				printf("child(%d) sees errors=%d\n", getpid(), errors);

			/* now (re-)mmap a portion of the shared region */
			/* yeah, this is a little bit arbitrary :-) */
			remapped_region_size = PAGE_SIZE*pc/8;
			printf("remapped_region_size: %ld\n", remapped_region_size);
			pages1 = (char *)mmap(addr1, remapped_region_size,
				 PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_FIXED | MAP_PRIVATE, 0, 0);
                        if (pages1 == MAP_FAILED) {
				printf("mmap() failed in child process %d\n",getpid());
				perror("mmap");
				atomic_add(1, atom);
				exit(-1);
			}

			/* fault the pages in and put some different data in the pages */
			tmp = (char) (getpid() & 0xFF);
			for(i=0; i<remapped_region_size; i+=PAGE_SIZE) {
				pages1[i] = tmp;
			}

			errors = 0;
			tests  = 0;

			/*
			 * now print out the pfn and pte addresses for the entire shared region
			 * (up to the end of the re-mapped region, above).
			 * we expect some of the addresses to still use shared ptes, but above
			 * the initial hole, we should see distinct ptes.  Another plausible
			 * implementation would be to unshared the entire region; that would be
			 * legal as well.
			 */
			for(i=0; i<INITIAL_HOLE*PAGE_SIZE+remapped_region_size; i+=PAGE_SIZE) {
			        if (((void *)&pages[i]) < addr1) {
					/* we expect shared pte's in this region */
					if (pages[i] != tmp)
						errors++;
					tests++;
					rc = get_vminfo(getpid(), &pages[i], results);
					if (rc >= 0) {
						if (results[0] != page_pfn[i/PAGE_SIZE])
							pfn_should_match_dont++;
						if (results[2] != page_ptep[i/PAGE_SIZE])
							ptep_should_match_dont++;
						printf("Expect shared: PID:%d i=%d vmaddr:%p pfn:0x%lx was 0x%lx pte:0x%lx was 0x%lx\n",
							getpid(), i, &pages[i], page_pfn[i/PAGE_SIZE], results[0], page_ptep[i/PAGE_SIZE], results[2]);
					} else
						printf("Expect shared: PID:%d i=%d vmaddr:%p returned %d\n",
							getpid(), i, &pages[i], rc);
				} else {
					/* we expect unshared pte's in this region */
					if (pages[i] != tmp)
						errors++;
					tests++;
					rc = get_vminfo(getpid(), &pages[i], results);
					if (rc >= 0) {
						if (results[0] == page_pfn[i/PAGE_SIZE])
							pfn_shouldnt_match_do++;
						if (results[2] == page_ptep[i/PAGE_SIZE])
							ptep_shouldnt_match_do++;
						printf("Expect unshared: PID:%d i=%d vmaddr:%p pfn:0x%lx was 0x%lx pte:0x%lx was 0x%lx\n",
							getpid(), i, &pages[i], page_pfn[i/PAGE_SIZE], results[0], page_ptep[i/PAGE_SIZE], results[2]);
					} else
						printf("Expect unshared: PID:%d i=%d vmaddr:%p returned %d\n",
							getpid(), i, &pages[i], rc);
				}
			}
			/* print the number of errors found for the region we have examined */
			if (errors > 0)
				printf("child(%d) sees errors=%d in region, tests:%d\n", getpid(), errors, tests);

			if (pfn_should_match_dont || ptep_should_match_dont || pfn_shouldnt_match_do || ptep_shouldnt_match_do) {
				int tmp = pfn_should_match_dont + ptep_should_match_dont + pfn_shouldnt_match_do + ptep_shouldnt_match_do;
				printf("child(%d) sees match/mismatch errors %d in region, tests:%d\n", getpid(), tmp, tests);
				printf("child(%d) pfn_should_match_dont:  %d\n", getpid(), pfn_should_match_dont);
				printf("child(%d) ptep_should_match_dont: %d\n", getpid(), ptep_should_match_dont);
				printf("child(%d) pfn_shouldnt_match_do:  %d\n", getpid(), pfn_shouldnt_match_do);
				printf("child(%d) ptep_shouldnt_match_do: %d\n", getpid(), ptep_shouldnt_match_do);
			}


			/* indicate that this child is done */
			atomic_add(1, atom);
			while (!(*flag))
				sleep(1);

			exit(errors);
		}
	}

	gettimeofday(&forkend, 0);

	/* wait for all of the children to get started and check their data */
	printf("Parent is waiting....\n");
        while(atomic_read(atom) < nchild)
		usleep(1000L);
	gettimeofday(&end, NULL);

	printf("All children are now sleeping....elapsed ms: %ld fork ms: %ld\n", 
		timeval_diff_in_ms(&start, &end), timeval_diff_in_ms(&start, &forkend));

	/* now let us check to see how many pages of pte's have been used */
	ending_pte_kb = get_pte_kb();

	/* We can use this number to see if the shared region is still using 
	 * any shared pte's after the mmap() by the child, although it really
	 * doesn't matter (e. g. it would be allowed to revert the whole shared
	 * region to non-shared ptes. ....................................... */
	printf("pte pages used: \t%8ld\n",    (ending_pte_kb-starting_pte_kb)/PAGE_SIZE_IN_KB);
	printf("KB of pte pages used: \t%8ld\n", ending_pte_kb-starting_pte_kb);

	*flag = 1;
	
	for(i=0;i<nchild;i++) {
		int status;
		waitpid(pid[i], &status, 0);
		if (status != 0)
			printf("pid %d exited with non-zero status: %d\n", pid[i], status);
	}

	munmap(pages, shared_region_size);

	printf("Main exits......\n");
}


--Boundary-00=_+wfcEpvu7wB+2Ow--

