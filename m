Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263301AbTCSWdM>; Wed, 19 Mar 2003 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263312AbTCSWdM>; Wed, 19 Mar 2003 17:33:12 -0500
Received: from shuzbut.anathoth.gen.nz ([202.49.159.11]:27271 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S263301AbTCSWcR>; Wed, 19 Mar 2003 17:32:17 -0500
Subject: Ptrace patch for 2.4.x BREAKS kill() 2 interesting effects for .pid
	and dot locking? (was Re: Ptrace hole / Linux 2.2.25)
From: Matthew Grant <grantma@anathoth.gen.nz>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, debian-security@lists.debian.org,
       Herbert Xu <herbert@debian.org>
In-Reply-To: <1048109690.23160.5.camel@luther>
References: <1048104545.20129.24.camel@zion> 
	<1048109690.23160.5.camel@luther>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Mavoo7F9/SUsa63mKUFJ"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Mar 2003 10:43:05 +1200
Message-Id: <1048113787.23160.21.camel@luther>
Mime-Version: 1.0
X-Virus-Scanned-By: Amavis with CLAM Anti Virus on shuzbut.anathoth.gen.nz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mavoo7F9/SUsa63mKUFJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi There!

Sorry about making a racket, but I am posting this for the edification
of all, as there is a work around without breaking your server for this
one.

As you can read below, I have found that the patch on 2.4.x also BREAKS
kill() 2 when executed for signal 0 on a process ID that the user is not
the owner of, except for root of course.

This has all sorts of interesting effects for processing .pid files, and
probably dot locking.....  Makes the patch as it stands unacceptable for
2.4.21, and vendor kernels I would say... (See below for effects on
Debian netsaint...)

I have been just digging harder, and the vulnerability is only
exploitable if you are using the kernel auto module loader, so compile
your kernel with out auto module loader enabled, or echo some garbage
into /proc/sys/kernel/modprobe after loading all your modules.  It has
to be an invalid executable name in there as any executable file will
open the bug to exploit.

Here are the effects on a netsaint box I look after:

bucket: -foo- [~]=20
$ ls -l /var/run/netsaint/netsaint.pid=20
-rw-r--r--    1 root     root            5 Mar 19 16:32 /var/run/netsaint/n=
etsaint.pid

bucket: -foo- [~]=20
$ cat !$
cat /var/run/netsaint/netsaint.pid
4276

bucket: -foo- [~]=20
$ kill -0 4276
bash: kill: (4276) - Operation not permitted

and the netsaint Web front end can't find the process alive that it
wants to talk to via a unix pipe so that it can start and stop
notifications etc....

Could I please say this to the kernel developers, please fix it
properly!

Thanks heaps,=20

Matthew Grant

On Thu, 2003-03-20 at 09:34, Matthew Grant wrote:
    Dear All,
   =20
    The patch also breaks kill(2) on a process with signal number 0 - This
    is used by a lot of monitoring programs running as one user ID to make
    sure a process with another user ID is running.
   =20
    This causes trouble with packages like nagios and netsaint, as well as
    other stuff.
   =20
    Alan, don't want to bash you around, but isn't there another fix
    possible that doesn't break this function call and UML skas mode?
   =20
    Cheers,
   =20
    Matthew Grantal
   =20
    On Thu, 2003-03-20 at 08:09, Matthew Grant wrote:
        Mistyped linux-kernel address  %-<=20
       =20
        -----Forwarded Message-----=20
       =20
        From: Matthew Grant <grantma@anathoth.gen.nz>
        To: Alan Cox <alan@lxorguk.ukuu.org.uk>
        Cc: Jeff Dike <jdike@karaya.com>, liinux-kerel@vger.kernel.org
        Subject: Re: Ptrace hole / Linux 2.2.25
        Date: 20 Mar 2003 07:55:45 +1200
       =20
        Alan,
       =20
        This patch really breaks UML using the skas mode of thread tracing =
skas3
        patch on quite a significant amount of machines out there. The skas=
 mode
        is a lot more secure than the traditional UML tt mode. I guess this=
 is
        related to the below...
       =20
        I am running a UML site that a lot of hospitals ad clinics in Bangl=
desh
        depend on for there email.  It allows them to work around the corru=
ption
        and agrandidement of the ISPs over there.  The skas3 mode patch is
        needed for the site to run securely.  Tracing thread mode does not =
cut
        it.
       =20
        There are also a large number of other telehoused ISP virtual hosti=
ng=20
        machines that use this stuff, and it is actually proving to be quit=
e
        reliable.
       =20
        I have attached the skas3 patch that Jeff Dike is currently using, =
and
        the patch that you have produced.  Could you please look into the c=
lash
        between them, and get it fixed.
       =20
        Thank you - there are lots out there who will appreciate this.
       =20
        Cheers,
       =20
        Matthew Grant
       =20
        On Mon, 2003-03-17 at 18:39, Ben Pfaff wrote:
        > I am concerned about this change because it will break sandboxing
        > software that I have written, which uses prctl() to turn
        > dumpability back on so that it can open a file, setuid(), and
        > then execve() through the open file via /proc/self/fd/#. Without
        > calling prctl(), the ownership of /proc/self/fd/* becomes root,
        > so the process cannot exec it after it drops privileges. It uses
        > prctl() in other places to get the same effect in /proc, but
        > that's one of the most critical.
       =20
        The dumpability is per mm, which means that you have to consider
        all the cases of a thread being created in parallel to dumpability
        being enabled.
       =20
        So consider a three threaded process. Thread one triggers kernel th=
read
        creation, thread two turns dumpability back on, thread three ptrace=
s
        the new kernel thread.
       =20
        Proving that is safe is non trivial so the current patch chooses no=
t
        to attempt it. For 2.4.21 proper someone can sit down and do the ne=
eded
        verification if they wish=20
       =20
        --=20
        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
        Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz      /~~~~\
        A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******=
\
        =3D=3D=3DGPG KeyID: 2EE20270  FingerPrint:
        8C2535E1A11DF3EA5EA19125BA4E790E2EE20270=3D=3D
       =20
        ___________________________________________________________________=
_____
       =20
        diff -Naur host/arch/i386/config.in host-ptrace/arch/i386/config.in
        --- host/arch/i386/config.in	Fri Aug  9 15:57:14 2002
        +++ host-ptrace/arch/i386/config.in	Sun Nov 10 18:40:09 2002
        @@ -291,6 +291,8 @@
            bool '    Use real mode APM BIOS call to power off' CONFIG_APM_=
REAL_MODE_POWER_OFF
         fi
        =20
        +bool '/proc/mm' CONFIG_PROC_MM
        +
         endmenu
        =20
         source drivers/mtd/Config.in
        diff -Naur host/arch/i386/kernel/ldt.c host-ptrace/arch/i386/kernel=
/ldt.c
        --- host/arch/i386/kernel/ldt.c	Fri Oct 26 00:01:41 2001
        +++ host-ptrace/arch/i386/kernel/ldt.c	Sun Nov  3 18:37:48 2002
        @@ -24,11 +24,12 @@
          * assured by user-space anyway. Writes are atomic, to protect
          * the security checks done on new descriptors.
          */
        -static int read_ldt(void * ptr, unsigned long bytecount)
        +static int read_ldt(struct task_struct *task, void * ptr,=20
        +		    unsigned long bytecount)
         {
         	int err;
         	unsigned long size;
        -	struct mm_struct * mm =3D current->mm;
        +	struct mm_struct * mm =3D task->mm;
        =20
         	err =3D 0;
         	if (!mm->context.segments)
        @@ -64,9 +65,10 @@
         	return err;
         }
        =20
        -static int write_ldt(void * ptr, unsigned long bytecount, int oldm=
ode)
        +static int write_ldt(struct task_struct *task, void * ptr,=20
        +		     unsigned long bytecount, int oldmode)
         {
        -	struct mm_struct * mm =3D current->mm;
        +	struct mm_struct * mm =3D task->mm;
         	__u32 entry_1, entry_2, *lp;
         	int error;
         	struct modify_ldt_ldt_s ldt_info;
        @@ -148,23 +150,29 @@
         	return error;
         }
        =20
        -asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned long b=
ytecount)
        +int modify_ldt(struct task_struct *task, int func, void *ptr,=20
        +	       unsigned long bytecount)
         {
         	int ret =3D -ENOSYS;
        =20
         	switch (func) {
         	case 0:
        -		ret =3D read_ldt(ptr, bytecount);
        +		ret =3D read_ldt(task, ptr, bytecount);
         		break;
         	case 1:
        -		ret =3D write_ldt(ptr, bytecount, 1);
        +		ret =3D write_ldt(task, ptr, bytecount, 1);
         		break;
         	case 2:
         		ret =3D read_default_ldt(ptr, bytecount);
         		break;
         	case 0x11:
        -		ret =3D write_ldt(ptr, bytecount, 0);
        +		ret =3D write_ldt(task, ptr, bytecount, 0);
         		break;
         	}
         	return ret;
        +}
        +
        +asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned long b=
