Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVI1Rbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVI1Rbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVI1Rbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:31:34 -0400
Received: from c-67-180-160-189.hsd1.ca.comcast.net ([67.180.160.189]:20929
	"EHLO mtv-vpn-hw-jlan-2.corp.sgi.com") by vger.kernel.org with ESMTP
	id S1751463AbVI1Rbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:31:33 -0400
Message-ID: <433AD359.8070509@engr.sgi.com>
Date: Wed, 28 Sep 2005 10:31:05 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com> <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com> <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com> <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus> <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
>On Tue, 27 Sep 2005, Jay Lan wrote:
>  
>>While in the work on separating hiwater_vm from hiwater_rss, i noticed
>>that __vm_stat_account() was not called in these functions where
>>total_vm was updated:
>>mm/mmap.c                           do_brk
>>mm/nommu.c                          do_mmap_pgoff
>>mm/nommu.c                          do_munmap
>>arch/ppc64/kernel/vdso.c            arch_setup_additional_pages
>>arch/x86_64/ia32/syscall32.c        syscall32_setup_pages
>>
>>Frank tried to touch the latter two in his proposed patch.
>>Does it make sense we add __vm_stat_account() calls to the above
>>routines?
>>    
>
>Probably not.  Partly because of the PROCFS issue you noticed after.
>And partly because that's a long list, whereas the evidence is that
>__vm_stat_account is nowadays being called in the places that need it.
>
>What, you couldn't find the call to __vm_stat_account next to
>updating total_vm in do_mmap_pgoff :-?  And I don't see that total_vm
>is updated in do_munmap, that and the vm_stat_account have to be done
>at a lower, per-vma level.  Haven't looked at the others yet.
>  

There are two do_mmap_pgoff, one in mm/mmap.c and the other in
mm/nommu.c. It was the mm/nommu.c version that does not  have
a call to __vm_stat_account.

I am not concerned about do_munmap any more from updating
hiwater_vm's concern since the total_vm gets decreased, not increased.

>I think, better leave hiwater_vm to me for now.  Since I've got that
>  
Sounds good to me.

I agreed with you (and Frank) that it makes sense to split hiwater_vm and
hiwater_rss update.
>patchset in the next -mm, it's maybe easier for me to put something
>together on top of that.  And it seems quite possible (haven't checked
>yet) that actually we should be moving the update of total_vm in to the
>core from out all over, rather than splattering hiwater_vm updates about
>  
>I'll take a look in the next couple of days.
>
>Hugh
>  

In case you are going to turn hiwater_vm update into a macro and hide it
in a config flag, here is what i have that might be useful.

Thanks,
 - jay


Index: linux/init/Kconfig
===================================================================
--- linux.orig/init/Kconfig     2005-09-22 14:14:54.105262867 -0700
+++ linux/init/Kconfig  2005-09-22 14:57:19.326784560 -0700
@@ -162,6 +162,19 @@ config BSD_PROCESS_ACCT_V3
          for processing it. A preliminary version of these tools is
available
          at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
+config ENHANCED_SYS_ACCT
+       bool "Enhanced System Accounting support"
+       depends on BSD_PROCESS_ACCT
+       default n
+       help
+         If you say Y here, some extra system accounting data will be
+         collected and updated to task struct as well as task->mm struct.
+         These information are used and presented in enhanced system
+         accounting packages such as Comprehensive System Accounting (CSA).
+         This activity may force cachelines into shared from exclusive
+         on a processor. The CSA project can be viewed at
+         <http://oss.sgi.com/projects/csa/>.
+
 config SYSCTL
        bool "Sysctl support"
        ---help---
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c      2005-09-22 14:15:07.465757425 -0700
+++ linux/mm/memory.c   2005-09-27 16:55:28.438702812 -0700
@@ -2206,21 +2206,21 @@ unsigned long vmalloc_to_pfn(void * vmal
 
 EXPORT_SYMBOL(vmalloc_to_pfn);
 
+#ifdef CONFIG_ENHANCED_SYS_ACCT
 /*
- * update_mem_hiwater
- *     - update per process rss and vm high water data
+ * update_rss_hiwater
+ *     - update per process rss high water data
  */
-void update_mem_hiwater(struct task_struct *tsk)
+void update_rss_hiwater(struct mm_struct *mm)
 {
-       if (tsk->mm) {
-               unsigned long rss = get_mm_counter(tsk->mm, rss);
+       if (likely(mm)) {
+               unsigned long rss = get_mm_counter(mm, rss);
 
-               if (tsk->mm->hiwater_rss < rss)
-                       tsk->mm->hiwater_rss = rss;
-               if (tsk->mm->hiwater_vm < tsk->mm->total_vm)
-                       tsk->mm->hiwater_vm = tsk->mm->total_vm;
+               if (mm->hiwater_rss < rss)
+                       mm->hiwater_rss = rss;
        }
 }
+#endif
 
 #if !defined(__HAVE_ARCH_GATE_AREA)
 
Index: linux/include/linux/mm.h
===================================================================
--- linux.orig/include/linux/mm.h       2005-08-28 16:41:01.000000000 -0700
+++ linux/include/linux/mm.h    2005-09-27 17:33:49.372846334 -0700
@@ -949,7 +949,18 @@ static inline void vm_stat_unaccount(str
 }
 
 /* update per process rss and vm hiwater data */
-extern void update_mem_hiwater(struct task_struct *tsk);
+#ifdef CONFIG_ENHANCED_SYS_ACCT
+static inline void update_hiwater_vm(struct mm_struct *mm)
+{
+       if (mm->hiwater_vm < mm->total_vm)
+               mm->hiwater_vm = mm->total_vm;
+}
+
+extern void update_hiwater_rss(struct mm_struct *mm);
+#else
+#define update_hiwater_vm(x)           do { } while (0)
+#define update_hiwater_rss(x)          do { } while (0)
+#endif
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void

