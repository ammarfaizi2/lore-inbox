Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTHVPGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTHVPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:06:33 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:51471 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S263827AbTHVPFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:05:07 -0400
Date: Fri, 22 Aug 2003 17:05:03 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <irda-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: <pl@dsa-ac.de>
Subject: [PATCH] + IrDA state
Message-ID: <Pine.LNX.4.33.0308221632200.2856-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

We have a StrongARM-1110-based device, that has to build and break Ir
connections multiple times, staying online, and, in parallel, we issue
multiple ifconfig requests both to irda0 and ppp0 interfaces. And then
straight away, we've got all the problems - memory leaks, races,... We've
gone the way from 2.4.13 to 2.4.21, fixed a few bugs ourselves (see
attached at the end of the email patch), but there are still a few left.
With 2.4.21 + 2 more patches from 2.4.22-pre* (with or without our patch)
our system leaks memory, and, typically, Oopses after some time in iriap.c
in iriap_getvaluebyclass_request(). What happens, is the following: in
irnet_discover_next_daddr() iriap_open() is called, which allocates and
initialises a iriap_cb structure, then iriap_getvaluebyclass_request() is
called, but there data is corrupted. Which looks like a race condition,
which we can't understand so far. First time it ended up with a BUG() in
skb_over_panic(), second time the pointer to the callback function went
wrong. Here are the 2 decoded Oopses with comments:

skput:over: c18f5730:29 put:29 dev:ULL>kernel BUG at skbuff.c:92!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
Internal error: Oops: c0c7f805
CPU: 0
pc : [001a634>]    lr : [0021a04>]    Not tainted
sp : c0b3bee8  ip : c0b7c000  fp : c0b3bef8
r10: c19380cc  r9 : c0b3a000  r8 : 00000013
Warning (Oops_set_i370_regs): garbage 'r9 : c0b3a000  r8 : 00000013' at
end of i370 register line ignored
r7 : 00000007  r6 : c0a177cc  r5 : c034911c  r4 : 00000000
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: C0C7F17F  Table: C0C7F17F  DAC: 00000015
Stack: (0xc0b3bee8 to 0xc0b3c000)
bee0:                   c19380c4 c0b3bf0c c0b3befc c00a431c c001a5fc c0108768
bf00: c0b3bf34 c0b3bf10 c18f5740 c00a42dc ffffffff c0bcba00 00000000 c0bcbab0
bf20: ffffffe7 02035dcc c0b3bf64 c0b3bf38 c193558c c18f561c c19380cc ffffffe7
bf40: 00000000 c0bcba00 02037ba4 02037ba4 ffffffe7 02035dcc c0b3bf80 c0b3bf68
bf60: c1934b3c c193543c c08ddf04 00005423 00000000 c0b3bfa4 c0b3bf84 c0052920
bf80: c19349bc 02037bd8 02035dc4 00000000 00000036 c0015604 00000000 c0b3bfa8
bfa0: c0015460 c0052730 02037bd8 c001e0ac 00000000 00005423 02037ba4 02038088
bfc0: 02037bd8 02035dc4 00000000 00000000 02035dc4 02037339 02035dcc bffffdf0
bfe0: 020386f8 bffffdcc 02019f78 400f1794 60000010 00000000 00000000 00000000
Backtrace:
Function entered at [<c001a5f0>] from [<c00a431c>]
 r4 = C19380C4
