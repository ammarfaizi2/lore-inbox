Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274077AbRISOvu>; Wed, 19 Sep 2001 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274080AbRISOvk>; Wed, 19 Sep 2001 10:51:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:7160 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274078AbRISOvR>; Wed, 19 Sep 2001 10:51:17 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Tue, 18 Sep 2001 09:49:42 PDT." <Pine.LNX.4.33.0109180948260.2077-100000@penguin.transmeta.com> 
Date: Wed, 19 Sep 2001 15:51:34 +0100
Message-ID: <5063.1000911094@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@transmeta.com> wrote:
> On Tue, 18 Sep 2001, David Howells wrote:
> >
> > Okay preliminary as-yet-untested patch to cure coredumping of the need
> > to hold the mm semaphore:
> >
> > 	- kernel/fork.c: function to partially copy an mm_struct and attach it
> > 			 to the task_struct in place of the old.
> 
> Oh, please no.
> 
> If the choice is between a hack to do strange and incomprehensible things
> for a special case, and just making the semaphores do the same thing
> rw-spinlocks do and make the problem go away naturally, Ill take #2 any
> day. The patches already exist, after all.

But surely giving rw-semaphores this behaviour is even worse... It introduces
the possibility of livelock, and so DoS attacks, and it affects more than just
access to the mm_struct.

Also comparing them to rw-spinlocks isn't really fair IMHO since they have
different restrictions. Things inside spinlocks aren't allowed to sleep, and
mustn't incur pagefaults.

I also don't think the hack is that bad. All it's doing is taking a copy of
the process's VM decription so that it knows that nobody is going to modify it
whilst a coredump is in progress. Furthermore, it _only_ affects the coredump
path, and the coredump path is just about the last thing on the agenda for a
dying process.

However, if you don't like that, how about just changing the lock on mm_struct
to a special mm_struct-only type lock that has a recursive lock operation for
use by the pagefault handler (and _only_ the pagefault handler)? I've attached
a patch to do just that. This introduces five operations:

	- mm_lock_shared()		- get shared lock fairly
	- mm_lock_shared_recursive()	- get shared lock unfairly
	- mm_unlock_shared()		- release shared lock
	- mm_lock_exclusive()		- get exclusive lock
	- mm_unlock_exclusive()		- release exclusive lock

David


diff -uNr linux-2.4.10-pre12/arch/alpha/kernel/osf_sys.c linux-mmsem/arch/alpha/kernel/osf_sys.c
--- linux-2.4.10-pre12/arch/alpha/kernel/osf_sys.c	Tue Sep 18 08:45:58 2001
+++ linux-mmsem/arch/alpha/kernel/osf_sys.c	Wed Sep 19 12:57:04 2001
@@ -241,9 +241,9 @@
 			goto out;
 	}
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (file)
 		fput(file);
 out:
diff -uNr linux-2.4.10-pre12/arch/alpha/mm/fault.c linux-mmsem/arch/alpha/mm/fault.c
--- linux-2.4.10-pre12/arch/alpha/mm/fault.c	Wed Sep 19 10:39:05 2001
+++ linux-mmsem/arch/alpha/mm/fault.c	Wed Sep 19 13:55:13 2001
@@ -113,7 +113,7 @@
 		goto vmalloc_fault;
 #endif
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -147,7 +147,7 @@
 	 * the fault.
 	 */
 	fault = handle_mm_fault(mm, vma, address, cause > 0);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	if (fault < 0)
 		goto out_of_memory;
@@ -161,7 +161,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	if (user_mode(regs)) {
 		force_sig(SIGSEGV, current);
@@ -198,7 +198,7 @@
 	if (current->pid == 1) {
 		current->policy |= SCHED_YIELD;
 		schedule();
-		down_read(&mm->mmap_sem);
+		mm_lock_shared_recursive(mm);
 		goto survive;
 	}
 	printk(KERN_ALERT "VM: killing process %s(%d)\n",
diff -uNr linux-2.4.10-pre12/arch/arm/kernel/sys_arm.c linux-mmsem/arch/arm/kernel/sys_arm.c
--- linux-2.4.10-pre12/arch/arm/kernel/sys_arm.c	Tue Sep 18 08:46:39 2001
+++ linux-mmsem/arch/arm/kernel/sys_arm.c	Wed Sep 19 12:57:09 2001
@@ -74,9 +74,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
@@ -125,9 +125,9 @@
 	    vectors_base() == 0)
 		goto out;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 out:
 	return ret;
diff -uNr linux-2.4.10-pre12/arch/arm/mm/fault-common.c linux-mmsem/arch/arm/mm/fault-common.c
--- linux-2.4.10-pre12/arch/arm/mm/fault-common.c	Tue Sep 18 08:46:39 2001
+++ linux-mmsem/arch/arm/mm/fault-common.c	Wed Sep 19 13:56:39 2001
@@ -251,9 +251,9 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	fault = __do_page_fault(mm, addr, error_code, tsk);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Handle the "normal" case first
diff -uNr linux-2.4.10-pre12/arch/cris/kernel/sys_cris.c linux-mmsem/arch/cris/kernel/sys_cris.c
--- linux-2.4.10-pre12/arch/cris/kernel/sys_cris.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/cris/kernel/sys_cris.c	Wed Sep 19 12:57:13 2001
@@ -59,9 +59,9 @@
                         goto out;
         }
 
-        down_write(&current->mm->mmap_sem);
+        mm_lock_exclusive(current->mm);
         error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-        up_write(&current->mm->mmap_sem);
+        mm_unlock_exclusive(current->mm);
 
         if (file)
                 fput(file);
diff -uNr linux-2.4.10-pre12/arch/cris/mm/fault.c linux-mmsem/arch/cris/mm/fault.c
--- linux-2.4.10-pre12/arch/cris/mm/fault.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/cris/mm/fault.c	Wed Sep 19 13:57:18 2001
@@ -266,7 +266,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -324,7 +324,7 @@
                 goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 	
 	/*
@@ -334,7 +334,7 @@
 
  bad_area:
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
  bad_area_nosemaphore:
 	DPG(show_registers(regs));
@@ -397,14 +397,14 @@
 	 */
 
  out_of_memory:
-        up_read(&mm->mmap_sem);
+        mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if(user_mode(regs))
 		do_exit(SIGKILL);
 	goto no_context;
 
  do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
          * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/i386/kernel/ldt.c linux-mmsem/arch/i386/kernel/ldt.c
--- linux-2.4.10-pre12/arch/i386/kernel/ldt.c	Tue Sep 18 08:45:58 2001
+++ linux-mmsem/arch/i386/kernel/ldt.c	Wed Sep 19 12:57:03 2001
@@ -73,7 +73,7 @@
 	 * the GDT index of the LDT is allocated dynamically, and is
 	 * limited by MAX_LDT_DESCRIPTORS.
 	 */
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 	if (!mm->context.segments) {
 		void * segments = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
 		error = -ENOMEM;
@@ -124,7 +124,7 @@
 	error = 0;
 
 out_unlock:
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 out:
 	return error;
 }
