Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVL0VRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVL0VRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVL0VRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:17:37 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:38927 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751147AbVL0VRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:17:37 -0500
Message-ID: <43B1AE23.4020105@tuxrocks.com>
Date: Tue, 27 Dec 2005 14:12:03 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
CC: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 4k stacks
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <200512260242.52379.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <200512260340.55037.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200512260340.55037.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090300090700070506070802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300090700070506070802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew James Wade wrote:
> I've modified stack.c to handle 4k stacks. It can also provide information
> for 8k stacks (fwiw) by changing STACK_GRANULARITY.
> 
> It found one stack with only 756 bytes left. I hope it's just due to a
> greedy boot-time function as I'm not running anything particularly exotic.
> (CIFS & Reiser4).

Yes, it does appear to be a boot-time function.  It eventually becomes
PID 1, and the stack usage shrinks considerably.

Here is a different approach that uses a kernel module, rather than
/dev/mem.  This module will display current stack usage for each PID, as
well as the maximum usage if the kernel has the stack-poison patch.
Also, the current call trace for each PID can be displayed if loaded
with "verbose=1".

for example:
1: init - free stack now: 3640, at max usage: 740
2: ksoftirqd/0 - free stack now: 3880, at max usage: 3788
3: watchdog/0 - free stack now: 3828, at max usage: 3736
4: events/0 - free stack now: 3784, at max usage: 3012
...

Disclaimer: This seems to work for me, but I'm not a very experienced
kernel hacker, so if it breaks, take care that you don't get hurt.

Comments and fixes are welcome.

Thanks,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDsa4iaI0dwg4A47wRAo14AKCbaraQkijBHpzSJdFzoTG1L/MXjgCg8VDe
130LL3/dMhRjVw4Wp8IN0a8=
=skKB
-----END PGP SIGNATURE-----

--------------090300090700070506070802
Content-Type: text/x-csrc;
 name="stack_avail.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stack_avail.c"

/*
* stack_avail - A linux kernel module to display available stack
*		If the kernel stack-poison patch has been applied, this
*		module also displays available stack at maximum usage
* Copyright Frank Sorenson <frank@tuxrocks.com> 2005
*
* Permission is hereby granted to copy, modify and redistribute this code
* in terms of the GNU Library General Public License, Version 2 or later,
* at your option.
*
*/

#include <linux/module.h>
#include <linux/kallsyms.h>

static int verbose = 0;

static unsigned long sinittext;
static unsigned long einittext;
static unsigned long stext;
static unsigned long etext;

// task_struct - /UML/Source/Host/linux-2.6.15-rc5-mm3+fs3/include/linux/sched.h
// thread_struct - /UML/Source/Host/linux-2.6.15-rc5-mm3+fs3/include/asm-i386/processor.h
// thread_info - /UML/Source/Host/linux-2.6.15-rc5-mm3+fs3/include/asm-i386/thread_info.h


static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
{
	return  p > (void *)tinfo &&
		p < (void *)tinfo + THREAD_SIZE - 3;
}

static int core_kernel_text(unsigned long addr)
{
	if (addr >= (unsigned long)stext &&
		addr <= (unsigned long)etext)
		return 1;

	if (addr >= (unsigned long)sinittext &&
		addr <= (unsigned long)einittext)
		return 1;
	return 0;
}

int my_kernel_text_address(unsigned long addr)
{
	if (core_kernel_text(addr))
		return 1;
	return 0;
//	return __module_text_address(addr) != NULL;
}


static inline unsigned long print_context_stack(struct thread_info *tinfo,
	unsigned long *stack, unsigned long ebp)
{
	unsigned long addr;
#ifdef  CONFIG_FRAME_POINTER
	while (valid_stack_ptr(tinfo, (void *)ebp)) {
		addr = *(unsigned long *)(ebp + 4);
		printk(" [<%08lx>] ", addr);
		print_symbol("%s", addr);
		printk("\n");
		ebp = *(unsigned long *)ebp;
	}
#else
	while (valid_stack_ptr(tinfo, stack)) {
		addr = *stack++;
		if (my_kernel_text_address(addr)) {
			printk(" [<%08lx>]", addr);
			print_symbol(" %s", addr);
			printk("\n");
		}
	}
#endif
	return ebp;
}

void show_trace(struct task_struct *task, unsigned long * stack)
{
	unsigned long ebp;

	ebp = *(unsigned long *) task->thread.esp;

	while (1) {
		struct thread_info *context;
		context = (struct thread_info *)
			((unsigned long)stack & (~(THREAD_SIZE - 1)));
		ebp = print_context_stack(context, stack, ebp);
		stack = (unsigned long*)context->previous_esp;
		if (!stack)
			break;
		printk(" =======================\n");
	}
}

static int stack_avail_load(void)
{
	struct task_struct *task;
	unsigned char *base_addr;
	unsigned char *max_addr;
	unsigned char *ptr;
	unsigned long current_avail;
	unsigned long poisoned_avail;

	sinittext = kallsyms_lookup_name("_sinittext");
	einittext = kallsyms_lookup_name("_einittext");
	stext = kallsyms_lookup_name("_stext");
	etext = kallsyms_lookup_name("_etext");

	printk("Displaying stack space available:\n");

	for_each_process(task) {
		printk("%d: %s", task->pid, task->comm);

		base_addr = (unsigned char *)(task->thread.esp & 0xFFFFF000);
		max_addr = base_addr + THREAD_SIZE - 1;
		ptr = base_addr + sizeof(struct thread_info);
		while (*ptr == 'Q') {
			ptr ++;
		}
		current_avail = (unsigned long)(task->thread.esp) -
			(unsigned long)(base_addr) - sizeof(struct thread_info);
		poisoned_avail = THREAD_SIZE - ((unsigned long)(max_addr - ptr)) -
			sizeof(struct thread_info) - 1;

		printk(" - free stack now: %lu", current_avail);
		if (poisoned_avail != 0)
			printk(", at max usage: %lu", poisoned_avail);

		if (verbose) {
			printk("\nCurrent call Trace:\n");
			show_trace(task, (unsigned long *)(task->thread.esp));
		}
		printk("\n");
	}
	return 0;
}

static void stack_avail_unload(void)
{
	printk("stack_avail module unloading\n");
}

module_init(stack_avail_load);
module_exit(stack_avail_unload);
module_param(verbose, int, 0);

MODULE_AUTHOR ("Frank Sorenson, frank@tuxrocks.com");
MODULE_DESCRIPTION ("Displays available stack space");
MODULE_LICENSE("GPL");

--------------090300090700070506070802
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

KVER := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build

PWD = $(shell pwd)

obj-m += stack_avail.o

all: modules

modules:
	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) BUILD_DIR=$(PWD) modules

ioctl: ioctl.c
	$(CC) $< -o $@

clean:
	@find . \
		\( -name '*.ko' -o -name '.*.cmd' \
		-o -name '*.o' -o -name '*.mod.c' \) \
		-type f -print | xargs rm -f

--------------090300090700070506070802--
