Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRAQTym>; Wed, 17 Jan 2001 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbRAQTyd>; Wed, 17 Jan 2001 14:54:33 -0500
Received: from msp-65-25-214-194.mn.rr.com ([65.25.214.194]:5130 "EHLO
	msp-65-25-214-194.mn.rr.com") by vger.kernel.org with ESMTP
	id <S130036AbRAQTyY>; Wed, 17 Jan 2001 14:54:24 -0500
Date: Wed, 17 Jan 2001 13:54:20 -0600
From: Rick Richardson <rick@remotepoint.com>
To: linux-kernel@vger.kernel.org
Subject: kmalloc() of 4MB causes "kernel BUG at slab.c:1542!"
Message-ID: <20010117135420.A3536@remotepoint.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


[please cc me on any responses]

Environment: 2.4.0 released, Pentium III with 256MB's of RAM.
Problem:  kmalloc() of 4M causes kernel message "kernel BUG at slab.c:1542"

	Here is the dmesg output:

kernel BUG at slab.c:1542!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129b84>]
EFLAGS: 00010282
eax: 0000001b   ebx: d2922000   ecx: cdf6c000   edx: 00000000
esi: 00000007   edi: 00000000   ebp: 0806f124   esp: cb1bdef4
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 24167, stackpage=cb1bd000)
Stack: c02148eb c021498b 00000606 00000286 00000001 c02a75ec 00000029 d2922000 
       00000000 d2922083 01000000 00000007 d29221c0 01000000 c0116c65 00000000 
       cc8a6000 0000020c cc8a7000 00000060 ffffffea 00000003 c2be5420 00000060 
Call Trace: [<d2922000>] [<d2922083>] [<d29221c0>] [<c0116c65>] [<d2920000>] [<d2922060>] [<c0109057>] 

Code: 0f 0b 83 c4 0c 31 c0 83 c4 10 5b 5e c3 eb 0d 90 90 90 90 90 

Repeat by:
	Compile simple driver attached.
	$ insmod test.o Amt=4096


-- 
Rick Richardson  rick@remotepoint.com  http://home.mn.rr.com/richardsons/
Twins Cities traffic animations are at http://members.nbci.com/tctraffic/#1

Most Minnesotans think Global Warming is a good thing.

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <linux/config.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/string.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/config.h>
#include <linux/socket.h>
#include <linux/sockios.h>
#include <linux/errno.h>
#include <linux/in.h>
#include <linux/mm.h>
#include <linux/inet.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/if_arp.h>
#include <linux/skbuff.h>
#include <linux/proc_fs.h>
#include <linux/stat.h>
#include <linux/init.h>

static size_t   Amt = 1;
MODULE_PARM(Amt, "l");
MODULE_PARM_DESC(Amt, "Pages of memory to allocate");

static void *mem;

static int __init
init(void)
{
        /* Announce this module has been loaded. */
        printk(KERN_INFO "test loading; allocate %d bytes\n", Amt*4096);

        mem = kmalloc(Amt*4096, GFP_KERNEL);
        if (!mem) return (-ENOMEM);

        printk(KERN_INFO "test loaded\n");
        return 0;
}

static void __exit
fini(void)
{
        printk(KERN_INFO "test unloading\n");
        kfree(mem);
}

module_init(init);
module_exit(fini);

--NzB8fVQJ5HfG6fxh--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
