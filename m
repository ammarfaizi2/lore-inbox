Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWEKUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWEKUdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWEKUds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:33:48 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:58858 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750773AbWEKUdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:33:47 -0400
Message-ID: <44639FC7.7030800@maintech.de>
Date: Thu, 11 May 2006 22:34:15 +0200
From: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060508)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards
 if IO space is not available (revised)
References: <44629D10.80803@maintech.de> <1147362779.26130.45.camel@localhost.localdomain>
In-Reply-To: <1147362779.26130.45.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050603010200090800010701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603010200090800010701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Thomas Kleffel <tk@maintech.de>

this patch enables ide_cs to access CF-cards via their common memory
rather than via their IO space.

Signed-off-by: Thomas Kleffel <tk@maintech.de>
---

This patch is against 2.6.17-rc3

The reason why this patch makes sense is that it is pretty easy to build
a CF-Interface out of a simple address/data-bus if you only use common
and attribute memory. Adding the capability to access IO space makes
things more complicated.

If you just want to use CF-Storage cards, access to common and attribute
memory is enough as the IDE registers are available there, as well.

I have submitted a patch to RMK which enables the AT91RM9200's CF
interface to work in that mode.

I made some changes based on the feedback from Alan Cox and Iain Barker.

Thomas



--------------050603010200090800010701
Content-Type: text/x-patch;
 name="ide_cs.mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_cs.mem.patch"

diff -uprN l1/drivers/ide/legacy/ide-cs.c l2/drivers/ide/legacy/ide-cs.c
--- l1/drivers/ide/legacy/ide-cs.c	2006-05-11 00:19:59.000000000 +0200
+++ l2/drivers/ide/legacy/ide-cs.c	2006-05-11 22:32:54.000000000 +0200
@@ -146,7 +146,16 @@ static void ide_detach(struct pcmcia_dev
     kfree(link->priv);
 } /* ide_detach */
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq, struct pcmcia_device *handle)
+static void idecs_mmio_fixup(ide_hwif_t *hwif)
+{
+	default_hwif_mmiops(hwif);
+	hwif->mmio = 2;
+	
+	ide_undecoded_slave(hwif);
+}
+
+static int idecs_register(unsigned long io, unsigned long ctl, 
+	unsigned long irq, struct pcmcia_device *handle, int is_mmio)
 {
     hw_regs_t hw;
     memset(&hw, 0, sizeof(hw));
@@ -154,7 +163,19 @@ static int idecs_register(unsigned long 
     hw.irq = irq;
     hw.chipset = ide_pci;
     hw.dev = &handle->dev;
-    return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
+    
+    if(is_mmio)
+    	return ide_register_hw_with_fixup(&hw, NULL, idecs_mmio_fixup);
+    else
+        return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
+}
+
+void outb_io(unsigned char value, unsigned long port) {
+	outb(value, port);
+}
+
+void outb_mem(unsigned char value, unsigned long port) {
+	writeb(value, (void __iomem *) port);
 }
 
 /*======================================================================
@@ -180,7 +201,8 @@ static int ide_config(struct pcmcia_devi
     } *stk = NULL;
     cistpl_cftable_entry_t *cfg;
     int i, pass, last_ret = 0, last_fn = 0, hd, is_kme = 0;
-    unsigned long io_base, ctl_base;
+    unsigned long io_base, ctl_base, is_mmio;
+    void (*my_outb)(unsigned char, unsigned long);
 
     DEBUG(0, "ide_config(0x%p)\n", link);
 
@@ -210,7 +232,7 @@ static int ide_config(struct pcmcia_devi
     /* Not sure if this is right... look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(link, &stk->conf));
 
-    pass = io_base = ctl_base = 0;
+    pass = io_base = ctl_base = is_mmio = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
@@ -263,6 +285,33 @@ static int ide_config(struct pcmcia_devi
 	    break;
 	}
 
+	if ((cfg->mem.nwin > 0) || (stk->dflt.mem.nwin > 0)) {
+	    win_req_t req;
+	    memreq_t map;
+	    cistpl_mem_t *mem = (cfg->mem.nwin) ? &cfg->mem : &stk->dflt.mem;
+	    
+	    if (mem->win[0].len < 16) 
+	    	goto next_entry;
+	    
+	    req.Attributes = WIN_DATA_WIDTH_16|WIN_MEMORY_TYPE_CM;
+	    req.Attributes |= WIN_ENABLE;
+	    req.Base = mem->win[0].host_addr;
+	    req.Size = 16;
+
+	    req.AccessSpeed = 0;
+	    if (pcmcia_request_window(&link, &req, &link->win) != 0)
+		goto next_entry;
+	    map.Page = 0; map.CardOffset = mem->win[0].card_addr;
+	    if (pcmcia_map_mem_page(link->win, &map) != 0)
+		goto next_entry;
+
+      	    io_base = (unsigned long) ioremap(req.Base, req.Size);
+    	    ctl_base = io_base + 0x0e;
+    	    is_mmio = 1;
+
+	    break;
+	}
+
     next_entry:
 	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
 	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
@@ -277,22 +326,27 @@ static int ide_config(struct pcmcia_devi
 
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
+    
+    if(is_mmio) 
+    	my_outb = outb_mem;
+    else
+    	my_outb = outb_io;
 
     /* disable drive interrupts during IDE probe */
-    outb(0x02, ctl_base);
+    my_outb(0x02, ctl_base);
 
     /* special setup for KXLC005 card */
     if (is_kme)
-	outb(0x81, ctl_base+1);
+	my_outb(0x81, ctl_base+1);
 
     /* retry registration in case device is still spinning up */
     for (hd = -1, i = 0; i < 10; i++) {
-	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, link);
+	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ, link, is_mmio);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
-	    outb(0x02, ctl_base + 0x10);
+	    my_outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ, link);
+				link->irq.AssignedIRQ, link, is_mmio);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;

--------------050603010200090800010701--
