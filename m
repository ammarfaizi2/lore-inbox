Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbTCLUye>; Wed, 12 Mar 2003 15:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbTCLUxU>; Wed, 12 Mar 2003 15:53:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7437 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262013AbTCLUwS>; Wed, 12 Mar 2003 15:52:18 -0500
Date: Wed, 12 Mar 2003 21:03:00 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 6/6 (7): Remove support for old cardbus clients
Message-ID: <20030312210300.I27656@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030312205659.C27656@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312205659.C27656@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 12, 2003 at 08:56:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia-7.diff

  Remove support for the old PCMCIA cardbus clients - all cardbus
  drivers should be converted to be full-class PCI citizens.

diff -ur orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Wed Mar 12 20:25:03 2003
+++ linux/drivers/pcmcia/cardbus.c	Wed Mar 12 20:28:14 2003
@@ -326,66 +326,4 @@
 		kfree(c);
 		printk(KERN_INFO "cs: cb_free(bus %d)\n", s->cap.cb_dev->subordinate->number);
 	}
-}
-
-/*=====================================================================
-
-    cb_enable() has the job of configuring a socket for a Cardbus
-    card, and initializing the card's PCI configuration registers.
-
-    It first sets up the Cardbus bridge windows, for IO and memory
-    accesses.  Then, it initializes each card function's base address
-    registers, interrupt line register, and command register.
-
-    It is called as part of the RequestConfiguration card service.
-    It should be called after a previous call to cb_config() (via the
-    RequestIO service).
-    
-======================================================================*/
-
-void cb_enable(socket_info_t * s)
-{
-	struct pci_dev *dev;
-	u_char i;
-
-	DEBUG(0, "cs: cb_enable(bus %d)\n", s->cap.cb_dev->subordinate->number);
-
-	/* Configure bridge */
-	cb_release_cis_mem(s);
-
-	/* Set up PCI interrupt and command registers */
-	for (i = 0; i < s->functions; i++) {
-		dev = s->cb_config->dev[i];
-		pci_write_config_byte(dev, PCI_COMMAND, PCI_COMMAND_MASTER |
-				      PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
-				      L1_CACHE_BYTES / 4);
-	}
-
-	if (s->irq.AssignedIRQ) {
-		for (i = 0; i < s->functions; i++) {
-			dev = s->cb_config->dev[i];
-			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					      s->irq.AssignedIRQ);
-		}
-		s->socket.io_irq = s->irq.AssignedIRQ;
-		s->ss_entry->set_socket(s->sock, &s->socket);
-	}
-}
-
-/*======================================================================
-
-    cb_disable() unconfigures a Cardbus card previously set up by
-    cb_enable().
-
-    It is called from the ReleaseConfiguration service.
-    
-======================================================================*/
-
-void cb_disable(socket_info_t * s)
-{
-	DEBUG(0, "cs: cb_disable(bus %d)\n", s->cap.cb_dev->subordinate->number);
-
-	/* Turn off bridge windows */
-	cb_release_cis_mem(s);
 }
diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Sun Mar  2 17:05:18 2003
+++ linux/drivers/pcmcia/cs.c	Sun Mar  2 17:45:53 2003
@@ -1518,11 +1518,8 @@
     s = SOCKET(handle);
     
 #ifdef CONFIG_CARDBUS
-    if (handle->state & CLIENT_CARDBUS) {
-	cb_disable(s);
-	s->lock_count = 0;
+    if (handle->state & CLIENT_CARDBUS)
 	return CS_SUCCESS;
-    }
 #endif
     
     if (!(handle->state & CLIENT_STALE)) {
@@ -1674,16 +1671,8 @@
 	return CS_NO_CARD;
     
 #ifdef CONFIG_CARDBUS
-    if (handle->state & CLIENT_CARDBUS) {
-	if (!(req->IntType & INT_CARDBUS))
-	    return CS_UNSUPPORTED_MODE;
-	if (s->lock_count != 0)
-	    return CS_CONFIGURATION_LOCKED;
-	cb_enable(s);
-	handle->state |= CLIENT_CONFIG_LOCKED;
-	s->lock_count++;
-	return CS_SUCCESS;
-    }
+    if (handle->state & CLIENT_CARDBUS)
+	return CS_UNSUPPORTED_MODE;
 #endif
     
     if (req->IntType & INT_CARDBUS)
diff -ur orig/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- orig/drivers/pcmcia/cs_internal.h	Sun Mar  2 17:05:18 2003
+++ linux/drivers/pcmcia/cs_internal.h	Sun Mar  2 17:45:36 2003
@@ -199,8 +199,6 @@
 /* In cardbus.c */
 int cb_alloc(socket_info_t *s);
 void cb_free(socket_info_t *s);
-void cb_enable(socket_info_t *s);
-void cb_disable(socket_info_t *s);
 int read_cb_mem(socket_info_t *s, int space, u_int addr, u_int len, void *ptr);
 void cb_release_cis_mem(socket_info_t *s);
 


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

