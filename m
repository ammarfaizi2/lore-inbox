Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSKUUMf>; Thu, 21 Nov 2002 15:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKUUMf>; Thu, 21 Nov 2002 15:12:35 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:45031 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S262981AbSKUUMb>; Thu, 21 Nov 2002 15:12:31 -0500
Date: Thu, 21 Nov 2002 12:19:31 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: [RFC] hangcheck-timer module
Message-ID: <20021121201931.GH770@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Feh, forgot to attach the damned file. ]


Folks,
	Attached is a module, hangcheck-timer.  It is used to detect
when the system goes out to lunch for a period of time, such as when a
driver like qla2x00 udelays a bunch.
	The module sets a timer.  When the timer goes off, it then uses
the TSC (warning: portability needed) to determine how much real time
has passed.
	On a normal system, the real elapsed time will be almost
identical to the expected timer duration.  However, if a device decided
to udelay for 60 seconds (or some other circumstance), the module takes
notice.  If the margin of error passes a threshold, the machine is
rebooted.
	The module is currently used in a cluster environment.  After
some time out to lunch, the rest of the cluster will have given up on a
machine.  If the machine suddenly comes back and assumes it is still
"live", bad things can happen.
	We can also see use for this in a debugging sense, for kernel
hangs as well as driver code.  That's why I'm proposing it for general
inclusion.
	Comments?  Thoughts?

Joel

Building:
	The module should happily build against most 2.4 kernels.  The
usual module building compile line:
	gcc  -I /scratch/jlbec/kernel/linux-2.4.20-rc2/include \
		-DMODULE -D__KERNEL__ -DLINUX  -c -o hangcheck-timer.o \
		hangcheck-timer.c

Running:
	Load the module with insmod.  There are two options.
"hangcheck_tick=<seconds>" specifies the timer timeout, and
"hangcheck_margin=<seconds" specifies the margin of error.

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

--sm4nu43k4a2Rpi4c
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="hangcheck-timer.c"

/*
 * hangcheck-timer.c
 *
 * Test driver for a little io fencing timer.
 *
 * Copyright (C) 2002 Oracle Corporation.  All rights reserved.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License version 2 as published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have recieved a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 021110-1307, USA.
 */


#include <linux/module.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/mm.h>
#include <linux/reboot.h>
#include <linux/smp_lock.h>
#include <linux/init.h>
#include <asm/uaccess.h>

/* #include "hangcheck-timer.h" */


#define DEFAULT_IOFENCE_MARGIN 60	/* Default fudge factor, in seconds */
#define DEFAULT_IOFENCE_TICK 180	/* Default timer timeout, in seconds */

static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;

MODULE_PARM(hangcheck_tick,"i");
MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
MODULE_PARM(hangcheck_margin,"i");
MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the machine will reboot.");
MODULE_LICENSE("GPL");


static void hangcheck_fire(unsigned long);

/* Last time scheduled */
static unsigned long long hangcheck_tsc, hangcheck_tsc_margin;

static struct timer_list hangcheck_ticktock = {
	function:	hangcheck_fire,
};


static void hangcheck_fire(unsigned long data)
{
	unsigned long long cur_tsc, tsc_diff;

	rdtscll(cur_tsc);

	if (cur_tsc > hangcheck_tsc)
		tsc_diff = cur_tsc - hangcheck_tsc;
	else
		tsc_diff = (cur_tsc + (~0ULL - hangcheck_tsc)); /* or something */

#if 0
	printk(KERN_CRIT "tsc_diff = %lu.%lu, predicted diff is %lu.%lu.\n",
	       (unsigned long) ((tsc_diff >> 32) & 0xFFFFFFFFULL),
	       (unsigned long) (tsc_diff & 0xFFFFFFFFULL),
	       (unsigned long) ((hangcheck_tsc_margin >> 32) & 0xFFFFFFFFULL),
	       (unsigned long) (hangcheck_tsc_margin & 0xFFFFFFFFULL));
	printk(KERN_CRIT "hangcheck_margin = %lu, HZ = %lu, current_cpu_data.loops_per_jiffy = %lu.\n", hangcheck_margin, HZ, current_cpu_data.loops_per_jiffy);
#endif
	
	if (tsc_diff > hangcheck_tsc_margin) {
		printk(KERN_CRIT "hangcheck is restarting the machine.\n");
		machine_restart(NULL);
	}
	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
	rdtscll(hangcheck_tsc);
}  /* hangcheck_fire() */


static int __init hangcheck_init(void)
{
        version_hash_print();
	printk("Starting hangcheck timer (tick is %d seconds, margin is %d seconds).\n",
	       hangcheck_tick, hangcheck_margin);

	hangcheck_tsc_margin = (unsigned long long)(hangcheck_margin + hangcheck_tick) * (unsigned long long)HZ * (unsigned long long)current_cpu_data.loops_per_jiffy;

	rdtscll(hangcheck_tsc);
	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));

	return 0;
}  /* hangcheck_init() */


static void __exit hangcheck_exit(void)
{
	printk("Stopping hangcheck timer.\n");

	lock_kernel();
	del_timer(&hangcheck_ticktock);
	unlock_kernel();
}  /* hangcheck_exit() */

module_init(hangcheck_init);
module_exit(hangcheck_exit);

--sm4nu43k4a2Rpi4c--
