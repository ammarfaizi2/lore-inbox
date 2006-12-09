Return-Path: <linux-kernel-owner+w=401wt.eu-S1755649AbWLIVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649AbWLIVKY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756325AbWLIVKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:10:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47772 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755649AbWLIVKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:10:23 -0500
Date: Sat, 9 Dec 2006 15:09:13 -0600
From: Erik Jacobson <erikj@sgi.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Erik Jacobson <erikj@sgi.com>, guillaume.thouvenin@bull.net,
       matthltc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-ID: <20061209210913.GA15159@sgi.com>
References: <20061207232213.GA29340@sgi.com> <20061208192027.18a1e708.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208192027.18a1e708.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here, we just adjust how the variables are declared and use memcopy to
> > avoid the error messages.
> > -	ev->timestamp_ns = timespec_to_ns(&ts);
> > +	ev.timestamp_ns = timespec_to_ns(&ts);
> Please try to declare u64 timestamp_ns, then copy it into the *ev
> instead of copying whole *ev. This ought to fix the problem if
> buffer[] ends aligned to 32 bits or better.

So I took this suggestion for a spin and met with the same result.
Please confirm I understood what you were asking.

The unaligned access messages are still produced.

Here is how I changed the function (declared timestamp_ns in the
top of the function, and used memcpy to copy it in place).

The case of fork is provided below but I did it to all the appropriate
functions.  See the removed and added comments to see what changed.

void proc_fork_connector(struct task_struct *task)
{
   struct cn_msg *msg;
   struct proc_event *ev;
   __u8 buffer[CN_PROC_MSG_SIZE];
   struct timespec ts;
   u64 timestamp_ns; // added

   if (atomic_read(&proc_event_num_listeners) < 1)
      return;

   msg = (struct cn_msg*)buffer;
   ev = (struct proc_event*)msg->data;
   get_seq(&msg->seq, &ev->cpu);
   ktime_get_ts(&ts); /* get high res monotonic timestamp */
   //ev->timestamp_ns = timespec_to_ns(&ts); removed
   printk("dbg fork before timestamp_to_ns call\n");
   timestamp_ns = timespec_to_ns(&ts); //added
   printk("dbg fork after timespec_to_ns call, b4 memcpy\n");
   memcpy(&ev->timestamp_ns, &timestamp_ns, sizeof(ev->timestamp_ns)); //added
   printk("dbg fork after memcpy, b4 other ev settings...\n");
   ev->what = PROC_EVENT_FORK;
   ev->event_data.fork.parent_pid = task->real_parent->pid;
   ev->event_data.fork.parent_tgid = task->real_parent->tgid;
   ev->event_data.fork.child_pid = task->pid;
   ev->event_data.fork.child_tgid = task->tgid;

   memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
   msg->ack = 0; /* not used */
   msg->len = sizeof(*ev);
   /*  If cn_netlink_send() failed, the data is not sent */
   cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
}

Here is the output from this kernel when the container program tracking
tasks is running.  You can see the unaligned access messages along with
my debug statements for the case of fork.  The TASK and EXIT messages are 
from the container program running in debug mode in the background of the 
same tty.

[root@minime1 ~]# /bin/true
dbg fork before timestamp_to_ns call
dbg fork after timespec_to_ns call, b4 memcpy
kernel unaligned access to 0xe000003076b6fbe4, ip=0xa0000001004f1480
dbg fork after memcpy, b4 other ev settings...
FORK parent 3389 (bash) child 3418 (bash) 
kernel unaligned access to 0xe0000030732dfe24, ip=0xa0000001004f17c1
kernel unaligned access to 0xe0000030732dfe04, ip=0xa0000001004f1241
[root@minime1 ~]# EXIT pid 3418 (No-Info)

I had built this kernel with KDB and I checked the IPs.

ip 0xa0000001004f1480 is in proc_fork_connector, between the two
printk calls.  That should make it the memcpy.  That jives with the
console output too.

0xa0000001004f17c1 is proc_exec_connector

0xa0000001004f1241 is proc_exit_connector

I'm not able to read the disassembly well, but I've included the full
disassembly of proc_fork_connector below in case that's helpful.

I could try some memory dumps if needed.  I really don't have lots of
experience fixing kernel unaligned access issues so if there are other 
things I should try that are better than my original patch, I'm all ears.


vmlinux:     file format elf64-ia64-little

