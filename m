Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTKYDIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTKYDIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 22:08:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:12937 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261956AbTKYDI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 22:08:27 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 24 Nov 2003 19:08:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: jt@hpl.hp.com, David Hinds <dhinds@sonic.net>,
       <linux-pcmcia@lists.infradead.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
In-Reply-To: <Pine.LNX.4.58.0311241845200.1599@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311241906500.1986-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Linus Torvalds wrote:

> 
> On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
> >
> > 	Currently, I managed to narrow down to :
> > -------------------------------------------------
> > PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
> 
> Can you do a "dump_pirq"? (Found on http://www.kernelnewbies.org/scripts/
> among other places, maybe there are newer versions, David would know).

I didn't want to post this because I was ashamed of the fix, but w/out 
this my orinoco cardbus gets an interrupt one every ten boots. This is 
against 2.4.20 ...



- Davide



diff -Nru linux-2.4.20-8ref/drivers/pcmcia/cs.c linux-2.4.20-8custom/drivers/pcmcia/cs.c
--- linux-2.4.20-8ref/drivers/pcmcia/cs.c	2003-05-27 21:30:12.527683232 -0700
+++ linux-2.4.20-8custom/drivers/pcmcia/cs.c	2003-05-27 19:59:55.000000000 -0700
@@ -1859,6 +1859,7 @@
     socket_info_t *s;
     config_t *c;
     int ret = 0, irq = 0;
+    u_int attr;
     
     if (CHECK_HANDLE(handle))
 	return CS_BAD_HANDLE;
@@ -1902,18 +1903,36 @@
 	}
 #endif
     }
-    if (ret != 0) return ret;
+    if (ret != 0) {
+        if (!s->cap.pci_irq)
+	    return ret;
+	irq = s->cap.pci_irq;
+    }
 
+    attr = req->Attributes;
     if (req->Attributes & IRQ_HANDLE_PRESENT) {
+        int share_irq;
+
+        share_irq = (attr & IRQ_TYPE_DYNAMIC_SHARING) ||
+            (s->functions > 1) ||
+            (irq == s->cap.pci_irq);
+    retry:
 	if (bus_request_irq(s->cap.bus, irq, req->Handler,
-			    ((req->Attributes & IRQ_TYPE_DYNAMIC_SHARING) || 
-			     (s->functions > 1) ||
-			     (irq == s->cap.pci_irq)) ? SA_SHIRQ : 0,
-			    handle->dev_info, req->Instance))
-	    return CS_IN_USE;
+                            share_irq ? SA_SHIRQ : 0,
+                            handle->dev_info, req->Instance)) {
+            if (!share_irq) {
+               share_irq = 1;
+               goto retry;
+            }
+            return CS_IN_USE;
+	}
+        if (share_irq) {
+            attr &= ~IRQ_TYPE_EXCLUSIVE;
+            attr |= IRQ_TYPE_DYNAMIC_SHARING;
+	}
     }
-
-    c->irq.Attributes = req->Attributes;
+  
+    c->irq.Attributes = attr;
     s->irq.AssignedIRQ = req->AssignedIRQ = irq;
     s->irq.Config++;
     