diff -uNr linux-2.4.10-pre12/arch/i386/kernel/sys_i386.c linux-mmsem/arch/i386/kernel/sys_i386.c
--- linux-2.4.10-pre12/arch/i386/kernel/sys_i386.c	Tue Sep 18 08:45:58 2001
+++ linux-mmsem/arch/i386/kernel/sys_i386.c	Wed Sep 19 12:57:03 2001
@@ -55,9 +55,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/i386/mm/fault.c linux-mmsem/arch/i386/mm/fault.c
--- linux-2.4.10-pre12/arch/i386/mm/fault.c	Wed Sep 19 10:39:06 2001
+++ linux-mmsem/arch/i386/mm/fault.c	Wed Sep 19 13:55:18 2001
@@ -191,7 +191,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -265,7 +265,7 @@
 		if (bit < 32)
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 /*
@@ -273,7 +273,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
@@ -341,11 +341,11 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	if (tsk->pid == 1) {
 		tsk->policy |= SCHED_YIELD;
 		schedule();
-		down_read(&mm->mmap_sem);
+		mm_lock_shared_recursive(mm);
 		goto survive;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
@@ -354,7 +354,7 @@
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/ia64/ia32/sys_ia32.c linux-mmsem/arch/ia64/ia32/sys_ia32.c
--- linux-2.4.10-pre12/arch/ia64/ia32/sys_ia32.c	Tue Sep 18 08:46:41 2001
+++ linux-mmsem/arch/ia64/ia32/sys_ia32.c	Wed Sep 19 12:57:11 2001
@@ -245,9 +245,9 @@
 		}
 		__copy_user(back, (char *)addr + len, PAGE_SIZE - ((addr + len) & ~PAGE_MASK));
 	}
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	r = do_mmap(0, baddr, len + (addr - baddr), prot, flags | MAP_ANONYMOUS, 0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (r < 0)
 		return(r);
 	if (addr == 0)
@@ -291,9 +291,9 @@
 		poff = offset & PAGE_MASK;
 		len += offset - poff;
 
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
 		error = do_mmap_pgoff(file, addr, len, prot, flags, poff >> PAGE_SHIFT);
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 
 		if (!IS_ERR((void *) error))
 			error += offset - poff;
@@ -338,9 +338,9 @@
 	if ((a.offset & ~PAGE_MASK) != 0)
 		return -EINVAL;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, a.offset >> PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 #else
 	retval = ia32_do_mmap(file, a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
 #endif
@@ -2605,11 +2605,11 @@
 		return(-EFAULT);
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	addr = do_mmap_pgoff(file, IA32_IOBASE,
 			     IOLEN, PROT_READ|PROT_WRITE, MAP_SHARED,
 			     (ia64_iobase & ~PAGE_OFFSET) >> PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (addr >= 0) {
 		ia64_set_kr(IA64_KR_IO_BASE, addr);
diff -uNr linux-2.4.10-pre12/arch/ia64/kernel/sys_ia64.c linux-mmsem/arch/ia64/kernel/sys_ia64.c
--- linux-2.4.10-pre12/arch/ia64/kernel/sys_ia64.c	Tue Sep 18 08:46:41 2001
+++ linux-mmsem/arch/ia64/kernel/sys_ia64.c	Wed Sep 19 12:57:11 2001
@@ -106,7 +106,7 @@
 	 * check and the clearing of r8.  However, we can't call sys_brk() because we need
 	 * to acquire the mmap_sem before we can do the test...
 	 */
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 
 	if (brk < mm->end_code)
 		goto out;
@@ -146,7 +146,7 @@
 	mm->brk = brk;
 out:
 	retval = mm->brk;
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 	regs->r8 = 0;		/* ensure large retval isn't mistaken as error code */
 	return retval;
 }
@@ -205,9 +205,9 @@
 	if (rgn_index(addr) != rgn_index(addr + len))
 		return -EINVAL;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/ia64/mm/fault.c linux-mmsem/arch/ia64/mm/fault.c
--- linux-2.4.10-pre12/arch/ia64/mm/fault.c	Tue Sep 18 08:46:41 2001
+++ linux-mmsem/arch/ia64/mm/fault.c	Wed Sep 19 13:56:55 2001
@@ -60,7 +60,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 
 	vma = find_vma_prev(mm, address, &prev_vma);
 	if (!vma)
@@ -112,7 +112,7 @@
 	      default:
 		goto out_of_memory;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
   check_expansion:
@@ -135,7 +135,7 @@
 	goto good_area;
 
   bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	if (isr & IA64_ISR_SP) {
 		/*
 		 * This fault was due to a speculative load set the "ed" bit in the psr to
@@ -184,7 +184,7 @@
 	return;
 
   out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
diff -uNr linux-2.4.10-pre12/arch/m68k/kernel/sys_m68k.c linux-mmsem/arch/m68k/kernel/sys_m68k.c
--- linux-2.4.10-pre12/arch/m68k/kernel/sys_m68k.c	Tue Sep 18 08:46:05 2001
+++ linux-mmsem/arch/m68k/kernel/sys_m68k.c	Wed Sep 19 12:57:08 2001
@@ -59,9 +59,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
@@ -146,9 +146,9 @@
 	}
 	a.flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (file)
 		fput(file);
 out:
diff -uNr linux-2.4.10-pre12/arch/m68k/mm/fault.c linux-mmsem/arch/m68k/mm/fault.c
--- linux-2.4.10-pre12/arch/m68k/mm/fault.c	Tue Sep 18 08:46:05 2001
+++ linux-mmsem/arch/m68k/mm/fault.c	Wed Sep 19 13:56:17 2001
@@ -101,7 +101,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -168,7 +168,7 @@
 	#warning should be obsolete now...
 	if (CPU_IS_040_OR_060)
 		flush_tlb_page(vma, address);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return 0;
 
 /*
@@ -203,6 +203,6 @@
 	current->thread.faddr = address;
 
 send_sig:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return send_fault_sig(regs);
 }
diff -uNr linux-2.4.10-pre12/arch/mips/kernel/irixelf.c linux-mmsem/arch/mips/kernel/irixelf.c
--- linux-2.4.10-pre12/arch/mips/kernel/irixelf.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/mips/kernel/irixelf.c	Wed Sep 19 12:57:05 2001
@@ -314,12 +314,12 @@
 		   (unsigned long) elf_prot, (unsigned long) elf_type,
 		   (unsigned long) (eppnt->p_offset & 0xfffff000));
 #endif
-	    down_write(&current->mm->mmap_sem);
+	    mm_lock_exclusive(current->mm);
 	    error = do_mmap(interpreter, vaddr,
 			    eppnt->p_filesz + (eppnt->p_vaddr & 0xfff),
 			    elf_prot, elf_type,
 			    eppnt->p_offset & 0xfffff000);
-	    up_write(&current->mm->mmap_sem);
+	    mm_unlock_exclusive(current->mm);
 
 	    if(error < 0 && error > -1024) {
 		    printk("Aieee IRIX interp mmap error=%d\n", error);
@@ -498,12 +498,12 @@
 		prot  = (epp->p_flags & PF_R) ? PROT_READ : 0;
 		prot |= (epp->p_flags & PF_W) ? PROT_WRITE : 0;
 		prot |= (epp->p_flags & PF_X) ? PROT_EXEC : 0;
-	        down_write(&current->mm->mmap_sem);
+	        mm_lock_exclusive(current->mm);
 		(void) do_mmap(fp, (epp->p_vaddr & 0xfffff000),
 			       (epp->p_filesz + (epp->p_vaddr & 0xfff)),
 			       prot, EXEC_MAP_FLAGS,
 			       (epp->p_offset & 0xfffff000));
-	        up_write(&current->mm->mmap_sem);
+	        mm_unlock_exclusive(current->mm);
 
 		/* Fixup location tracking vars. */
 		if((epp->p_vaddr & 0xfffff000) < *estack)
@@ -762,10 +762,10 @@
 	 * Since we do not have the power to recompile these, we
 	 * emulate the SVr4 behavior.  Sigh.
 	 */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	(void) do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 		       MAP_FIXED | MAP_PRIVATE, 0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
@@ -837,14 +837,14 @@
 	while(elf_phdata->p_type != PT_LOAD) elf_phdata++;
 	
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap(file,
 			elf_phdata->p_vaddr & 0xfffff000,
 			elf_phdata->p_filesz + (elf_phdata->p_vaddr & 0xfff),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			elf_phdata->p_offset & 0xfffff000);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	k = elf_phdata->p_vaddr + elf_phdata->p_filesz;
 	if (k > elf_bss) elf_bss = k;
@@ -916,12 +916,12 @@
 		prot  = (hp->p_flags & PF_R) ? PROT_READ : 0;
 		prot |= (hp->p_flags & PF_W) ? PROT_WRITE : 0;
 		prot |= (hp->p_flags & PF_X) ? PROT_EXEC : 0;
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
 		retval = do_mmap(filp, (hp->p_vaddr & 0xfffff000),
 				 (hp->p_filesz + (hp->p_vaddr & 0xfff)),
 				 prot, (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
 				 (hp->p_offset & 0xfffff000));
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 
 		if(retval != (hp->p_vaddr & 0xfffff000)) {
 			printk("irix_mapelf: do_mmap fails with %d!\n", retval);
diff -uNr linux-2.4.10-pre12/arch/mips/kernel/syscall.c linux-mmsem/arch/mips/kernel/syscall.c
--- linux-2.4.10-pre12/arch/mips/kernel/syscall.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/mips/kernel/syscall.c	Wed Sep 19 12:57:05 2001
@@ -69,9 +69,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/mips/kernel/sysirix.c linux-mmsem/arch/mips/kernel/sysirix.c
--- linux-2.4.10-pre12/arch/mips/kernel/sysirix.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/mips/kernel/sysirix.c	Wed Sep 19 12:57:05 2001
@@ -471,7 +471,7 @@
 		if (retval)
 			return retval;
 
-		down_read(&mm->mmap_sem);
+		mm_lock_shared(mm);
 		pgdp = pgd_offset(mm, addr);
 		pmdp = pmd_offset(pgdp, addr);
 		ptep = pte_offset(pmdp, addr);
@@ -484,7 +484,7 @@
 				                   PAGE_SHIFT, pageno);
 			}
 		}
