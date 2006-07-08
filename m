Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWGHRlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWGHRlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWGHRlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:41:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964915AbWGHRlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:41:06 -0400
Date: Sat, 8 Jul 2006 10:41:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
Message-Id: <20060708104100.af5dcbd8.akpm@osdl.org>
In-Reply-To: <1152380199.27368.9.camel@localhost.localdomain>
References: <20060708145541.GA2079@elf.ucw.cz>
	<1152380199.27368.9.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jul 2006 18:36:39 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Sad, 2006-07-08 am 16:55 +0200, ysgrifennodd Pavel Machek:
> > ide2: I/O resource 0xF887E00E-0xF887E00E not free.
> > ide2: ports already in use, skipping probe
> > ide2: I/O resource 0xF887E01E-0xF887E01E not free.
> > ide2: ports already in use, skipping probe
> 
> 
> Looks like ioremap values not I/O ports. Probably the various IDE layer
> changes from 2.6.17-mm.
> 
> My first guess would be the PCMCIA layer changes to use mmio ports are
> not setting hwif->mmio (I think its ->mmio) to 2 and doing their own
> resource management.
> 

5040cb8b7e61b7a03e8837920b9eb2c839bb1947 looks like a good one to try
reverting.

commit 5040cb8b7e61b7a03e8837920b9eb2c839bb1947
Author: Thomas Kleffel <tk@maintech.de>
Date:   Sun May 14 15:16:30 2006 +0200

    [PATCH] pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available
    
    This patch enables ide_cs to access CF-cards via their common memory
    rather than via their IO space.
    
    Signed-off-by: Thomas Kleffel <tk@maintech.de>
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 602797a..b7e459e 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
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
+    unsigned long io_base, ctl_base, is_mmio, try_slave;
+    void (*my_outb)(unsigned char, unsigned long);
 
     DEBUG(0, "ide_config(0x%p)\n", link);
 
@@ -210,7 +232,7 @@ static int ide_config(struct pcmcia_devi
     /* Not sure if this is right... look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(link, &stk->conf));
 
-    pass = io_base = ctl_base = 0;
+    pass = io_base = ctl_base = is_mmio = try_slave = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
@@ -258,11 +280,45 @@ static int ide_config(struct pcmcia_devi
 			goto next_entry;
 		io_base = link->io.BasePort1;
 		ctl_base = link->io.BasePort1 + 0x0e;
+
+		if (io->win[0].len >= 0x20)
+			try_slave = 1;
+
 	    } else goto next_entry;
 	    /* If we've got this far, we're done */
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
+	    req.Size = 0;
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
+    	    if (mem->win[0].len >= 0x20)
+    	    	try_slave = 1;
+
+	    break;
+	}
+
     next_entry:
 	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
 	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
@@ -278,21 +334,26 @@ static int ide_config(struct pcmcia_devi
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
 
+    if(is_mmio)
+    	my_outb = outb_mem;
+    else
+    	my_outb = outb_io;
+
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
-	if (link->io.NumPorts1 == 0x20) {
-	    outb(0x02, ctl_base + 0x10);
+	if (try_slave) {
+	    my_outb(0x02, ctl_base + 0x10);
 	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
-				link->irq.AssignedIRQ, link);
+				link->irq.AssignedIRQ, link, is_mmio);
 	    if (hd >= 0) {
 		io_base += 0x10;
 		ctl_base += 0x10;

