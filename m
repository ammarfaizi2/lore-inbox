Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbTKZVh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTKZVh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:37:56 -0500
Received: from [65.248.4.67] ([65.248.4.67]:40681 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S264345AbTKZVht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:37:49 -0500
Message-ID: <001201c3b465$8e979060$34dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22 fs/exec
Date: Wed, 26 Nov 2003 19:31:51 -0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C3B453.F0E48820"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C3B453.F0E48820
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit



------=_NextPart_000_0007_01C3B453.F0E48820
Content-Type: application/octet-stream;
	name="exec.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="exec.patch"

--- exec-original.c	Tue Oct 14 16:40:12 2003=0A=
+++ exec.c	Wed Oct 15 22:26:58 2003=0A=
@@ -39,6 +39,8 @@=0A=
 #include <linux/utsname.h>=0A=
 #define __NO_VERSION__=0A=
 #include <linux/module.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/sched.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 #include <asm/pgalloc.h>=0A=
@@ -1097,6 +1099,87 @@=0A=
 	*out_ptr =3D 0;=0A=
 }=0A=
 =0A=
+=0A=
+int show_addrvm(struct vm_area_struct *vma, struct task_struct *task, =
struct pt_regs *regs)=0A=
+{=0A=
+    struct vm_area_struct *next, *mlloc, *stk;=0A=
+    unsigned long addr, end;=0A=
+=0A=
+		=0A=
+		addr =3D vma->vm_start;=0A=
+		=0A=
+		end =3D vma->vm_end;=0A=
+		    =0A=
+		    printk(KERN_CRIT"Process name %s\n",task->comm);=0A=
+		    printk(KERN_CRIT"Process PID %d\n",task->pid);=0A=
+		    printk(KERN_CRIT"Process REGS\n");=0A=
+		    printk(KERN_CRIT"ebp :0x%x\n",regs->ebp);=0A=
+		    printk(KERN_CRIT"eax : 0x%x\n",regs->eax);=0A=
+		    printk(KERN_CRIT"eip : 0x%x\n",regs->eip);=0A=
+		    printk(KERN_CRIT"esp : 0x%x\n",regs->esp);=0A=
+		=0A=
+		    stk =3D find_vma(task->mm,task->mm->start_stack);=0A=
+		    =0A=
+		    if(stk)=0A=
+		    {=0A=
+			printk(KERN_CRIT"Process stack area start : 0x%x\n",stk->vm_start);=0A=
+			printk(KERN_CRIT"Stack flags 0x%x\n",stk->vm_flags);=0A=
+		    }=0A=
+		    =0A=
+		    mlloc =3D find_vma(task->mm,task->mm->start_brk);=0A=
+		    =0A=
+		    if(mlloc)=0A=
+		    {=0A=
+			printk(KERN_CRIT"Process brk area range: 0x%x - 0x%x =
\n",mlloc->vm_start, mlloc->vm_end);=0A=
+			printk(KERN_CRIT"brk flags 0x%x\n",mlloc->vm_flags);=0A=
+		    }=0A=
+		    =0A=
+		    do =0A=
+		    {=0A=
+		    =0A=
+			printk(KERN_CRIT" VM Range 0x%x - 0x%x\n",addr,end);=0A=
+			printk(KERN_CRIT" VM flags 0x%x\n",vma->vm_flags);=0A=
+		    =0A=
+			if(vma->vm_file)=0A=
+			{=0A=
+			    printk(KERN_CRIT" VM map file : =
%s\n",vma->vm_file->f_dentry->d_name.name);=0A=
+			}=0A=
+		    =0A=
+			next =3D vma->vm_next;=0A=
+=0A=
+			vma =3D next;=0A=
+		    =0A=
+			addr =3D vma->vm_start;=0A=
+		    =0A=
+			end =3D vma->vm_end;=0A=
+		    =0A=
+		    }while((vma->vm_next) && (vma));=0A=
+=0A=
+return 0;=0A=
+}=0A=
+=0A=
+=0A=
+int print_vm_state(struct pt_regs *regs)=0A=
+{=0A=
+	struct task_struct *pold =3D NULL;=0A=
+	int show , name;=0A=
+=0A=
+=0A=
+	for_each_task(pold)=0A=
+	{=0A=
+		=0A=
+	    if((pold !=3D NULL) && (pold->mm !=3D NULL) && (pold->comm !=3D =
pold->prev_task->comm))=0A=
+	    {=0A=
+		=0A=
+	    show =3D show_addrvm(pold->mm->mmap, pold, regs);=0A=
+	    =0A=
+	    }=0A=
+	    =0A=
+	}=0A=
+	=0A=
+return 0;=0A=
+}=0A=
+=0A=
 int do_coredump(long signr, struct pt_regs * regs)=0A=
 {=0A=
 	struct linux_binfmt * binfmt;=0A=
@@ -1104,8 +1187,11 @@=0A=
 	struct file * file;=0A=
 	struct inode * inode;=0A=
 	int retval =3D 0;=0A=
-=0A=
+	int retstate;=0A=
+	struct task_struct *p =3D current;=0A=
+	=0A=
 	lock_kernel();=0A=
+	=0A=
 	binfmt =3D current->binfmt;=0A=
 	if (!binfmt || !binfmt->core_dump)=0A=
 		goto fail;=0A=
@@ -1133,12 +1219,16 @@=0A=
 		goto close_fail;=0A=
 	if (do_truncate(file->f_dentry, 0) !=3D 0)=0A=
 		goto close_fail;=0A=
-=0A=
+		=0A=
+	printk(KERN_CRIT"Core dump created of process pid %d\n",p->pid);=0A=
+	=0A=
 	retval =3D binfmt->core_dump(signr, regs, file);=0A=
+	=0A=
+	retstate =3D print_vm_state(regs);=0A=
 =0A=
 close_fail:=0A=
 	filp_close(file, NULL);=0A=
 fail:=0A=
 	unlock_kernel();=0A=
 	return retval;=0A=
-}=0A=
+}=0A=
\ No newline at end of file=0A=

------=_NextPart_000_0007_01C3B453.F0E48820--