ytecount)
        +{
        +	return(modify_ldt(current, func, ptr, bytecount));
         }
        diff -Naur host/arch/i386/kernel/process.c host-ptrace/arch/i386/ke=
rnel/process.c
        --- host/arch/i386/kernel/process.c	Fri Aug  9 15:57:14 2002
        +++ host-ptrace/arch/i386/kernel/process.c	Wed Nov  6 22:12:45 2002
        @@ -551,13 +551,11 @@
          * we do not have to muck with descriptors here, that is
          * done in switch_mm() as needed.
          */
        -void copy_segments(struct task_struct *p, struct mm_struct *new_mm=
)
        +void mm_copy_segments(struct mm_struct *old_mm, struct mm_struct *=
new_mm)
         {
        -	struct mm_struct * old_mm;
         	void *old_ldt, *ldt;
        =20
         	ldt =3D NULL;
        -	old_mm =3D current->mm;
         	if (old_mm && (old_ldt =3D old_mm->context.segments) !=3D NULL) {
         		/*
         		 * Completely new LDT, we initialize it from the parent:
        @@ -570,6 +568,16 @@
         	}
         	new_mm->context.segments =3D ldt;
         	new_mm->context.cpuvalid =3D ~0UL;	/* valid on all CPU's - they c=
an't have stale data */
        +}
        +
        +void copy_segments(struct task_struct *p, struct mm_struct *new_mm=
)
        +{
        +	mm_copy_segments(current->mm, new_mm);
        +}
        +
        +void copy_task_segments(struct task_struct *from, struct mm_struct=
 *new_mm)
        +{
        +	mm_copy_segments(from->mm, new_mm);
         }
        =20
         /*
        diff -Naur host/arch/i386/kernel/ptrace.c host-ptrace/arch/i386/ker=
nel/ptrace.c
        --- host/arch/i386/kernel/ptrace.c	Fri Aug  9 15:57:14 2002
        +++ host-ptrace/arch/i386/kernel/ptrace.c	Mon Nov 11 19:03:38 2002
        @@ -147,6 +147,11 @@
         	put_stack_long(child, EFL_OFFSET, tmp);
         }
        =20
        +extern int modify_ldt(struct task_struct *task, int func, void *pt=
r,=20
        +		      unsigned long bytecount);
        +
        +extern struct mm_struct *proc_mm_get_mm(int fd);
        +
         asmlinkage int sys_ptrace(long request, long pid, long addr, long =
data)
         {
         	struct task_struct *child;
        @@ -415,6 +420,53 @@
         			child->ptrace |=3D PT_TRACESYSGOOD;
         		else
         			child->ptrace &=3D ~PT_TRACESYSGOOD;
        +		ret =3D 0;
        +		break;
        +	}
        +
        +	case PTRACE_FAULTINFO: {
        +		struct ptrace_faultinfo fault;
        +
        +		fault =3D ((struct ptrace_faultinfo)=20
        +			{ .is_write	=3D child->thread.error_code,
        +			  .addr		=3D child->thread.cr2 });
        +		ret =3D copy_to_user((unsigned long *) data, &fault,=20
        +				   sizeof(fault));
        +		if(ret)
        +			break;
        +		break;
        +	}
        +	case PTRACE_SIGPENDING:
        +		ret =3D copy_to_user((unsigned long *) data,=20
        +				   &child->pending.signal,
        +				   sizeof(child->pending.signal));
        +		break;
        +
        +	case PTRACE_LDT: {
        +		struct ptrace_ldt ldt;
        +
        +		if(copy_from_user(&ldt, (unsigned long *) data,=20
        +				  sizeof(ldt))){
        +			ret =3D -EIO;
        +			break;
        +		}
        +		ret =3D modify_ldt(child, ldt.func, ldt.ptr, ldt.bytecount);
        +		break;
        +	}
        +
        +	case PTRACE_SWITCH_MM: {
        +		struct mm_struct *old =3D child->mm;
        +		struct mm_struct *new =3D proc_mm_get_mm(data);
        +
        +		if(IS_ERR(new)){
        +			ret =3D PTR_ERR(new);
        +			break;
        +		}
        +
        +		atomic_inc(&new->mm_users);
        +		child->mm =3D new;
        +		child->active_mm =3D new;
        +		mmput(old);
         		ret =3D 0;
         		break;
         	}
        diff -Naur host/arch/i386/kernel/sys_i386.c host-ptrace/arch/i386/k=
ernel/sys_i386.c
        --- host/arch/i386/kernel/sys_i386.c	Mon Mar 19 15:35:09 2001
        +++ host-ptrace/arch/i386/kernel/sys_i386.c	Mon Nov 11 17:23:25 200=
2
        @@ -40,7 +40,7 @@
         }
        =20
         /* common code for old and new mmaps */
        -static inline long do_mmap2(
        +long do_mmap2(struct mm_struct *mm,
         	unsigned long addr, unsigned long len,
         	unsigned long prot, unsigned long flags,
         	unsigned long fd, unsigned long pgoff)
        @@ -55,9 +55,9 @@
         			goto out;
         	}
        =20
        -	down_write(&current->mm->mmap_sem);
        -	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
        -	up_write(&current->mm->mmap_sem);
        +	down_write(&mm->mmap_sem);
        +	error =3D do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
        +	up_write(&mm->mmap_sem);
        =20
         	if (file)
         		fput(file);
        @@ -69,7 +69,7 @@
         	unsigned long prot, unsigned long flags,
         	unsigned long fd, unsigned long pgoff)
         {
        -	return do_mmap2(addr, len, prot, flags, fd, pgoff);
        +	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgoff);
         }
        =20
         /*
        @@ -100,7 +100,7 @@
         	if (a.offset & ~PAGE_MASK)
         		goto out;
        =20
        -	err =3D do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >=
> PAGE_SHIFT);
        +	err =3D do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags, a.f=
d, a.offset >> PAGE_SHIFT);
         out:
         	return err;
         }
        diff -Naur host/include/asm-i386/processor.h host-ptrace/include/as=
m-i386/processor.h
        --- host/include/asm-i386/processor.h	Sun Nov 10 18:47:37 2002
        +++ host-ptrace/include/asm-i386/processor.h	Mon Nov 11 17:33:30 20=
02
        @@ -436,6 +436,8 @@
         extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        =20
         /* Copy and release all segment info associated with a VM */
        +extern void mm_copy_segments(struct mm_struct *old_mm,=20
        +			     struct mm_struct *new_mm);
         extern void copy_segments(struct task_struct *p, struct mm_struct =
* mm);
         extern void release_segments(struct mm_struct * mm);
        =20
        diff -Naur host/include/asm-i386/ptrace.h host-ptrace/include/asm-i=
