Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSFQMJJ>; Mon, 17 Jun 2002 08:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSFQMJJ>; Mon, 17 Jun 2002 08:09:09 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:32142 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S311752AbSFQMJI>; Mon, 17 Jun 2002 08:09:08 -0400
Importance: Normal
Sensitivity: 
Subject: (BUG?) loosing memory with interrupt registration/freeing
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF833B5691.F9F8B36C-ONC1256BDB.003609BB@de.ibm.com>
From: "Stefan Koch4" <STK@de.ibm.com>
Date: Mon, 17 Jun 2002 14:09:01 +0200
X-MIMETrack: Serialize by Router on d12ml039/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 17/06/2002 14:09:02
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel: 2.4.19-pre4 from Montavista
(in the linuxppc-embedded mailing list it was suggested
to ask here regarding the following problem)

hardware: 405GP (Walnut), i386 (see below)

problem:

I discovered the following effect: I made a driver as a
module. I created a regression test which was (also)
loading/unloading the module about 20000 times.

When running this test my kernel began to kill processes
after 10000 cycles and finally it crashed.

After some debugging I wrote a little test driver
(see code below) and I found out that the reason for this
problem is the registration / unregistration of the interrupt.

Does anybody know what's wrong (if it is wrong) in the usage
of request_irq(..) and free_irq(..) in this scenario??

I also tried this testcase on my i386 box (Thinkpad21) and
saw the memory slowly decreasing. There I did not wait untill
any kernel problems.

I took the memory value from /proc/meminfo Mem: free

Any ideas?

Thanks,
Stefan Koch

===========================================================
CODE:

/* just copy pasted the headers from another driver - not all is needed ;-)
*/

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/timer.h>
#include <linux/ptrace.h>
#include <linux/errno.h>
#include <linux/ioport.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/version.h>
#include <linux/pci.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>
#include <linux/proc_fs.h>
#include <linux/modversions.h>

static void inthnd (int irq, void *dev, struct pt_regs *regs)
{
 return;
}

int init_module(void)
{
 int c;

 printk("inttest start\n");

 for (c = 0; c < 100000; c++) {
  if (request_irq( 8, inthnd, 0, "inttest", NULL) != 0) {
   printk("inttest: %d cannot request irq\n", c);
   break;
  }
  free_irq(8, NULL);
 }
 printk("inttest stop\n");

 return 0;
}

void cleanup_module(void)
{
 printk("inttest cleanup\n");
}