-		up_read(&mm->mmap_sem);
+		mm_unlock_shared(mm);
 		break;
 	}
 
@@ -534,7 +534,7 @@
 	struct mm_struct *mm = current->mm;
 	int ret;
 
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 	if (brk < mm->end_code) {
 		ret = -ENOMEM;
 		goto out;
@@ -592,7 +592,7 @@
 	ret = 0;
 
 out:
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 	return ret;
 }
 
@@ -1082,9 +1082,9 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap(file, addr, len, prot, flags, offset);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (file)
 		fput(file);
 
@@ -1642,9 +1642,9 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/mips/mm/fault.c linux-mmsem/arch/mips/mm/fault.c
--- linux-2.4.10-pre12/arch/mips/mm/fault.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/mips/mm/fault.c	Wed Sep 19 13:55:33 2001
@@ -72,7 +72,7 @@
 	printk("[%s:%d:%08lx:%ld:%08lx]\n", current->comm, current->pid,
 	       address, write, regs->cp0_epc);
 #endif
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -115,7 +115,7 @@
 		goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 /*
@@ -123,7 +123,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
@@ -177,14 +177,14 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/mips64/kernel/linux32.c linux-mmsem/arch/mips64/kernel/linux32.c
--- linux-2.4.10-pre12/arch/mips64/kernel/linux32.c	Wed Sep 19 10:39:07 2001
+++ linux-mmsem/arch/mips64/kernel/linux32.c	Wed Sep 19 12:57:12 2001
@@ -443,10 +443,10 @@
 	 *  `execve' frees all current memory we only have to do an
 	 *  `munmap' if the `execve' failes.
 	 */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	av = (char **) do_mmap_pgoff(0, 0, len, PROT_READ | PROT_WRITE,
 				     MAP_PRIVATE | MAP_ANONYMOUS, 0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (IS_ERR(av))
 		return (long) av;
diff -uNr linux-2.4.10-pre12/arch/mips64/kernel/syscall.c linux-mmsem/arch/mips64/kernel/syscall.c
--- linux-2.4.10-pre12/arch/mips64/kernel/syscall.c	Wed Sep 19 10:39:07 2001
+++ linux-mmsem/arch/mips64/kernel/syscall.c	Wed Sep 19 12:57:12 2001
@@ -65,9 +65,9 @@
 	}
         flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
         error = do_mmap(file, addr, len, prot, flags, offset);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
         if (file)
                 fput(file);
 out:
diff -uNr linux-2.4.10-pre12/arch/mips64/mm/fault.c linux-mmsem/arch/mips64/mm/fault.c
--- linux-2.4.10-pre12/arch/mips64/mm/fault.c	Wed Sep 19 10:39:07 2001
+++ linux-mmsem/arch/mips64/mm/fault.c	Wed Sep 19 13:57:01 2001
@@ -124,7 +124,7 @@
 	printk("Cpu%d[%s:%d:%08lx:%ld:%08lx]\n", smp_processor_id(), current->comm,
 		current->pid, address, write, regs->cp0_epc);
 #endif
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -167,7 +167,7 @@
 		goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 /*
@@ -175,7 +175,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 bad_area_nosemaphore:
 	if (user_mode(regs)) {
@@ -233,14 +233,14 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/parisc/kernel/sys_parisc.c linux-mmsem/arch/parisc/kernel/sys_parisc.c
--- linux-2.4.10-pre12/arch/parisc/kernel/sys_parisc.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/parisc/kernel/sys_parisc.c	Wed Sep 19 12:57:13 2001
@@ -51,7 +51,7 @@
 	struct file * file = NULL;
 	int error;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	lock_kernel();
 	if (!(flags & MAP_ANONYMOUS)) {
 		error = -EBADF;
@@ -65,7 +65,7 @@
 		fput(file);
 out:
 	unlock_kernel();
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return error;
 }
 
diff -uNr linux-2.4.10-pre12/arch/parisc/mm/fault.c linux-mmsem/arch/parisc/mm/fault.c
--- linux-2.4.10-pre12/arch/parisc/mm/fault.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/parisc/mm/fault.c	Wed Sep 19 13:57:13 2001
@@ -175,7 +175,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = pa_find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -218,14 +218,14 @@
 	      default:
 		goto out_of_memory;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 /*
  * Something tried to access memory that isn't in our memory map..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	if (user_mode(regs)) {
 		struct siginfo si;
@@ -275,7 +275,7 @@
 	parisc_terminate("Bad Address (null pointer deref?)",regs,code,address);
 
   out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
diff -uNr linux-2.4.10-pre12/arch/ppc/kernel/syscalls.c linux-mmsem/arch/ppc/kernel/syscalls.c
--- linux-2.4.10-pre12/arch/ppc/kernel/syscalls.c	Tue Sep 18 08:46:01 2001
+++ linux-mmsem/arch/ppc/kernel/syscalls.c	Wed Sep 19 12:57:06 2001
@@ -202,9 +202,9 @@
 			goto out;
 	}
 	
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (file)
 		fput(file);
 out:
diff -uNr linux-2.4.10-pre12/arch/ppc/mm/fault.c linux-mmsem/arch/ppc/mm/fault.c
--- linux-2.4.10-pre12/arch/ppc/mm/fault.c	Tue Sep 18 08:46:01 2001
+++ linux-mmsem/arch/ppc/mm/fault.c	Wed Sep 19 13:55:48 2001
@@ -103,7 +103,7 @@
 		bad_page_fault(regs, address, SIGSEGV);
 		return;
 	}
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -163,7 +163,7 @@
                 goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	/*
 	 * keep track of tlb+htab misses that are good addrs but
 	 * just need pte's created via handle_mm_fault()
@@ -173,7 +173,7 @@
 	return;
 
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	pte_errors++;	
 
 	/* User mode accesses cause a SIGSEGV */
