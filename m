Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCETXt>; Mon, 5 Mar 2001 14:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCETXl>; Mon, 5 Mar 2001 14:23:41 -0500
Received: from [199.183.24.200] ([199.183.24.200]:47939 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130380AbRCETXX>; Mon, 5 Mar 2001 14:23:23 -0500
Date: Mon, 5 Mar 2001 14:23:17 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: SLAB vs. pci_alloc_xxx in usb-uhci patch
Message-ID: <20010305142317.A21685@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone:

When I turn FORCE_DEBUG on in mm/slab.c, usb-uhci driver stops
working. It turned out that DMA headers must be aligned on 16.
Slab poisoning violates that assumption.

I have come up with a fix which USB folks did not like, but
they did not object to discussion on linux-kernel. Here is it.

The current code does something like this:

    struct dmahdr {
        __u32 head;
    };
    struct desc {
        struct dmahdr h;
        struct desc *next;
        int last_used;
    };

    struct desc *p;
    unsigned long busaddr;
    p = kmalloc_z(sizeof(struct desc), GFP_SOMETHING);
    busaddr = virt_to_bus(p);
    writel(busaddr, ioremap_cookie + UHCI_SOME_REGISTER);

I changed it to this:

    struct dmahdr {
        __u32 head;
    };
    struct desc {
        struct dmahdr *hp;
        struct desc *next;
        int last_used;
    };

    struct desc *p;
    void *dp;
    unsigned long busaddr;
    p = kmalloc_z(sizeof(struct desc), GFP_SOMETHING);
    dp = kmalloc_z(sizeof(struct dmahdr) + 15, GFP_SOMETHING);
    dp = (dp + 15) & ~15;
    p->hp = dp;
    busaddr = virt_to_bus(p->hp);
    writel(busaddr, ioremap_cookie + UHCI_SOME_REGISTER);

This way, after testing, we may replace second kmalloc and virt_to_bus
with pci_alloc_consistent.

Actual patch is more complicated due to checks, zeroing, and so on.
It is attached below.

Here is a mail that sums up the disagreement:

 Date: Sun, 04 Mar 2001 13:10:26 -0800
 From: David Brownell <david-b@pacbell.net>
 Subject: Re: [linux-usb-devel] Patch for usb-uhci and poisoned slab (2.4.2-ac7)
 To: Peter Zaitcev <zaitcev@redhat.com>
 Cc: linux-usb-devel@lists.sourceforge.net

 > I found that usb-uhci fails when FORCE_DEBUG is set in mm/slab.c
 > because it expects 16 bytes alignment for structures it allocates.
  
 And mm/slab.c changes semantics when CONFIG_SLAB_DEBUG
 is set:  it ignores SLAB_HWCACHE_ALIGN.  That seems more like
 the root cause of the problem to me!
 
 It's a lot simpler to patch mm/slab.c so its semantics don't change.
 That is, don't resolve clashes between HWCACHE_ALIGN and
 automagic redzoning in favor of redzoning any more.

 > I did not go all the way to using pci_alloc_single,
 > pci_alloc_consistent and friends, because I am not too sure
 > in my hand, and also because I believe in gradual change
 > (in this case).

 That big a patch is rather non-gradual ... :-)

 I think that the pci_alloc_consistent patch that Johannes sent
 by for "uhci.c" would be a better approach.  Though I'd like
 to see that be more general ... say, making mm/slab.c know
 about such things.  Add a simple abstraction, and that should
 be it -- right?  :-)

 - Dave

I see the Dave's argument as  1. Slab must honor HWCACHE_ALIGN
when debugged; 2. My patch is too big for too little gain.
It is understandable, but I find it hard to agree. First,
mixing the controller imposed alignment with cache alignment
is quite misleading. Second, is more "phylosophical" - yes
I can work without global poisoning. I just do want to use it.
I fancy forced slab poisoning, is it so wrong?

I need our benevolent dictatiorship to judge. Or else ... umm...
well, I guess, nothing will happen, we would just have broken
code as we always did :0

-- Pete

diff -ur -X ../dontdiff linux-2.4.2-ac7/drivers/usb/usb-uhci-debug.h linux-2.4.2-ac7-p3/drivers/usb/usb-uhci-debug.h
--- linux-2.4.2-ac7/drivers/usb/usb-uhci-debug.h	Sat Jul  8 19:38:16 2000
+++ linux-2.4.2-ac7-p3/drivers/usb/usb-uhci-debug.h	Sat Mar  3 11:27:45 2001
@@ -1,25 +1,25 @@
-#ifdef DEBUG
+#ifdef DEBUG_DUMP
 static void __attribute__((__unused__)) uhci_show_qh (puhci_desc_t qh)
 {
 	if (qh->type != QH_TYPE) {
 		dbg("qh has not QH_TYPE");
 		return;
 	}
-	dbg("QH @ %p/%08lX:", qh, virt_to_bus (qh));
+	dbg("QH @ %p->%p/%08lX:", qh, qh->hwp, virt_to_bus (qh->hwp));
 
-	if (qh->hw.qh.head & UHCI_PTR_TERM)
+	if (qh->hwp->qh.head & UHCI_PTR_TERM)
 		dbg("    Head Terminate");
 	else 
 		dbg("    Head: %s @ %08X",
-		    (qh->hw.qh.head & UHCI_PTR_QH?"QH":"TD"),
-		    qh->hw.qh.head & ~UHCI_PTR_BITS);
+		    (qh->hwp->qh.head & UHCI_PTR_QH?"QH":"TD"),
+		    qh->hwp->qh.head & ~UHCI_PTR_BITS);
 
