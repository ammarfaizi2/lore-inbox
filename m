Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWEBOhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWEBOhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWEBOhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:37:16 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:29898
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964848AbWEBOhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:37:14 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Carsten Paeth <calle@calle.de>
Subject: [PATCH, RFC] CAPI crash / race condition
Date: Tue, 2 May 2006 16:43:24 +0200
User-Agent: KMail/1.9.1
Cc: kai.germaschewski@gmx.de, kkeil@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605021643.24618.mb@bu3sch.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting more or less reproducible crashes from
the CAPI subsystem using the fcdsl driver:

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c39bbca4
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: netconsole capi capifs 3c59x mii fcdsl kernelcapi uhci_hcd usbcore ide_cd cdrom
CPU:    0
EIP:    0060:[<c39bbca4>]    Tainted: P      VLI
EFLAGS: 00010202   (2.6.16.11 #3) 
EIP is at handle_minor_send+0x17a/0x241 [capi]
eax: c24abbc0   ebx: c0b4c980   ecx: 00000010   edx: 00000010
esi: c1679140   edi: c2783016   ebp: 0000c28d   esp: c0327e24
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0326000 task=c02e1300)
Stack: <0>000005b4 c1679180 00000000 c28d0000 c1ce04e0 c2f69654 c221604e c1679140 
       c39bc19a 00000038 c20c0400 c075c560 c1f2f800 00000000 c01dc9b5 c1e96a40 
       c075c560 c2ed64c0 c1e96a40 c01dcd3b c2fb94e8 c075c560 c0327f00 c1e96a40 
Call Trace:
 [<c39bc19a>] capinc_tty_write+0xda/0xf3 [capi]
 [<c01dc9b5>] ppp_sync_push+0x52/0xfe
 [<c01dcd3b>] ppp_sync_send+0x1f5/0x204
 [<c01d9bc1>] ppp_push+0x3e/0x9c
 [<c01dacd4>] ppp_xmit_process+0x422/0x4cc
 [<c01daf3f>] ppp_start_xmit+0x1c1/0x1f6
 [<c0213ea5>] qdisc_restart+0xa7/0x135
 [<c020b112>] dev_queue_xmit+0xba/0x19e
 [<c0223f69>] ip_output+0x1eb/0x236
 [<c0220907>] ip_forward+0x1c1/0x21a
 [<c021fa6c>] ip_rcv+0x38e/0x3ea
 [<c020b4c2>] netif_receive_skb+0x166/0x195
 [<c020b55e>] process_backlog+0x6d/0xd2
 [<c020a30f>] net_rx_action+0x6a/0xff
 [<c0112909>] __do_softirq+0x35/0x7d
 [<c0112973>] do_softirq+0x22/0x26
 [<c0103a9d>] do_IRQ+0x1e/0x25
 [<c010255a>] common_interrupt+0x1a/0x20
 [<c01013c5>] default_idle+0x2b/0x53
 [<c0101426>] cpu_idle+0x39/0x4e
 [<c0328386>] start_kernel+0x20b/0x20d
Code: c0 e8 b3 b6 77 fc 85 c0 75 10 68 d8 c8 9b c3 e8 82 3d 75 fc 8b 43 60 5a eb 50 8d 56 50 c7 00 00 00 00 00 66 89 68 04 eb 02 89 
ca <8b> 0a 85 c9 75 f8 89 02 89 da ff 46 54 8b 46 10 e8 30 79 fd ff 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

That oops took me to the "ackqueue" implementation in
capi.c. The crash occured in capincci_add_ack() (auto-inlined
by the compiler).
I read the code a bit and finally decided to replace the custom
linked list implementation (struct capiminor->ackqueue) by a
struct list_head. That did not solve the crash, but produced the following
interresting oops:

Unable to handle kernel paging request at virtual address 00200200
 printing eip:
c39bb1f5
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: netconsole capi capifs 3c59x mii fcdsl kernelcapi uhci_hcd usbcore ide_cd cdrom
CPU:    0
EIP:    0060:[<c39bb1f5>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.16.11 #3) 
EIP is at capiminor_del_ack+0x18/0x49 [capi]
eax: 00200200   ebx: c18d41a0   ecx: c1385620   edx: 00100100
esi: 0000d147   edi: 00001103   ebp: 0000d147   esp: c1093f3c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1092000 task=c1089030)
Stack: <0>c2a17580 c18d41a0 c39bbd16 00000038 c18d41e0 00000000 d147c640 c29e0b68 
       c29e0b90 00000212 c29e0b68 c39932b2 c29e0bb0 c10736a0 c0119ef0 c399326c 
       c10736a8 c10736a0 c10736b0 c0119f93 c011a06e 00000001 00000000 00000000 
Call Trace:
 [<c39bbd16>] handle_minor_send+0x1af/0x241 [capi]
 [<c39932b2>] recv_handler+0x46/0x5f [kernelcapi]
 [<c0119ef0>] run_workqueue+0x5e/0x8d
 [<c399326c>] recv_handler+0x0/0x5f [kernelcapi]
 [<c0119f93>] worker_thread+0x0/0x10b
 [<c011a06e>] worker_thread+0xdb/0x10b
 [<c010c998>] default_wake_function+0x0/0xc
 [<c011c399>] kthread+0x90/0xbc
 [<c011c309>] kthread+0x0/0xbc
 [<c0100a65>] kernel_thread_helper+0x5/0xb