386/ptrace.h
        --- host/include/asm-i386/ptrace.h	Sun Sep 23 19:20:51 2001
        +++ host-ptrace/include/asm-i386/ptrace.h	Sun Nov 10 18:36:22 2002
        @@ -51,6 +51,22 @@
        =20
         #define PTRACE_SETOPTIONS         21
        =20
        +struct ptrace_faultinfo {
        +	int is_write;
        +	unsigned long addr;
        +};
        +
        +struct ptrace_ldt {
        +	int func;
        +  	void *ptr;
        +	unsigned long bytecount;
        +};
        +
        +#define PTRACE_FAULTINFO 52
        +#define PTRACE_SIGPENDING 53
        +#define PTRACE_LDT 54
        +#define PTRACE_SWITCH_MM 55
        +
         /* options set using PTRACE_SETOPTIONS */
         #define PTRACE_O_TRACESYSGOOD     0x00000001
        =20
        diff -Naur host/include/linux/mm.h host-ptrace/include/linux/mm.h
        --- host/include/linux/mm.h	Fri Aug 30 15:03:44 2002
        +++ host-ptrace/include/linux/mm.h	Mon Nov 11 19:08:53 2002
        @@ -492,6 +492,9 @@
         int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, =
unsigned long start,
         		int len, int write, int force, struct page **pages, struct vm_ar=
ea_struct **vmas);
        =20
        +extern long do_mprotect(struct mm_struct *mm, unsigned long start,=
=20
        +			size_t len, unsigned long prot);
        +
         /*
          * On a two-level page table, this ends up being trivial. Thus the
          * inlining and the symmetry break with pte_alloc() that does all
        @@ -539,9 +542,10 @@
        =20
         extern unsigned long get_unmapped_area(struct file *, unsigned lon=
g, unsigned long, unsigned long, unsigned long);
        =20
        -extern unsigned long do_mmap_pgoff(struct file *file, unsigned lon=
g addr,
        -	unsigned long len, unsigned long prot,
        -	unsigned long flag, unsigned long pgoff);
        +extern unsigned long do_mmap_pgoff(struct mm_struct *mm,=20
        +				   struct file *file, unsigned long addr,
        +				   unsigned long len, unsigned long prot,
        +				   unsigned long flag, unsigned long pgoff);
        =20
         static inline unsigned long do_mmap(struct file *file, unsigned lo=
ng addr,
         	unsigned long len, unsigned long prot,
        @@ -551,7 +555,7 @@
         	if ((offset + PAGE_ALIGN(len)) < offset)
         		goto out;
         	if (!(offset & ~PAGE_MASK))
        -		ret =3D do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAG=
E_SHIFT);
        +		ret =3D do_mmap_pgoff(current->mm, file, addr, len, prot, flag, =
offset >> PAGE_SHIFT);
         out:
         	return ret;
         }
        diff -Naur host/include/linux/proc_mm.h host-ptrace/include/linux/p=
roc_mm.h
        --- host/include/linux/proc_mm.h	Wed Dec 31 19:00:00 1969
        +++ host-ptrace/include/linux/proc_mm.h	Mon Nov 11 17:41:09 2002
        @@ -0,0 +1,44 @@
        +/*=20
        + * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
        + * Licensed under the GPL
        + */
        +
        +#ifndef __PROC_MM_H
        +#define __PROC_MM_H
        +
        +#define MM_MMAP 54
        +#define MM_MUNMAP 55
        +#define MM_MPROTECT 56
        +#define MM_COPY_SEGMENTS 57
        +
        +struct mm_mmap {
        +	unsigned long addr;
        +	unsigned long len;
        +	unsigned long prot;
        +	unsigned long flags;
        +	unsigned long fd;
        +	unsigned long offset;
        +};
        +
        +struct mm_munmap {
        +	unsigned long addr;
        +	unsigned long len;=09
        +};
        +
        +struct mm_mprotect {
        +	unsigned long addr;
        +	unsigned long len;
        +        unsigned int prot;
        +};
        +
        +struct proc_mm_op {
        +	int op;
        +	union {
        +		struct mm_mmap mmap;
        +		struct mm_munmap munmap;
        +	        struct mm_mprotect mprotect;
        +		int copy_segments;
        +	} u;
        +};
        +
        +#endif
        diff -Naur host/mm/Makefile host-ptrace/mm/Makefile
        --- host/mm/Makefile	Fri Aug  9 15:57:31 2002
        +++ host-ptrace/mm/Makefile	Sun Nov 10 18:37:33 2002
        @@ -17,5 +17,6 @@
         	    shmem.o
        =20
         obj-$(CONFIG_HIGHMEM) +=3D highmem.o
        +obj-$(CONFIG_PROC_MM) +=3D proc_mm.o
        =20
         include $(TOPDIR)/Rules.make
        diff -Naur host/mm/mmap.c host-ptrace/mm/mmap.c
        --- host/mm/mmap.c	Fri Aug  9 15:57:31 2002
        +++ host-ptrace/mm/mmap.c	Mon Nov 11 17:24:18 2002
        @@ -390,10 +390,11 @@
         	return 0;
         }
        =20
        -unsigned long do_mmap_pgoff(struct file * file, unsigned long addr=
, unsigned long len,
        -	unsigned long prot, unsigned long flags, unsigned long pgoff)
        +unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file * fi=