-	if (qh->hw.qh.element & UHCI_PTR_TERM)
+	if (qh->hwp->qh.element & UHCI_PTR_TERM)
 		dbg("    Element Terminate");
 	else 
 		dbg("    Element: %s @ %08X",
-		    (qh->hw.qh.element & UHCI_PTR_QH?"QH":"TD"),
-		    qh->hw.qh.element & ~UHCI_PTR_BITS);
+		    (qh->hwp->qh.element & UHCI_PTR_QH?"QH":"TD"),
+		    qh->hwp->qh.element & ~UHCI_PTR_BITS);
 }
 #endif
 
@@ -27,7 +27,7 @@
 {
 	char *spid;
 	
-	switch (td->hw.td.info & 0xff) {
+	switch (td->hwp->td.info & 0xff) {
 	case USB_PID_SETUP:
 		spid = "SETUP";
 		break;
@@ -42,50 +42,52 @@
 		break;
 	}
 
-	warn("  TD @ %p/%08lX, MaxLen=%02x DT%d EP=%x Dev=%x PID=(%s) buf=%08x",
-	     td, virt_to_bus (td),
-	     td->hw.td.info >> 21,
-	     ((td->hw.td.info >> 19) & 1),
-	     (td->hw.td.info >> 15) & 15,
-	     (td->hw.td.info >> 8) & 127,
+	warn("  TD @ %p->%p/%08lX, MaxLen=%02x DT%d EP=%x Dev=%x PID=(%s) buf=%08x",
+	     td, td->hwp, virt_to_bus (td->hwp),
+	     td->hwp->td.info >> 21,
+	     ((td->hwp->td.info >> 19) & 1),
+	     (td->hwp->td.info >> 15) & 15,
+	     (td->hwp->td.info >> 8) & 127,
 	     spid,
-	     td->hw.td.buffer);
+	     td->hwp->td.buffer);
 
 	warn("    Len=%02x e%d %s%s%s%s%s%s%s%s%s%s",
-	     td->hw.td.status & 0x7ff,
-	     ((td->hw.td.status >> 27) & 3),
-	     (td->hw.td.status & TD_CTRL_SPD) ? "SPD " : "",
-	     (td->hw.td.status & TD_CTRL_LS) ? "LS " : "",
-	     (td->hw.td.status & TD_CTRL_IOC) ? "IOC " : "",
-	     (td->hw.td.status & TD_CTRL_ACTIVE) ? "Active " : "",
-	     (td->hw.td.status & TD_CTRL_STALLED) ? "Stalled " : "",
-	     (td->hw.td.status & TD_CTRL_DBUFERR) ? "DataBufErr " : "",
-	     (td->hw.td.status & TD_CTRL_BABBLE) ? "Babble " : "",
-	     (td->hw.td.status & TD_CTRL_NAK) ? "NAK " : "",
-	     (td->hw.td.status & TD_CTRL_CRCTIMEO) ? "CRC/Timeo " : "",
-	     (td->hw.td.status & TD_CTRL_BITSTUFF) ? "BitStuff " : ""
+	     td->hwp->td.status & 0x7ff,
+	     ((td->hwp->td.status >> 27) & 3),
+	     (td->hwp->td.status & TD_CTRL_SPD) ? "SPD " : "",
+	     (td->hwp->td.status & TD_CTRL_LS) ? "LS " : "",
+	     (td->hwp->td.status & TD_CTRL_IOC) ? "IOC " : "",
+	     (td->hwp->td.status & TD_CTRL_ACTIVE) ? "Active " : "",
+	     (td->hwp->td.status & TD_CTRL_STALLED) ? "Stalled " : "",
+	     (td->hwp->td.status & TD_CTRL_DBUFERR) ? "DataBufErr " : "",
+	     (td->hwp->td.status & TD_CTRL_BABBLE) ? "Babble " : "",
+	     (td->hwp->td.status & TD_CTRL_NAK) ? "NAK " : "",
+	     (td->hwp->td.status & TD_CTRL_CRCTIMEO) ? "CRC/Timeo " : "",
+	     (td->hwp->td.status & TD_CTRL_BITSTUFF) ? "BitStuff " : ""
 		);
 
-	if (td->hw.td.link & UHCI_PTR_TERM)
+	if (td->hwp->td.link & UHCI_PTR_TERM)
 		warn("   TD Link Terminate");
 	else 
 		warn("    Link points to %s @ %08x, %s",
-		     (td->hw.td.link & UHCI_PTR_QH?"QH":"TD"),
-		     td->hw.td.link & ~UHCI_PTR_BITS,
-		     (td->hw.td.link & UHCI_PTR_DEPTH ? "Depth first" : "Breadth first"));
+		     (td->hwp->td.link & UHCI_PTR_QH?"QH":"TD"),
+		     td->hwp->td.link & ~UHCI_PTR_BITS,
+		     (td->hwp->td.link & UHCI_PTR_DEPTH ? "Depth first" : "Breadth first"));
 }
