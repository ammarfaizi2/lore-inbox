Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUDPQLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUDPQLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:11:13 -0400
Received: from cpe.atm2-0-1051208.0x50a2959e.arcnxx10.customer.tele.dk ([80.162.149.158]:145
	"EHLO www.loke.dk") by vger.kernel.org with ESMTP id S263295AbUDPQKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:10:51 -0400
Message-ID: <4080058A.8090607@cs.auc.dk>
Date: Fri, 16 Apr 2004 18:10:50 +0200
From: Mikkel Christiansen <mixxel@cs.auc.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vfree in timerfunciton causes  kernel crash
Content-Type: multipart/mixed;
 boundary="------------030000060903090600080009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030000060903090600080009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Idea: a module allocates memory (vmalloc) for userspace program which 
then craches.
Due to lack of activity timer is  expires and free's the unused memory 
(vfree).
(see tc_core.c later in this mail for details)

Problem: when timer expires and vfree is called then kernel crashes -
or rather freezes silently.

Can anyone explain why this happens? a kernel bug?

Cheers
    Mikkel

kernel 2.6.5


--------------030000060903090600080009
Content-Type: text/x-c;
 name="tf_core.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tf_core.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/vmalloc.h>
#include <linux/timer.h>
#include <linux/sched.h>

#define MODULE_NAME "tf"

#ifdef __KERNEL__

int *buf;
struct timer_list timer;

static void timeoutfun(unsigned long b) {
  printk("tf: timeoutfun\n");
  vfree(buf);
}

struct timer_list timer;

int __init init_tf(void)
{
  printk("init_tf\n");
  buf = vmalloc(10*sizeof(int));
  
  init_timer(&timer); /* Initialization of the timer */
  
  timer.function = &timeoutfun;
  timer.data     = 10;
  timer.expires  = jiffies + (10 * HZ); /* 1 sec */
  
  add_timer(&timer);

  return 0;
}


void __exit exit_tf(void)
{
  printk("exit_tf\n");
  vfree(buf);
}


module_init(init_tf);
module_exit(exit_tf);
MODULE_LICENSE("GPL");


#endif

--------------030000060903090600080009
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

KERNEL_SOURCE = /home/mixxel/pack/linux-2.6.4
PWD = `pwd`
obj-m := tf.o

tf-objs := tf_core.o 

default: 
	make -C ${KERNEL_SOURCE} SUBDIRS=${PWD} modules

clean:
	rm *.{o,ko} .*.cmd
--------------030000060903090600080009--