le,=20
        +			    unsigned long addr, unsigned long len,
        +			    unsigned long prot, unsigned long flags,=20
        +			    unsigned long pgoff)
         {
        -	struct mm_struct * mm =3D current->mm;
         	struct vm_area_struct * vma, * prev;
         	unsigned int vm_flags;
         	int correct_wcount =3D 0;
        diff -Naur host/mm/mprotect.c host-ptrace/mm/mprotect.c
        --- host/mm/mprotect.c	Fri Aug  9 15:57:31 2002
        +++ host-ptrace/mm/mprotect.c	Mon Nov 11 17:47:58 2002
        @@ -264,7 +264,8 @@
         	return 0;
         }
        =20
        -asmlinkage long sys_mprotect(unsigned long start, size_t len, unsi=
gned long prot)
        +long do_mprotect(struct mm_struct *mm, unsigned long start, size_t=
 len,=20
        +		 unsigned long prot)
         {
         	unsigned long nstart, end, tmp;
         	struct vm_area_struct * vma, * next, * prev;
        @@ -281,9 +282,9 @@
         	if (end =3D=3D start)
         		return 0;
        =20
        -	down_write(&current->mm->mmap_sem);
        +	down_write(&mm->mmap_sem);
        =20
        -	vma =3D find_vma_prev(current->mm, start, &prev);
        +	vma =3D find_vma_prev(mm, start, &prev);
         	error =3D -ENOMEM;
         	if (!vma || vma->vm_start > start)
         		goto out;
        @@ -332,6 +333,11 @@
         		prev->vm_mm->map_count--;
         	}
         out:
        -	up_write(&current->mm->mmap_sem);
        +	up_write(&mm->mmap_sem);
         	return error;
        +}
        +
        +asmlinkage long sys_mprotect(unsigned long start, size_t len, unsi=
gned long prot)
        +{
        +	return(do_mprotect(current->mm, start, len, prot));
         }
        diff -Naur host/mm/proc_mm.c host-ptrace/mm/proc_mm.c
        --- host/mm/proc_mm.c	Wed Dec 31 19:00:00 1969
        +++ host-ptrace/mm/proc_mm.c	Mon Nov 11 19:07:52 2002
        @@ -0,0 +1,173 @@
        +/*=20
        + * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
        + * Licensed under the GPL
        + */
        +
        +#include "linux/proc_fs.h"
        +#include "linux/proc_mm.h"
        +#include "linux/file.h"
        +#include "asm/uaccess.h"
        +#include "asm/mmu_context.h"
        +
        +static struct file_operations proc_mm_fops;
        +
        +struct mm_struct *proc_mm_get_mm(int fd)
        +{
        +	struct mm_struct *ret =3D ERR_PTR(-EBADF);
        +	struct file *file;
        +
        +	file =3D fget(fd);
        +	if (!file)
        +		goto out;
        +
        +	ret =3D ERR_PTR(-EINVAL);
        +	if(file->f_op !=3D &proc_mm_fops)
        +		goto out_fput;
        +
        +	ret =3D file->private_data;
        +
        + out_fput:
        +	fput(file);
        + out:
        +	return(ret);
        +}
        +
        +extern long do_mmap2(struct mm_struct *mm, unsigned long addr,=20
        +		     unsigned long len, unsigned long prot,=20
        +		     unsigned long flags, unsigned long fd,
        +		     unsigned long pgoff);
        +
        +static ssize_t write_proc_mm(struct file *file, const char *buffer=
,
        +			     size_t count, loff_t *ppos)
        +{
        +	struct mm_struct *mm =3D file->private_data;
        +	struct proc_mm_op req;
        +	int n, ret;
        +
        +	if(count > sizeof(req))
        +		return(-EINVAL);
        +
        +	n =3D copy_from_user(&req, buffer, count);
        +	if(n !=3D 0)
        +		return(-EFAULT);
        +
        +	ret =3D count;
        +	switch(req.op){
        +	case MM_MMAP: {
        +		struct mm_mmap *map =3D &req.u.mmap;
        +
        +		ret =3D do_mmap2(mm, map->addr, map->len, map->prot,=20
        +			       map->flags, map->fd, map->offset >> PAGE_SHIFT);
        +		if((ret & ~PAGE_MASK) =3D=3D 0)
        +			ret =3D count;
        +=09
        +		break;
        +	}
        +	case MM_MUNMAP: {
        +		struct mm_munmap *unmap =3D &req.u.munmap;
        +
        +		down_write(&mm->mmap_sem);
        +		ret =3D do_munmap(mm, unmap->addr, unmap->len);
        +		up_write(&mm->mmap_sem);
        +
        +		if(ret =3D=3D 0)
        +			ret =3D count;
        +		break;
        +	}
        +	case MM_MPROTECT: {
        +		struct mm_mprotect *protect =3D &req.u.mprotect;
        +
        +		ret =3D do_mprotect(mm, protect->addr, protect->len,=20
        +				  protect->prot);
        +		if(ret =3D=3D 0)
        +			ret =3D count;
        +		break;
        +	}
        +
        +	case MM_COPY_SEGMENTS: {
        +		struct mm_struct *from =3D proc_mm_get_mm(req.u.copy_segments);
        +
        +		if(IS_ERR(from)){
        +			ret =3D PTR_ERR(from);
        +			break;
        +		}
        +
        +		mm_copy_segments(from, mm);
        +		break;
        +	}
        +	default:
        +		ret =3D -EINVAL;
        +		break;
        +	}
        +
        +	return(ret);
        +}
        +
        +static int open_proc_mm(struct inode *inode, struct file *file)
        +{
        +	struct mm_struct *mm =3D mm_alloc();
        +	int ret;
        +
        +	ret =3D -ENOMEM;
        +	if(mm =3D=3D NULL)
        +		goto out_mem;
        +
        +	ret =3D init_new_context(current, mm);
        +	if(ret)
        +		goto out_free;
        +
        +	spin_lock(&mmlist_lock);
        +	list_add(&mm->mmlist, &current->mm->mmlist);
        +	mmlist_nr++;
        +	spin_unlock(&mmlist_lock);
        +
        +	file->private_data =3D mm;
        +
        +	return(0);
        +
        + out_free:
        +	mmput(mm);
        + out_mem:
        +	return(ret);
        +}
        +
        +static int release_proc_mm(struct inode *inode, struct file *file)
        +{
        +	struct mm_struct *mm =3D file->private_data;
        +
        +	mmput(mm);
        +	return(0);
        +}
        +
        +static struct file_operations proc_mm_fops =3D {
        +	.open		=3D open_proc_mm,
        +	.release	=3D release_proc_mm,
        +	.write		=3D write_proc_mm,
        +};
        +
        +static int make_proc_mm(void)
        +{
        +	struct proc_dir_entry *ent;
        +
        +	ent =3D create_proc_entry("mm", 0222, &proc_root);
        +	if(ent =3D=3D NULL){
        +		printk("make_proc_mm : Failed to register /proc/mm\n");
        +		return(0);
        +	}
        +	ent->proc_fops =3D &proc_mm_fops;
        +
        +	return(0);
        +}
        +
        +__initcall(make_proc_mm);
        +
        +/*
        + * Overrides for Emacs so that we follow Linus's tabbing style.
        + * Emacs will notice this stuff at the end of the file and automat=
ically
        + * adjust the settings for this buffer only.  This must remain at =
the end
        + * of the file.
        + * ---------------------------------------------------------------=
------------
        + * Local variables:
        + * c-file-style: "linux"
        + * End:
        + */
       =20
        ___________________________________________________________________=
_____
       =20
                                                                        LWN=
.net Logo=20
       =20
       =20
                                                                        Spo=
nsored Link
       =20
           TrustCommerce
       =20
           E-Commerce & credit card processing - the Open Source way!
             ______________________________________________________________=
_____________________________________________________________________
       =20
           You are not logged in
           Log in now
           Create an account
           Subscribe to LWN
       =20
           Recent Features
       =20
           LWN.net Weekly Edition for March 13, 2003
       =20
           A look at the SCO complaint
       =20
           LWN.net Weekly Edition for March 6, 2003
       =20
           LWN.net Weekly Edition for February 27, 2003
       =20
           LWN.net Weekly Edition for February 20, 2003
       =20
           Printable page
       =20
       =20
               Home      Weekly edition     Archives    Security  Calendar
           Distributions Penguin Gallery Kernel patches  Search   Old site
            LWN.net FAQ   Subscriptions    Advertise    Headlines Privacy
       =20
        Ptrace vulnerability in 2.2 and 2.4 kernels
       =20
           From:   Alan Cox <alan@redhat.com>
           To:   editor@lwn.net, scoop@freshmeat.net, kernel@linuxtoday.com=
, kernel@linuxfr.org, rob@linuxberg.com, chris@linuxdev.net,
           kernel@linuxhq.com, kernel@linuxcare.com, marcelo@conectiva.com.=
br, ac-kernels@tonnikala.net
           Subject:   Ptrace vulnerability in Linux 2.2/2.4
           Date:   Mon, 17 Mar 2003 11:00:16 -0500 (EST)
       =20
        Vulnerability: CAN-2003-0127
       =20
        The Linux 2.2 and Linux 2.4 kernels have a flaw in ptrace. This hol=
