Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUHWSV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUHWSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUHWSSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:18:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3594 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266296AbUHWSQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:16:25 -0400
Date: Mon, 23 Aug 2004 19:16:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de, akpm@osdl.org,
       rml@ximian.com, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] pcmcia driver model support [4/5]
Message-ID: <20040823191617.C31791@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de,
	akpm@osdl.org, rml@ximian.com, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
References: <20040805222820.GE11641@neo.rr.com> <20040823190539.B31791@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040823190539.B31791@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Aug 23, 2004 at 07:05:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 07:05:39PM +0100, Russell King wrote:
> On Thu, Aug 05, 2004 at 10:28:20PM +0000, Adam Belay wrote:
> >...
> > The event is then eventually reported to the ds.c client.  DS then informs
> > userspace of the ejection request and waits for userspace to reply with whether
> > the request was successful.  pcmcia-cs, in turn, calls DS_GET_FIRST_TUPLE while
> > verifying the ejection request.
> 
> The alternative is that we avoid taking the lock when we know that
> we don't need to re-validate the regions.  How does this look?

Terrible. 8)  This one probably builds.

(Note: I'm expecting that this patch will have offsets, but should
still apply, build and should solve your problem.)

--- linux-2.6-pcmcia/drivers/pcmcia/rsrc_mgr.c	Sun Aug 22 15:42:36 2004
+++ linux/drivers/pcmcia/rsrc_mgr.c	Mon Aug 23 19:11:40 2004
@@ -88,6 +88,9 @@
 };
 
 static DECLARE_MUTEX(rsrc_sem);
+static unsigned int rsrc_mem_probe;
+#define MEM_PROBE_LOW	(1 << 0)
+#define MEM_PROBE_HIGH	(1 << 1)
 
 #ifdef CONFIG_PCMCIA_PROBE
 
@@ -451,24 +454,22 @@
     return do_mem_probe(m->base, m->num, s);
 }
 
-static void validate_mem(struct pcmcia_socket *s)
+static void validate_mem(struct pcmcia_socket *s, unsigned int probe_mask)
 {
     resource_map_t *m, mm;
     static u_char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
     static int hi = 0, lo = 0;
     u_long b, i, ok = 0;
-    int force_low = !(s->features & SS_CAP_PAGE_REGS);
 
-    down(&rsrc_sem);
     /* We do up to four passes through the list */
-    if (!force_low) {
-	if (hi++ || (inv_probe(mem_db.next, s) > 0))
-	    goto out;
+    if (probe_mask & MEM_PROBE_HIGH) {
+	if (inv_probe(mem_db.next, s) > 0)
+	    return;
 	printk(KERN_NOTICE "cs: warning: no high memory space "
 	       "available!\n");
     }
-    if (lo++)
-	goto out;
+    if ((probe_mask & MEM_PROBE_LOW) == 0)
+	return;
     for (m = mem_db.next; m != &mem_db; m = mm.next) {
 	mm = *m;
 	/* Only probe < 1 MB */
@@ -488,38 +489,51 @@
 	    }
 	}
     }
- out:
-    up(&rsrc_sem);
 }
 
 #else /* CONFIG_PCMCIA_PROBE */
 
-static void validate_mem(struct pcmcia_socket *s)
+static void validate_mem(struct pcmcia_socket *s, unsigned int probe_mask)
 {
-    resource_map_t *m, mm;
-    static int done = 0;
+	resource_map_t *m, mm;
     
-    if (done++ == 0) {
-	down(&rsrc_sem);
 	for (m = mem_db.next; m != &mem_db; m = mm.next) {
-	    mm = *m;
-	    if (do_mem_probe(mm.base, mm.num, s))
-		break;
+		mm = *m;
+		if (do_mem_probe(mm.base, mm.num, s))
+			break;
 	}
-	up(&rsrc_sem);
-    }
 }
 
 #endif /* CONFIG_PCMCIA_PROBE */
 
+/*
+ * Locking note: this is the only place where we take
+ * both rsrc_sem and skt_sem.
+ */
 void pcmcia_validate_mem(struct pcmcia_socket *s)
 {
-	down(&s->skt_sem);
+	if (probe_mem) {
+		unsigned int probe_mask;
+
+		down(&rsrc_sem);
+
+		probe_mask = MEM_PROBE_LOW;
+		if (s->features & SS_CAP_PAGE_REGS)
+			probe_mask = MEM_PROBE_HIGH;
 
-	if (probe_mem && s->state & SOCKET_PRESENT)
-		validate_mem(s);
+		if (probe_mask & ~rsrc_mem_probe) {
+			rsrc_mem_probe |= probe_mask;
 
-	up(&s->skt_sem);
+			down(&s->skt_sem);
+
+			if (s->state & SOCKET_PRESENT)
+				validate_mem(s, probe_mask);
+
+			up(&s->skt_sem);
+		}
+
+		up(&rsrc_sem);
+	}
 }
 
 EXPORT_SYMBOL(pcmcia_validate_mem);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
