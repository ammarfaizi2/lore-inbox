Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbTCZTgp>; Wed, 26 Mar 2003 14:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbTCZTgp>; Wed, 26 Mar 2003 14:36:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25611 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262005AbTCZTgh>; Wed, 26 Mar 2003 14:36:37 -0500
Date: Wed, 26 Mar 2003 19:47:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (6/9) PCMCIA changes
Message-ID: <20030326194747.H8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk> <20030326193625.F8871@flint.arm.linux.org.uk> <20030326194726.G8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326194726.G8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:47:26PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.5 -> 1.889.359.6
#	drivers/pcmcia/cs_internal.h	1.6     -> 1.7    
#	 drivers/pcmcia/cs.c	1.19    -> 1.20   
#	drivers/pcmcia/cardbus.c	1.23    -> 1.23.1.1
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	rmk@flint.arm.linux.org.uk	1.889.359.6
# [PCMCIA] pcmcia-7: Remove cb_enable() and cb_disable()
# 
# Remove support for the old PCMCIA cardbus clients - all cardbus
# drivers should be converted to be full-class PCI citizens.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Wed Mar 26 19:21:29 2003
+++ b/drivers/pcmcia/cardbus.c	Wed Mar 26 19:21:29 2003
@@ -327,65 +327,3 @@
 		printk(KERN_INFO "cs: cb_free(bus %d)\n", s->cap.cb_dev->subordinate->number);
 	}
 }
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
-}
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Wed Mar 26 19:21:29 2003
+++ b/drivers/pcmcia/cs.c	Wed Mar 26 19:21:29 2003
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
@@ -1569,9 +1566,8 @@
     s = SOCKET(handle);
     
 #ifdef CONFIG_CARDBUS
-    if (handle->state & CLIENT_CARDBUS) {
+    if (handle->state & CLIENT_CARDBUS)
 	return CS_SUCCESS;
-    }
 #endif
     
     if (!(handle->state & CLIENT_STALE)) {
@@ -1674,16 +1670,8 @@
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
diff -Nru a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
--- a/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:21:29 2003
+++ b/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:21:29 2003
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