e allows
        local users to obtain full privileges. Remote exploitation of this =
hole is
        not possible. Linux 2.5 is not believed to be vulnerable.
       =20
        Linux 2.2.25 has been released to correct Linux 2.2. It contains no=
 other
        changes. The bug fixes that would have been in 2.2.5pre1 will now a=
ppear in
        2.2.26pre1. The patch will apply directly to most older 2.2 release=
s.
       =20
        A patch for Linux 2.4.20/Linux 2.4.21pre is attached. The patch als=
o
        subtly changes the PR_SET_DUMPABLE prctl. We believe this is necces=
sary and
        that it will not affect any software. The functionality change is s=
pecific
        to unusual debugging situations.
       =20
        We would like to thank Andrzej Szombierski who found the problem, a=
nd
        wrote an initial patch. Seth Arnold cleaned up the 2.2 change. Arja=
n van
        de Ven and Ben LaHaise identified additional problems with the orig=
inal
        fix.
       =20
        Alan
       =20
        diff -purN linux.orig/arch/alpha/kernel/entry.S linux/arch/alpha/ke=
rnel/entry.S
        --- linux.orig/arch/alpha/kernel/entry.S        Thu Mar 13 12:01:46=
 2003
        +++ linux/arch/alpha/kernel/entry.S     Thu Mar 13 13:28:49 2003
        @@ -231,12 +231,12 @@ kernel_clone:
         .end   kernel_clone
       =20
         /*
        - * kernel_thread(fn, arg, clone_flags)
        + * arch_kernel_thread(fn, arg, clone_flags)
          */
         .align 3
         .globl kernel_thread
         .ent   kernel_thread
        -kernel_thread:
        +arch_kernel_thread:
                ldgp    $29,0($27)      /* we can be called from a module *=
/
                .frame $30, 4*8, $26
                subq    $30,4*8,$30
        diff -purN linux.orig/arch/arm/kernel/process.c linux/arch/arm/kern=
el/process.c
        --- linux.orig/arch/arm/kernel/process.c        Thu Mar 13 12:01:29=
 2003
        +++ linux/arch/arm/kernel/process.c     Thu Mar 13 13:25:56 2003
        @@ -366,7 +366,7 @@ void dump_thread(struct pt_regs * regs,
          * a system call from a "real" process, but the process memory spa=
ce will
          * not be free'd until both the parent and the child have exited.
          */
        -pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long fl=
