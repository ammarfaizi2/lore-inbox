Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310809AbSCHLPh>; Fri, 8 Mar 2002 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310810AbSCHLPS>; Fri, 8 Mar 2002 06:15:18 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:30898 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310809AbSCHLPQ>; Fri, 8 Mar 2002 06:15:16 -0500
Date: Fri, 8 Mar 2002 13:00:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH][2.5] BUG check in elevator.c:237
Message-ID: <Pine.LNX.4.44.0203081258500.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please refer to Subject [PANIC] 2.5.5-pre1 elevator.c for more detailed 
explanation.

I don't really like this patch mainly because it _really_ feels like a 
bandaid for a larger problem in ide-cd, namely it violating the ide 
layers command requirements. But it does stop my box from oopsing and 
lets it finish the "dd" i was doing. Oops is at the end.

diffed against 2.5.6-pre3 (one down 2 quadrillion to go ;)

--- linux-2.5.6-pre/drivers/ide/ide-cd.c.orig	Fri Mar  8 12:09:10 2002
+++ linux-2.5.6-pre/drivers/ide/ide-cd.c	Fri Mar  8 12:04:08 2002
@@ -666,9 +666,11 @@
 			cdrom_end_request(drive, 0);
 		}
 
-		/* If we got a CHECK_CONDITION status,
-		   queue a request sense command. */
-		if ((stat & ERR_STAT) != 0)
+		/* If we got a CHECK_CONDITION status, queue a request sense command,
+		   however if we're generating spurious errors, make sure we don't
+		   attempt to queue an an already started request.
+		*/
+		if (((stat & ERR_STAT) != 0) && !(rq->flags & REQ_STARTED))
 			cdrom_queue_request_sense(drive, NULL, NULL, NULL);
 	} else
 		blk_dump_rq_flags(rq, "ide-cd bad flags");



invalid operand: 0000
CPU:    0
EIP:    0010:[<c01ebb68>]    Not tainted
EFLAGS: 00010086
eax: 0000001e   ebx: cfdd6c50   ecx: ffffff43   edx: 000017b6
esi: c03753c8   edi: c03753c8   ebp: c159ca64   esp: c02fdc68
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c02fc000 task=c02e3ec0)
Stack: c02bc7c5 000000ed 00000000 c03753c8 c03753c8 00000002 00000002 c01fd4a9 
       c03753c8 cfdd6c50 c03753c8 c15ab37c 00000000 00000000 c02fdcb0 c02fdcb0 
       00000000 00000000 c02fdcb0 c02fdcb0 00000000 cfdd3a78 c03753c8 00000001 
Call Trace: [<c01fd4a9>] [<c02070ec>] [<c0207471>] [<c0121075>] [<c01213ed>] 
   [<c010d54b>] [<c010a1ea>] [<c010a434>] [<c01153d3>] [<c01319f8>] [<c022e91b>] 
   [<c022ea82>] [<c0230a5d>] [<c028fbf0>] [<c028d4d3>] [<c025f478>] [<c025f835>] 
   [<c0232c09>] [<c024118b>] [<c0241524>] [<c01fd2c6>] [<c0207400>] [<c010a1ea>] 
   [<c010a3e1>] [<c0106d50>] [<c0106d50>] [<c0106d50>] [<c0106d74>] [<c0106df2>] 
   [<c0105000>] 

Code: 0f 0b 58 5a 8b 43 1c a9 04 00 00 00 75 0a 83 e0 01 8b 44 85 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; c01ebb68 <elevator_linus_add_request+38/90>   <=====
Trace; c01fd4a9 <ide_do_drive_cmd+c9/120>
Trace; c02070ec <cdrom_decode_status+1fc/230>
Trace; c0207471 <cdrom_read_intr+71/330>
Trace; c0121075 <update_process_times+25/30>
Trace; c01213ed <do_timer+3d/70>
Trace; c010d54b <timer_interrupt+13b/150>
Trace; c010a1ea <handle_IRQ_event+3a/70>
Trace; c010a434 <do_IRQ+e4/f0>
Trace; c01153d3 <try_to_wake_up+183/190>
Trace; c01319f8 <kfree+1d8/270>
Trace; c022e91b <kfree_skbmem+b/60>
Trace; c022ea82 <__kfree_skb+112/120>
Trace; c0230a5d <skb_free_datagram+1d/30>
Trace; c028fbf0 <rpc_unlock_task+90/a0>
Trace; c028d4d3 <udp_data_ready+243/280>
Trace; c025f478 <udp_queue_rcv_skb+178/1c0>
Trace; c025f835 <udp_rcv+165/2c0>
Trace; c0232c09 <netif_rx+79/f0>
Trace; c024118b <ip_local_deliver+12b/1c0>
Trace; c0241524 <ip_rcv+304/370>
Trace; c01fd2c6 <ide_intr+d6/150>
Trace; c0207400 <cdrom_read_intr+0/330>
Trace; c010a1ea <handle_IRQ_event+3a/70>
Trace; c010a3e1 <do_IRQ+91/f0>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d50 <default_idle+0/30>
Trace; c0106d74 <default_idle+24/30>
Trace; c0106df2 <cpu_idle+32/50>
Trace; c0105000 <_stext+0/0>
Code;  c01ebb68 <elevator_linus_add_request+38/90>
00000000 <_EIP>:
Code;  c01ebb68 <elevator_linus_add_request+38/90>   <=====

