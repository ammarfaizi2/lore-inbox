Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264826AbSJOWfL>; Tue, 15 Oct 2002 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSJOWdu>; Tue, 15 Oct 2002 18:33:50 -0400
Received: from beta.bandnet.com.br ([200.195.133.131]:39945 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S264853AbSJOWcc>; Tue, 15 Oct 2002 18:32:32 -0400
Message-ID: <00bc01c2749a$cf0e4640$cddea7c8@bsb.virtua.com.br>
From: "Breno" <breno_silva@bandnet.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: [KERNEL 2.4 or 2.5] New source for allocation anonymous memory+paging demand
Date: Tue, 15 Oct 2002 19:32:56 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B9_01C27481.A954B7E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00B9_01C27481.A954B7E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi people

I developed a module for allocation of anonymous memory, I believe that it
is util. it follows attached module+header

the use is sufficiently simple:

..... to char * map;  map = (to char *)build_vma(100);  ....

What do you think ? it´s possible to enter in kernel 2.4 or 2.5 ?

Breno






------=_NextPart_000_00B9_01C27481.A954B7E0
Content-Type: application/octet-stream;
	name="vm.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vm.c"

/*by Breno S. Pinto*/
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/unistd.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/highmem.h>
#include <linux/string.h>
#include <asm/uaccess.h>
#include <asm/errno.h>
#include <asm/mman.h>
#include <asm/page.h>
#include <asm/pgalloc.h>
#include <asm/processor.h>


#define NUM_mysyscallmem       230

extern void *sys_call_table[];
=20

asmlinkage unsigned long (*original_call) (int numero,unsigned long =
address);
asmlinkage unsigned long my_syscallmem(int numero,unsigned long =
address);



struct page *my_teste_page_alloc_mem(struct vm_area_struct *vma,unsigned =
long address,int unused)
{
   struct page *page;

              page =3D alloc_page(GFP_USER);
              =20
	      if(!page) {=20
                 printk("<2>Can not alloc new page\n");
                 return NOPAGE_OOM;
		 }



 return page;
}

struct vm_operations_struct my_vm_operation =3D {
nopage:    my_teste_page_alloc_mem,
};



asmlinkage unsigned long my_syscallmem(int numero,unsigned long address)
{
 unsigned long end;
 unsigned long len;
 unsigned int flags;
 unsigned int vmflags;
 struct vm_area_struct *vma;
 struct mm_struct *mm =3D current->mm;

 flags =3D MAP_ANON;
=20
 len =3D PAGE_ALIGN(numero);
=20
 down_write(&current->mm->mmap_sem);
=20
 address =3D get_unmapped_area(NULL,address,len,0,flags);

 if(!address)
  {
   printk("<2>Can not define start address\n");
   return -ENOMEM;
   }
=20
 end =3D address + len;
  =20
 if(end > TASK_SIZE)
  {
   printk("<2>No memory\n");
   return -ENOMEM;
   }
  =20
  vma =3D kmem_cache_alloc(vm_area_cachep,SLAB_KERNEL);
  if(!vma)
  return -ENOMEM;
 =20
 vmflags =3D mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_WRITE | =
VM_READ;
 =20
  vma->vm_mm =3D mm;
  vma->vm_start =3D address;  /*Start address*/
  vma->vm_end =3D end; /*Final address*/
  vma->vm_ops =3D &my_vm_operation;=20
  vma->vm_flags =3D vmflags;
  vma->vm_pgoff =3D 0;
  vma->vm_file =3D NULL; /*MAP_NON*/
  vma->vm_private_data =3D NULL;
  vma->vm_raend =3D 0;
  vma->vm_page_prot =3D protection_map[vmflags & 0x0f];
=20

 insert_vm_struct(mm,vma);


 up_write(&current->mm->mmap_sem);

 return address;
}

int init_module()
 {=20
  original_call =3D sys_call_table[NUM_mysyscallmem];
  sys_call_table[NUM_mysyscallmem] =3D my_syscallmem;
  return 0;
}

int cleanup_module()
{
 sys_call_table[NUM_mysyscallmem] =3D original_call;
 return 0;
}



------=_NextPart_000_00B9_01C27481.A954B7E0
Content-Type: application/octet-stream;
	name="bvma.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bvma.h"

/*by Breno S. Pinto*/
#include <asm/unistd.h>
#include <errno.h>

#define __NR_mysyscallmem 230
_syscall2(unsigned long,mysyscallmem,int,numero,unsigned long,address)

void *build_vma(int numero)
{
 char *c_vma;
 c_vma = (char *)mysyscallmem(numero,0);
 return c_vma;
}
------=_NextPart_000_00B9_01C27481.A954B7E0--