ags)
        +pid_t arch_kernel_thread(int (*fn)(void *), void *arg, unsigned lo=
ng flags)
         {
                pid_t __ret;
       =20
        diff -purN linux.orig/arch/cris/kernel/entry.S linux/arch/cris/kern=
el/entry.S
        --- linux.orig/arch/cris/kernel/entry.S Thu Mar 13 12:01:29 2003
        +++ linux/arch/cris/kernel/entry.S      Thu Mar 13 13:30:30 2003
        @@ -736,12 +736,12 @@ hw_bp_trig_ptr:
          * the grosser the code, at least with the gcc version in cris-dis=
t-1.13.
          */
       =20
        -/* int kernel_thread(int (*fn)(void *), void * arg, unsigned long =
flags) */
        +/* int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned =
long flags) */
         /*                   r10                r11         r12  */
       =20
                .text
        -       .global kernel_thread
        -kernel_thread:
        +       .global arch_kernel_thread
        +arch_kernel_thread:
       =20
                /* Save ARG for later.  */
                move.d $r11, $r13
        diff -purN linux.orig/arch/i386/kernel/process.c linux/arch/i386/ke=
rnel/process.c
        --- linux.orig/arch/i386/kernel/process.c       Thu Mar 13 12:01:57=
 2003
        +++ linux/arch/i386/kernel/process.c    Thu Mar 13 13:26:08 2003
        @@ -495,7 +495,7 @@ void release_segments(struct mm_struct *
         /*
          * Create a kernel thread
          */
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                long retval, d0;
       =20
        @@ -518,6 +518,7 @@ int kernel_thread(int (*fn)(void *), voi
                         "r" (arg), "r" (fn),
                         "b" (flags | CLONE_VM)
                        : "memory");
        +
                return retval;
         }
       =20
        diff -purN linux.orig/arch/ia64/kernel/process.c linux/arch/ia64/ke=
rnel/process.c
        --- linux.orig/arch/ia64/kernel/process.c       Thu Mar 13 12:01:29=
 2003
        +++ linux/arch/ia64/kernel/process.c    Thu Mar 13 13:26:15 2003
        @@ -220,7 +220,7 @@ ia64_load_extra (struct task_struct *tas
          *     |                     | <-- sp (lowest addr)
          *     +---------------------+
          *
        - * Note: if we get called through kernel_thread() then the memory
        + * Note: if we get called through arch_kernel_thread() then the me=
mory
          * above "(highest addr)" is valid kernel stack memory that needs =
to
          * be copied as well.
          *
        @@ -469,7 +469,7 @@ ia64_set_personality (struct elf64_hdr *
         }
       =20
         pid_t
        -kernel_thread (int (*fn)(void *), void *arg, unsigned long flags)
        +arch_kernel_thread (int (*fn)(void *), void *arg, unsigned long fl=
ags)
         {
                struct task_struct *parent =3D current;
                int result, tid;
        diff -purN linux.orig/arch/m68k/kernel/process.c linux/arch/m68k/ke=
rnel/process.c
        --- linux.orig/arch/m68k/kernel/process.c       Thu Mar 13 12:01:29=
 2003
        +++ linux/arch/m68k/kernel/process.c    Thu Mar 13 13:26:18 2003
        @@ -124,7 +124,7 @@ void show_regs(struct pt_regs * regs)
         /*
          * Create a kernel thread
          */
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                int pid;
                mm_segment_t fs;
        diff -purN linux.orig/arch/mips/kernel/process.c linux/arch/mips/ke=
rnel/process.c
        --- linux.orig/arch/mips/kernel/process.c       Thu Mar 13 12:01:29=
 2003
        +++ linux/arch/mips/kernel/process.c    Thu Mar 13 13:26:28 2003
        @@ -155,7 +155,7 @@ void dump_thread(struct pt_regs *regs, s
         /*
          * Create a kernel thread
          */
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                long retval;
       =20
        diff -purN linux.orig/arch/mips64/kernel/process.c linux/arch/mips6=
4/kernel/process.c
        --- linux.orig/arch/mips64/kernel/process.c     Thu Mar 13 12:01:29=
 2003
        +++ linux/arch/mips64/kernel/process.c  Thu Mar 13 13:26:23 2003
        @@ -152,7 +152,7 @@ void dump_thread(struct pt_regs *regs, s
         /*
          * Create a kernel thread
          */
        -int kernel_thread(int (*fn)(void *), void *arg, unsigned long flag=
s)
        +int arch_kernel_thread(int (*fn)(void *), void *arg, unsigned long=
 flags)
         {
                int retval;
       =20
        diff -purN linux.orig/arch/parisc/kernel/process.c linux/arch/paris=
c/kernel/process.c
        --- linux.orig/arch/parisc/kernel/process.c     Fri Feb  9 14:29:44=
 2001
        +++ linux/arch/parisc/kernel/process.c  Thu Mar 13 13:26:36 2003
        @@ -118,7 +118,7 @@ void machine_heartbeat(void)
          */
       =20
         extern pid_t __kernel_thread(int (*fn)(void *), void *arg, unsigne=
d long flags);
        -pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long fl=
ags)
        +pid_t arch_kernel_thread(int (*fn)(void *), void *arg, unsigned lo=
ng flags)
         {
       =20
                /*
        diff -purN linux.orig/arch/ppc/kernel/misc.S linux/arch/ppc/kernel/=
misc.S
        --- linux.orig/arch/ppc/kernel/misc.S   Thu Mar 13 12:01:29 2003
        +++ linux/arch/ppc/kernel/misc.S        Thu Mar 13 13:32:21 2003
        @@ -899,9 +899,9 @@ _GLOBAL(cvt_df)
       =20
         /*
          * Create a kernel thread
        - *   kernel_thread(fn, arg, flags)
        + *   arch_kernel_thread(fn, arg, flags)
          */
        -_GLOBAL(kernel_thread)
        +_GLOBAL(arch_kernel_thread)
                mr      r6,r3           /* function */
                ori     r3,r5,CLONE_VM  /* flags */
                li      r0,__NR_clone
        diff -purN linux.orig/arch/ppc64/kernel/misc.S linux/arch/ppc64/ker=
nel/misc.S
        --- linux.orig/arch/ppc64/kernel/misc.S Thu Mar 13 12:01:30 2003
        +++ linux/arch/ppc64/kernel/misc.S      Thu Mar 13 13:29:42 2003
        @@ -493,9 +493,9 @@ _GLOBAL(cvt_df)
       =20
         /*
          * Create a kernel thread
        - *   kernel_thread(fn, arg, flags)
        + *   arch_kernel_thread(fn, arg, flags)
          */
        -_GLOBAL(kernel_thread)
        +_GLOBAL(arch_kernel_thread)
                mr      r6,r3           /* function */
                ori     r3,r5,CLONE_VM  /* flags */
                li      r0,__NR_clone
        diff -purN linux.orig/arch/s390/kernel/process.c linux/arch/s390/ke=
rnel/process.c
        --- linux.orig/arch/s390/kernel/process.c       Thu Mar 13 12:01:30=
 2003
        +++ linux/arch/s390/kernel/process.c    Thu Mar 13 13:26:43 2003
        @@ -105,7 +105,7 @@ void show_regs(struct pt_regs *regs)
                        show_trace((unsigned long *) regs->gprs[15]);
         }
       =20
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                 int clone_arg =3D flags | CLONE_VM;
                 int retval;
        diff -purN linux.orig/arch/s390x/kernel/process.c linux/arch/s390x/=
kernel/process.c
        --- linux.orig/arch/s390x/kernel/process.c      Thu Mar 13 12:01:30=
 2003
        +++ linux/arch/s390x/kernel/process.c   Thu Mar 13 13:26:46 2003
        @@ -102,7 +102,7 @@ void show_regs(struct pt_regs *regs)
                        show_trace((unsigned long *) regs->gprs[15]);
         }
       =20
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                 int clone_arg =3D flags | CLONE_VM;
                 int retval;
        diff -purN linux.orig/arch/sh/kernel/process.c linux/arch/sh/kernel=
/process.c
        --- linux.orig/arch/sh/kernel/process.c Mon Oct 15 16:36:48 2001
        +++ linux/arch/sh/kernel/process.c      Thu Mar 13 13:26:49 2003
        @@ -118,7 +118,7 @@ void free_task_struct(struct task_struct
          * This is the mechanism for creating a new kernel thread.
          *
          */
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {      /* Don't use this in BL=3D1(cli).  Or else, CPU resets! */
                register unsigned long __sc0 __asm__ ("r0");
                register unsigned long __sc3 __asm__ ("r3") =3D __NR_clone;
        diff -purN linux.orig/arch/sparc/kernel/process.c linux/arch/sparc/=
kernel/process.c
        --- linux.orig/arch/sparc/kernel/process.c      Thu Mar 13 12:01:30=
 2003
        +++ linux/arch/sparc/kernel/process.c   Thu Mar 13 13:26:58 2003
        @@ -676,7 +676,7 @@ out:
          * a system call from a "real" process, but the process memory spa=
ce will
          * not be free'd until both the parent and the child have exited.
          */
        -pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long f=
lags)
        +pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags)
         {
                long retval;
       =20
        diff -purN linux.orig/arch/sparc64/kernel/process.c linux/arch/spar=
c64/kernel/process.c
        --- linux.orig/arch/sparc64/kernel/process.c    Thu Mar 13 12:01:30=
 2003
        +++ linux/arch/sparc64/kernel/process.c Thu Mar 13 13:26:54 2003
        @@ -658,7 +658,7 @@ int copy_thread(int nr, unsigned long cl
          * a system call from a "real" process, but the process memory spa=
ce will
          * not be free'd until both the parent and the child have exited.
          */
        -pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long f=
lags)
        +pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags)
         {
                long retval;
       =20
        diff -purN linux.orig/arch/um/kernel/process_kern.c linux/arch/um/k=
ernel/process_kern.c
        --- linux.orig/arch/um/kernel/process_kern.c    Thu Mar 13 12:01:48=
 2003
        +++ linux/arch/um/kernel/process_kern.c Thu Mar 13 13:27:37 2003
        @@ -171,14 +171,14 @@ static int new_thread_proc(void *stack)
                os_usr1_process(os_getpid());
         }
       =20
        -int kernel_thread(int (*fn)(void *), void * arg, unsigned long fla=
gs)
        +int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned lon=
g flags)
         {
                int pid;
       =20
                current->thread.request.u.thread.proc =3D fn;
                current->thread.request.u.thread.arg =3D arg;
                pid =3D do_fork(CLONE_VM | flags, 0, NULL, 0);
        -       if(pid < 0) panic("do_fork failed in kernel_thread");
        +       if(pid < 0) panic("do_fork failed in arch_kernel_thread");
                return(pid);
         }
       =20
        diff -purN linux.orig/fs/exec.c linux/fs/exec.c
        --- linux.orig/fs/exec.c        Thu Mar 13 12:01:46 2003
        +++ linux/fs/exec.c     Thu Mar 13 14:19:08 2003
        @@ -559,8 +559,10 @@ int flush_old_exec(struct linux_binprm *
       =20
                current->sas_ss_sp =3D current->sas_ss_size =3D 0;
       =20
        -       if (current->euid =3D=3D current->uid && current->egid =3D=
=3D current->gid)
        +       if (current->euid =3D=3D current->uid && current->egid =3D=
=3D current->gid) {
                        current->mm->dumpable =3D 1;
        +               current->task_dumpable =3D 1;
        +       }
                name =3D bprm->filename;
                for (i=3D0; (ch =3D *(name++)) !=3D '\0';) {
                        if (ch =3D=3D '/')
        @@ -952,7 +954,7 @@ int do_coredump(long signr, struct pt_re
                binfmt =3D current->binfmt;
                if (!binfmt || !binfmt->core_dump)
                        goto fail;
        -       if (!current->mm->dumpable)
        +       if (!is_dumpable(current))
                        goto fail;
                current->mm->dumpable =3D 0;
                if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_cored=
ump)
        diff -purN linux.orig/include/asm-alpha/processor.h linux/include/a=
sm-alpha/processor.h
        --- linux.orig/include/asm-alpha/processor.h    Fri Oct  5 15:11:05=
 2001
        +++ linux/include/asm-alpha/processor.h Thu Mar 13 13:35:18 2003
        @@ -119,7 +119,7 @@ struct task_struct;
         extern void release_thread(struct task_struct *);
       =20
         /* Create a kernel thread without removing it from tasklists.  */
        -extern long kernel_thread(int (*fn)(void *), void *arg, unsigned l=
ong flags);
        +extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsig=
ned long flags);
       =20
         #define copy_segments(tsk, mm)         do { } while (0)
         #define release_segments(mm)           do { } while (0)
        diff -purN linux.orig/include/asm-arm/processor.h linux/include/asm=
-arm/processor.h
        --- linux.orig/include/asm-arm/processor.h      Thu Mar 13 12:01:35=
 2003
        +++ linux/include/asm-arm/processor.h   Thu Mar 13 13:35:18 2003
        @@ -117,7 +117,7 @@ extern void __free_task_struct(struct ta
         /*
          * Create a new kernel thread
          */
        -extern int kernel_thread(int (*fn)(void *), void *arg, unsigned lo=
ng flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void *arg, unsign=
ed long flags);
       =20
         #endif
       =20
        diff -purN linux.orig/include/asm-cris/processor.h linux/include/as=
m-cris/processor.h
        --- linux.orig/include/asm-cris/processor.h     Thu Mar 13 12:01:35=
 2003
        +++ linux/include/asm-cris/processor.h  Thu Mar 13 13:35:18 2003
        @@ -81,7 +81,7 @@ struct thread_struct {
         #define INIT_THREAD  { \
            0, 0, 0x20 }  /* ccr =3D int enable, nothing else */
       =20
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* give the thread a program location
          * set user-mode (The 'U' flag (User mode flag) is CCR/DCCR bit 8)
        diff -purN linux.orig/include/asm-i386/processor.h linux/include/as=
m-i386/processor.h
        --- linux.orig/include/asm-i386/processor.h     Thu Mar 13 12:01:57=
 2003
        +++ linux/include/asm-i386/processor.h  Thu Mar 13 13:51:02 2003
        @@ -433,7 +433,7 @@ extern void release_thread(struct task_s
         /*
          * create a kernel thread without removing it from tasklists
          */
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         extern void copy_segments(struct task_struct *p, struct mm_struct =
* mm);
        diff -purN linux.orig/include/asm-ia64/processor.h linux/include/as=
m-ia64/processor.h
        --- linux.orig/include/asm-ia64/processor.h     Thu Mar 13 12:01:35=
 2003
        +++ linux/include/asm-ia64/processor.h  Thu Mar 13 13:35:18 2003
        @@ -476,7 +476,7 @@ struct task_struct;
          * do_basic_setup() and the timing is such that free_initmem() has
          * been called already.
          */
        -extern int kernel_thread (int (*fn)(void *), void *arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread (int (*fn)(void *), void *arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         #define copy_segments(tsk, mm)                 do { } while (0)
        diff -purN linux.orig/include/asm-m68k/processor.h linux/include/as=
m-m68k/processor.h
        --- linux.orig/include/asm-m68k/processor.h     Fri Oct  5 15:11:05=
 2001
        +++ linux/include/asm-m68k/processor.h  Thu Mar 13 13:35:18 2003
        @@ -105,7 +105,7 @@ static inline void release_thread(struct
         {
         }
       =20
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         #define copy_segments(tsk, mm)         do { } while (0)
         #define release_segments(mm)           do { } while (0)
        diff -purN linux.orig/include/asm-mips/processor.h linux/include/as=
m-mips/processor.h
        --- linux.orig/include/asm-mips/processor.h     Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-mips/processor.h  Thu Mar 13 13:35:18 2003
        @@ -186,7 +186,7 @@ struct thread_struct {
         /* Free all resources held by a thread. */
         #define release_thread(thread) do { } while(0)
       =20
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         #define copy_segments(p, mm) do { } while(0)
        diff -purN linux.orig/include/asm-mips64/processor.h linux/include/=
asm-mips64/processor.h
        --- linux.orig/include/asm-mips64/processor.h   Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-mips64/processor.h        Thu Mar 13 13:35:18=
 2003
        @@ -245,7 +245,7 @@ struct thread_struct {
         /* Free all resources held by a thread. */
         #define release_thread(thread) do { } while(0)
       =20
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         #define copy_segments(p, mm) do { } while(0)
        diff -purN linux.orig/include/asm-parisc/processor.h linux/include/=
asm-parisc/processor.h
        --- linux.orig/include/asm-parisc/processor.h   Fri Oct  5 15:11:05=
 2001
        +++ linux/include/asm-parisc/processor.h        Thu Mar 13 13:35:18=
 2003
        @@ -305,7 +305,7 @@ struct task_struct;
       =20
         /* Free all resources held by a thread. */
         extern void release_thread(struct task_struct *);
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         #define copy_segments(tsk, mm) do { } while (0)
         #define release_segments(mm)   do { } while (0)
        diff -purN linux.orig/include/asm-ppc/processor.h linux/include/asm=
-ppc/processor.h
        --- linux.orig/include/asm-ppc/processor.h      Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-ppc/processor.h   Thu Mar 13 13:35:18 2003
        @@ -593,7 +593,7 @@ void release_thread(struct task_struct *
         /*
          * Create a new kernel thread.
          */
        -extern long kernel_thread(int (*fn)(void *), void *arg, unsigned l=
ong flags);
        +extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsig=
ned long flags);
       =20
         /*
          * Bus types
        diff -purN linux.orig/include/asm-ppc64/processor.h linux/include/a=
sm-ppc64/processor.h
        --- linux.orig/include/asm-ppc64/processor.h    Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-ppc64/processor.h Thu Mar 13 13:35:18 2003
        @@ -609,7 +609,7 @@ void release_thread(struct task_struct *
         /*
          * Create a new kernel thread.
          */
        -extern long kernel_thread(int (*fn)(void *), void *arg, unsigned l=
ong flags);
        +extern long arch_kernel_thread(int (*fn)(void *), void *arg, unsig=
ned long flags);
       =20
         /*
          * Bus types
        diff -purN linux.orig/include/asm-s390/processor.h linux/include/as=
m-s390/processor.h
        --- linux.orig/include/asm-s390/processor.h     Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-s390/processor.h  Thu Mar 13 13:35:18 2003
        @@ -113,7 +113,7 @@ struct mm_struct;
       =20
         /* Free all resources held by a thread. */
         extern void release_thread(struct task_struct *);
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         #define copy_segments(nr, mm)           do { } while (0)
        diff -purN linux.orig/include/asm-s390x/processor.h linux/include/a=
sm-s390x/processor.h
        --- linux.orig/include/asm-s390x/processor.h    Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-s390x/processor.h Thu Mar 13 13:35:18 2003
        @@ -127,7 +127,7 @@ struct mm_struct;
       =20
         /* Free all resources held by a thread. */
         extern void release_thread(struct task_struct *);
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /* Copy and release all segment info associated with a VM */
         #define copy_segments(nr, mm)           do { } while (0)
        diff -purN linux.orig/include/asm-sh/processor.h linux/include/asm-=
sh/processor.h
        --- linux.orig/include/asm-sh/processor.h       Fri Oct  5 15:11:05=
 2001
        +++ linux/include/asm-sh/processor.h    Thu Mar 13 13:35:18 2003
        @@ -137,7 +137,7 @@ extern void release_thread(struct task_s
         /*
          * create a kernel thread without removing it from tasklists
          */
        -extern int kernel_thread(int (*fn)(void *), void * arg, unsigned l=
ong flags);
        +extern int arch_kernel_thread(int (*fn)(void *), void * arg, unsig=
ned long flags);
       =20
         /*
          * Bus types
        diff -purN linux.orig/include/asm-sparc/processor.h linux/include/a=
sm-sparc/processor.h
        --- linux.orig/include/asm-sparc/processor.h    Thu Oct 11 02:42:47=
 2001
        +++ linux/include/asm-sparc/processor.h Thu Mar 13 13:35:18 2003
        @@ -146,7 +146,7 @@ extern __inline__ void start_thread(stru
       =20
         /* Free all resources held by a thread. */
         #define release_thread(tsk)            do { } while(0)
        -extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned=
 long flags);
        +extern pid_t arch_kernel_thread(int (*fn)(void *), void * arg, uns=
igned long flags);
       =20
       =20
         #define copy_segments(tsk, mm)         do { } while (0)
        diff -purN linux.orig/include/asm-sparc64/processor.h linux/include=
/asm-sparc64/processor.h
        --- linux.orig/include/asm-sparc64/processor.h  Thu Mar 13 12:01:36=
 2003
        +++ linux/include/asm-sparc64/processor.h       Thu Mar 13 13:35:18=
 2003
        @@ -270,7 +270,7 @@ do { \
         /* Free all resources held by a thread. */
         #define release_thread(tsk)            do { } while(0)
       =20
        -extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned=
 long flags);
        +extern pid_t arch_kernel_thread(int (*fn)(void *), void * arg, uns=
igned long flags);
       =20
         #define copy_segments(tsk, mm)         do { } while (0)
         #define release_segments(mm)           do { } while (0)
        diff -purN linux.orig/include/linux/sched.h linux/include/linux/sch=
ed.h
        --- linux.orig/include/linux/sched.h    Thu Mar 13 12:01:57 2003
        +++ linux/include/linux/sched.h Thu Mar 13 13:54:05 2003
        @@ -362,6 +362,7 @@ struct task_struct {
                /* ??? */
                unsigned long personality;
                int did_exec:1;
        +       unsigned task_dumpable:1;
                pid_t pid;
                pid_t pgrp;
                pid_t tty_old_pgrp;
        @@ -485,6 +486,8 @@ struct task_struct {
         #define PT_TRACESYSGOOD        0x00000008
         #define PT_PTRACE_CAP  0x00000010      /* ptracer can follow suid-=
exec */
       =20
        +#define is_dumpable(tsk)       ((tsk)->task_dumpable && (tsk)->mm-=
>dumpable)
        +
         /*
          * Limit the stack by to some sane default: root can always
          * increase this limit if needed..  8MB seems reasonable.
        @@ -848,6 +851,8 @@ extern void FASTCALL(remove_wait_queue(w
       =20
         extern void wait_task_inactive(task_t * p);
         extern void kick_if_running(task_t * p);
        +extern long kernel_thread(int (*fn)(void *), void * arg, unsigned =
long flags);
        +
       =20
         #define __wait_event(wq, condition)                               =
     \
         do {                                                              =
     \
        diff -purN linux.orig/kernel/fork.c linux/kernel/fork.c
        --- linux.orig/kernel/fork.c    Thu Mar 13 12:01:57 2003
        +++ linux/kernel/fork.c Thu Mar 13 13:51:24 2003
        @@ -28,6 +28,7 @@
         #include <asm/pgalloc.h>
         #include <asm/uaccess.h>
         #include <asm/mmu_context.h>
        +#include <asm/processor.h>
       =20
         /* The idle threads do not count.. */
         int nr_threads;
        @@ -575,6 +576,31 @@ static inline void copy_flags(unsigned l
                p->flags =3D new_flags;
         }
       =20
        +long kernel_thread(int (*fn)(void *), void * arg, unsigned long fl=
ags)
        +{
        +       struct task_struct *task =3D current;
        +       unsigned old_task_dumpable;
        +       long ret;
        +
        +       /* lock out any potential ptracer */
        +       task_lock(task);
        +       if (task->ptrace) {
        +               task_unlock(task);
        +               return -EPERM;
        +       }
        +
        +       old_task_dumpable =3D task->task_dumpable;
        +       task->task_dumpable =3D 0;
        +       task_unlock(task);
        +
        +       ret =3D arch_kernel_thread(fn, arg, flags);
        +
        +       /* never reached in child process, only in parent */
        +       current->task_dumpable =3D old_task_dumpable;
        +
        +       return ret;
        +}
        +
         /*
          *  Ok, this is the main fork-routine. It copies the system proces=
s
          * information (task[nr]) and sets up the necessary registers. It =
also
        diff -purN linux.orig/kernel/ptrace.c linux/kernel/ptrace.c
        --- linux.orig/kernel/ptrace.c  Thu Mar 13 12:01:46 2003
        +++ linux/kernel/ptrace.c       Thu Mar 13 13:47:16 2003
        @@ -21,6 +21,10 @@
          */
         int ptrace_check_attach(struct task_struct *child, int kill)
         {
        +       mb();
        +       if (!is_dumpable(child))
        +               return -EPERM;
        +
                if (!(child->ptrace & PT_PTRACED))
                        return -ESRCH;
       =20
        @@ -57,7 +61,7 @@ int ptrace_attach(struct task_struct *ta
                    (current->gid !=3D task->gid)) && !capable(CAP_SYS_PTRA=
CE))
                        goto bad;
                rmb();
        -       if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
        +       if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
                        goto bad;
                /* the same process cannot be attached many times */
                if (task->ptrace & PT_PTRACED)
        @@ -123,6 +127,8 @@ int access_process_vm(struct task_struct
                /* Worry about races with exit() */
                task_lock(tsk);
                mm =3D tsk->mm;
        +       if (!is_dumpable(tsk) || (&init_mm =3D=3D mm))
        +               mm =3D NULL;
                if (mm)
                        atomic_inc(&mm->mm_users);
                task_unlock(tsk);
        diff -purN linux.orig/kernel/sys.c linux/kernel/sys.c
        --- linux.orig/kernel/sys.c     Thu Mar 13 12:01:57 2003
        +++ linux/kernel/sys.c  Thu Mar 13 13:41:25 2003
        @@ -1286,7 +1286,7 @@ asmlinkage long sys_prctl(int option, un
                                error =3D put_user(current->pdeath_signal, =
(int *)arg2);
                                break;
                        case PR_GET_DUMPABLE:
        -                       if (current->mm->dumpable)
        +                       if (is_dumpable(current))
                                        error =3D 1;
                                break;
                        case PR_SET_DUMPABLE:
        @@ -1294,7 +1294,8 @@ asmlinkage long sys_prctl(int option, un
                                        error =3D -EINVAL;
                                        break;
                                }
        -                       current->mm->dumpable =3D arg2;
        +                       if (is_dumpable(current))
        +                               current->mm->dumpable =3D arg2;
                                break;
                        case PR_SET_UNALIGN:
         #ifdef SET_UNALIGN_CTL
           ________________________________________________________________=
_________________
       =20
           No comments have been posted. Log in to post comments.
       =20
                                                              Copyright (=
=A9) 2003, Eklektix, Inc.
                                                    Linux (=AE) is a regist=
ered trademark of Linus Torvalds
                                                            Web hosting pro=
vided by Rackspace.com.
        --=20
        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
        Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz      /~~~~\
        A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******=
\
        =3D=3D=3DGPG KeyID: 2EE20270  FingerPrint:
        8C2535E1A11DF3EA5EA19125BA4E790E2EE20270=3D=3D
       =20
       =20
   =20
   =20

--=-Mavoo7F9/SUsa63mKUFJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+ePJ5uk55Di7iAnARAvotAJ0R6+HN44HpdY+Ev3T6ufutV+/uiQCfS1CW
ZU/8Thb2IpiERl85b7qItCg=
=upg7
-----END PGP SIGNATURE-----

--=-Mavoo7F9/SUsa63mKUFJ--