Function entered at [<c00a42d0>] from [<c18f5740>]
Function entered at [<c18f5610>] from [<c193558c>]
Function entered at [<c1935430>] from [<c1934b3c>]
Function entered at [<c19349b0>] from [<c0052920>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>r10; c19380cc <[irnet].rodata.start+14a4/2e87>
Trace; c001a5f0 <__bug+0/58>
Trace; c00a431c <skb_over_panic+4c/60>
Trace; c00a42d0 <skb_over_panic+0/60>
Trace; c18f5740 <[irda]iriap_getvaluebyclass_request+130/15e8>
Trace; c18f5610 <[irda]iriap_getvaluebyclass_request+0/15e8>
Trace; c193558c <[irnet]irda_irnet_connect+15c/2d4>
Trace; c1935430 <[irnet]irda_irnet_connect+0/2d4>
Trace; c1934b3c <[irnet].text.start+ae8/120c>
Trace; c19349b0 <[irnet].text.start+95c/120c>
Trace; c0052920 <sys_ioctl+1fc/218>

Second one:

Unable to handle kernel paging request at virtual address 5a5a5a58
Internal error: Oops: 0
CPU: 0
pc : [<5a5a5a58>]    lr : [<c18fdf40>]    Not tainted
Using defaults from ksymoops -t elf32-i386
sp : c0b33ec8  ip : c047a16c  fp : c0b33ee4
r10: c19380b4  r9 : c0b32000  r8 : 00000013
Warning (Oops_set_i370_regs): garbage 'r9 : c0b32000  r8 : 00000013' at
end of i370 register line ignored
r7 : 00000007  r6 : c0cd9cfc  r5 : 00000000  r4 : c0cd9cfc
r3 : 5a5a5a5a  r2 : 00000000  r1 : 00000000  r0 : 0000000a
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: C0B4B17F  Table: C0B4B17F  DAC: 00000015
Stack: (0xc0b33ec8 to 0xc0b34000)
3ec0:                   00000000 00000000 c0cd9cfc c06fb96c c0b33efc c0b33ee8
3ee0: c18fe6b4 c18fdee8 c0cd984b c06fb96c c0b33f0c c0b33f00 c18fe5ac c18fe674
3f00: c0b33f34 c0b33f10 c18fd788 c18fe584 ffffffff c0bc8600 00000000 c0bc86b0
3f20: ffffffe7 02035dcc c0b33f64 c0b33f38 c1935580 c18fd61c c19380b4 ffffffe7
3f40: 00000000 c0bc8600 02037ba4 02037ba4 ffffffe7 02035dcc c0b33f80 c0b33f68
3f60: c1934b3c c193543c c0c9ae54 00005423 00000000 c0b33fa4 c0b33f84 c0052920
3f80: c19349bc 02037bd8 02035dc4 00000000 00000036 c0015604 00000000 c0b33fa8
3fa0: c0015460 c0052730 02037bd8 c0016044 00000000 00005423 02037ba4 02038088
3fc0: 02037bd8 02035dc4 00000000 00000000 02035dc4 02037339 02035dcc bffffdf0
3fe0: 020386f8 bffffdcc 02019f78 400f1794 60000010 00000000 00000000 00000000
Backtrace:
Function entered at [<c18fdedc>] from [<c18fe6b4>]
 r5 = C06FB96C  r4 = C0CD9CFC
Function entered at [<c18fe668>] from [<c18fe5ac>]
 r5 = C06FB96C  r4 = C0CD984B
Function entered at [<c18fe578>] from [<c18fd788>]
Function entered at [<c18fd610>] from [<c1935580>]
Function entered at [<c1935430>] from [<c1934b3c>]
Function entered at [<c19349b0>] from [<c0052920>]
 r6 = 00000000  r5 = 00005423  r4 = C0C9AE54
Function entered at [<c0052724>] from [<c0015460>]
 r8 = C0015604  r7 = 00000036  r6 = 00000000  r5 = 02035DC4
 r4 = 02037BD8
Code: bad PC value.
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; 5a5a5a58 Before first symbol   <=====
>>r10; c19380b4 <[irnet].rodata.start+14a4/2e87>
Trace; c18fdedc <[irda]iriap_getvaluebyclass_request+8cc/15d8>	@ iriap_connect_request
Trace; c18fe6b4 <[irda]iriap_getvaluebyclass_request+10a4/15d8>
Trace; c18fe668 <[irda]iriap_getvaluebyclass_request+1058/15d8>	@ state_s_disconnect
Trace; c18fe5ac <[irda]iriap_getvaluebyclass_request+f9c/15d8>
Trace; c18fe578 <[irda]iriap_getvaluebyclass_request+f68/15d8>	@ iriap_do_client_event
Trace; c18fd788 <[irda]iriap_getvaluebyclass_request+178/15d8>
Trace; c18fd610 <[irda]iriap_getvaluebyclass_request+0/15d8>
								@ inline irnet_discover_next_daddr
								@ inline irnet_discover_daddr_and_lsap_sel
Trace; c1935580 <[irnet]irda_irnet_connect+150/2c8>
Trace; c1935430 <[irnet]irda_irnet_connect+0/2c8>
Trace; c1934b3c <[irnet].text.start+ae8/120c>
Trace; c19349b0 <[irnet].text.start+95c/120c>
Trace; c0052920 <sys_ioctl+1fc/218>
Trace; c0052724 <sys_ioctl+0/218>
Trace; c0015460 <ret_fast_syscall+0/38>

As usual, ideas?

Thanks
Peter Lueg, Guennadi Liakhovetski
P.S. The patch below addresses several problems, and, as such, can be
trivially splitted into several pieces, if needed. Some edges are not
quite smooth, e.g. locking in hashbin_get_first() (if at all needed) has
to be done with a spin_lock, not with save_flags(); cli(); but we didn't
find a suitable spinlock, and didn't create one ourselves. BTW, this is
also done in hashbin_remove_first(), which, perhaps, is also wrong.
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

diff -urp linux-2.4.21/drivers/net/irda/sa1100_ir.c linux-2.4.21-rmk1-dsa/drivers/net/irda/sa1100_ir.c
--- linux-2.4.21/drivers/net/irda/sa1100_ir.c	Fri Aug 22 13:58:58 2003
+++ linux-2.4.21-rmk1-dsa/drivers/net/irda/sa1100_ir.c	Wed Aug 20 15:13:34 2003
@@ -92,7 +92,7 @@ static int sa1100_irda_rx_alloc(struct s
 	if (si->rxskb)
 		return 0;

-	si->rxskb = alloc_skb(HPSIR_MAX_RXLEN + 1, GFP_ATOMIC);
+	si->rxskb = alloc_skb(HPSIR_MAX_RXLEN + 3, GFP_ATOMIC);

 	if (!si->rxskb) {
 		printk(KERN_ERR "sa1100_ir: out of memory for RX SKB\n");
@@ -103,7 +103,7 @@ static int sa1100_irda_rx_alloc(struct s
 	 * Align any IP headers that may be contained
 	 * within the frame.
 	 */
-	skb_reserve(si->rxskb, 1);
+	skb_reserve(si->rxskb, 3);

 	si->rxbuf_dma = pci_map_single(NULL, si->rxskb->data,
 					HPSIR_MAX_RXLEN,
@@ -767,8 +767,12 @@ static int sa1100_irda_hard_xmit(struct
 		/*
 		 * We must not be transmitting...
 		 */
-		if (si->txskb)
-			BUG();
+		if (si->txskb) {
+			/* Cancel the first send. */
+			pci_unmap_single(NULL, si->txbuf_dma, skb->len, PCI_DMA_TODEVICE);
+			dev_kfree_skb_irq(skb);
+			printk(__FUNCTION__" More than one TX, remove 1st\n");
+		}

 		netif_stop_queue(dev);

@@ -830,6 +834,7 @@ sa1100_irda_ioctl(struct net_device *dev
 	case SIOCGRECEIVING:
 		rq->ifr_receiving = IS_FIR(si) ? 0
 					: si->rx_buff.state != OUTSIDE_FRAME;
+		ret = 0; // This IOCTL is supported (pl)
 		break;

 	default:
diff -urp linux-2.4.21/net/irda/irda_device.c linux-2.4.21-rmk1-dsa/net/irda/irda_device.c
--- linux-2.4.21/net/irda/irda_device.c	Fri Aug 22 13:46:30 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irda_device.c	Thu Aug 21 13:23:09 2003
@@ -116,6 +116,7 @@ int __init irda_device_init( void)
 	if (tasks == NULL) {
 		printk(KERN_WARNING
 		       "IrDA: Can't allocate tasks hashbin!\n");
+		hashbin_delete(dongles, NULL);
 		return -ENOMEM;
 	}

diff -urp linux-2.4.21/net/irda/iriap.c linux-2.4.21-rmk1-dsa/net/irda/iriap.c
--- linux-2.4.21/net/irda/iriap.c	Fri Aug 22 13:59:00 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/iriap.c	Thu Aug 21 17:30:05 2003
@@ -98,7 +98,8 @@ int __init iriap_init(void)

 	objects = hashbin_new(HB_LOCAL);
 	if (!objects) {
-		WARNING("%s(), Can't allocate objects hashbin!\n", __FUNCTION__);
+		ERROR(__FUNCTION__ "(), Can't allocate objects hashbin!\n");
+		hashbin_delete(iriap, NULL);
 		return -ENOMEM;
 	}

@@ -730,6 +731,7 @@ void iriap_connect_request(struct iriap_
 				    self->saddr, self->daddr,
 				    NULL, NULL);
 	if (ret < 0) {
+		WARNING("irlmp_connect_request() failed with %d\n", ret);
 		IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
 		self->confirm(IAS_DISCONNECT, 0, NULL, self->priv);
 	}
diff -urp linux-2.4.21/net/irda/irias_object.c linux-2.4.21-rmk1-dsa/net/irda/irias_object.c
--- linux-2.4.21/net/irda/irias_object.c	Mon Nov  5 09:33:20 2001
+++ linux-2.4.21-rmk1-dsa/net/irda/irias_object.c	Thu Aug 21 13:30:37 2003
@@ -85,7 +85,7 @@ struct ias_object *irias_new_object( cha
 	obj = (struct ias_object *) kmalloc(sizeof(struct ias_object),
 					    GFP_ATOMIC);
 	if (obj == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unable to allocate object!\n");
+		ERROR(__FUNCTION__ "(), Unable to allocate object!\n");
 		return NULL;
 	}
 	memset(obj, 0, sizeof( struct ias_object));
@@ -95,6 +95,11 @@ struct ias_object *irias_new_object( cha
 	obj->id = id;

 	obj->attribs = hashbin_new(HB_LOCAL);
+	if (obj->attribs == NULL) {
+		ERROR(__FUNCTION__ "(), Unable to allocate attribs!\n");
+		kfree(obj);
+		return NULL;
+	}

 	return obj;
 }
diff -urp linux-2.4.21/net/irda/irlap.c linux-2.4.21-rmk1-dsa/net/irda/irlap.c
--- linux-2.4.21/net/irda/irlap.c	Fri Aug 22 13:46:30 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irlap.c	Thu Aug 21 13:31:07 2003
@@ -522,8 +522,12 @@ void irlap_discovery_request(struct irla
 		self->discovery_log = NULL;
 	}

-	self->discovery_log= hashbin_new(HB_LOCAL);
-
+	self->discovery_log = hashbin_new(HB_LOCAL);
+	if (self->discovery_log == NULL) {
+		ERROR(__FUNCTION__ "(), Unable to allocate discovery log!\n");
+		return;
+	}
+
 	info.S = discovery->nslots; /* Number of slots */
 	info.s = 0; /* Current slot */

diff -urp linux-2.4.21/net/irda/irlmp.c linux-2.4.21-rmk1-dsa/net/irda/irlmp.c
--- linux-2.4.21/net/irda/irlmp.c	Fri Aug 22 13:46:30 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irlmp.c	Thu Aug 21 13:36:41 2003
@@ -91,6 +91,12 @@ int __init irlmp_init(void)
 	irlmp->links = hashbin_new(HB_GLOBAL);
 	irlmp->unconnected_lsaps = hashbin_new(HB_GLOBAL);
 	irlmp->cachelog = hashbin_new(HB_GLOBAL);
+	if (!irlmp->clients ||
+	    !irlmp->services ||
+	    !irlmp->links ||
+	    !irlmp->unconnected_lsaps ||
+	    !irlmp->cachelog)
+		goto nomem;

 	irlmp->free_lsap_sel = 0x10; /* Reserved 0x00-0x0f */
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
@@ -103,6 +109,9 @@ int __init irlmp_init(void)
    	irlmp_start_discovery_timer(irlmp, sysctl_discovery_timeout*HZ);

 	return 0;
+ nomem:
+	irlmp_cleanup();
+	return -ENOMEM;
 }

 /*
@@ -256,7 +265,6 @@ void irlmp_close_lsap(struct lsap_cb *se
 	}
 	if (!lsap) {
 		IRDA_DEBUG(0, "%s(), Looks like somebody has removed me already!\n", __FUNCTION__);
-		return;
 	}
 	__irlmp_close_lsap(self);
 }
@@ -291,6 +299,11 @@ void irlmp_register_link(struct irlap_cb
 	lap->saddr = saddr;
 	lap->daddr = DEV_ADDR_ANY;
 	lap->lsaps = hashbin_new(HB_GLOBAL);
+	if (lap->lsaps == NULL) {
+		ERROR(__FUNCTION__ "(), unable to kmalloc lsaps\n");
+		kfree(lap);
+		return;
+	}

 	lap->lap_state = LAP_STANDBY;

@@ -323,8 +336,25 @@ void irlmp_unregister_link(__u32 saddr)

 	link = hashbin_remove(irlmp->links, saddr, NULL);
 	if (link) {
+		irda_queue_t* entry;
 		ASSERT(link->magic == LMP_LAP_MAGIC, return;);

+		/* Remove references to this LAP from all linked LSAPs */
+		if (link->lsaps != NULL) {
+			unsigned long flags;
+			spin_lock_irqsave(&irlmp->log_lock, flags);
+			while ((entry = hashbin_get_first(link->lsaps)) != NULL) {
+				struct lsap_cb *lsap = hashbin_remove_this(link->lsaps, entry);
+
+				ASSERT(lsap != NULL, continue;);
+				ASSERT(lsap->lap == link, continue;);
+				IRDA_DEBUG(1, __FUNCTION__"(): Closing reference from %p to %p\n", lsap, link);
+				lsap->lap = NULL;
+			}
+			spin_unlock_irqrestore(&irlmp->log_lock, flags);
+			hashbin_delete(link->lsaps, (FREE_FUNC) kfree);
+		}
+
 		/* Remove all discoveries discovered at this link */
 		irlmp_expire_discoveries(irlmp->cachelog, link->saddr, TRUE);

@@ -406,6 +436,7 @@ int irlmp_connect_request(struct lsap_cb
 		IRDA_DEBUG(1, "%s(), Unable to find a usable link!\n", __FUNCTION__);
 		return -EHOSTUNREACH;
 	}
+	ASSERT(lap->magic == LMP_LAP_MAGIC, return -EINVAL;);

 	/* Check if LAP is disconnected or already connected */
 	if (lap->daddr == DEV_ADDR_ANY)
@@ -671,6 +702,7 @@ void irlmp_disconnect_indication(struct
 				 struct sk_buff *userdata)
 {
 	struct lsap_cb *lsap;
+	struct lap_cb *lap;

 	IRDA_DEBUG(1, "%s(), reason=%s\n", __FUNCTION__, lmp_reasons[reason]);
 	ASSERT(self != NULL, return;);
@@ -698,9 +730,11 @@ void irlmp_disconnect_indication(struct
 	 *  Remove association between this LSAP and the link it used
 	 */
 	ASSERT(self->lap != NULL, return;);
-	ASSERT(self->lap->lsaps != NULL, return;);
+	lap = self->lap;
+	self->lap = NULL;
+	ASSERT(lap->lsaps != NULL, return;);

-	lsap = hashbin_remove(self->lap->lsaps, (int) self, NULL);
+	lsap = hashbin_remove(lap->lsaps, (int) self, NULL);

 	ASSERT(lsap != NULL, return;);
 	ASSERT(lsap == self, return;);
@@ -708,7 +742,6 @@ void irlmp_disconnect_indication(struct
 		       NULL);

 	self->dlsap_sel = LSAP_ANY;
-	self->lap = NULL;

 	/*
 	 *  Inform service user
@@ -1801,6 +1834,3 @@ int irlmp_proc_read(char *buf, char **st
 }

 #endif /* PROC_FS */
-
-
-
diff -urp linux-2.4.21/net/irda/irlmp_event.c linux-2.4.21-rmk1-dsa/net/irda/irlmp_event.c
--- linux-2.4.21/net/irda/irlmp_event.c	Fri Aug 22 13:46:30 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irlmp_event.c	Thu Aug 21 13:38:50 2003
@@ -872,7 +872,12 @@ static int irlmp_state_setup_pend(struct
 	case LM_WATCHDOG_TIMEOUT:
 		IRDA_DEBUG(0, "%s() : WATCHDOG_TIMEOUT !\n",  __FUNCTION__);

-		ASSERT(self->lap != NULL, return -1;);
+		if (self->lap == NULL) {
+			/* Have to free. */
+			WARNING(__FUNCTION__ "(), Watchdog timeout on a \"dead\" LSAP\n");
+			irlmp_close_lsap(self);
+			return -1;
+		}
 		irlmp_do_lap_event(self->lap, LM_LAP_DISCONNECT_REQUEST, NULL);
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);

diff -urp linux-2.4.21/net/irda/irnet/irnet_irda.c linux-2.4.21-rmk1-dsa/net/irda/irnet/irnet_irda.c
--- linux-2.4.21/net/irda/irnet/irnet_irda.c	Fri Aug 22 13:46:30 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irnet/irnet_irda.c	Thu Aug 21 17:30:25 2003
@@ -318,6 +318,8 @@ irnet_discover_next_daddr(irnet_socket *
   /* Create a new IAP instance */
   self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 			   irnet_discovervalue_confirm);
+  if (self->iriap == NULL)
+    return -ENOMEM;

   /* Next discovery - before the call to avoid races */
   self->disco_index++;
diff -urp linux-2.4.21/net/irda/irqueue.c linux-2.4.21-rmk1-dsa/net/irda/irqueue.c
--- linux-2.4.21/net/irda/irqueue.c	Mon Nov  5 09:12:48 2001
+++ linux-2.4.21-rmk1-dsa/net/irda/irqueue.c	Thu Aug 21 13:40:37 2003
@@ -468,26 +468,26 @@ void* hashbin_remove_this( hashbin_t* ha
  */
 irda_queue_t *hashbin_get_first( hashbin_t* hashbin)
 {
+	unsigned long flags;
 	irda_queue_t *entry;
 	int i;

+	save_flags(flags);
+	cli();
+
 	ASSERT( hashbin != NULL, return NULL;);
 	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);

-	if ( hashbin == NULL)
-		return NULL;
-
 	for ( i = 0; i < HASHBIN_SIZE; i ++ ) {
-		entry = hashbin->hb_queue[ i];
-		if ( entry) {
+		entry = hashbin->hb_queue[i];
+		if (entry) {
 			hashbin->hb_current = entry;
-			return entry;
+			break;
 		}
 	}
-	/*
-	 *  Did not find any item in hashbin
-	 */
-	return NULL;
+	restore_flags(flags);
+
+	return entry;
 }

 /*
diff -urp linux-2.4.21/net/irda/irttp.c linux-2.4.21-rmk1-dsa/net/irda/irttp.c
--- linux-2.4.21/net/irda/irttp.c	Fri Aug 22 13:59:00 2003
+++ linux-2.4.21-rmk1-dsa/net/irda/irttp.c	Thu Aug 21 13:42:26 2003
@@ -1093,7 +1093,7 @@ int irttp_connect_request(struct tsap_cb
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
 		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER + TTP_SAR_HEADER),
-		       return -1;);
+		       do {dev_kfree_skb(skb); return -1;} while (0););

 		/* Insert SAR parameters */
 		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);
@@ -1331,7 +1331,7 @@ int irttp_connect_response(struct tsap_c
 	/* SAR enabled? */
 	if (max_sdu_size > 0) {
 		ASSERT(skb_headroom(skb) >= (TTP_MAX_HEADER+TTP_SAR_HEADER),
-		       return -1;);
+		       do {dev_kfree_skb(skb); return -1;} while (0););

 		/* Insert TTP header with SAR parameters */
 		frame = skb_push(skb, TTP_HEADER+TTP_SAR_HEADER);