@@ -194,7 +194,7 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
@@ -202,7 +202,7 @@
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
diff -uNr linux-2.4.10-pre12/arch/s390/kernel/sys_s390.c linux-mmsem/arch/s390/kernel/sys_s390.c
--- linux-2.4.10-pre12/arch/s390/kernel/sys_s390.c	Tue Sep 18 08:46:42 2001
+++ linux-mmsem/arch/s390/kernel/sys_s390.c	Wed Sep 19 12:57:12 2001
@@ -61,9 +61,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/s390/mm/fault.c linux-mmsem/arch/s390/mm/fault.c
--- linux-2.4.10-pre12/arch/s390/mm/fault.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/s390/mm/fault.c	Wed Sep 19 13:57:08 2001
@@ -113,7 +113,7 @@
 	 * task's user address space, so we search the VMAs
 	 */
 
-        down_read(&mm->mmap_sem);
+        mm_lock_shared_recursive(mm);
 
         vma = find_vma(mm, address);
         if (!vma)
@@ -164,7 +164,7 @@
 		goto out_of_memory;
 	}
 
-        up_read(&mm->mmap_sem);
+        mm_unlock_shared(mm);
         return;
 
 /*
@@ -172,7 +172,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-        up_read(&mm->mmap_sem);
+        mm_unlock_shared(mm);
 
         /* User mode accesses just cause a SIGSEGV */
         if (regs->psw.mask & PSW_PROBLEM_STATE) {
@@ -231,14 +231,14 @@
  * us unable to handle the page fault gracefully.
 */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (regs->psw.mask & PSW_PROBLEM_STATE)
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/s390x/kernel/binfmt_elf32.c linux-mmsem/arch/s390x/kernel/binfmt_elf32.c
--- linux-2.4.10-pre12/arch/s390x/kernel/binfmt_elf32.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/s390x/kernel/binfmt_elf32.c	Wed Sep 19 12:57:13 2001
@@ -194,11 +194,11 @@
 	if(!addr)
 		addr = 0x40000000;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return(map_addr);
 }
 
diff -uNr linux-2.4.10-pre12/arch/s390x/kernel/exec32.c linux-mmsem/arch/s390x/kernel/exec32.c
--- linux-2.4.10-pre12/arch/s390x/kernel/exec32.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/s390x/kernel/exec32.c	Wed Sep 19 12:57:13 2001
@@ -54,7 +54,7 @@
 	if (!mpnt) 
 		return -ENOMEM; 
 	
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	{
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
@@ -77,7 +77,7 @@
 		}
 		stack_base += PAGE_SIZE;
 	}
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	
 	return 0;
 }
diff -uNr linux-2.4.10-pre12/arch/s390x/kernel/linux32.c linux-mmsem/arch/s390x/kernel/linux32.c
--- linux-2.4.10-pre12/arch/s390x/kernel/linux32.c	Tue Sep 18 08:46:43 2001
+++ linux-mmsem/arch/s390x/kernel/linux32.c	Wed Sep 19 12:57:13 2001
@@ -4186,14 +4186,14 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	if (!IS_ERR((void *) error) && error + len >= 0x80000000ULL) {
 		/* Result is out of bounds.  */
 		do_munmap(current->mm, addr, len);
 		error = -ENOMEM;
 	}
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/s390x/kernel/sys_s390.c linux-mmsem/arch/s390x/kernel/sys_s390.c
--- linux-2.4.10-pre12/arch/s390x/kernel/sys_s390.c	Tue Sep 18 08:46:44 2001
+++ linux-mmsem/arch/s390x/kernel/sys_s390.c	Wed Sep 19 12:57:13 2001
@@ -61,9 +61,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/s390x/mm/fault.c linux-mmsem/arch/s390x/mm/fault.c
--- linux-2.4.10-pre12/arch/s390x/mm/fault.c	Tue Sep 18 08:46:44 2001
+++ linux-mmsem/arch/s390x/mm/fault.c	Wed Sep 19 13:57:25 2001
@@ -141,7 +141,7 @@
 	 * task's user address space, so we search the VMAs
 	 */
 
-        down_read(&mm->mmap_sem);
+        mm_lock_shared_recursive(mm);
 
         vma = find_vma(mm, address);
         if (!vma) {
@@ -195,7 +195,7 @@
 		goto out_of_memory;
 	}
 
-        up_read(&mm->mmap_sem);
+        mm_unlock_shared(mm);
         return;
 
 /*
@@ -203,7 +203,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-        up_read(&mm->mmap_sem);
+        mm_unlock_shared(mm);
 
         /* User mode accesses just cause a SIGSEGV */
         if (regs->psw.mask & PSW_PROBLEM_STATE) {
@@ -262,14 +262,14 @@
  * us unable to handle the page fault gracefully.
 */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (regs->psw.mask & PSW_PROBLEM_STATE)
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/sh/kernel/sys_sh.c linux-mmsem/arch/sh/kernel/sys_sh.c
--- linux-2.4.10-pre12/arch/sh/kernel/sys_sh.c	Wed Sep 19 10:39:08 2001
+++ linux-mmsem/arch/sh/kernel/sys_sh.c	Wed Sep 19 12:57:10 2001
@@ -96,9 +96,9 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	if (file)
 		fput(file);
diff -uNr linux-2.4.10-pre12/arch/sh/mm/fault.c linux-mmsem/arch/sh/mm/fault.c
--- linux-2.4.10-pre12/arch/sh/mm/fault.c	Wed Sep 19 10:39:08 2001
+++ linux-mmsem/arch/sh/mm/fault.c	Wed Sep 19 13:56:46 2001
@@ -105,7 +105,7 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared_recursive(mm);
 
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -147,7 +147,7 @@
 		goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 /*
@@ -155,7 +155,7 @@
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	if (user_mode(regs)) {
 		tsk->thread.address = address;
@@ -204,14 +204,14 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/sparc/kernel/sys_sparc.c linux-mmsem/arch/sparc/kernel/sys_sparc.c
--- linux-2.4.10-pre12/arch/sparc/kernel/sys_sparc.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/sparc/kernel/sys_sparc.c	Wed Sep 19 12:57:04 2001
@@ -242,9 +242,9 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 out_putf:
 	if (file)
@@ -288,7 +288,7 @@
 	if (old_len > TASK_SIZE - PAGE_SIZE ||
 	    new_len > TASK_SIZE - PAGE_SIZE)
 		goto out;
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if (flags & MREMAP_FIXED) {
 		if (ARCH_SUN4C_SUN4 &&
 		    new_addr < 0xe0000000 &&
@@ -323,7 +323,7 @@
 	}
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
 out_sem:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 out:
 	return ret;       
 }
diff -uNr linux-2.4.10-pre12/arch/sparc/kernel/sys_sunos.c linux-mmsem/arch/sparc/kernel/sys_sunos.c
--- linux-2.4.10-pre12/arch/sparc/kernel/sys_sunos.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/sparc/kernel/sys_sunos.c	Wed Sep 19 12:57:04 2001
@@ -116,9 +116,9 @@
 	}
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if(!ret_type)
 		retval = ((retval < PAGE_OFFSET) ? 0 : retval);
 
@@ -145,7 +145,7 @@
 	unsigned long rlim;
 	unsigned long newbrk, oldbrk;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if(ARCH_SUN4C_SUN4) {
 		if(brk >= 0x20000000 && brk < 0xe0000000) {
 			goto out;
@@ -208,7 +208,7 @@
 	do_brk(oldbrk, newbrk-oldbrk);
 	retval = 0;
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return retval;
 }
 
diff -uNr linux-2.4.10-pre12/arch/sparc/mm/fault.c linux-mmsem/arch/sparc/mm/fault.c
--- linux-2.4.10-pre12/arch/sparc/mm/fault.c	Tue Sep 18 08:45:59 2001
+++ linux-mmsem/arch/sparc/mm/fault.c	Wed Sep 19 12:57:05 2001
@@ -222,7 +222,7 @@
         if (in_interrupt() || !mm)
                 goto no_context;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 
 	/*
 	 * The kernel referencing a bad kernel pointer can lock up
@@ -272,7 +272,7 @@
 	default:
 		goto out_of_memory;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 
 	/*
@@ -280,7 +280,7 @@
 	 * Fix it, but check if it's kernel or user first..
 	 */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
@@ -336,14 +336,14 @@
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", tsk->comm);
 	if (from_user)
 		do_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
@@ -477,7 +477,7 @@
 	printk("wf<pid=%d,wr=%d,addr=%08lx>\n",
 	       tsk->pid, write, address);
 #endif
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	vma = find_vma(mm, address);
 	if(!vma)
 		goto bad_area;
@@ -498,10 +498,10 @@
 	}
 	if (!handle_mm_fault(mm, vma, address, write))
 		goto do_sigbus;
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return;
 bad_area:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 #if 0
 	printk("Window whee %s [%d]: segfaults at %08lx\n",
 	       tsk->comm, tsk->pid, address);