Disassembly of section .text:
proc_fork_connector():
a0000001004f1280 <proc_fork_connector> [MMB]       alloc r36=ar.pfs,9,6,0
a0000001004f1286 <proc_fork_connector+0x6>             adds r12=-80,r12
a0000001004f128c <proc_fork_connector+0xc>             nop.b 0x0
a0000001004f1290 <proc_fork_connector+0x10> [MMI]       adds r20=3200,r13
a0000001004f1296 <proc_fork_connector+0x16>             addl r2=-1981124,r1
a0000001004f129c <proc_fork_connector+0x1c>             mov r35=b0;;
a0000001004f12a0 <proc_fork_connector+0x20> [MMI]       ld4.acq r14=[r2]
a0000001004f12a6 <proc_fork_connector+0x26>             adds r19=40,r20
a0000001004f12ac <proc_fork_connector+0x2c>             adds r34=40,r12;;
a0000001004f12b0 <proc_fork_connector+0x30> [MIB]       nop.m 0x0
a0000001004f12b6 <proc_fork_connector+0x36>             cmp4.lt p7,p6=0,r14
a0000001004f12bc <proc_fork_connector+0x3c>       (p06) br.cond.dpnt.few a0000001004f1570 <proc_fork_connector+0x2f0>
a0000001004f12c0 <proc_fork_connector+0x40> [MMI]       ld4 r15=[r19];;
a0000001004f12c6 <proc_fork_connector+0x46>             adds r8=1,r15
a0000001004f12cc <proc_fork_connector+0x4c>             nop.i 0x0
a0000001004f12d0 <proc_fork_connector+0x50> [MMI]       nop.m 0x0;;
a0000001004f12d6 <proc_fork_connector+0x56>             st4 [r19]=r8
a0000001004f12dc <proc_fork_connector+0x5c>             nop.i 0x0;;
a0000001004f12e0 <proc_fork_connector+0x60> [MMI]       mov r3=-65496
a0000001004f12e6 <proc_fork_connector+0x66>             mov r14=-35804
a0000001004f12ec <proc_fork_connector+0x6c>             adds r40=48,r12
a0000001004f12f0 <proc_fork_connector+0x70> [MII]       adds r30=20,r20
a0000001004f12f6 <proc_fork_connector+0x76>             adds r28=64,r12;;
a0000001004f12fc <proc_fork_connector+0x7c>             nop.i 0x0
a0000001004f1300 <proc_fork_connector+0x80> [MMI]       ld8 r2=[r3]
a0000001004f1306 <proc_fork_connector+0x86>             nop.m 0x0
a0000001004f130c <proc_fork_connector+0x8c>             nop.i 0x0;;
a0000001004f1310 <proc_fork_connector+0x90> [MMI]       add r31=r14,r2;;
a0000001004f1316 <proc_fork_connector+0x96>             ld4 r38=[r31]
a0000001004f131c <proc_fork_connector+0x9c>             nop.i 0x0;;
a0000001004f1320 <proc_fork_connector+0xa0> [MMI]       adds r39=1,r38
a0000001004f1326 <proc_fork_connector+0xa6>             st4 [r40]=r38
a0000001004f132c <proc_fork_connector+0xac>             nop.i 0x0;;
a0000001004f1330 <proc_fork_connector+0xb0> [MMI]       st4 [r31]=r39
a0000001004f1336 <proc_fork_connector+0xb6>             ld4 r29=[r30]
a0000001004f133c <proc_fork_connector+0xbc>             nop.i 0x0
a0000001004f1340 <proc_fork_connector+0xc0> [MMI]       nop.m 0x0;;
a0000001004f1346 <proc_fork_connector+0xc6>             st4 [r28]=r29
a0000001004f134c <proc_fork_connector+0xcc>             nop.i 0x0;;
a0000001004f1350 <proc_fork_connector+0xd0> [MMI]       ld4 r27=[r19];;
a0000001004f1356 <proc_fork_connector+0xd6>             adds r26=-1,r27
a0000001004f135c <proc_fork_connector+0xdc>             nop.i 0x0
a0000001004f1360 <proc_fork_connector+0xe0> [MMI]       nop.m 0x0;;
a0000001004f1366 <proc_fork_connector+0xe6>             st4 [r19]=r26
a0000001004f136c <proc_fork_connector+0xec>             nop.i 0x0;;
a0000001004f1370 <proc_fork_connector+0xf0> [MMI]       adds r25=16,r20
a0000001004f1376 <proc_fork_connector+0xf6>             nop.m 0x0
a0000001004f137c <proc_fork_connector+0xfc>             adds r33=24,r12;;
a0000001004f1380 <proc_fork_connector+0x100> [MII]       ld4.acq r24=[r25]
a0000001004f1386 <proc_fork_connector+0x106>             nop.i 0x0;;
a0000001004f138c <proc_fork_connector+0x10c>             tbit.z p8,p9=r24,2
a0000001004f1390 <proc_fork_connector+0x110> [MMB]       nop.m 0x0
a0000001004f1396 <proc_fork_connector+0x116>             nop.m 0x0
a0000001004f139c <proc_fork_connector+0x11c>       (p09) br.call.spnt.many b0=a0000001007a8ee0 <preempt_schedule>;;
a0000001004f13a0 <proc_fork_connector+0x120> [MIB]       mov r38=r33
a0000001004f13a6 <proc_fork_connector+0x126>             nop.i 0x0
a0000001004f13ac <proc_fork_connector+0x12c>             br.call.sptk.many b0=a0000001000dbbe0 <ktime_get_ts>;;
a0000001004f13b0 <proc_fork_connector+0x130> [MMI]       nop.m 0x0
a0000001004f13b6 <proc_fork_connector+0x136>             addl r23=-2061232,r1
a0000001004f13bc <proc_fork_connector+0x13c>             nop.i 0x0;;
a0000001004f13c0 <proc_fork_connector+0x140> [MIB]       ld8 r38=[r23]
a0000001004f13c6 <proc_fork_connector+0x146>             nop.i 0x0
a0000001004f13cc <proc_fork_connector+0x14c>             br.call.sptk.many b0=a0000001000a36c0 <printk>;;
a0000001004f13d0 <proc_fork_connector+0x150> [MMI]       addl r22=-2061224,r1
a0000001004f13d6 <proc_fork_connector+0x156>             ld8 r17=[r33],8
a0000001004f13dc <proc_fork_connector+0x15c>             nop.i 0x0
a0000001004f13e0 <proc_fork_connector+0x160> [MMI]       adds r2=16,r12;;
a0000001004f13e6 <proc_fork_connector+0x166>             nop.m 0x0
a0000001004f13ec <proc_fork_connector+0x16c>             shl r19=r17,5
a0000001004f13f0 <proc_fork_connector+0x170> [MMI]       ld8 r8=[r33]
a0000001004f13f6 <proc_fork_connector+0x176>             ld8 r38=[r22]
a0000001004f13fc <proc_fork_connector+0x17c>             adds r33=400,r32;;
a0000001004f1400 <proc_fork_connector+0x180> [MII]       nop.m 0x0
a0000001004f1406 <proc_fork_connector+0x186>             sub r21=r19,r17;;
a0000001004f140c <proc_fork_connector+0x18c>             shl r18=r21,6;;
a0000001004f1410 <proc_fork_connector+0x190> [MII]       nop.m 0x0
a0000001004f1416 <proc_fork_connector+0x196>             sub r11=r18,r21;;
a0000001004f141c <proc_fork_connector+0x19c>             shladd r10=r11,3,r17;;
a0000001004f1420 <proc_fork_connector+0x1a0> [MII]       nop.m 0x0
a0000001004f1426 <proc_fork_connector+0x1a6>             shladd r16=r10,2,r10;;
a0000001004f142c <proc_fork_connector+0x1ac>             shladd r9=r16,2,r16;;
a0000001004f1430 <proc_fork_connector+0x1b0> [MII]       nop.m 0x0
a0000001004f1436 <proc_fork_connector+0x1b6>             shladd r15=r9,2,r9;;
a0000001004f143c <proc_fork_connector+0x1bc>             shl r20=r15,9;;
a0000001004f1440 <proc_fork_connector+0x1c0> [MMI]       nop.m 0x0
a0000001004f1446 <proc_fork_connector+0x1c6>             add r3=r20,r8
a0000001004f144c <proc_fork_connector+0x1cc>             nop.i 0x0;;
a0000001004f1450 <proc_fork_connector+0x1d0> [MIB]       st8 [r2]=r3
a0000001004f1456 <proc_fork_connector+0x1d6>             nop.i 0x0
a0000001004f145c <proc_fork_connector+0x1dc>             br.call.sptk.many b0=a0000001000a36c0 <printk>;;
a0000001004f1460 <proc_fork_connector+0x1e0> [MMI]       addl r38=-2061216,r1
a0000001004f1466 <proc_fork_connector+0x1e6>             adds r14=16,r12
a0000001004f146c <proc_fork_connector+0x1ec>             adds r39=68,r12;;
a0000001004f1470 <proc_fork_connector+0x1f0> [MMI]       ld8 r40=[r14]
a0000001004f1476 <proc_fork_connector+0x1f6>             ld8 r38=[r38]
a0000001004f147c <proc_fork_connector+0x1fc>             nop.i 0x0;;
a0000001004f1480 <proc_fork_connector+0x200> [MIB]       st8 [r39]=r40
a0000001004f1486 <proc_fork_connector+0x206>             nop.i 0x0
a0000001004f148c <proc_fork_connector+0x20c>             br.call.sptk.many b0=a0000001000a36c0 <printk>;;
a0000001004f1490 <proc_fork_connector+0x210> [MMI]       addl r25=-1986756,r1
a0000001004f1496 <proc_fork_connector+0x216>             ld8 r29=[r33]
a0000001004f149c <proc_fork_connector+0x21c>             mov r31=1
a0000001004f14a0 <proc_fork_connector+0x220> [MMI]       adds r30=60,r12
a0000001004f14a6 <proc_fork_connector+0x226>             adds r27=392,r32
a0000001004f14ac <proc_fork_connector+0x22c>             adds r28=388,r32;;
a0000001004f14b0 <proc_fork_connector+0x230> [MMI]       st4 [r30]=r31
a0000001004f14b6 <proc_fork_connector+0x236>             adds r26=388,r29
a0000001004f14bc <proc_fork_connector+0x23c>             adds r23=76,r12
a0000001004f14c0 <proc_fork_connector+0x240> [MMI]       adds r22=392,r29
a0000001004f14c6 <proc_fork_connector+0x246>             adds r21=84,r12
a0000001004f14cc <proc_fork_connector+0x24c>             adds r17=88,r12
a0000001004f14d0 <proc_fork_connector+0x250> [MMI]       ld4 r20=[r25],4
a0000001004f14d6 <proc_fork_connector+0x256>             ld4 r19=[r28]
a0000001004f14dc <proc_fork_connector+0x25c>             adds r10=80,r12
a0000001004f14e0 <proc_fork_connector+0x260> [MMI]       adds r9=44,r12
a0000001004f14e6 <proc_fork_connector+0x266>             mov r15=32
a0000001004f14ec <proc_fork_connector+0x26c>             adds r8=56,r12;;
a0000001004f14f0 <proc_fork_connector+0x270> [MMI]       ld4 r24=[r26]
a0000001004f14f6 <proc_fork_connector+0x276>             ld4 r18=[r27]
a0000001004f14fc <proc_fork_connector+0x27c>             adds r3=52,r12
a0000001004f1500 <proc_fork_connector+0x280> [MMI]       mov r38=r34
a0000001004f1506 <proc_fork_connector+0x286>             mov r39=1
a0000001004f150c <proc_fork_connector+0x28c>             mov r40=208
a0000001004f1510 <proc_fork_connector+0x290> [MII]       ld4 r16=[r25]
a0000001004f1516 <proc_fork_connector+0x296>             nop.i 0x0;;
a0000001004f151c <proc_fork_connector+0x29c>             nop.i 0x0
a0000001004f1520 <proc_fork_connector+0x2a0> [MMI]       st4 [r23]=r24
a0000001004f1526 <proc_fork_connector+0x2a6>             ld4 r11=[r22]
a0000001004f152c <proc_fork_connector+0x2ac>             nop.i 0x0
a0000001004f1530 <proc_fork_connector+0x2b0> [MMI]       st4 [r21]=r19
a0000001004f1536 <proc_fork_connector+0x2b6>             st4 [r17]=r18
a0000001004f153c <proc_fork_connector+0x2bc>             nop.i 0x0;;
a0000001004f1540 <proc_fork_connector+0x2c0> [MMI]       st4 [r10]=r11
a0000001004f1546 <proc_fork_connector+0x2c6>             st4 [r9]=r16
a0000001004f154c <proc_fork_connector+0x2cc>             nop.i 0x0
a0000001004f1550 <proc_fork_connector+0x2d0> [MMI]       st4 [r34]=r20
a0000001004f1556 <proc_fork_connector+0x2d6>             st2 [r8]=r15
a0000001004f155c <proc_fork_connector+0x2dc>             nop.i 0x0
a0000001004f1560 <proc_fork_connector+0x2e0> [MIB]       st4 [r3]=r0
a0000001004f1566 <proc_fork_connector+0x2e6>             nop.i 0x0
a0000001004f156c <proc_fork_connector+0x2ec>             br.call.sptk.many b0=a0000001004f02e0 <cn_netlink_send>;;
a0000001004f1570 <proc_fork_connector+0x2f0> [MII]       nop.m 0x0
a0000001004f1576 <proc_fork_connector+0x2f6>             mov.i ar.pfs=r36
a0000001004f157c <proc_fork_connector+0x2fc>             mov b0=r35
a0000001004f1580 <proc_fork_connector+0x300> [MIB]       nop.m 0x0
a0000001004f1586 <proc_fork_connector+0x306>             adds r12=80,r12
a0000001004f158c <proc_fork_connector+0x30c>             br.ret.sptk.many b0;;
a0000001004f1590 <proc_fork_connector+0x310> [MMI]       nop.m 0x0
a0000001004f1596 <proc_fork_connector+0x316>             nop.m 0x0
a0000001004f159c <proc_fork_connector+0x31c>             nop.i 0x0
Disassembly of section .init.text:
Disassembly of section .data.page_aligned:
