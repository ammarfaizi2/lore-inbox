Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUAGN7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUAGN7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:59:53 -0500
Received: from [213.149.44.4] ([213.149.44.4]:34446 "HELO tian1.alterbox.net")
	by vger.kernel.org with SMTP id S265585AbUAGN7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:59:45 -0500
From: delacko@alterbox.hr
Reply-To: delacko@alterbox.hr
MIME-version: 1.0
To: linux-kernel@vger.kernel.org
X-Mailer: AlterUM v1.3
X-Alter-SendRequest: 38763
Subject: =?utf-8?B?bW9kdWxlIHBhdGNoZXMgKG5vIGtlcm5lbCByZWNvbXBpbGF0aW9uISkgIGZvciBkb19icmsgYW5kIGRvX21yZW1hcCBidWdz?=
Date: Wed,  7 Jan 2004 14:59:47 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <S265585AbUAGN7p/20040107135945Z+24379@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



These two modules overload brk and mremap syscall and 
before calling original syscalls they check boundaries and thus disableing posible exploits.

This is useful for systems you cannot reboot.

Instructions:
1. compile modules 
gcc -O3 -c overload_brk_2.4.c -I/kernel_location/include
gcc -O3 -c overload_mremap_2.4.c -I/kernel_location/include

2. install modules
/sbin/insmod ./overload_brk_2.4.o
/sbin/insmod ./overload_mremap_2.4.o


Source:
--------------- overload_brk_2.4 ------------------------
/*LICENCE: GPL
 * Author: Denis Lackovic <delacko_NO-SPAM_@alterbox.hr>
 * Purpose: Module that overloads linux kernel syscall sys_brk to patch
 *          it against boundary check bug in do_brk syscall.
 * Intended platform: unpatched 2.4.x kernels < 2.4.23
 * 
 * */



#define MODULE 
#define __KERNEL__
#include <linux/config.h>
#ifdef MODULE
#include <linux/module.h>
#include <linux/version.h>
#else
#define MOD_INC_USE_COUNT
#define MOD_DEC_USE_COUNT
#endif

#include <sys/syscall.h>
#include <linux/types.h>
#include <linux/mm.h>
#include <linux/errno.h>



//pointer to original sys_brk call
int (*old_brk)(unsigned long);

//system call table 
unsigned long **system_call_table;

//new sys_brk system call
inline int new_brk(unsigned long end_data_segment)
{
  int r;

  unsigned long newbrk, oldbrk;
  struct mm_struct *mm = current->mm;
  oldbrk = PAGE_ALIGN(mm->brk);
  newbrk = PAGE_ALIGN(end_data_segment);

  //  printk("In brk syscall: %d,%d\n",oldbrk,newbrk);
  //boundary checking (this is what patch is all about)
  if (newbrk > TASK_SIZE || newbrk < oldbrk){
          return oldbrk;
  }

  //calling original sys_brk
  r = old_brk(end_data_segment);

  return r;
}
int init_module(void)
{

 struct module *mod_ptr;
 unsigned long ptr;
 extern int loops_per_jiffy;

  EXPORT_NO_SYMBOLS;
  MODULE_LICENSE("GPL");



  system_call_table = NULL;

  //searching for system call table location
  for (ptr = (unsigned long)&loops_per_jiffy;
       ptr < (unsigned long)&boot_cpu_data; ptr += sizeof(void *)){

    unsigned long *p;
    p = (unsigned long *)ptr;
    if (p[__NR_close] == (unsigned long) sys_close){
      system_call_table = (unsigned long **)p;
      break;
    }
  }

  if(system_call_table){
    //replaceing old sys_brk call with new_brk syscal, storing
    //original version in old_brk
    (int *)old_brk = system_call_table[__NR_brk];
    system_call_table[__NR_brk] =  (unsigned long *)new_brk;
  }


  return 0;
}


int cleanup_module(void)
{

 //restoring original sys_brk call
  if(system_call_table && old_brk){
    system_call_table[__NR_brk] = (unsigned long *)old_brk;
  }


  return 0;
}


----------------------------------------------------------


--------------- overload_mremap_2.4 -------------------
/*LICENCE: GPL
 * Author: Denis Lackovic <delacko_NO-SPAM_@alterbox.hr>
 * Purpose: Module that overloads linux kernel syscall
 *              sys_mremap to patch  it against boundary 
 *              check bug in do_mremap syscall.
 * Intended platform: unpatched 2.4.x kernels < 2.4.24
 * 
 * */

#define MODULE 
#define __KERNEL__
#include <linux/config.h>
#ifdef MODULE
#include <linux/module.h>
#include <linux/version.h>
#else
#define MOD_INC_USE_COUNT
#define MOD_DEC_USE_COUNT
#endif

#include <linux/types.h>
#include <linux/mm.h>
#include <linux/mman.h>
#include <linux/compiler.h>
#include <sys/syscall.h>



//pointer to original sys_mremap call
unsigned long  (*old_mremap)(unsigned long,  unsigned long , unsigned long, unsigned long,unsigned long);


//system call table pointer
unsigned long **system_call_table;



//new sys_mremap system call
asmlinkage unsigned long new_mremap(unsigned long addr, unsigned long old_len, unsigned long new_len,
                                        unsigned long flags, unsigned long new_addr)
{
        unsigned long r;

        //printk ("In mremap call %d,%d,%d,%d\n",addr,old_len,new_len,new_addr);

        //boundary check (what this patch is all about)
        if (flags & MREMAP_FIXED) {
                if (unlikely(!new_len && new_addr != addr))
                        return -EINVAL;
        }

        //runing original sys_mremap
        r = old_mremap(addr,old_len,new_len,flags,new_addr);

        return r;
}


int init_module(void)
{
{

 struct module *mod_ptr;
 unsigned long ptr;
 extern int loops_per_jiffy;

  EXPORT_NO_SYMBOLS;
  MODULE_LICENSE("GPL");



  system_call_table = NULL;

  //searching for system call table location
  for (ptr = (unsigned long)&loops_per_jiffy;
       ptr < (unsigned long)&boot_cpu_data; ptr += sizeof(void *)){

    unsigned long *p;
    p = (unsigned long *)ptr;
    if (p[__NR_close] == (unsigned long) sys_close){
      system_call_table = (unsigned long **)p;
      break;
    }
  }

  if(system_call_table){
    //replaceing old sys_mremap call with new_mremap syscal, storing
    //original version in old_mremap
    (unsigned long *)old_mremap = system_call_table[__NR_mremap];
    system_call_table[__NR_mremap] =  (unsigned long *)new_mremap;
  }


  return 0;
}


int cleanup_module(void)
{


 //restoring original sys_mremap call
  if(system_call_table && old_mremap){
    system_call_table[__NR_mremap] = (unsigned long *)old_mremap;
  }


  return 0;
}


----------------------------------------------------------

-- 
Denis Lackovic ==> delacko @ alterbox . hr