@@ -516,7 +516,7 @@
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
diff -uNr linux-2.4.10-pre12/arch/sparc64/kernel/binfmt_aout32.c linux-mmsem/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.4.10-pre12/arch/sparc64/kernel/binfmt_aout32.c	Tue Sep 18 08:46:07 2001
+++ linux-mmsem/arch/sparc64/kernel/binfmt_aout32.c	Wed Sep 19 12:57:09 2001
@@ -277,24 +277,24 @@
 			goto beyond_if;
 		}
 
-	        down_write(&current->mm->mmap_sem);
+	        mm_lock_exclusive(current->mm);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 			fd_offset);
-	        up_write(&current->mm->mmap_sem);
+	        mm_unlock_exclusive(current->mm);
 
 		if (error != N_TXTADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
 		}
 
-	        down_write(&current->mm->mmap_sem);
+	        mm_lock_exclusive(current->mm);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
-	        up_write(&current->mm->mmap_sem);
+	        mm_unlock_exclusive(current->mm);
 		if (error != N_DATADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -369,12 +369,12 @@
 	start_addr =  ex.a_entry & 0xfffff000;
 
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			N_TXTOFF(ex));
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	retval = error;
 	if (error != start_addr)
 		goto out;
diff -uNr linux-2.4.10-pre12/arch/sparc64/kernel/sys_sparc.c linux-mmsem/arch/sparc64/kernel/sys_sparc.c
--- linux-2.4.10-pre12/arch/sparc64/kernel/sys_sparc.c	Tue Sep 18 08:46:06 2001
+++ linux-mmsem/arch/sparc64/kernel/sys_sparc.c	Wed Sep 19 12:57:09 2001
@@ -292,9 +292,9 @@
 			goto out_putf;
 	}
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 out_putf:
 	if (file)
@@ -310,9 +310,9 @@
 	if (len > -PAGE_OFFSET ||
 	    (addr < PAGE_OFFSET && addr + len > -PAGE_OFFSET))
 		return -EINVAL;
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_munmap(current->mm, addr, len);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return ret;
 }
 
@@ -332,7 +332,7 @@
 		goto out;
 	if (addr < PAGE_OFFSET && addr + old_len > -PAGE_OFFSET)
 		goto out;
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if (flags & MREMAP_FIXED) {
 		if (new_addr < PAGE_OFFSET &&
 		    new_addr + new_len > -PAGE_OFFSET)
@@ -363,7 +363,7 @@
 	}
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
 out_sem:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 out:
 	return ret;       
 }
diff -uNr linux-2.4.10-pre12/arch/sparc64/kernel/sys_sparc32.c linux-mmsem/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.4.10-pre12/arch/sparc64/kernel/sys_sparc32.c	Tue Sep 18 08:46:06 2001
+++ linux-mmsem/arch/sparc64/kernel/sys_sparc32.c	Wed Sep 19 12:57:09 2001
@@ -4141,7 +4141,7 @@
 		goto out;
 	if (addr > 0xf0000000UL - old_len)
 		goto out;
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if (flags & MREMAP_FIXED) {
 		if (new_addr > 0xf0000000UL - new_len)
 			goto out_sem;
@@ -4171,7 +4171,7 @@
 	}
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
 out_sem:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 out:
 	return ret;       
 }
diff -uNr linux-2.4.10-pre12/arch/sparc64/kernel/sys_sunos32.c linux-mmsem/arch/sparc64/kernel/sys_sunos32.c
--- linux-2.4.10-pre12/arch/sparc64/kernel/sys_sunos32.c	Tue Sep 18 08:46:08 2001
+++ linux-mmsem/arch/sparc64/kernel/sys_sunos32.c	Wed Sep 19 12:57:09 2001
@@ -100,12 +100,12 @@
 	flags &= ~_MAP_NEW;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
 			 (unsigned long) prot, (unsigned long) flags,
 			 (unsigned long) off);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if(!ret_type)
 		retval = ((retval < 0xf0000000) ? 0 : retval);
 out_putf:
@@ -126,7 +126,7 @@
 	unsigned long rlim;
 	unsigned long newbrk, oldbrk, brk = (unsigned long) baddr;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if (brk < current->mm->end_code)
 		goto out;
 	newbrk = PAGE_ALIGN(brk);
@@ -170,7 +170,7 @@
 	do_brk(oldbrk, newbrk-oldbrk);
 	retval = 0;
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return retval;
 }
 
diff -uNr linux-2.4.10-pre12/arch/sparc64/mm/fault.c linux-mmsem/arch/sparc64/mm/fault.c
--- linux-2.4.10-pre12/arch/sparc64/mm/fault.c	Wed Sep 19 10:39:08 2001
+++ linux-mmsem/arch/sparc64/mm/fault.c	Wed Sep 19 12:57:09 2001
@@ -306,7 +306,7 @@
 		address &= 0xffffffff;
 	}
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -378,7 +378,7 @@
 		goto out_of_memory;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	goto fault_done;
 
 	/*
@@ -387,7 +387,7 @@
 	 */
 bad_area:
 	insn = get_fault_insn(regs, insn);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 handle_kernel_fault:
 	do_kernel_fault(regs, si_code, fault_code, insn, address);
@@ -400,7 +400,7 @@
  */
 out_of_memory:
 	insn = get_fault_insn(regs, insn);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	printk("VM: killing process %s\n", current->comm);
 	if (!(regs->tstate & TSTATE_PRIV))
 		do_exit(SIGKILL);
@@ -412,7 +412,7 @@
 
 do_sigbus:
 	insn = get_fault_insn(regs, insn);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/*
 	 * Send a sigbus, regardless of whether we were in kernel
diff -uNr linux-2.4.10-pre12/arch/sparc64/solaris/misc.c linux-mmsem/arch/sparc64/solaris/misc.c
--- linux-2.4.10-pre12/arch/sparc64/solaris/misc.c	Wed Sep 19 10:39:08 2001
+++ linux-mmsem/arch/sparc64/solaris/misc.c	Wed Sep 19 12:57:09 2001
@@ -92,12 +92,12 @@
 	ret_type = flags & _MAP_NEW;
 	flags &= ~_MAP_NEW;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
 			 (unsigned long) prot, (unsigned long) flags, off);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if(!ret_type)
 		retval = ((retval < 0xf0000000) ? 0 : retval);
 	                        
diff -uNr linux-2.4.10-pre12/drivers/char/mem.c linux-mmsem/drivers/char/mem.c
--- linux-2.4.10-pre12/drivers/char/mem.c	Wed Sep 19 10:39:10 2001
+++ linux-mmsem/drivers/char/mem.c	Wed Sep 19 12:58:59 2001
@@ -350,7 +350,7 @@
 
 	mm = current->mm;
 	/* Oops, this was forgotten before. -ben */
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 
 	/* For private mappings, just map in zero pages. */
 	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
