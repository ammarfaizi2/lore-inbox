Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUFPSVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUFPSVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUFPSVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:21:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:27883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264312AbUFPSUL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:20:11 -0400
Date: Wed, 16 Jun 2004 11:16:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Message-Id: <20040616111621.4d1fdfff.rddunlap@osdl.org>
In-Reply-To: <20040616175730.GA15365@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	<20040615163445.6b886383.rddunlap@osdl.org>
	<200406160911.11985.jolt@tuxbox.org>
	<20040616094737.GA2548@wohnheim.fh-wedel.de>
	<40D01928.1080309@tuxbox.org>
	<20040616100008.GB2548@wohnheim.fh-wedel.de>
	<20040616103741.042f8029.rddunlap@osdl.org>
	<20040616175730.GA15365@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 19:57:30 +0200 Jörn Engel wrote:

| On Wed, 16 June 2004 10:37:41 -0700, Randy.Dunlap wrote:
| > 
| > Thanks for the helpful comments.  Here's a corrected patch.
| 
| Looks, as if it still leaks memory:

duh.  fudge.  Thanks.  How's this one?




Reduce large stack usage in ide_config() by using kmalloc(),
  down from 0x4a4 bytes to 0x74 bytes (x86-32).
Little whitespace cleanup.
Move function comment block to immediately above the function.
Module loaded and unloaded, otherwise not tested (no hardware).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/ide/legacy/ide-cs.c |  137 +++++++++++++++++++++++++-------------------
 1 files changed, 80 insertions(+), 57 deletions(-)

diff -Naurp ./drivers/ide/legacy/ide-cs.c~idecs_stack ./drivers/ide/legacy/ide-cs.c
--- ./drivers/ide/legacy/ide-cs.c~idecs_stack	2004-05-09 19:32:53.000000000 -0700
+++ ./drivers/ide/legacy/ide-cs.c	2004-06-16 10:42:00.554161496 -0700
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
@@ -210,84 +220,86 @@ static void ide_detach(dev_link_t *link)
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
+    u_short *tbuf = 0;
+    cisparse_t *cisparse = 0;
+    config_info_t *cfginfo = 0;
+    cistpl_cftable_entry_t *cfg;
+    cistpl_cftable_entry_t *def_cte = 0;
+    int i, pass, last_ret = 0, last_fn = 0, hd, is_kme = 0;
     unsigned long io_base, ctl_base;
 
     DEBUG(0, "ide_config(0x%p)\n", link);
-    
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleOffset = 0; tuple.TupleDataMax = 255;
+
+    tbuf = kmalloc(128 * sizeof(u_short), GFP_KERNEL);
+    if (!tbuf) goto err_mem;
+    def_cte = kmalloc(sizeof(*def_cte), GFP_KERNEL);
+    if (!def_cte) goto err_mem;
+    memset(def_cte, 0, sizeof(*def_cte));
+    cfginfo = kmalloc(sizeof(*cfginfo), GFP_KERNEL);
+    if (!cfginfo) goto err_mem;
+    cisparse = kmalloc(sizeof(*cisparse), GFP_KERNEL);
+    if (!cisparse) goto err_mem;
+    cfg = &cisparse->cftable_entry;
+
+    tuple.TupleData = (cisdata_t *)tbuf;
+    tuple.TupleOffset = 0;
+    tuple.TupleDataMax = 255;
     tuple.Attributes = 0;
     tuple.DesiredTuple = CISTPL_CONFIG;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     CS_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
-    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
-    link->conf.ConfigBase = parse.config.base;
-    link->conf.Present = parse.config.rmask[0];
+    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, cisparse));
+    link->conf.ConfigBase = cisparse->config.base;
+    link->conf.Present = cisparse->config.rmask[0];
 
     tuple.DesiredTuple = CISTPL_MANFID;
     if (!pcmcia_get_first_tuple(handle, &tuple) &&
 	!pcmcia_get_tuple_data(handle, &tuple) &&
-	!pcmcia_parse_tuple(handle, &tuple, &parse))
-	is_kme = ((parse.manfid.manf == MANFID_KME) &&
-		  ((parse.manfid.card == PRODID_KME_KXLC005_A) ||
-		   (parse.manfid.card == PRODID_KME_KXLC005_B)));
+	!pcmcia_parse_tuple(handle, &tuple, cisparse))
+	is_kme = ((cisparse->manfid.manf == MANFID_KME) &&
+		  ((cisparse->manfid.card == PRODID_KME_KXLC005_A) ||
+		   (cisparse->manfid.card == PRODID_KME_KXLC005_B)));
 
     /* Configure card */
     link->state |= DEV_CONFIG;
 
     /* Not sure if this is right... look up the current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, &conf));
-    link->conf.Vcc = conf.Vcc;
-    
+    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handle, cfginfo));
+    link->conf.Vcc = cfginfo->Vcc;
+
     pass = io_base = ctl_base = 0;
     tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
     tuple.Attributes = 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     while (1) {
     	if (pcmcia_get_tuple_data(handle, &tuple) != 0) goto next_entry;
-	if (pcmcia_parse_tuple(handle, &tuple, &parse) != 0) goto next_entry;
+	if (pcmcia_parse_tuple(handle, &tuple, cisparse) != 0) goto next_entry;
 
 	/* Check for matching Vcc, unless we're desperate */
 	if (!pass) {
-	    if (cfg->vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM]/10000)
+	    if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (cfginfo->Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
 		    goto next_entry;
-	    } else if (dflt.vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc != dflt.vcc.param[CISTPL_POWER_VNOM]/10000)
+	    } else if (def_cte->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (cfginfo->Vcc != def_cte->vcc.param[CISTPL_POWER_VNOM] / 10000)
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
+	else if (def_cte->vpp1.present & (1 << CISTPL_POWER_VNOM))
 	    link->conf.Vpp1 = link->conf.Vpp2 =
-		dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
-	
-	if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
-	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt.io;
+		def_cte->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cfg->io.nwin > 0) || (def_cte->io.nwin > 0)) {
+	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &def_cte->io;
 	    link->conf.ConfigIndex = cfg->index;
 	    link->io.BasePort1 = io->win[0].base;
 	    link->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
@@ -307,23 +319,24 @@ void ide_config(dev_link_t *link)
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
+	    memcpy(def_cte, cfg, sizeof(*def_cte));
 	if (pass) {
 	    CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
 	} else if (pcmcia_get_next_tuple(handle, &tuple) != 0) {
 	    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
-	    memset(&dflt, 0, sizeof(dflt));
+	    memset(def_cte, 0, sizeof(*def_cte));
 	    pass++;
 	}
     }
-    
+
     CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle, &link->conf));
 
@@ -336,25 +349,27 @@ void ide_config(dev_link_t *link)
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
@@ -363,24 +378,32 @@ void ide_config(dev_link_t *link)
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
+    kfree(cisparse);
+    kfree(cfginfo);
+    kfree(def_cte);
+    kfree(tbuf);
+
     ide_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
-
 } /* ide_config */
 
 /*======================================================================
