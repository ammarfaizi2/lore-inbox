Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263695AbUDYXOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUDYXOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 19:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUDYXOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 19:14:19 -0400
Received: from ns2.s-sl.cc ([213.147.180.51]:32772 "EHLO mail.infotainment.cc")
	by vger.kernel.org with ESMTP id S263695AbUDYXOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 19:14:15 -0400
From: "nolife" <nolife@sigsegv.cc>
To: <linux-kernel@vger.kernel.org>
Subject: Hotfix for the latest Kernel exploit. (setsockopt integer overflow)
Date: Sat, 26 Apr 2003 00:14:35 +0200
Message-ID: <DIEBLLMOKGKFFKIKHIPGMEGCCAAA.nolife@sigsegv.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thought i publish the code so it has more use than idling on a single box.
It should patch against the latest bug in setsockopt without the need of a
new kernel/reboot.
It logs process and id if someone tries to exploit the system.

I've tested it against the public POC, seems to work fine.

It can be downloaded here: http://sigsegv.cc/setsockopt.c

Or copy/paste from here:
----------------------------------------------------------------------------
------------
/* setsockopt hotfix by nolife.
 * gcc -c -O3 -fomit-frame-pointer setsockopt.c
   This is a hotfix against the latest kernel vulnerability (integer
overflow in memory size calculation)
   It protects against the POC and should protect against upcoming exploits.
 */

#include <linux/autoconf.h>
#ifdef CONFIG_SMP
#define __SMP__
#endif
#define MODULE
#define __KERNEL__
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/mman.h>
#include <linux/in.h>
#include <linux/net.h>
#include <asm/unistd.h>
#include <asm/uaccess.h>
#include <sys/syscall.h>
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

#ifndef MCAST_MSFILTER     // you probably do not even have multicast
support .....
 #define MCAST_MSFILTER 48
#endif
#ifndef SYS_SOCKETCALL
 #define SYS_SOCKETCALL 102
#endif
#ifndef SYS_SETSOCKOPT
 #define SYS_SETSOCKOPT 14
#endif

#define AL(x) ((x) * sizeof(unsigned long))
static unsigned char nargs[18]={AL(0),AL(3),AL(3),AL(3),AL(2),AL(3),
                                AL(3),AL(3),AL(4),AL(4),AL(4),AL(6),
                                AL(6),AL(2),AL(5),AL(5),AL(3),AL(3)};
#undef AL

extern void *sys_call_table[];
const int optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);

static long (*old_socketcall)(int call, unsigned long *args);
static long new_socketcall(int call,unsigned long *args)
{
  unsigned long a[6];
  unsigned long a0,a1;

	if (call == SYS_SETSOCKOPT)
	{
        	if (copy_from_user(a, args, nargs[call]))
                	return -EFAULT;
		a0=a[0];
		a1=a[1];
		//printk("setsockopt called with optlen= %d by
%s\n",(int)a[4],current->comm);
		if ((int)a[2] ==  MCAST_MSFILTER)
		{
		// Multicast option
			if ((int)a[4] > optmem_max)
			{
				printk(KERN_ALERT "setsockopt exploit halted. abused by uid %d with
process %.32s\n",current->uid, current->comm);
				return(-ENOBUFS);
			}
		}


 	}
	return old_socketcall(call,args);
}


int init_module()
{
	unsigned long flags;

	save_flags(flags);
	cli();

	old_socketcall = sys_call_table[SYS_SOCKETCALL];
	sys_call_table[SYS_SOCKETCALL] = new_socketcall;

	restore_flags(flags);
	printk(KERN_NOTICE "\"setsockopt\" hotfix loaded (c)nolife\n");
	return 0;
}

void cleanup_module()
{
	unsigned long flags;

	save_flags(flags);
	cli();

	sys_call_table[SYS_SOCKETCALL] = old_socketcall;
	printk(KERN_NOTICE "\"setsockopt\" hotfix unloaded\n");
	restore_flags(flags);
}
----------------------------------------------------------------------------
------------

best regards,
nolife ;)