@@ -374,7 +374,7 @@
 			goto out_up;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	
 	/* The shared case is hard. Let's do the conventional zeroing. */ 
 	do {
@@ -389,7 +389,7 @@
 
 	return size;
 out_up:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return size;
 }
 
diff -uNr linux-2.4.10-pre12/drivers/sgi/char/graphics.c linux-mmsem/drivers/sgi/char/graphics.c
--- linux-2.4.10-pre12/drivers/sgi/char/graphics.c	Wed Sep 19 10:39:17 2001
+++ linux-mmsem/drivers/sgi/char/graphics.c	Wed Sep 19 12:59:13 2001
@@ -152,11 +152,11 @@
 		 * sgi_graphics_mmap
 		 */
 		disable_gconsole ();
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
 		r = do_mmap (file, (unsigned long)vaddr,
 			     cards[board].g_regs_size, PROT_READ|PROT_WRITE,
 			     MAP_FIXED|MAP_PRIVATE, 0);
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 		if (r)
 			return r;
 	}
diff -uNr linux-2.4.10-pre12/drivers/sgi/char/shmiq.c linux-mmsem/drivers/sgi/char/shmiq.c
--- linux-2.4.10-pre12/drivers/sgi/char/shmiq.c	Wed Sep 19 10:39:17 2001
+++ linux-mmsem/drivers/sgi/char/shmiq.c	Wed Sep 19 12:59:13 2001
@@ -285,11 +285,11 @@
 			s = req.arg * sizeof (struct shmqevent) +
 			    sizeof (struct sharedMemoryInputQueue);
 			v = sys_munmap (vaddr, s);
-			down_write(&current->mm->mmap_sem);
+			mm_lock_exclusive(current->mm);
 			do_munmap(current->mm, vaddr, s);
 			do_mmap(filp, vaddr, s, PROT_READ | PROT_WRITE,
 			        MAP_PRIVATE|MAP_FIXED, 0);
-			up_write(&current->mm->mmap_sem);
+			mm_unlock_exclusive(current->mm);
 			shmiqs[minor].events = req.arg;
 			shmiqs[minor].mapped = 1;
 
diff -uNr linux-2.4.10-pre12/fs/binfmt_aout.c linux-mmsem/fs/binfmt_aout.c
--- linux-2.4.10-pre12/fs/binfmt_aout.c	Wed Sep 19 10:39:20 2001
+++ linux-mmsem/fs/binfmt_aout.c	Wed Sep 19 11:42:59 2001
@@ -377,24 +377,24 @@
 			goto beyond_if;
 		}
 
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 			fd_offset);
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 
 		if (error != N_TXTADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
 		}
 
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 		if (error != N_DATADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -476,12 +476,12 @@
 		goto out;
 	}
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			N_TXTOFF(ex));
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	retval = error;
 	if (error != start_addr)
 		goto out;
diff -uNr linux-2.4.10-pre12/fs/binfmt_elf.c linux-mmsem/fs/binfmt_elf.c
--- linux-2.4.10-pre12/fs/binfmt_elf.c	Wed Sep 19 10:39:20 2001
+++ linux-mmsem/fs/binfmt_elf.c	Wed Sep 19 11:43:48 2001
@@ -224,11 +224,11 @@
 {
 	unsigned long map_addr;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return(map_addr);
 }
 
@@ -743,10 +743,10 @@
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior.  Sigh.  */
 		/* N.B. Shouldn't the size here be PAGE_SIZE?? */
-		down_write(&current->mm->mmap_sem);
+		mm_lock_exclusive(current->mm);
 		error = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
-		up_write(&current->mm->mmap_sem);
+		mm_unlock_exclusive(current->mm);
 	}
 
 #ifdef ELF_PLAT_INIT
@@ -827,7 +827,7 @@
 	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
 
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	error = do_mmap(file,
 			ELF_PAGESTART(elf_phdata->p_vaddr),
 			(elf_phdata->p_filesz +
@@ -836,7 +836,7 @@
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			(elf_phdata->p_offset -
 			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	if (error != ELF_PAGESTART(elf_phdata->p_vaddr))
 		goto out_free_ph;
 
diff -uNr linux-2.4.10-pre12/fs/exec.c linux-mmsem/fs/exec.c
--- linux-2.4.10-pre12/fs/exec.c	Wed Sep 19 10:39:20 2001
+++ linux-mmsem/fs/exec.c	Wed Sep 19 11:44:38 2001
@@ -307,7 +307,7 @@
 	if (!mpnt) 
 		return -ENOMEM; 
 	
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	{
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
@@ -330,7 +330,7 @@
 		}
 		stack_base += PAGE_SIZE;
 	}
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	
 	return 0;
 }
@@ -969,9 +969,9 @@
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
 
-	down_read(&current->mm->mmap_sem);
+	mm_lock_shared(current->mm);
 	retval = binfmt->core_dump(signr, regs, file);
-	up_read(&current->mm->mmap_sem);
+	mm_unlock_shared(current->mm);
 
 close_fail:
 	filp_close(file, NULL);
diff -uNr linux-2.4.10-pre12/fs/proc/array.c linux-mmsem/fs/proc/array.c
--- linux-2.4.10-pre12/fs/proc/array.c	Tue Sep 18 08:45:09 2001
+++ linux-mmsem/fs/proc/array.c	Wed Sep 19 11:47:34 2001
@@ -181,7 +181,7 @@
 	unsigned long data = 0, stack = 0;
 	unsigned long exec = 0, lib = 0;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
 		if (!vma->vm_file) {
@@ -212,7 +212,7 @@
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
 		exec - lib, lib);
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	return buffer;
 }
 
@@ -317,7 +317,7 @@
 	task_unlock(task);
 	if (mm) {
 		struct vm_area_struct *vma;
-		down_read(&mm->mmap_sem);
+		mm_lock_shared(mm);
 		vma = mm->mmap;
 		while (vma) {
 			vsize += vma->vm_end - vma->vm_start;
@@ -325,7 +325,7 @@
 		}
 		eip = KSTK_EIP(task);
 		esp = KSTK_ESP(task);
-		up_read(&mm->mmap_sem);
+		mm_unlock_shared(mm);
 	}
 
 	wchan = get_wchan(task);
@@ -479,7 +479,7 @@
 	task_unlock(task);
 	if (mm) {
 		struct vm_area_struct * vma;
-		down_read(&mm->mmap_sem);
+		mm_lock_shared(mm);
 		vma = mm->mmap;
 		while (vma) {
 			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
@@ -500,7 +500,7 @@
 				drs += pages;
 			vma = vma->vm_next;
 		}
-		up_read(&mm->mmap_sem);
+		mm_unlock_shared(mm);
 		mmput(mm);
 	}
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
@@ -577,7 +577,7 @@
 	column = *ppos & (MAPS_LINE_LENGTH-1);
 
 	/* quickly go to line lineno */
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	for (map = mm->mmap, i = 0; map && (i < lineno); map = map->vm_next, i++)
 		continue;
 
@@ -658,7 +658,7 @@
 		if (volatile_task)
 			break;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 
 	/* encode f_pos */
 	*ppos = (lineno << MAPS_LINE_SHIFT) + column;
diff -uNr linux-2.4.10-pre12/fs/proc/base.c linux-mmsem/fs/proc/base.c
--- linux-2.4.10-pre12/fs/proc/base.c	Tue Sep 18 08:45:09 2001
+++ linux-mmsem/fs/proc/base.c	Wed Sep 19 11:47:49 2001
@@ -64,7 +64,7 @@
 	task_unlock(task);
 	if (!mm)
 		goto out;
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	vma = mm->mmap;
 	while (vma) {
 		if ((vma->vm_flags & VM_EXECUTABLE) && 
@@ -76,7 +76,7 @@
 		}
 		vma = vma->vm_next;
 	}
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	mmput(mm);
 out:
 	return result;