-#ifdef DEBUG
+#ifdef DEBUG_DUMP
 static void __attribute__((__unused__)) uhci_show_td_queue (puhci_desc_t td)
 {
-	//dbg("uhci_show_td_queue %p (%08lX):", td, virt_to_bus (td));
+	uhci_desc_u_t *h;
+	//dbg("uhci_show_td_queue %p (%08lX):", td, virt_to_bus (td->hwp));
 	while (1) {
 		uhci_show_td (td);
-		if (td->hw.td.link & UHCI_PTR_TERM)
+		if (td->hwp->td.link & UHCI_PTR_TERM)
 			break;
-		if (td != bus_to_virt (td->hw.td.link & ~UHCI_PTR_BITS))
-			td = bus_to_virt (td->hw.td.link & ~UHCI_PTR_BITS);
-		else {
-			dbg("td points to itself!");
+		h = bus_to_virt (td->hwp->td.link & ~UHCI_PTR_BITS);
+		if (td->hwp != h) {
+			td = h->td.backp;
+		} else {
+			dbg("td %p points to itself!", td);
 			break;
 		}
 	}
@@ -94,21 +96,23 @@
 static void __attribute__((__unused__)) uhci_show_queue (puhci_desc_t qh)
 {
 	uhci_desc_t *start_qh=qh;
+	uhci_desc_u_t *h;
 
 	dbg("uhci_show_queue %p:", qh);
 	while (1) {
 		uhci_show_qh (qh);
 
-		if (!(qh->hw.qh.element & UHCI_PTR_TERM))
-			uhci_show_td_queue (bus_to_virt (qh->hw.qh.element & ~UHCI_PTR_BITS));
+		if (!(qh->hwp->qh.element & UHCI_PTR_TERM))
+			uhci_show_td_queue (((uhci_desc_u_t *)bus_to_virt (qh->hwp->qh.element & ~UHCI_PTR_BITS))->td.backp);
 
-		if (qh->hw.qh.head & UHCI_PTR_TERM)
+		if (qh->hwp->qh.head & UHCI_PTR_TERM)
 			break;
 
-		if (qh != bus_to_virt (qh->hw.qh.head & ~UHCI_PTR_BITS))
-			qh = bus_to_virt (qh->hw.qh.head & ~UHCI_PTR_BITS);
+		h = bus_to_virt (qh->hwp->qh.head & ~UHCI_PTR_BITS);
+		if (qh->hwp != h)
+			qh = h->qh.backp;
 		else {
-			dbg("qh points to itself!");
+			dbg("qh %p points to itself!", qh);
 			break;
 		}
 		
diff -ur -X ../dontdiff linux-2.4.2-ac7/drivers/usb/usb-uhci.c linux-2.4.2-ac7-p3/drivers/usb/usb-uhci.c
--- linux-2.4.2-ac7/drivers/usb/usb-uhci.c	Thu Mar  1 15:08:47 2001
+++ linux-2.4.2-ac7-p3/drivers/usb/usb-uhci.c	Sat Mar  3 11:44:37 2001
@@ -44,7 +44,7 @@
 //#define ISO_SANITY_CHECK
 
 /* This enables debug printks */
-#define DEBUG
+#define DEBUG_DUMP
 
 /* This enables all symbols to be exported, to ease debugging oopses */
 //#define DEBUG_SYMBOLS
@@ -58,7 +58,6 @@
 #include "usb-uhci.h"
 #include "usb-uhci-debug.h"
 
-#undef DEBUG
 #undef dbg
 #define dbg(format, arg...) do {} while (0)
 #define DEBUG_SYMBOLS
@@ -128,17 +127,17 @@
 {
 
 	if (!list_empty(&s->urb_unlinked)) {
-		s->td1ms->hw.td.status |= TD_CTRL_IOC;
+		s->td1ms->hwp->td.status |= TD_CTRL_IOC;
 	}
 	else {
-		s->td1ms->hw.td.status &= ~TD_CTRL_IOC;
+		s->td1ms->hwp->td.status &= ~TD_CTRL_IOC;
 	}
 
 	if (s->timeout_urbs) {
-		s->td32ms->hw.td.status |= TD_CTRL_IOC;
+		s->td32ms->hwp->td.status |= TD_CTRL_IOC;
 	}
 	else {
-		s->td32ms->hw.td.status &= ~TD_CTRL_IOC;
+		s->td32ms->hwp->td.status &= ~TD_CTRL_IOC;
 	}
 
 	wmb();
@@ -153,7 +152,7 @@
 		return;
 
 	spin_lock_irqsave (&s->qh_lock, flags);
-	s->chain_end->hw.qh.head&=~UHCI_PTR_TERM; 
+	s->chain_end->hwp->qh.head &= ~UHCI_PTR_TERM; 
 	mb();
 	s->loop_usage++;
 	((urb_priv_t*)urb->hcpriv)->use_loop=1;
@@ -172,7 +171,7 @@
 		s->loop_usage--;
 
 		if (!s->loop_usage) {
-			s->chain_end->hw.qh.head|=UHCI_PTR_TERM;
+			s->chain_end->hwp->qh.head|=UHCI_PTR_TERM;
 			mb();
 		}
 		((urb_priv_t*)urb->hcpriv)->use_loop=0;
@@ -228,20 +227,42 @@
 /*-------------------------------------------------------------------*/
 _static int alloc_td (uhci_desc_t ** new, int flags)
 {
+	uhci_desc_t *u;
+	void *p;
 #ifdef DEBUG_SLAB
-	*new= kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);
+	u = kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);
 #else
-	*new = (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);
+	u = (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);
 #endif
-	if (!*new)
+	*new = u;
+	if (u == NULL)
 		return -ENOMEM;
 	 memset (*new, 0, sizeof (uhci_desc_t));
-	(*new)->hw.td.link = UHCI_PTR_TERM | (flags & UHCI_PTR_BITS);	// last by default
-	(*new)->type = TD_TYPE;
+
+	/* XXX Replace this with a layer over pci_alloc_consistent(). */
+	/* Do not slabify (will not be able after pci_alloc_consistent(). */
+	if ((p = kmalloc(UHCI_HWDESC_SZ + 0xf, KMALLOC_FLAG)) == NULL) {
+#ifdef DEBUG_SLAB
+		kmem_cache_free(uhci_desc_kmem, u);
+#else
+		kfree (u);
+#endif
+		*new = NULL;
+		return -ENOMEM;
+	}
+	u->mmp = p;
+	u->hwp = (void *)(((unsigned long)p + 0xf) & ~0xf);
+	memset(u->hwp, 0, UHCI_HWDESC_SZ);
+
+#ifdef DEBUG_DUMP
+	u->hwp->td.backp = u;
+#endif
+	u->hwp->td.link = UHCI_PTR_TERM | (flags & UHCI_PTR_BITS);	// last by default
+	u->type = TD_TYPE;
 	mb();
-	INIT_LIST_HEAD (&(*new)->vertical);
-	INIT_LIST_HEAD (&(*new)->horizontal);
-	
+	INIT_LIST_HEAD (&u->vertical);
+	INIT_LIST_HEAD (&u->horizontal);
+
 	return 0;
 }
 /*-------------------------------------------------------------------*/
@@ -252,7 +273,7 @@
 	
 	spin_lock_irqsave (&s->td_lock, xxx);
 
-	td->hw.td.link = virt_to_bus (qh) | (flags & UHCI_PTR_DEPTH) | UHCI_PTR_QH;
+	td->hwp->td.link = virt_to_bus (qh->hwp) | (flags & UHCI_PTR_DEPTH) | UHCI_PTR_QH;
        
 	mb();
 	spin_unlock_irqrestore (&s->td_lock, xxx);
@@ -272,11 +293,11 @@
 
 	if (qh == prev ) {
 		// virgin qh without any tds
-		qh->hw.qh.element = virt_to_bus (new) | UHCI_PTR_TERM;
+		qh->hwp->qh.element = virt_to_bus (new->hwp) | UHCI_PTR_TERM;
 	}
 	else {
 		// already tds inserted, implicitely remove TERM bit of prev
-		prev->hw.td.link = virt_to_bus (new) | (flags & UHCI_PTR_DEPTH);
+		prev->hwp->td.link = virt_to_bus (new->hwp) | (flags & UHCI_PTR_DEPTH);
 	}
 	mb();
 	spin_unlock_irqrestore (&s->td_lock, xxx);
@@ -294,8 +315,8 @@
 
 	next = list_entry (td->horizontal.next, uhci_desc_t, horizontal);
 	list_add (&new->horizontal, &td->horizontal);
-	new->hw.td.link = td->hw.td.link;
-	td->hw.td.link = virt_to_bus (new);
+	new->hwp->td.link = td->hwp->td.link;
+	td->hwp->td.link = virt_to_bus (new->hwp);
 	mb();
 	spin_unlock_irqrestore (&s->td_lock, flags);	
 	
@@ -322,9 +343,9 @@
 	if (phys_unlink) {
 		// really remove HW linking
 		if (prev->type == TD_TYPE)
-			prev->hw.td.link = element->hw.td.link;
+			prev->hwp->td.link = element->hwp->td.link;
 		else
-			prev->hw.qh.element = element->hw.td.link;
+			prev->hwp->qh.element = element->hwp->td.link;
 	}
 
 	mb ();
@@ -342,6 +363,7 @@
 /*-------------------------------------------------------------------*/
 _static int delete_desc (uhci_desc_t *element)
 {
+	kfree (element->mmp);
 #ifdef DEBUG_SLAB
 	kmem_cache_free(uhci_desc_kmem, element);
 #else
@@ -353,23 +375,45 @@
 // Allocates qh element
 _static int alloc_qh (uhci_desc_t ** new)
 {
+	uhci_desc_t *u;
+	void *p;
 #ifdef DEBUG_SLAB
-	*new= kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);
+	u = kmem_cache_alloc(uhci_desc_kmem, SLAB_FLAG);
 #else
-	*new = (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);
+	u = (uhci_desc_t *) kmalloc (sizeof (uhci_desc_t), KMALLOC_FLAG);
 #endif	
-	if (!*new)
+	*new = u;
+	if (u == NULL)
 		return -ENOMEM;
 	memset (*new, 0, sizeof (uhci_desc_t));
-	(*new)->hw.qh.head = UHCI_PTR_TERM;
-	(*new)->hw.qh.element = UHCI_PTR_TERM;
-	(*new)->type = QH_TYPE;
+
+	/* XXX Replace this with a layer over pci_alloc_consistent(). */
+	/* Do not slabify (will not be able after pci_alloc_consistent(). */
+	if ((p = kmalloc(UHCI_HWDESC_SZ + 0xf, KMALLOC_FLAG)) == NULL) {
+#ifdef DEBUG_SLAB
+		kmem_cache_free(uhci_desc_kmem, u);
+#else
+		kfree (u);
+#endif
+		*new = NULL;
+		return -ENOMEM;
+	}
+	u->mmp = p;
+	u->hwp = (void *)(((unsigned long)p + 0xf) & ~0xf);
+	memset(u->hwp, 0, UHCI_HWDESC_SZ);
+
+#ifdef DEBUG_DUMP
+	u->hwp->qh.backp = u;
+#endif
+	u->hwp->qh.head = UHCI_PTR_TERM;
+	u->hwp->qh.element = UHCI_PTR_TERM;
+	u->type = QH_TYPE;
 	
 	mb();
-	INIT_LIST_HEAD (&(*new)->horizontal);
-	INIT_LIST_HEAD (&(*new)->vertical);
+	INIT_LIST_HEAD (&u->horizontal);
+	INIT_LIST_HEAD (&u->vertical);
 	
-	dbg("Allocated qh @ %p", *new);
+	dbg("Allocated qh @ %p", u);
 	
 	return 0;
 }
@@ -387,16 +431,16 @@
 		// (OLD) (POS) -> (OLD) (NEW) (POS)
 		old = list_entry (pos->horizontal.prev, uhci_desc_t, horizontal);
 		list_add_tail (&new->horizontal, &pos->horizontal);
-		new->hw.qh.head = MAKE_QH_ADDR (pos) ;
-		if (!(old->hw.qh.head & UHCI_PTR_TERM))
-			old->hw.qh.head = MAKE_QH_ADDR (new) ;
+		new->hwp->qh.head = MAKE_QH_ADDR (pos->hwp) ;
+		if (!(old->hwp->qh.head & UHCI_PTR_TERM))
+			old->hwp->qh.head = MAKE_QH_ADDR (new->hwp) ;
 	}
 	else {
 		// (POS) (OLD) -> (POS) (NEW) (OLD)
 		old = list_entry (pos->horizontal.next, uhci_desc_t, horizontal);
 		list_add (&new->horizontal, &pos->horizontal);
-		new->hw.qh.head = MAKE_QH_ADDR (old);
-		pos->hw.qh.head = MAKE_QH_ADDR (new) ;
+		new->hwp->qh.head = MAKE_QH_ADDR (old->hwp);
+		pos->hwp->qh.head = MAKE_QH_ADDR (new->hwp) ;
 	}
 
 	mb ();
@@ -415,10 +459,10 @@
 	spin_lock_irqsave (&s->qh_lock, flags);
 	
 	prev = list_entry (element->horizontal.prev, uhci_desc_t, horizontal);
-	prev->hw.qh.head = element->hw.qh.head;
+	prev->hwp->qh.head = element->hwp->qh.head;
 
 	dbg("unlink qh %p, pqh %p, nxqh %p, to %08x", element, prev, 
-	    list_entry (element->horizontal.next, uhci_desc_t, horizontal),element->hw.qh.head &~15);
+	    list_entry (element->horizontal.next, uhci_desc_t, horizontal),element->hwp->qh.head &~15);  /* XXX Why x&~15 here anymore? */
 	
 	list_del(&element->horizontal);
 
@@ -466,9 +510,10 @@
 /*-------------------------------------------------------------------*/
 _static void fill_td (uhci_desc_t *td, int status, int info, __u32 buffer)
 {
-	td->hw.td.status = status;
-	td->hw.td.info = info;
-	td->hw.td.buffer = buffer;
+	uhci_td_t *p = &td->hwp->td;
+	p->status = status;
+	p->info = info;
+	p->buffer = buffer;
 }
 /*-------------------------------------------------------------------*/
 // Removes ALL qhs in chain (paranoia!)
@@ -564,12 +609,12 @@
 		if (ret)
 			goto init_skel_cleanup;
 		s->iso_td[n] = td;
-		s->framelist[n] = ((__u32) virt_to_bus (td));
+		s->framelist[n] = (__u32) virt_to_bus (td->hwp);
 	}
 
 	dbg("allocating qh: chain_end");
 	ret = alloc_qh (&qh);
