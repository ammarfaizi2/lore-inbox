Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUFPW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUFPW4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUFPW4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:56:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:11735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266339AbUFPWzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:55:41 -0400
Date: Wed, 16 Jun 2004 15:53:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: bgerst@didntduck.org, joern@wohnheim.fh-wedel.de, jolt@tuxbox.org,
       akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Message-Id: <20040616155317.68793511.rddunlap@osdl.org>
In-Reply-To: <20040616125209.73724776.rddunlap@osdl.org>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	<20040615163445.6b886383.rddunlap@osdl.org>
	<200406160911.11985.jolt@tuxbox.org>
	<20040616094737.GA2548@wohnheim.fh-wedel.de>
	<40D01928.1080309@tuxbox.org>
	<20040616100008.GB2548@wohnheim.fh-wedel.de>
	<20040616103741.042f8029.rddunlap@osdl.org>
	<40D0984B.3050405@didntduck.org>
	<20040616125209.73724776.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This version moves the stack structure "stk" inside the ide_config()
function as an anonymous struct.
I hope this is the last one.... :)



Reduce large stack usage in ide_config() by using kmalloc(),
  down from 0x4a4 bytes to 0x64 bytes (x86-32).
Little whitespace cleanup.
Move function comment block to immediately above the function.
Module loaded and unloaded, otherwise not tested (no hardware).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/ide/legacy/ide-cs.c |  130 ++++++++++++++++++++++++--------------------
 1 files changed, 73 insertions(+), 57 deletions(-)

diff -Naurp ./drivers/ide/legacy/ide-cs.c~idecs_stack ./drivers/ide/legacy/ide-cs.c
--- ./drivers/ide/legacy/ide-cs.c~idecs_stack	2004-05-09 19:32:53.000000000 -0700
+++ ./drivers/ide/legacy/ide-cs.c	2004-06-16 13:31:08.285160776 -0700
@@ -199,6 +199,16 @@ static void ide_detach(dev_link_t *link)
     
 } /* ide_detach */
 
+static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
+{
+    hw_regs_t hw;
+    memset(&hw, 0, sizeof(hw));
+    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    hw.irq = irq;
+    hw.chipset = ide_pci;
+    return ide_register_hw(&hw, NULL);
+}
+
 /*======================================================================
 
     ide_config() is scheduled to run after a CARD_INSERTION event
@@ -210,84 +220,82 @@ static void ide_detach(dev_link_t *link)
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-static int idecs_register(unsigned long io, unsigned long ctl, unsigned long irq)
-{
-    hw_regs_t hw;
-    memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
-    hw.irq = irq;
-    hw.chipset = ide_pci;
-    return ide_register_hw(&hw, NULL);
-}
-
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
     ide_info_t *info = link->priv;
     tuple_t tuple;
-    u_short buf[128];
-    cisparse_t parse;
-    config_info_t conf;
-    cistpl_cftable_entry_t *cfg = &parse.cftable_entry;
-    cistpl_cftable_entry_t dflt = { 0 };
-    int i, pass, last_ret, last_fn, hd, is_kme = 0;
+    struct {
+	u_short		buf[128];
+	cisparse_t	parse;
+	config_info_t	conf;
+	cistpl_cftable_entry_t dflt;
+    } *stk = 0;
+    cistpl_cftable_entry_t *cfg;
+    int i, pass, last_ret = 0, last_fn = 0, hd, is_kme = 0;
     unsigned long io_base, ctl_base;
 
     DEBUG(0, "ide_config(0x%p)\n", link);
-    
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleOffset = 0; tuple.TupleDataMax = 255;
+
+    stk = kmalloc(sizeof(*stk), GFP_KERNEL);
+    if (!stk) goto err_mem;
+    memset(stk, 0, sizeof(*stk));
+    cfg = &stk->parse.cftable_entry;
+
+    tuple.TupleData = (cisdata_t *)&stk->buf;
+    tuple.TupleOffset = 0;
+    tuple.TupleDataMax = 255;
     tuple.Attributes = 0;
     tuple.DesiredTuple = CISTPL_CONFIG;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     CS_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
-    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
-    link->conf.ConfigBase = parse.config.base;
-    link->conf.Present = parse.config.rmask[0];
+    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &stk->parse));
+    link->conf.ConfigBase = stk->parse.config.base;
+    link->conf.Present = stk->parse.config.rmask[0];
 
     tuple.DesiredTuple = CISTPL_MANFID;
     if (!pcmcia_get_first_tuple(handle, &tuple) &&
 	!pcmcia_get_tuple_data(handle, &tuple) &&
-	!pcmcia_parse_tuple(handle, &tuple, &parse))
-	is_kme = ((parse.manfid.manf == MANFID_KME) &&
-		  ((parse.manfid.card == PRODID_KME_KXLC005_A) ||
-		   (parse.manfid.card == PRODID_KME_KXLC005_B)));
+	!pcmcia_parse_tuple(handle, &tuple, &stk->parse))
+	is_kme = ((stk->parse.manfid.manf == MANFID_KME) &&
+		  ((stk->parse.manfid.card == PRODID_KME_KXLC005_A) ||
+		   (stk->parse.manfid.card == PRODID_KME_KXLC005_B)));
 
     /* Configure card */
     link->state |= DEV_CONFIG;
 
     /* Not sure if this is right... look up the current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
-    
+    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &stk->conf));
+    link->conf.Vcc = stk->conf.Vcc;
+
     pass = io_base = ctl_base = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     while (1) {
     	if (pcmcia_get_tuple_data(handle, &tuple) != 0) goto next_entry;
-	if (pcmcia_parse_tuple(handle, &tuple, &parse) != 0) goto next_entry;
+	if (pcmcia_parse_tuple(handle, &tuple, &stk->parse) != 0) goto next_entry;
 
 	/* Check for matching Vcc, unless we're desperate */
 	if (!pass) {
-	    if (cfg->vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM]/10000)
+	    if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (stk->conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
 		    goto next_entry;
-	    } else if (dflt.vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc != dflt.vcc.param[CISTPL_POWER_VNOM]/10000)
+	    } else if (stk->dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (stk->conf.Vcc != stk->dflt.vcc.param[CISTPL_POWER_VNOM] / 10000)
 		    goto next_entry;
 	    }
 	}