diff -uNr linux-2.4.10-pre12/include/linux/sched.h linux-mmsem/include/linux/sched.h
--- linux-2.4.10-pre12/include/linux/sched.h	Wed Sep 19 10:39:23 2001
+++ linux-mmsem/include/linux/sched.h	Wed Sep 19 13:07:34 2001
@@ -209,7 +209,9 @@
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
-	struct rw_semaphore mmap_sem;
+	spinlock_t mmsem_lock;			/* protects access to mmsem stuff */
+	int mmsem_activity;			/* 0 inactive, +n active readers, -1 active writer */
+	struct list_head mmsem_waiters;
 	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
 
 	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
@@ -233,15 +235,70 @@
 
 extern int mmlist_nr;
 
-#define INIT_MM(name) \
-{			 				\
-	mm_rb:		RB_ROOT,			\
-	pgd:		swapper_pg_dir, 		\
-	mm_users:	ATOMIC_INIT(2), 		\
-	mm_count:	ATOMIC_INIT(1), 		\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
-	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
-	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
+#define INIT_MM(name)						\
+{								\
+	mm_rb:		RB_ROOT,				\
+	pgd:		swapper_pg_dir,				\
+	mm_users:	ATOMIC_INIT(2),				\
+	mm_count:	ATOMIC_INIT(1),				\
+	mmsem_lock:	SPIN_LOCK_UNLOCKED,			\
+	mmsem_activity:	0,					\
+	mmsem_waiters:	LIST_HEAD_INIT(name.mmsem_waiters),	\
+	page_table_lock: SPIN_LOCK_UNLOCKED,			\
+	mmlist:		LIST_HEAD_INIT(name.mmlist),		\
+}
+
+extern void __mm_lock_wait(struct mm_struct *mm, int bias);
+extern void __mm_lock_wake(struct mm_struct *mm);
+
+static inline void mm_lock_shared(struct mm_struct *mm)
+{
+	spin_lock(&mm->mmsem_lock);
+	if (mm->mmsem_activity>=0 && list_empty(&mm->mmsem_waiters)) {
+		mm->mmsem_activity++;
+		spin_unlock(&mm->mmsem_lock);
+	}
+	else
+		__mm_lock_wait(mm,1);
+}
+
+static inline void mm_lock_shared_recursive(struct mm_struct *mm)
+{
+	spin_lock(&mm->mmsem_lock);
+	if (mm->mmsem_activity>=0) {
+		mm->mmsem_activity++;
+		spin_unlock(&mm->mmsem_lock);
+	}
+	else
+		__mm_lock_wait(mm,1);
+}
+
+static inline void mm_unlock_shared(struct mm_struct *mm)
+{
+	spin_lock(&mm->mmsem_lock);
+	if (!--mm->mmsem_activity && !list_empty(&mm->mmsem_waiters))
+		__mm_lock_wake(mm);
+	spin_unlock(&mm->mmsem_lock);
+}
+
+static inline void mm_lock_exclusive(struct mm_struct *mm)
+{
+	spin_lock(&mm->mmsem_lock);
+	if (mm->mmsem_activity==0) {
+		mm->mmsem_activity--;
+		spin_unlock(&mm->mmsem_lock);
+	}
+	else
+		__mm_lock_wait(mm,-1);
+}
+
+static inline void mm_unlock_exclusive(struct mm_struct *mm)
+{
+	spin_lock(&mm->mmsem_lock);
+	mm->mmsem_activity++;
+	if (!list_empty(&mm->mmsem_waiters))
+		__mm_lock_wake(mm);
+	spin_unlock(&mm->mmsem_lock);
 }
 
 struct signal_struct {
diff -uNr linux-2.4.10-pre12/ipc/shm.c linux-mmsem/ipc/shm.c
--- linux-2.4.10-pre12/ipc/shm.c	Wed Sep 19 10:39:23 2001
+++ linux-mmsem/ipc/shm.c	Wed Sep 19 12:32:57 2001
@@ -619,9 +619,9 @@
 	shp->shm_nattch++;
 	shm_unlock(shmid);
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	user_addr = (void *) do_mmap (file, addr, file->f_dentry->d_inode->i_size, prot, flags, 0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 
 	down (&shm_ids.sem);
 	if(!(shp = shm_lock(shmid)))
@@ -650,14 +650,14 @@
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *shmd, *shmdnext;
 
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 	for (shmd = mm->mmap; shmd; shmd = shmdnext) {
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
 			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
 	}
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 	return 0;
 }
 
diff -uNr linux-2.4.10-pre12/kernel/acct.c linux-mmsem/kernel/acct.c
--- linux-2.4.10-pre12/kernel/acct.c	Tue Sep 18 08:45:11 2001
+++ linux-mmsem/kernel/acct.c	Wed Sep 19 11:38:59 2001
@@ -315,13 +315,13 @@
 	vsize = 0;
 	if (current->mm) {
 		struct vm_area_struct *vma;
-		down_read(&current->mm->mmap_sem);
+		mm_lock_shared(current->mm);
 		vma = current->mm->mmap;
 		while (vma) {
 			vsize += vma->vm_end - vma->vm_start;
 			vma = vma->vm_next;
 		}
-		up_read(&current->mm->mmap_sem);
+		mm_unlock_shared(current->mm);
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
diff -uNr linux-2.4.10-pre12/kernel/fork.c linux-mmsem/kernel/fork.c
--- linux-2.4.10-pre12/kernel/fork.c	Wed Sep 19 10:39:23 2001
+++ linux-mmsem/kernel/fork.c	Wed Sep 19 11:41:48 2001
@@ -216,7 +216,9 @@
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
-	init_rwsem(&mm->mmap_sem);
+	spin_lock_init(&mm->mmsem_lock);
+	mm->mmsem_activity = 0;
+	INIT_LIST_HEAD(&mm->mmsem_waiters);
 	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
 	mm->pgd = pgd_alloc(mm);
 	if (mm->pgd)
@@ -333,9 +335,9 @@
 	if (!mm_init(mm))
 		goto fail_nomem;
 
-	down_write(&oldmm->mmap_sem);
+	mm_lock_exclusive(oldmm);
 	retval = dup_mmap(mm);
-	up_write(&oldmm->mmap_sem);
+	mm_unlock_exclusive(oldmm);
 
 	if (retval)
 		goto free_pt;
diff -uNr linux-2.4.10-pre12/kernel/ksyms.c linux-mmsem/kernel/ksyms.c
--- linux-2.4.10-pre12/kernel/ksyms.c	Wed Sep 19 10:39:23 2001
+++ linux-mmsem/kernel/ksyms.c	Wed Sep 19 14:13:42 2001
@@ -87,6 +87,8 @@
 EXPORT_SYMBOL(exit_files);
 EXPORT_SYMBOL(exit_fs);
 EXPORT_SYMBOL(exit_sighand);
+EXPORT_SYMBOL(__mm_lock_wait);
+EXPORT_SYMBOL(__mm_lock_wake);
 
 /* internal kernel memory management */
 EXPORT_SYMBOL(_alloc_pages);
diff -uNr linux-2.4.10-pre12/kernel/ptrace.c linux-mmsem/kernel/ptrace.c
--- linux-2.4.10-pre12/kernel/ptrace.c	Wed Sep 19 10:39:23 2001
+++ linux-mmsem/kernel/ptrace.c	Wed Sep 19 11:40:34 2001
@@ -208,13 +208,13 @@
 	if (!mm)
 		return 0;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 	vma = find_extend_vma(mm, addr);
 	copied = 0;
 	if (vma)
 		copied = access_mm(mm, vma, addr, buf, len, write);
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	mmput(mm);
 	return copied;
 }
diff -uNr linux-2.4.10-pre12/mm/filemap.c linux-mmsem/mm/filemap.c
--- linux-2.4.10-pre12/mm/filemap.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/filemap.c	Wed Sep 19 11:33:14 2001
@@ -1949,7 +1949,7 @@
 	struct vm_area_struct * vma;
 	int unmapped_error, error = -EINVAL;
 
-	down_read(&current->mm->mmap_sem);
+	mm_lock_shared(current->mm);
 	if (start & ~PAGE_MASK)
 		goto out;
 	len = (len + ~PAGE_MASK) & PAGE_MASK;
@@ -1995,7 +1995,7 @@
 		vma = vma->vm_next;
 	}
 out:
-	up_read(&current->mm->mmap_sem);
+	mm_unlock_shared(current->mm);
 	return error;
 }
 
