Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273798AbRIXEzv>; Mon, 24 Sep 2001 00:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273797AbRIXEzn>; Mon, 24 Sep 2001 00:55:43 -0400
Received: from ir.com.au ([203.202.109.33]:42727 "EHLO ir_nt_server2.ir.com.au")
	by vger.kernel.org with ESMTP id <S273796AbRIXEzb>;
	Mon, 24 Sep 2001 00:55:31 -0400
Message-ID: <C0D2F5944500D411AD8A00104B31930E8D409B@ir_nt_server2>
From: Tony.Young@ir.com
To: linux-kernel@vger.kernel.org
Subject: FW: trapping syscall problem - kernel module
Date: Mon, 24 Sep 2001 14:55:51 +1000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C144B5.2EF5E200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C144B5.2EF5E200
Content-Type: text/plain;
	charset="ISO-8859-1"

If anyone here can help with the attached problem I'd appreciate it.
Please CC any responses to me as I'm not on the list.

TIA
Tony...

>  -----Original Message-----
> From: 	Tony Young  
> Sent:	Friday, 21 September 2001 17:24
> To:	'slug@slug.org.au'
> Subject:	trapping syscall problem - kernel module
> 
> 
> This is a question for those kernel hackers on the list that 
> know about developing modules to trap/intercept system calls.
> 
> I'm trying to develop a module that detects calls to 
> fork/vfork, execve and exit to track processes on the system. 
> I've implemented a module that will do this on Solaris - it 
> was relatively simple. However I'm having trouble 
> implementing a similar module on Linux.
> 
> I've attached my source code and makefile - it should be safe 
> to compile and load. But I make no guarantees. I've been 
> testing and developing it on a 2.4.8 kernel - single 
> cpu(Mandrake 8.1 beta).
>  <<syscall.c>>  <<makefile>> 
> The module is fairly basic. It replaces each system call with 
> my own that just displays some information using printk and 
> calls the original.
> The fork, vfork and exit replacements work fine. But I'm 
> having trouble with execve.
> 
> With the implementation in the code that's currently enabled 
> (inside #if 1 in newexecve()) any execve results in the 
> calling process core dumping. The printk's before and after 
> the call to oldexecve work which implies that the execve 
> actually worked. But something appears to be going wrong 
> returning from the function.
> 
> This implementation is similar to the implementation of my 
> Solaris module. After failure on linux though I went looking 
> for alternatives and found another way of doing it which 
> basically just bypasses the sys_execve(oldexecve) syscall 
> entirely, calling do_execve itself. This method, as expected, 
> works. However, if the implementation of sys_execve ever 
> changes I'll need to change my implementation to match - I'd 
> rather leverage of sys_execve if at all possible.
> 
> So I guess what I'm asking is why my implementation doesn't 
> work? I'm guessing that something's going on with 
> sys_execve's use of the registers that's somehow trashing the 
> stack or return pointer when used my way but I'm not sure.
> 
> I haven't yet tried the kernel debugger to see what's going 
> on - simply because I've never used it before.
> 
> Any help anyone could provide would be great.
> 
> Thanks.
> Tony...
> 
> --
> Tony Young
> Senior Software Engineer
> Integrated Research Limited
> Level 10, 168 Walker St
> North Sydney, NSW 2060, Australia
> Ph:  +61 2 9966 1066
> Fax: +61 2 9966 1042
> 

------_=_NextPart_000_01C144B5.2EF5E200
Content-Type: application/octet-stream;
	name="syscall.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syscall.c"

/*=0A=
 * syscall.c=0A=
 *=0A=
 * gcc -D__KERNEL__ -DMODULE -c syscall.o syscall.c=0A=
 */=0A=
=0A=
#include <linux/module.h>=0A=
#include <linux/kernel.h>     /* printk */=0A=
#include <sys/syscall.h>      /* SYS_... */=0A=
#include <linux/sched.h>      /* task_struct */=0A=
#include <asm/current.h>      /* current */=0A=
#include <asm/errno.h>=0A=
#include <asm/smplock.h>=0A=
#include <linux/slab.h>=0A=
=0A=
int errno;=0A=
=0A=
/*=0A=
 * SYS_exit      1=0A=
 * SYS_fork      2=0A=
 * SYS_vfork     190=0A=
 * SYS_execve    11=0A=
 */=0A=
=0A=
extern void*   sys_call_table[];=0A=
=0A=
asmlinkage int (*oldfork)(struct pt_regs regs);=0A=
asmlinkage int (*oldvfork)(struct pt_regs regs);=0A=
asmlinkage int (*oldexecve)(struct pt_regs regs);=0A=
asmlinkage void (*oldexit)(int rc);=0A=
=0A=
asmlinkage int newfork(struct pt_regs regs)=0A=
{=0A=
   int childpid;=0A=
=0A=
   printk(KERN_DEBUG "newfork: fork called by PID %ld (%s)\n", =
current->pid, current->comm);=0A=
   childpid =3D oldfork(regs);=0A=
   if (childpid !=3D -1)=0A=
      printk(KERN_DEBUG "newfork: process PID %ld (%s) created child =
%ld\n", current->pid, current->comm, childpid);=0A=
   else=0A=
      printk(KERN_DEBUG "newfork: process PID %ld (%s) failed to create =
child\n", current->pid, current->comm);=0A=
   return childpid;=0A=
}=0A=
=0A=
asmlinkage int newvfork(struct pt_regs regs)=0A=
{=0A=
   int childpid;=0A=
=0A=
   printk(KERN_DEBUG "newvfork: vfork called by PID %ld (%s)\n", =
current->pid, current->comm);=0A=
   childpid =3D oldvfork(regs);=0A=
   if (childpid !=3D -1)=0A=
      printk(KERN_DEBUG "newvfork: process PID %ld (%s) created child =
%ld\n", current->pid, current->comm, childpid);=0A=
   else=0A=
      printk(KERN_DEBUG "newvfork: process PID %ld (%s) failed to =
create child\n", current->pid, current->comm);=0A=
   return childpid;=0A=
}=0A=
=0A=
asmlinkage int newexecve(struct pt_regs regs)=0A=
{=0A=
   int rc;=0A=
   /* From modexecvehash */=0A=
   char *filename;=0A=
=0A=
   printk(KERN_DEBUG "newexecve: execve called by PID %ld (%s) - =
%lp\n", current->pid, current->comm, oldexecve);=0A=
#if 0=0A=
   lock_kernel();=0A=
   filename =3D getname((char*)regs.ebx);=0A=
   rc =3D PTR_ERR(filename);=0A=
   if (!IS_ERR(filename))=0A=
   {=0A=
      rc =3D do_execve(filename, (char **)regs.ecx, (char **)regs.edx, =
&regs);=0A=
      if (rc =3D=3D 0)=0A=
      {=0A=
         current->ptrace &=3D ~PT_DTRACE;=0A=
         printk(KERN_DEBUG "newexecve: process PID %ld execve'd =
(%s)\n", current->pid, current->comm);=0A=
      }=0A=
      else=0A=
         printk(KERN_DEBUG "newexecve: process PID %ld failed to execve =
(%s) - rc =3D %d\n", current->pid, filename, rc);=0A=
      unlock_kernel();=0A=
      putname(filename);=0A=
   }=0A=
#endif=0A=
#if 1=0A=
   rc =3D oldexecve(regs);=0A=
   if (rc =3D=3D 0)=0A=
      printk(KERN_DEBUG "newexecve: process PID %ld execve'd (%s)\n", =
current->pid, current->comm);=0A=
   else=0A=
      printk(KERN_DEBUG "newexecve: process PID %ld failed to execve - =
rc =3D %d\n", current->pid, rc);=0A=
#endif=0A=
=0A=
   /* restore the original execve so that if ours breaks down=0A=
    * we can still create processes and not make the system unusable=0A=
    */=0A=
   sys_call_table[SYS_execve] =3D oldexecve;=0A=
   printk(KERN_DEBUG "cleanup_module: old execve syscall =
restored\n");=0A=
   return rc;=0A=
}=0A=
=0A=
asmlinkage void newexit(int rc)=0A=
{=0A=
   printk(KERN_DEBUG "newexit: exit called by PID %ld (%s) with rc =
%d\n", current->pid, current->comm, rc);=0A=
   oldexit(rc);=0A=
}=0A=
=0A=
int init_module()=0A=
{=0A=
   printk(KERN_DEBUG "init_module: syscall mod loaded\n");=0A=
   //sys_call_table_addr =3D (func_ptr**)sys_call_table;=0A=
=0A=
   oldfork =3D (int(*)())sys_call_table[SYS_fork];=0A=
   sys_call_table[SYS_fork] =3D newfork;=0A=
   printk(KERN_DEBUG "init_module: fork syscall replaced\n");=0A=
=0A=
   oldvfork =3D (int(*)())sys_call_table[SYS_vfork];=0A=
   sys_call_table[SYS_vfork] =3D newvfork;=0A=
   printk(KERN_DEBUG "init_module: vfork syscall replaced\n");=0A=
=0A=
   oldexecve =3D (int(*)())sys_call_table[SYS_execve];=0A=
   sys_call_table[SYS_execve] =3D newexecve;=0A=
   printk(KERN_DEBUG "init_module: execve syscall replaced\n");=0A=
=0A=
   oldexit =3D (void(*)())sys_call_table[SYS_exit];=0A=
   sys_call_table[SYS_exit] =3D newexit;=0A=
   printk(KERN_DEBUG "init_module: exit syscall replaced\n");=0A=
=0A=
   return 0;=0A=
}=0A=
=0A=
void cleanup_module()=0A=
{=0A=
   sys_call_table[SYS_fork] =3D oldfork;=0A=
   printk(KERN_DEBUG "cleanup_module: old fork syscall restored\n");=0A=
=0A=
   sys_call_table[SYS_vfork] =3D oldvfork;=0A=
   printk(KERN_DEBUG "cleanup_module: old vfork syscall =
restored\n");=0A=
=0A=
   sys_call_table[SYS_execve] =3D oldexecve;=0A=
   printk(KERN_DEBUG "cleanup_module: old execve syscall =
restored\n");=0A=
=0A=
   sys_call_table[SYS_exit] =3D oldexit;=0A=
   printk(KERN_DEBUG "cleanup_module: old exit syscall restored\n");=0A=
=0A=
   printk(KERN_DEBUG "cleanup_module: syscall mod removed\n");=0A=
}=0A=
=0A=

------_=_NextPart_000_01C144B5.2EF5E200
Content-Type: application/octet-stream;
	name="makefile"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="makefile"

CFLAGS=3D-D__KERNEL__ -DMODULE -O -g=0A=
CC=3Dgcc=0A=
=0A=
all: clean syscall.o=0A=
=0A=
clean:=0A=
	rm -f syscall.o=0A=
=0A=
in:=0A=
	sudo insmod ./syscall.o=0A=
=0A=
out:=0A=
	sudo rmmod syscall=0A=
=0A=

------_=_NextPart_000_01C144B5.2EF5E200--
