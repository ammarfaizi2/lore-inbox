Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTARKeh>; Sat, 18 Jan 2003 05:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTARKeh>; Sat, 18 Jan 2003 05:34:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:64651 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264628AbTARKef>;
	Sat, 18 Jan 2003 05:34:35 -0500
Date: Sat, 18 Jan 2003 02:44:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: recent change to exit_mmap
Message-Id: <20030118024456.11a9c7ff.akpm@digeo.com>
In-Reply-To: <20030118072331.GF7800@krispykreme>
References: <20030118060522.GE7800@krispykreme>
	<20030117230014.2647791a.akpm@digeo.com>
	<20030118072331.GF7800@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 10:43:29.0606 (UTC) FILETIME=[704F5660:01C2BEDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > On seconds thoughts...
> > 
> > Are the first two SET_PERSONALITY() calls in there actually doing anything? 
> > Perhaps you're right, and we only need the one at line 615, whcih is in the
> > right place?
> 
> Sounds good. The following patch tests out OK.
> 
> Anton
> 
> ===== fs/binfmt_elf.c 1.34 vs edited =====
> --- 1.34/fs/binfmt_elf.c	Mon Nov 25 19:59:02 2002
> +++ edited/fs/binfmt_elf.c	Sat Jan 18 18:16:52 2003
> @@ -536,8 +536,6 @@
>  			    strcmp(elf_interpreter,"/usr/lib/ld.so.1") == 0)
>  				ibcs2_interpreter = 1;
>  
> -			SET_PERSONALITY(elf_ex, ibcs2_interpreter);
> -
>  			interpreter = open_exec(elf_interpreter);
>  			retval = PTR_ERR(interpreter);
>  			if (IS_ERR(interpreter))
> @@ -578,9 +576,6 @@
>  			// printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");
>  			interpreter_type = INTERPRETER_ELF;
>  		}
> -	} else {
> -		/* Executables without an interpreter also need a personality  */
> -		SET_PERSONALITY(elf_ex, ibcs2_interpreter);
>  	}

Unfortunately it isn't right.  See, we set the peronality prior to looking up
the elf interpreter because different types of executables can have different
filesystem namespaces.  open_exec() needs it.  The IBCS stuff needs this, as
well as (thanks davem):

 "When we have a personality like "SunOS" or whatever, we allow the usage
  of an alternate '/' for file lookups, it trumps whatever would be found in
  the normal /, so we could put the SunOS ld.so under /emul/SunOS/lib for
  example using an emulation alternative-root of /emul/SunOS"

And we can't dump the currect exec image until we've determined that the
interpreter is available.

So it's all a bit of a stew.  We're back to the original patch.  Could you
please test it?  (This includes the ia64 bit)


diff -puN mm/mmap.c~exit_mmap-fix mm/mmap.c
--- 25/mm/mmap.c~exit_mmap-fix	2003-01-17 22:35:13.000000000 -0800
+++ 25-akpm/mm/mmap.c	2003-01-17 22:41:10.000000000 -0800
@@ -1379,6 +1379,22 @@ void build_mmap_rb(struct mm_struct * mm
 	}
 }
 
+/*
+ * During exit_mmap, TASK_SIZE is not a reliable indication of the virtual
+ * size of the mm which is being torn down.  Because on the exec() path, this
+ * process may have switched its personality from 64-bit to 32-bit prior to
+ * calling exit_mmap().  So TASK_SIZE returns a value suitable for a 32-bit
+ * process, and not the 64-bit process whose mm we need to empty.
+ *
+ * So what we do is to always unmap the largest virtual address space which
+ * the architecture supports.  unmap_vmas() will then unmap every VMA in the
+ * mm, which is what we want to happen here.
+ */
+
+#ifndef TASK_SIZE_MAX
+#define TASK_SIZE_MAX TASK_SIZE
+#endif
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -1395,7 +1411,7 @@ void exit_mmap(struct mm_struct *mm)
 	tlb = tlb_gather_mmu(mm, 1);
 	flush_cache_mm(mm);
 	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
-					TASK_SIZE, &nr_accounted);
+					TASK_SIZE_MAX, &nr_accounted);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
diff -puN include/asm-ppc64/processor.h~exit_mmap-fix include/asm-ppc64/processor.h
--- 25/include/asm-ppc64/processor.h~exit_mmap-fix	2003-01-17 22:41:32.000000000 -0800
+++ 25-akpm/include/asm-ppc64/processor.h	2003-01-17 22:42:03.000000000 -0800
@@ -630,6 +630,7 @@ extern struct task_struct *last_task_use
 
 #define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
+#define TASK_SIZE_MAX	TASK_SIZE_USER64
 #endif /* __KERNEL__ */
 
 
diff -puN include/asm-ia64/processor.h~exit_mmap-fix include/asm-ia64/processor.h
--- 25/include/asm-ia64/processor.h~exit_mmap-fix	2003-01-17 22:46:08.000000000 -0800
+++ 25-akpm/include/asm-ia64/processor.h	2003-01-17 22:47:19.000000000 -0800
@@ -39,6 +39,12 @@
 #define TASK_SIZE		(current->thread.task_size)
 
 /*
+ * This determines the virtual address space which must be torn down
+ * during exec.
+ *
+#define TASK_SIZE_MAX		DEFAULT_TASK_SIZE
+
+/*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */

_