-	
+
 	if (ret)
 		goto init_skel_cleanup;
 				
@@ -582,7 +627,7 @@
 	
 	fill_td (td, 0 * TD_CTRL_IOC, 0, 0); // generate 1ms interrupt (enabled on demand)
 	insert_td (s, qh, td, 0);
-	qh->hw.qh.element &= ~UHCI_PTR_TERM; // remove TERM bit
+	qh->hwp->qh.element &= ~UHCI_PTR_TERM; // remove TERM bit
 	s->td1ms=td;
 
 	dbg("allocating qh: bulk_chain");
@@ -603,7 +648,7 @@
 
 #ifdef	CONFIG_USB_UHCI_HIGH_BANDWIDTH
 	// disabled reclamation loop
-	s->chain_end->hw.qh.head=virt_to_bus(s->control_chain) | UHCI_PTR_QH | UHCI_PTR_TERM;
+	s->chain_end->hwp->qh.head = virt_to_bus(s->control_chain->hwp) | UHCI_PTR_QH | UHCI_PTR_TERM;
 #endif
 
 	dbg("allocating qh: ls_control_chain");
@@ -627,10 +672,10 @@
 			goto init_skel_cleanup;
 		s->int_chain[n] = td;
 		if (n == 0) {
-			s->int_chain[0]->hw.td.link = virt_to_bus (s->ls_control_chain) | UHCI_PTR_QH;
+			s->int_chain[0]->hwp->td.link = virt_to_bus (s->ls_control_chain->hwp) | UHCI_PTR_QH;
 		}
 		else {
-			s->int_chain[n]->hw.td.link = virt_to_bus (s->int_chain[0]);
+			s->int_chain[n]->hwp->td.link = virt_to_bus (s->int_chain[0]->hwp);
 		}
 	}
 