@@ -2298,7 +2298,7 @@
 	int unmapped_error = 0;
 	int error = -EINVAL;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 
 	if (start & ~PAGE_MASK)
 		goto out;
@@ -2349,7 +2349,7 @@
 	}
 
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return error;
 }
 
@@ -2451,7 +2451,7 @@
 	int unmapped_error = 0;
 	long error = -EINVAL;
 
-	down_read(&current->mm->mmap_sem);
+	mm_lock_shared(current->mm);
 
 	if (start & ~PAGE_CACHE_MASK)
 		goto out;
@@ -2503,7 +2503,7 @@
 	}
 
 out:
-	up_read(&current->mm->mmap_sem);
+	mm_unlock_shared(current->mm);
 	return error;
 }
 
diff -uNr linux-2.4.10-pre12/mm/memory.c linux-mmsem/mm/memory.c
--- linux-2.4.10-pre12/mm/memory.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/memory.c	Wed Sep 19 11:33:28 2001
@@ -464,7 +464,7 @@
 	if (err)
 		return err;
 
-	down_read(&mm->mmap_sem);
+	mm_lock_shared(mm);
 
 	err = -EFAULT;
 	iobuf->locked = 0;
@@ -522,12 +522,12 @@
 		ptr += PAGE_SIZE;
 	}
 
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	dprintk ("map_user_kiobuf: end OK\n");
 	return 0;
 
  out_unlock:
-	up_read(&mm->mmap_sem);
+	mm_unlock_shared(mm);
 	unmap_kiobuf(iobuf);
 	dprintk ("map_user_kiobuf: end %d\n", err);
 	return err;
diff -uNr linux-2.4.10-pre12/mm/mlock.c linux-mmsem/mm/mlock.c
--- linux-2.4.10-pre12/mm/mlock.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/mlock.c	Wed Sep 19 11:35:27 2001
@@ -198,7 +198,7 @@
 	unsigned long lock_limit;
 	int error = -ENOMEM;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
 
@@ -219,7 +219,7 @@
 
 	error = do_mlock(start, len, 1);
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return error;
 }
 
@@ -227,11 +227,11 @@
 {
 	int ret;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
 	ret = do_mlock(start, len, 0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return ret;
 }
 
@@ -268,7 +268,7 @@
 	unsigned long lock_limit;
 	int ret = -EINVAL;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
 		goto out;
 
@@ -286,7 +286,7 @@
 
 	ret = do_mlockall(flags);
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return ret;
 }
 
@@ -294,8 +294,8 @@
 {
 	int ret;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_mlockall(0);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return ret;
 }
diff -uNr linux-2.4.10-pre12/mm/mmap.c linux-mmsem/mm/mmap.c
--- linux-2.4.10-pre12/mm/mmap.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/mmap.c	Wed Sep 19 13:24:42 2001
@@ -149,7 +149,7 @@
 	unsigned long newbrk, oldbrk;
 	struct mm_struct *mm = current->mm;
 
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 
 	if (brk < mm->end_code)
 		goto out;
@@ -185,7 +185,7 @@
 	mm->brk = brk;
 out:
 	retval = mm->brk;
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 	return retval;
 }
 
@@ -995,9 +995,9 @@
 	int ret;
 	struct mm_struct *mm = current->mm;
 
-	down_write(&mm->mmap_sem);
+	mm_lock_exclusive(mm);
 	ret = do_munmap(mm, addr, len);
-	up_write(&mm->mmap_sem);
+	mm_unlock_exclusive(mm);
 	return ret;
 }
 
@@ -1172,4 +1172,86 @@
 		BUG();
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	validate_mm(mm);
+}
+
+
+struct mm_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	unsigned int		flags;
+#define MM_WAITING_FOR_READ	0x00000001
+#define MM_WAITING_FOR_WRITE	0x00000002
+};
+
+/*
+ * handle the lock being released whilst there are processes blocked on it that can now run
+ * - if we come here, then:
+ *   - the 'active count' _reached_ zero
+ *   - the 'waiting count' is non-zero
+ * - the spinlock must be held by the caller
+ * - woken process blocks are discarded from the list after having flags zeroised
+ */
+void __mm_lock_wake(struct mm_struct *mm)
+{
+	struct mm_waiter *waiter;
+	int woken;
+
+	waiter = list_entry(mm->mmsem_waiters.next,struct mm_waiter,list);
+
+	/* try to grant a single write lock if there's a writer at the front of the queue
+	 * - we leave the 'waiting count' incremented to signify potential contention
+	 */
+	if (waiter->flags & MM_WAITING_FOR_WRITE) {
+		mm->mmsem_activity = -1;
+		list_del(&waiter->list);
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		return;
+	}
+
+	/* grant an infinite number of read locks to the readers at the front of the queue */
+	woken = 0;
+	do {
+		list_del(&waiter->list);
+		waiter->flags = 0;
+		wake_up_process(waiter->task);
+		woken++;
+		if (list_empty(&mm->mmsem_waiters))
+			break;
+		waiter = list_entry(mm->mmsem_waiters.next,struct mm_waiter,list);
+	} while (waiter->flags&MM_WAITING_FOR_READ);
+
+	mm->mmsem_activity += woken;
+}
+
+/*
+ * wait for a lock on the mm_struct
+ * - must be entered with the mmsem_lock spinlock held
+ */
+void __mm_lock_wait(struct mm_struct *mm, int bias)
+{
+	struct mm_waiter waiter;
+	struct task_struct *tsk;
+
+	tsk = current;
+	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
+
+	/* add to the waitqueue */
+	waiter.task = tsk;
+	waiter.flags = MM_WAITING_FOR_READ;
+
+	list_add_tail(&waiter.list,&mm->mmsem_waiters);
+
+	/* we don't need to touch the mm_struct anymore */
+	spin_unlock(&mm->mmsem_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter.flags)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
 }
diff -uNr linux-2.4.10-pre12/mm/mprotect.c linux-mmsem/mm/mprotect.c
--- linux-2.4.10-pre12/mm/mprotect.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/mprotect.c	Wed Sep 19 11:36:18 2001
@@ -281,7 +281,7 @@
 	if (end == start)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 
 	vma = find_vma_prev(current->mm, start, &prev);
 	error = -EFAULT;
@@ -332,6 +332,6 @@
 		prev->vm_mm->map_count--;
 	}
 out:
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return error;
 }
diff -uNr linux-2.4.10-pre12/mm/mremap.c linux-mmsem/mm/mremap.c
--- linux-2.4.10-pre12/mm/mremap.c	Wed Sep 19 10:39:24 2001
+++ linux-mmsem/mm/mremap.c	Wed Sep 19 11:36:35 2001
@@ -346,8 +346,8 @@
 {
 	unsigned long ret;
 
-	down_write(&current->mm->mmap_sem);
+	mm_lock_exclusive(current->mm);
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
-	up_write(&current->mm->mmap_sem);
+	mm_unlock_exclusive(current->mm);
 	return ret;
 }