Code: 7e 02 89 ee 89 f0 5a f7 d0 c1 f8 1f 5b 21 f0 5e 5f 5d c3 56 53 8b 48 50 89 d6 89 c3 8b 11 eb 2f 66 39 71 08 75 25 8b 41 04 8b 11 <89> 10 89 42 04 c7 01 00 01 10 00 89 c8 c7 41 04 00 02 20 00 e8 

The interresting part of it is the "virtual address 00200200", which
is LIST_POISON2. I thought about some race condition, but as this is
an UP system, it leads to questions on how it can happen.
If we look at EFLAGS: 00010202, we see that interrupts are enabled
at the time of the crash (eflags & 0x200).

Finally, I don't understand all the capi code, but I think that
handle_minor_send() is racing somehow against capi_recv_message(),
which call both capiminor_del_ack(). So if an IRQ occurs in the middle
of capiminor_del_ack() and another instance of it is invoked, it leads
to linked list corruption.

I came up with the following patch:

Index: linux-2.6.16.11/drivers/isdn/capi/capi.c
===================================================================
--- linux-2.6.16.11.orig/drivers/isdn/capi/capi.c	2006-04-29 15:01:24.000000000 +0200
+++ linux-2.6.16.11/drivers/isdn/capi/capi.c	2006-04-30 18:58:29.000000000 +0200
@@ -87,6 +87,11 @@
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 struct capiminor;
 
+struct datahandle_queue {
+	struct list_head	list;
+	u16			datahandle;
+};
+
 struct capiminor {
 	struct list_head list;
 	struct capincci  *nccip;
@@ -109,12 +114,9 @@
 	int                 outbytes;
 
 	/* transmit path */
-	struct datahandle_queue {
-		    struct datahandle_queue *next;
-		    u16                    datahandle;
-	} *ackqueue;
+	struct list_head ackqueue;
 	int nack;
-
+	spinlock_t ackqlock;
 };
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 
@@ -156,48 +158,54 @@
 
 static int capincci_add_ack(struct capiminor *mp, u16 datahandle)
 {
-	struct datahandle_queue *n, **pp;
+	struct datahandle_queue *n;
+	unsigned long flags;
 
 	n = kmalloc(sizeof(*n), GFP_ATOMIC);
-	if (!n) {
-	   printk(KERN_ERR "capi: alloc datahandle failed\n");
-	   return -1;
+	if (unlikely(!n)) {
+		printk(KERN_ERR "capi: alloc datahandle failed\n");
+		return -1;
 	}
-	n->next = NULL;
 	n->datahandle = datahandle;
-	for (pp = &mp->ackqueue; *pp; pp = &(*pp)->next) ;
-	*pp = n;
+	INIT_LIST_HEAD(&n->list);
+	spin_lock_irqsave(&mp->ackqlock, flags);
+	list_add_tail(&n->list, &mp->ackqueue);
 	mp->nack++;
+	spin_unlock_irqrestore(&mp->ackqlock, flags);
 	return 0;
 }
 
 static int capiminor_del_ack(struct capiminor *mp, u16 datahandle)
 {
-	struct datahandle_queue **pp, *p;
+	struct datahandle_queue *p, *tmp;
+	unsigned long flags;
 
-	for (pp = &mp->ackqueue; *pp; pp = &(*pp)->next) {
- 		if ((*pp)->datahandle == datahandle) {
-			p = *pp;
-			*pp = (*pp)->next;
+	spin_lock_irqsave(&mp->ackqlock, flags);
+	list_for_each_entry_safe(p, tmp, &mp->ackqueue, list) {
+ 		if (p->datahandle == datahandle) {
+			list_del(&p->list);
 			kfree(p);
 			mp->nack--;
+			spin_unlock_irqrestore(&mp->ackqlock, flags);
 			return 0;
 		}
 	}
+	spin_unlock_irqrestore(&mp->ackqlock, flags);
 	return -1;
 }
 
 static void capiminor_del_all_ack(struct capiminor *mp)
 {
-	struct datahandle_queue **pp, *p;
+	struct datahandle_queue *p, *tmp;
+	unsigned long flags;
 
-	pp = &mp->ackqueue;
-	while (*pp) {
-		p = *pp;
-		*pp = (*pp)->next;
+	spin_lock_irqsave(&mp->ackqlock, flags);
+	list_for_each_entry_safe(p, tmp, &mp->ackqueue, list) {
+		list_del(&p->list);
 		kfree(p);
 		mp->nack--;
 	}
+	spin_unlock_irqrestore(&mp->ackqlock, flags);
 }
 
 
@@ -220,6 +228,8 @@
 	mp->ncci = ncci;
 	mp->msgid = 0;
 	atomic_set(&mp->ttyopencount,0);
+	INIT_LIST_HEAD(&mp->ackqueue);
+	spin_lock_init(&mp->ackqlock);
 
 	skb_queue_head_init(&mp->inqueue);
 	skb_queue_head_init(&mp->outqueue);


With this, I could not reproduce the crash anymore.
Clearly, this is not the correct fix for the issue.
As this seems to be some locking issue, there might be
more locking issues in that code. For example, doesn't the
whole struct capiminor have to be locked somehow?

-- 
Greetings Michael.