@@ -641,11 +686,11 @@
 		int m, o;
 		dbg("framelist[%i]=%x",n,s->framelist[n]);
 		if ((n&127)==127) 
-			((uhci_desc_t*) s->iso_td[n])->hw.td.link = virt_to_bus(s->int_chain[0]);
+			((uhci_desc_t*) s->iso_td[n])->hwp->td.link = virt_to_bus(s->int_chain[0]->hwp);
 		else 
 			for (o = 1, m = 2; m <= 128; o++, m += m)
 				if ((n & (m - 1)) == ((m - 1) / 2))
-					((uhci_desc_t*) s->iso_td[n])->hw.td.link = virt_to_bus (s->int_chain[o]);
+					((uhci_desc_t*) s->iso_td[n])->hwp->td.link = virt_to_bus (s->int_chain[o]->hwp);
 	}
 
 	ret = alloc_td (&td, 0);
@@ -783,7 +828,7 @@
 	urb->status = -EINPROGRESS;
 	queue_urb (s, urb);	// queue before inserting in desc chain
 
-	qh->hw.qh.element &= ~UHCI_PTR_TERM;
+	qh->hwp->qh.element &= ~UHCI_PTR_TERM;
 
 	//uhci_show_queue(qh);
 	/* Start it up... put low speed first */
@@ -862,8 +907,8 @@
 			}
 			return -ENOMEM;
 		}
