Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVGIN2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVGIN2G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGIN2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:28:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36813 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261396AbVGIN1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:27:15 -0400
Date: Sat, 9 Jul 2005 15:26:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709132657.GA6088@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709124105.GB4665@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) ####################################
> (gdb) # c02a0a26, stack size:  416 bytes #
> (gdb) ####################################
> (gdb) 0xc02a0a26 is in pcmcia_device_query (drivers/pcmcia/ds.c:436).

----
this patch reduces the stack footprint of pcmcia_device_query() from 416 
bytes to 36 bytes. (patch only build-tested)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/pcmcia/ds.c
===================================================================
--- linux.orig/drivers/pcmcia/ds.c
+++ linux/drivers/pcmcia/ds.c
@@ -436,9 +436,13 @@ static int pcmcia_device_query(struct pc
 {
 	cistpl_manfid_t manf_id;
 	cistpl_funcid_t func_id;
-	cistpl_vers_1_t	vers1;
+	cistpl_vers_1_t	*vers1;
 	unsigned int i;
 
+	vers1 = kmalloc(sizeof(*vers1), GFP_KERNEL);
+	if (!vers1)
+		return -ENOMEM;
+
 	if (!pccard_read_tuple(p_dev->socket, p_dev->func,
 			       CISTPL_MANFID, &manf_id)) {
 		p_dev->manf_id = manf_id.manf;
@@ -455,23 +459,30 @@ static int pcmcia_device_query(struct pc
 		/* rule of thumb: cards with no FUNCID, but with
 		 * common memory device geometry information, are
 		 * probably memory cards (from pcmcia-cs) */
-		cistpl_device_geo_t devgeo;
+		cistpl_device_geo_t *devgeo;
+
+		devgeo = kmalloc(sizeof(*devgeo), GFP_KERNEL);
+		if (!devgeo) {
+			kfree(vers1);
+			return -ENOMEM;
+		}
 		if (!pccard_read_tuple(p_dev->socket, p_dev->func,
-				      CISTPL_DEVICE_GEO, &devgeo)) {
+				      CISTPL_DEVICE_GEO, devgeo)) {
 			ds_dbg(0, "mem device geometry probably means "
 			       "FUNCID_MEMORY\n");
 			p_dev->func_id = CISTPL_FUNCID_MEMORY;
 			p_dev->has_func_id = 1;
 		}
+		kfree(devgeo);
 	}
 
 	if (!pccard_read_tuple(p_dev->socket, p_dev->func, CISTPL_VERS_1,
-			       &vers1)) {
-		for (i=0; i < vers1.ns; i++) {
+			       vers1)) {
+		for (i=0; i < vers1->ns; i++) {
 			char *tmp;
 			unsigned int length;
 
-			tmp = vers1.str + vers1.ofs[i];
+			tmp = vers1->str + vers1->ofs[i];
 
 			length = strlen(tmp) + 1;
 			if ((length < 3) || (length > 255))
@@ -487,6 +498,7 @@ static int pcmcia_device_query(struct pc
 		}
 	}
 
+	kfree(vers1);
 	return 0;
 }
 
@@ -856,7 +868,9 @@ static int bind_request(struct pcmcia_bu
 rescan:
 	p_dev->cardmgr = p_drv;
 
-	pcmcia_device_query(p_dev);
+	ret = pcmcia_device_query(p_dev);
+	if (ret)
+		goto err_put_module;
 
 	/*
 	 * Prevent this racing with a card insertion.