-	
-	if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
+
+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
 	    link->conf.Vpp1 = link->conf.Vpp2 =
-		cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
-	else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
+		cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
 	    link->conf.Vpp1 = link->conf.Vpp2 =
-		dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
-	
-	if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
-	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt.io;
+		stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
+	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &stk->dflt.io;
 	    link->conf.ConfigIndex = cfg->index;
 	    link->io.BasePort1 = io->win[0].base;
 	    link->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
@@ -307,23 +315,24 @@ void ide_config(dev_link_t *link)
 		if (pcmcia_request_io(link->handle, &link->io) != 0)
 			goto next_entry;
 		io_base = link->io.BasePort1;
-		ctl_base = link->io.BasePort1+0x0e;
+		ctl_base = link->io.BasePort1 + 0x0e;
 	    } else goto next_entry;
 	    /* If we've got this far, we're done */
 	    break;
 	}
-	
+
     next_entry:
-	if (cfg->flags & CISTPL_CFTABLE_DEFAULT) dflt = *cfg;
+	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
 	if (pass) {
 	    CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
 	} else if (pcmcia_get_next_tuple(handle, &tuple) != 0) {
 	    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
-	    memset(&dflt, 0, sizeof(dflt));
+	    memset(&stk->dflt, 0, sizeof(stk->dflt));
 	    pass++;
 	}
     }
-    
+
     CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle, &link->conf));
 
@@ -336,25 +345,27 @@ void ide_config(dev_link_t *link)
     outb(0x02, ctl_base);
 
     /* special setup for KXLC005 card */
-    if (is_kme) outb(0x81, ctl_base+1);
+    if (is_kme)
+	outb(0x81, ctl_base+1);
 
     /* retry registration in case device is still spinning up */
     for (hd = -1, i = 0; i < 10; i++) {
 	hd = idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
 	if (hd >= 0) break;
 	if (link->io.NumPorts1 == 0x20) {
-	    outb(0x02, ctl_base+0x10);
-	    hd = idecs_register(io_base+0x10, ctl_base+0x10,
+	    outb(0x02, ctl_base + 0x10);
+	    hd = idecs_register(io_base + 0x10, ctl_base + 0x10,
 				link->irq.AssignedIRQ);
 	    if (hd >= 0) {
-		io_base += 0x10; ctl_base += 0x10;
+		io_base += 0x10;
+		ctl_base += 0x10;
 		break;
 	    }
 	}
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/10);
     }
-    
+
     if (hd < 0) {
 	printk(KERN_NOTICE "ide-cs: ide_register() at 0x%3lx & 0x%3lx"
 	       ", irq %u failed\n", io_base, ctl_base,
@@ -363,24 +374,29 @@ void ide_config(dev_link_t *link)
     }
 
     info->ndev = 1;
-    sprintf(info->node.dev_name, "hd%c", 'a'+(hd*2));
+    sprintf(info->node.dev_name, "hd%c", 'a' + (hd * 2));
     info->node.major = ide_major[hd];
     info->node.minor = 0;
     info->hd = hd;
     link->dev = &info->node;
     printk(KERN_INFO "ide-cs: %s: Vcc = %d.%d, Vpp = %d.%d\n",
-	   info->node.dev_name, link->conf.Vcc/10, link->conf.Vcc%10,
-	   link->conf.Vpp1/10, link->conf.Vpp1%10);
+	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
+	   link->conf.Vpp1 / 10, link->conf.Vpp1 % 10);
 
     link->state &= ~DEV_CONFIG_PENDING;
+    kfree(stk);
     return;
-    
+
+err_mem:
+    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
+    goto failed;
+
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
+    kfree(stk);
     ide_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-
 } /* ide_config */
 
 /*======================================================================