-		bqh->hw.qh.element = UHCI_PTR_TERM;
-		bqh->hw.qh.head = virt_to_bus(nqh) | UHCI_PTR_QH; // element
+		bqh->hwp->qh.element = UHCI_PTR_TERM;
+		bqh->hwp->qh.head = virt_to_bus(nqh->hwp) | UHCI_PTR_QH; // element
 		upriv->bottom_qh = bqh;
 	}
 	queue_dbg("uhci_submit_bulk: qh %p bqh %p nqh %p",qh, bqh, nqh);
@@ -904,7 +949,7 @@
 		last = (len == 0 && (usb_pipein(pipe) || pktsze < maxsze || !(urb->transfer_flags & USB_DISABLE_SPD)));
 
 		if (last)
-			td->hw.td.status |= TD_CTRL_IOC;	// last one generates INT
+			td->hwp->td.status |= TD_CTRL_IOC;	// last one generates INT
 
 		insert_td (s, qh, td, UHCI_PTR_DEPTH * depth_first);
 		if (!first_td)
@@ -925,9 +970,9 @@
 	queue_urb_unlocked (s, urb);
 	
 	if (urb->transfer_flags & USB_QUEUE_BULK)
-		qh->hw.qh.element = virt_to_bus (first_td);
+		qh->hwp->qh.element = virt_to_bus (first_td->hwp);
 	else
-		qh->hw.qh.element &= ~UHCI_PTR_TERM;    // arm QH
+		qh->hwp->qh.element &= ~UHCI_PTR_TERM;    // arm QH
 
 	if (!bulk_urb) { 					// new bulk queue	
 		if (urb->transfer_flags & USB_QUEUE_BULK) {
@@ -996,7 +1041,7 @@
 				spin_lock_irqsave (&s->qh_lock, flags);
 				prevqh = list_entry (ppriv->desc_list.next, uhci_desc_t, desc_list);
 				prevtd = list_entry (prevqh->vertical.prev, uhci_desc_t, vertical);
-				prevtd->hw.td.link = virt_to_bus(priv->bottom_qh) | UHCI_PTR_QH; // skip current qh
+				prevtd->hwp->td.link = virt_to_bus(priv->bottom_qh->hwp) | UHCI_PTR_QH; // skip current qh
 				mb();
 				queue_dbg("uhci_clean_transfer: relink pqh %p, ptd %p",prevqh, prevtd);
 				spin_unlock_irqrestore (&s->qh_lock, flags);
@@ -1039,7 +1084,7 @@
 			if (!priv->prev_queued_urb) { // top QH
 				
 				prevqh = list_entry (qh->horizontal.prev, uhci_desc_t, horizontal);
-				prevqh->hw.qh.head = virt_to_bus(bqh) | UHCI_PTR_QH;
+				prevqh->hwp->qh.head = virt_to_bus(bqh->hwp) | UHCI_PTR_QH;
 				list_del (&qh->horizontal);  // remove this qh form horizontal chain
 				list_add (&bqh->horizontal, &prevqh->horizontal); // insert next bqh in horizontal chain
 			}
@@ -1052,7 +1097,7 @@
 				ppriv->bottom_qh = bnqh;
 				ppriv->next_queued_urb = nurb;				
 				prevqh = list_entry (ppriv->desc_list.next, uhci_desc_t, desc_list);
-				prevqh->hw.qh.head = virt_to_bus(bqh) | UHCI_PTR_QH;
+				prevqh->hwp->qh.head = virt_to_bus(bqh->hwp) | UHCI_PTR_QH;
 			}
 
 			mb();
@@ -2274,7 +2319,7 @@
 	 */
 
 	if (urb_priv->flags && 
-		((qh->hw.qh.element == UHCI_PTR_TERM) ||(!(last_desc->hw.td.status & TD_CTRL_ACTIVE)))) 
+		((qh->hwp->qh.element == UHCI_PTR_TERM) ||(!(last_desc->hwp->td.status & TD_CTRL_ACTIVE)))) 
 		goto transfer_finished;
 
 	urb->actual_length=0;
@@ -2282,12 +2327,12 @@
 	for (; p != &qh->vertical; p = p->next) {
 		desc = list_entry (p, uhci_desc_t, vertical);
 
-		if (desc->hw.td.status & TD_CTRL_ACTIVE)	// do not process active TDs
+		if (desc->hwp->td.status & TD_CTRL_ACTIVE)	// do not process active TDs
 			return ret;
 	
-		actual_length = (desc->hw.td.status + 1) & 0x7ff;		// extract transfer parameters from TD
-		maxlength = (((desc->hw.td.info >> 21) & 0x7ff) + 1) & 0x7ff;
-		status = uhci_map_status (uhci_status_bits (desc->hw.td.status), usb_pipeout (urb->pipe));
+		actual_length = (desc->hwp->td.status + 1) & 0x7ff;		// extract transfer parameters from TD
+		maxlength = (((desc->hwp->td.info >> 21) & 0x7ff) + 1) & 0x7ff;
+		status = uhci_map_status (uhci_status_bits (desc->hwp->td.status), usb_pipeout (urb->pipe));
 
 		if (status == -EPIPE) { 		// see if EP is stalled
 			// set up stalled condition
@@ -2301,7 +2346,7 @@
 			urb->error_count++;
 			break;
 		}
-		else if ((desc->hw.td.info & 0xff) != USB_PID_SETUP)
+		else if ((desc->hwp->td.info & 0xff) != USB_PID_SETUP)
 			urb->actual_length += actual_length;
 
 		// got less data than requested
@@ -2314,9 +2359,9 @@
 
 			// short read during control-IN: re-start status stage
 			if ((usb_pipetype (urb->pipe) == PIPE_CONTROL)) {
-				if (uhci_packetid(last_desc->hw.td.info) == USB_PID_OUT) {
+				if (uhci_packetid(last_desc->hwp->td.info) == USB_PID_OUT) {
 			
-					qh->hw.qh.element = virt_to_bus (last_desc);  // re-trigger status stage
+					qh->hwp->qh.element = virt_to_bus (last_desc->hwp);  // re-trigger status stage
 					dbg("short packet during control transfer, retrigger status stage @ %p",last_desc);
 					//uhci_show_td (desc);
 					//uhci_show_td (last_desc);
@@ -2325,14 +2370,14 @@
 				}
 			}
 			// all other cases: short read is OK
-			data_toggle = uhci_toggle (desc->hw.td.info);
+			data_toggle = uhci_toggle (desc->hwp->td.info);
 			break;
 		}
 		else if (status)
 			goto is_error;
 
-		data_toggle = uhci_toggle (desc->hw.td.info);
-		queue_dbg("process_transfer: len:%d status:%x mapped:%x toggle:%d", actual_length, desc->hw.td.status,status, data_toggle);      
+		data_toggle = uhci_toggle (desc->hwp->td.info);
+		queue_dbg("process_transfer: len:%d status:%x mapped:%x toggle:%d", actual_length, desc->hwp->td.status,status, data_toggle);      
 
 	}
 
