Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSGRJaa>; Thu, 18 Jul 2002 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSGRJaa>; Thu, 18 Jul 2002 05:30:30 -0400
Received: from daimi.au.dk ([130.225.16.1]:60956 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317537AbSGRJa2>;
	Thu, 18 Jul 2002 05:30:28 -0400
Message-ID: <3D368B63.E2CFB52@daimi.au.dk>
Date: Thu, 18 Jul 2002 11:33:23 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: irfan_hamid@softhome.net
CC: linux-kernel@vger.kernel.org
Subject: Re: cli()/sti() clarification
References: <courier.3D365FDC.0000712F@softhome.net>
Content-Type: multipart/mixed;
 boundary="------------08198AB390BCE873190FB70B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------08198AB390BCE873190FB70B
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

irfan_hamid@softhome.net wrote:
> 
> Hi,
> 
> I added two system calls, blockintr() and unblockintr() to give cli()/sti()
> control to userland programs (yes I know its not advisable) but I only want
> to do it as a test. My test program looks like this:
> 
>         blockintr();
>         /* Some long calculations */
>         unblockintr();
> 
> The problem is that if I press Ctrl+C during the calculation, the program
> terminates. So I checked the _syscallN() and __syscall_return() macros to
> see if they explicitly call sti() before returning to userspace, but they
> dont.

The flag register is saved on the stack and restored by the INT 0x80
and IRET instructions. You would want to change the interrupt flag
in that register. Here is an ugly piece of code that is known to
work on some kernel version, I don't remember which.

Another approach would be to use ioperm to get access to the IRQ
controller, and block interrupts there.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
--------------08198AB390BCE873190FB70B
Content-Type: text/plain; charset=us-ascii;
 name="cli.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cli.c"

/* This piece of code is ugly and inefficient. */

#include <stdlib.h>
#include <linux/module.h>
#include <asm/current.h>
#include "cli.h"

struct my_module {
  struct module m;
  char name[64];
  unsigned long jmp;
  unsigned long delta;
} my_module;

static int do_cli()
{
	(*(unsigned long*)(((char*)current)+0x1FF4)) &= ~0x200;
	return 0;
}

static int do_sti()
{
        (*(unsigned long*)(((char*)current)+0x1FF4)) |= 0x200;
        return 0;
}

void init_struct(int (*func)(),struct my_module *dst, struct my_module *p)
{
  dst->m.size_of_struct = sizeof(struct module);
  dst->m.next=NULL;
  dst->m.name=p->name;
  dst->m.size=sizeof(my_module);
  dst->m.flags=0;
  dst->m.nsyms=0;
  dst->m.ndeps=0;
  dst->m.syms=NULL;
  dst->m.deps=NULL;
  dst->m.refs=NULL;
  dst->m.init=(void*)&(p->jmp);
  dst->m.cleanup=NULL;
  dst->m.ex_table_start=NULL;
  dst->m.ex_table_end=NULL;
  dst->m.persist_start=NULL;
  dst->m.persist_end=NULL;
  dst->m.can_unload=NULL;
  sprintf(dst->name,"hack_%d_hack",getpid());
  dst->jmp=0xE9909090;
  dst->delta=(unsigned long)func-(unsigned long)(p+1);
}

static void kernel_call(int (*func)())
{
  struct my_module my_module;
  init_struct(func,&my_module,&my_module);
  init_struct(func,&my_module,(void*)create_module(my_module.name,my_module.m.size));
  init_module(my_module.name,&my_module.m);
  delete_module(my_module.name);
}

void cli()
{
  kernel_call(do_cli);
}

void sti()
{
  kernel_call(do_sti);
}

--------------08198AB390BCE873190FB70B--

