Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTEGFbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTEGFbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:31:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6384 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262903AbTEGFba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:31:30 -0400
Date: Wed, 7 May 2003 11:21:03 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030507055103.GA31797@in.ibm.com>
References: <20030505081300.6B2ED2C016@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505081300.6B2ED2C016@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:17:07AM +0000, Rusty Russell wrote:
> Hi Andrew,
> 
> 	This is the kmalloc_percpu patch.  I have another patch which
> tests the allocator if you want to see that to.  This is the precursor
> to per-cpu stuff in modules, but also allows other space gains for
> structures which currently embed per-cpu arrays (eg. your fuzzy counters).
>

I tried to run a test to compare this implementation, but got an oops.
Here is the oops and the patch I was trying...  

btw, why the change from kmalloc_percpu(size) to kmalloc_percpu(type)?
You do kmalloc(sizeof (long)) for the usual kmalloc, but 
kmalloc_percpu(long) for percpu data...looks strange no?

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.69/mm/swap.c rusty-1-2.5.69/mm/swap.c
--- linux-2.5.69/mm/swap.c	Mon May  5 05:23:13 2003
+++ rusty-1-2.5.69/mm/swap.c	Wed May  7 10:01:00 2003
@@ -356,14 +356,14 @@
  */
 #define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
 
-static DEFINE_PER_CPU(long, committed_space) = 0;
+static long *committed_space;
 
 void vm_acct_memory(long pages)
 {
 	long *local;
 
 	preempt_disable();
-	local = &__get_cpu_var(committed_space);
+	local = per_cpu_ptr(committed_space, smp_processor_id());
 	*local += pages;
 	if (*local > ACCT_THRESHOLD || *local < -ACCT_THRESHOLD) {
 		atomic_add(*local, &vm_committed_space);
@@ -371,6 +371,12 @@
 	}
 	preempt_enable();
 }
+
+static int init_committed_space(void)
+{
+	committed_space = kmalloc_percpu(long);
+	return committed_space;
+}
 #endif
 
 
@@ -390,4 +396,6 @@
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+	if (!init_committed_space)
+		panic("swap_setup\n");
 }



Unable to handle kernel paging request at virtual address 0115d040
 printing eip:
c01392ae
*pde = 1fccf001
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01392ae>]    Not tainted
EFLAGS: 00010202
EIP is at vm_acct_memory+0x1e/0x60
eax: 00000000   ebx: dfcca4e0   ecx: 0115d040   edx: 00000001
esi: 00000001   edi: dff7e000   ebp: dff7fe3c   esp: dff7fc7c
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=dff7e000 task=dff7c040)
Stack: c013fa8f 00000001 dffe4120 00000000 dfcd8720 dff7fe3c dfcca4e0 dfcd3dc0
       c0155966 00000001 dff7e000 bffe0000 dff7e000 dff7fe3c c02ba305 00000000
       c0171013 dff7fe3c 00000000 00000000 00000000 ffffffff 00000003 00000000
Call Trace:
 [<c013fa8f>] vm_enough_memory+0xf/0xc0
 [<c0155966>] setup_arg_pages+0x96/0x190
 [<c0171013>] load_elf_binary+0x4c3/0x9f0
 [<c01376ea>] cache_grow+0x1fa/0x2d0
 [<c0134ab9>] __alloc_pages+0x89/0x2f0
 [<c01556c8>] copy_strings+0x238/0x250
 [<c0170b50>] load_elf_binary+0x0/0x9f0
 [<c0156975>] search_binary_handler+0xa5/0x1f0
 [<c0155707>] copy_strings_kernel+0x27/0x30
 [<c0156c3f>] do_execve+0x17f/0x200
 [<c015821e>] getname+0x5e/0xa0
 [<c01078f0>] sys_execve+0x30/0x70
 [<c0109087>] syscall_call+0x7/0xb
 [<c01051b1>] init+0x151/0x1d0
 [<c0105060>] init+0x0/0x1d0
 [<c01070f5>] kernel_thread_helper+0x5/0x10

Code: 8b 01 01 c2 89 11 83 fa 40 7f 09 89 d0 83 f8 c0 7d 11 eb 02
 <0>Kernel panic: Attempted to kill init!