@@ -2369,20 +2414,20 @@
 	{
 		desc = list_entry (p, uhci_desc_t, desc_list);
 
-		if (desc->hw.td.status & TD_CTRL_ACTIVE) {
+		if (desc->hwp->td.status & TD_CTRL_ACTIVE) {
 			// do not process active TDs
-			//dbg("TD ACT Status @%p %08x",desc,desc->hw.td.status);
+			//dbg("TD ACT Status @%p %08x",desc,desc->hwp->td.status);
 			break;
 		}
 
-		if (!desc->hw.td.status & TD_CTRL_IOC) {
+		if (!desc->hwp->td.status & TD_CTRL_IOC) {
 			// do not process one-shot TDs, no recycling
 			break;
 		}
 		// extract transfer parameters from TD
 
-		actual_length = (desc->hw.td.status + 1) & 0x7ff;
-		status = uhci_map_status (uhci_status_bits (desc->hw.td.status), usb_pipeout (urb->pipe));
+		actual_length = (desc->hwp->td.status + 1) & 0x7ff;
+		status = uhci_map_status (uhci_status_bits (desc->hwp->td.status), usb_pipeout (urb->pipe));
 
 		// see if EP is stalled
 		if (status == -EPIPE) {
@@ -2422,23 +2467,23 @@
 			// Recycle INT-TD if interval!=0, else mark TD as one-shot
 			if (urb->interval) {
 				
-				desc->hw.td.info &= ~(1 << TD_TOKEN_TOGGLE);
+				desc->hwp->td.info &= ~(1 << TD_TOKEN_TOGGLE);
 				if (status==0) {
 					((urb_priv_t*)urb->hcpriv)->started=jiffies;
-					desc->hw.td.info |= (usb_gettoggle (urb->dev, usb_pipeendpoint (urb->pipe),
+					desc->hwp->td.info |= (usb_gettoggle (urb->dev, usb_pipeendpoint (urb->pipe),
 									    usb_pipeout (urb->pipe)) << TD_TOKEN_TOGGLE);
 					usb_dotoggle (urb->dev, usb_pipeendpoint (urb->pipe), usb_pipeout (urb->pipe));
 				} else {
-					desc->hw.td.info |= (!usb_gettoggle (urb->dev, usb_pipeendpoint (urb->pipe),
+					desc->hwp->td.info |= (!usb_gettoggle (urb->dev, usb_pipeendpoint (urb->pipe),
 									     usb_pipeout (urb->pipe)) << TD_TOKEN_TOGGLE);
 				}
-				desc->hw.td.status= (urb->pipe & TD_CTRL_LS) | TD_CTRL_ACTIVE | TD_CTRL_IOC |
+				desc->hwp->td.status= (urb->pipe & TD_CTRL_LS) | TD_CTRL_ACTIVE | TD_CTRL_IOC |
 					(urb->transfer_flags & USB_DISABLE_SPD ? 0 : TD_CTRL_SPD) | (3 << 27);
 				mb();
 			}
 			else {
 				uhci_unlink_urb_async(s, urb);
-				desc->hw.td.status &= ~TD_CTRL_IOC; // inactivate TD
+				desc->hwp->td.status &= ~TD_CTRL_IOC; // inactivate TD
 			}
 		}
 	}
@@ -2456,23 +2501,23 @@
 	uhci_desc_t *desc = list_entry (urb_priv->desc_list.prev, uhci_desc_t, desc_list);
 
 	dbg("urb contains iso request");
-	if ((desc->hw.td.status & TD_CTRL_ACTIVE) && !mode)
+	if ((desc->hwp->td.status & TD_CTRL_ACTIVE) && !mode)
 		return -EXDEV;	// last TD not finished
 
 	urb->error_count = 0;
 	urb->actual_length = 0;
 	urb->status = 0;
 	dbg("process iso urb %p, %li, %i, %i, %i %08x",urb,jiffies,UHCI_GET_CURRENT_FRAME(s),
-	    urb->number_of_packets,mode,desc->hw.td.status);
+	    urb->number_of_packets,mode,desc->hwp->td.status);
 
 	for (i = 0; p != &urb_priv->desc_list;  i++) {
 		desc = list_entry (p, uhci_desc_t, desc_list);
 		
 		//uhci_show_td(desc);
-		if (desc->hw.td.status & TD_CTRL_ACTIVE) {
+		if (desc->hwp->td.status & TD_CTRL_ACTIVE) {
 			// means we have completed the last TD, but not the TDs before
-			desc->hw.td.status &= ~TD_CTRL_ACTIVE;
-			dbg("TD still active (%x)- grrr. paranoia!", desc->hw.td.status);
+			desc->hwp->td.status &= ~TD_CTRL_ACTIVE;
+			dbg("TD still active (%x)- grrr. paranoia!", desc->hwp->td.status);
 			ret = -EXDEV;
 			urb->iso_frame_desc[i].status = ret;
 			unlink_td (s, desc, 1);
@@ -2489,15 +2534,15 @@
 			goto err;
 		}
 
-		if (urb->iso_frame_desc[i].offset + urb->transfer_buffer != bus_to_virt (desc->hw.td.buffer)) {
+		if (urb->iso_frame_desc[i].offset + urb->transfer_buffer != bus_to_virt (desc->hwp->td.buffer)) {
 			// Hm, something really weird is going on
-			dbg("Pointer Paranoia: %p!=%p", urb->iso_frame_desc[i].offset + urb->transfer_buffer, bus_to_virt (desc->hw.td.buffer));
+			dbg("Pointer Paranoia: %p!=%p", urb->iso_frame_desc[i].offset + urb->transfer_buffer, bus_to_virt (desc->hwp->td.buffer));
 			ret = -EINVAL;
 			urb->iso_frame_desc[i].status = ret;
 			goto err;
 		}
-		urb->iso_frame_desc[i].actual_length = (desc->hw.td.status + 1) & 0x7ff;
-		urb->iso_frame_desc[i].status = uhci_map_status (uhci_status_bits (desc->hw.td.status), usb_pipeout (urb->pipe));
+		urb->iso_frame_desc[i].actual_length = (desc->hwp->td.status + 1) & 0x7ff;
+		urb->iso_frame_desc[i].status = uhci_map_status (uhci_status_bits (desc->hwp->td.status), usb_pipeout (urb->pipe));
 		urb->actual_length += urb->iso_frame_desc[i].actual_length;
 
 	      err:
@@ -2507,7 +2552,7 @@
 			urb->status = urb->iso_frame_desc[i].status;
 		}
 		dbg("process_iso: %i: len:%d %08x status:%x",
-		     i, urb->iso_frame_desc[i].actual_length, desc->hw.td.status,urb->iso_frame_desc[i].status);
+		     i, urb->iso_frame_desc[i].actual_length, desc->hwp->td.status,urb->iso_frame_desc[i].status);
 
 		list_del (p);
 		p = p->next;
@@ -2939,6 +2984,9 @@
 {
 	int i;
 
+	/* disable legacy emulation */
+	pci_write_config_word (dev, USBLEGSUP, 0);
+
 	if (pci_enable_device(dev) < 0)
 		return -ENODEV;
 	
@@ -2954,8 +3002,6 @@
 		/* Is it already in use? */
 		if (check_region (io_addr, io_size))
 			break;
-		/* disable legacy emulation */
-		pci_write_config_word (dev, USBLEGSUP, 0);
 
 		pci_set_master(dev);
 		return alloc_uhci(dev, dev->irq, io_addr, io_size);
@@ -3005,7 +3051,7 @@
 #ifdef DEBUG_SLAB
 
 	uhci_desc_kmem = kmem_cache_create("uhci_desc", sizeof(uhci_desc_t), 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
-	
+
 	if(!uhci_desc_kmem) {
 		err("kmem_cache_create for uhci_desc failed (out of memory)");
 		return -ENOMEM;
diff -ur -X ../dontdiff linux-2.4.2-ac7/drivers/usb/usb-uhci.h linux-2.4.2-ac7-p3/drivers/usb/usb-uhci.h
--- linux-2.4.2-ac7/drivers/usb/usb-uhci.h	Mon May 15 12:05:15 2000
+++ linux-2.4.2-ac7-p3/drivers/usb/usb-uhci.h	Sat Mar  3 11:29:36 2001
@@ -100,7 +100,7 @@
 
 #define uhci_status_bits(ctrl_sts)	(ctrl_sts & 0xFE0000)
 #define uhci_actual_length(ctrl_sts)	((ctrl_sts + 1) & TD_CTRL_ACTLEN_MASK)	/* 1-based */
-#define uhci_ptr_to_virt(x)	bus_to_virt(x & ~UHCI_PTR_BITS)
+/* #define uhci_ptr_to_virt(x)	bus_to_virt(x & ~UHCI_PTR_BITS) */ /* unused */
 
 /*
  * for TD <flags>:
@@ -124,6 +124,10 @@
 /* ------------------------------------------------------------------------------------
    New TD/QH-structures
    ------------------------------------------------------------------------------------ */
+
+/* One size for TD & QH. Align to 16 eats any gains of two sizes. Less fragmented, too. */
+#define UHCI_HWDESC_SZ  16	
+
 typedef enum {
 	TD_TYPE, QH_TYPE
 } uhci_desc_type_t;
@@ -133,18 +137,29 @@
 	__u32 status;
 	__u32 info;
 	__u32 buffer;
-} uhci_td_t, *puhci_td_t;
+#ifdef DEBUG_DUMP
+	struct uhci_desc *backp;
+#endif
+} uhci_td_t, *puhci_td_t;	/* __attribute__((packed)) perhaps? XXX */
 
 typedef struct {
 	__u32 head;
 	__u32 element;		/* Queue element pointer */
+#ifdef DEBUG_DUMP
+	__u32 fill_08;
+	__u32 fill_0c;
+	struct uhci_desc *backp;
+#endif
 } uhci_qh_t, *puhci_qh_t;
 
-typedef struct {
-	union {
-		uhci_td_t td;
-		uhci_qh_t qh;
-	} hw;
+typedef union uhci_desc_u {	/* uncached, dma-able part of descriptor */
+	uhci_td_t td;
+	uhci_qh_t qh;
+} uhci_desc_u_t;
+
+typedef struct uhci_desc {	/* cached, or software, descriptor */
+	uhci_desc_u_t *hwp;
+	void *mmp;
 	uhci_desc_type_t type;
 	struct list_head horizontal;
 	struct list_head vertical;
