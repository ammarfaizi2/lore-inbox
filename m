Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVDUWN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVDUWN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDUWN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:13:58 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:42477 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261422AbVDUWMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:12:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sRAjNte83MDaj5tWM8SqnbLyTTPaQrxBD+hYvYIXJjv99hhSSATxtieBdcQHzxN11LhSkuPayc6N2/h2huORUPAP+JS7x9W3MFxW58y7ZYH+suL33I3MWenQ1FGDCL26oo3QcPKlEw5hkqAuel6mwo6Kwwk1oOAfGOHOtlOug7A=
Message-ID: <df35dfeb05042115124fb28471@mail.gmail.com>
Date: Thu, 21 Apr 2005 15:12:17 -0700
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH linux-2.6.12-rc2-mm3] serial_cs: Reduce stack usage in serial_event()
Cc: dahinds@users.sourceforge.net, rddunlap@osdl.org
In-Reply-To: <df35dfeb05042115021c24638b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <df35dfeb05042115021c24638b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces the stack usage of the function serial_event() in
serial_cs from 2212 to 228. I used a patched version of gcc 3.4.3 on
i386 with -fno-unit-at-a-time disabled.

This patch is only compile tested. It would be nice to get feedback
from someone that owns the hardware and would like to test it.

Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

 serial_cs.c |  170 ++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 110 insertions(+), 60 deletions(-)

diff -Nupr -X dontdiff
linux-2.6.12-rc2-mm3.a/drivers/serial/serial_cs.c
linux-2.6.12-rc2-mm3.b/drivers/serial/serial_cs.c
--- linux-2.6.12-rc2-mm3.a/drivers/serial/serial_cs.c	2005-04-19
23:20:14.000000000 -0700
+++ linux-2.6.12-rc2-mm3.b/drivers/serial/serial_cs.c	2005-04-20
23:22:19.000000000 -0700
@@ -110,6 +110,13 @@ struct serial_info {
 	int			line[4];
 };
 
+struct serial_cfg_mem {
+	tuple_t tuple;
+	cisparse_t parse;
+	u_char buf[256];	
+};
+
+
 static void serial_config(dev_link_t * link);
 static int serial_event(event_t event, int priority,
 			event_callback_args_t * args);
@@ -388,14 +395,24 @@ static int simple_config(dev_link_t *lin
 	static int size_table[2] = { 8, 16 };
 	client_handle_t handle = link->handle;
 	struct serial_info *info = link->priv;
-	tuple_t tuple;
-	u_char buf[256];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
+	struct serial_cfg_mem *cfg_mem;
+	tuple_t *tuple;
+	u_char *buf;
+	cisparse_t *parse;
+	cistpl_cftable_entry_t *cf;
 	config_info_t config;
 	int i, j, try;
 	int s;
 
+	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
+	if (!cfg_mem)
+		return -1;
+	
+	tuple = &cfg_mem->tuple;
+	parse = &cfg_mem->parse;
+	cf = &parse->cftable_entry;
+	buf = cfg_mem->buf;
+
 	/* If the card is already configured, look up the port and irq */
 	i = pcmcia_get_configuration_info(handle, &config);
 	if ((i == CS_SUCCESS) && (config.Attributes & CONF_VALID_CLIENT)) {
@@ -408,21 +425,23 @@ static int simple_config(dev_link_t *lin
 			port = config.BasePort1 + 0x28;
 			info->slave = 1;
 		}
-		if (info->slave)
+		if (info->slave) {
+			kfree(cfg_mem);
 			return setup_serial(handle, info, port, config.AssignedIRQ);
+		}
 	}
 	link->conf.Vcc = config.Vcc;
 
 	/* First pass: look for a config entry that looks normal. */
-	tuple.TupleData = (cisdata_t *) buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+	tuple->TupleData = (cisdata_t *) buf;
+	tuple->TupleOffset = 0;
+	tuple->TupleDataMax = 255;
+	tuple->Attributes = 0;
+	tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	/* Two tries: without IO aliases, then with aliases */
 	for (s = 0; s < 2; s++) {
 		for (try = 0; try < 2; try++) {
-			i = first_tuple(handle, &tuple, &parse);
+			i = first_tuple(handle, tuple, parse);
 			while (i != CS_NO_MORE_ITEMS) {
 				if (i != CS_SUCCESS)
 					goto next_entry;
@@ -440,14 +459,14 @@ static int simple_config(dev_link_t *lin
 						goto found_port;
 				}
 next_entry:
-				i = next_tuple(handle, &tuple, &parse);
+				i = next_tuple(handle, tuple, parse);
 			}
 		}
 	}
 	/* Second pass: try to find an entry that isn't picky about
 	   its base address, then try to grab any standard serial port
 	   address, and finally try to get any free port. */
-	i = first_tuple(handle, &tuple, &parse);
+	i = first_tuple(handle, tuple, parse);
 	while (i != CS_NO_MORE_ITEMS) {
 		if ((i == CS_SUCCESS) && (cf->io.nwin > 0) &&
 		    ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
@@ -460,7 +479,7 @@ next_entry:
 					goto found_port;
 			}
 		}
-		i = next_tuple(handle, &tuple, &parse);
+		i = next_tuple(handle, tuple, parse);
 	}
 
       found_port:
@@ -468,6 +487,7 @@ next_entry:
 		printk(KERN_NOTICE
 		       "serial_cs: no usable port range found, giving up\n");
 		cs_error(link->handle, RequestIO, i);
+		kfree(cfg_mem);
 		return -1;
 	}
 
@@ -481,9 +501,10 @@ next_entry:
 	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestConfiguration, i);
+		kfree(cfg_mem);
 		return -1;
 	}
-
+	kfree(cfg_mem);
 	return setup_serial(handle, info, link->io.BasePort1, link->irq.AssignedIRQ);
 }
 
@@ -491,29 +512,39 @@ static int multi_config(dev_link_t * lin
 {
 	client_handle_t handle = link->handle;
 	struct serial_info *info = link->priv;
-	tuple_t tuple;
-	u_char buf[256];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
+	struct serial_cfg_mem *cfg_mem;
+	tuple_t *tuple;
+	u_char *buf;
+	cisparse_t *parse;
+	cistpl_cftable_entry_t *cf;
 	config_info_t config;
-	int i, base2 = 0;
+	int i, rc, base2 = 0;
+
+	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
+	if (!cfg_mem)
+		return -1;
+	tuple = &cfg_mem->tuple;
+	parse = &cfg_mem->parse;
+	cf = &parse->cftable_entry;
+	buf = cfg_mem->buf;
 
 	i = pcmcia_get_configuration_info(handle, &config);
 	if (i != CS_SUCCESS) {
 		cs_error(handle, GetConfigurationInfo, i);
-		return -1;
+		rc = -1;
+		goto free_cfg_mem;
 	}
 	link->conf.Vcc = config.Vcc;
 
-	tuple.TupleData = (cisdata_t *) buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+	tuple->TupleData = (cisdata_t *) buf;
+	tuple->TupleOffset = 0;
+	tuple->TupleDataMax = 255;
+	tuple->Attributes = 0;
+	tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
 
 	/* First, look for a generic full-sized window */
 	link->io.NumPorts1 = info->multi * 8;
-	i = first_tuple(handle, &tuple, &parse);
+	i = first_tuple(handle, tuple, parse);
 	while (i != CS_NO_MORE_ITEMS) {
 		/* The quad port cards have bad CIS's, so just look for a
 		   window larger than 8 ports and assume it will be right */
@@ -528,14 +559,14 @@ static int multi_config(dev_link_t * lin
 			if (i == CS_SUCCESS)
 				break;
 		}
-		i = next_tuple(handle, &tuple, &parse);
+		i = next_tuple(handle, tuple, parse);
 	}
 
 	/* If that didn't work, look for two windows */
 	if (i != CS_SUCCESS) {
 		link->io.NumPorts1 = link->io.NumPorts2 = 8;
 		info->multi = 2;
-		i = first_tuple(handle, &tuple, &parse);
+		i = first_tuple(handle, tuple, parse);
 		while (i != CS_NO_MORE_ITEMS) {
 			if ((i == CS_SUCCESS) && (cf->io.nwin == 2)) {
 				link->conf.ConfigIndex = cf->index;
@@ -548,13 +579,14 @@ static int multi_config(dev_link_t * lin
 				if (i == CS_SUCCESS)
 					break;
 			}
-			i = next_tuple(handle, &tuple, &parse);
+			i = next_tuple(handle, tuple, parse);
 		}
 	}
 
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestIO, i);
-		return -1;
+		rc = -1;
+		goto free_cfg_mem;
 	}
 
 	i = pcmcia_request_irq(link->handle, &link->irq);
@@ -572,7 +604,8 @@ static int multi_config(dev_link_t * lin
 	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestConfiguration, i);
-		return -1;
+		rc = -1;
+		goto free_cfg_mem;
 	}
 
 	/* The Oxford Semiconductor OXCF950 cards are in fact single-port:
@@ -593,17 +626,22 @@ static int multi_config(dev_link_t * lin
 		}
 		info->c950ctrl = base2;
 		wakeup_card(info);
-		return 0;
+		rc = 0;
+		goto free_cfg_mem;
 	}
 
 	setup_serial(handle, info, link->io.BasePort1, link->irq.AssignedIRQ);
 	/* The Nokia cards are not really multiport cards */
-	if (info->manfid == MANFID_NOKIA)
-		return 0;
+	if (info->manfid == MANFID_NOKIA) {
+		rc = 0;
+		goto free_cfg_mem;
+	}
 	for (i = 0; i < info->multi - 1; i++)
 		setup_serial(handle, info, base2 + (8 * i), link->irq.AssignedIRQ);
-
-	return 0;
+	rc = 0;
+free_cfg_mem:
+	kfree(cfg_mem);
+	return rc;
 }
 
 /*======================================================================
@@ -618,39 +656,49 @@ void serial_config(dev_link_t * link)
 {
 	client_handle_t handle = link->handle;
 	struct serial_info *info = link->priv;
-	tuple_t tuple;
-	u_short buf[128];
-	cisparse_t parse;
-	cistpl_cftable_entry_t *cf = &parse.cftable_entry;
+	struct serial_cfg_mem *cfg_mem;
+	tuple_t *tuple;
+	u_char *buf;
+	cisparse_t *parse;
+	cistpl_cftable_entry_t *cf;
 	int i, last_ret, last_fn;
 
 	DEBUG(0, "serial_config(0x%p)\n", link);
 
-	tuple.TupleData = (cisdata_t *) buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
+	cfg_mem = kmalloc(sizeof(struct serial_cfg_mem), GFP_KERNEL);
+	if (!cfg_mem)
+		goto failed;
+
+	tuple = &cfg_mem->tuple;
+	parse = &cfg_mem->parse;
+	cf = &parse->cftable_entry;
+	buf = cfg_mem->buf;
+
+	tuple->TupleData = (cisdata_t *) buf;
+	tuple->TupleOffset = 0;
+	tuple->TupleDataMax = 255;
+	tuple->Attributes = 0;
 	/* Get configuration register information */
-	tuple.DesiredTuple = CISTPL_CONFIG;
-	last_ret = first_tuple(handle, &tuple, &parse);
+	tuple->DesiredTuple = CISTPL_CONFIG;
+	last_ret = first_tuple(handle, tuple, parse);
 	if (last_ret != CS_SUCCESS) {
 		last_fn = ParseTuple;
 		goto cs_failed;
 	}
-	link->conf.ConfigBase = parse.config.base;
-	link->conf.Present = parse.config.rmask[0];
+	link->conf.ConfigBase = parse->config.base;
+	link->conf.Present = parse->config.rmask[0];
 
 	/* Configure card */
 	link->state |= DEV_CONFIG;
 
 	/* Is this a compliant multifunction card? */
-	tuple.DesiredTuple = CISTPL_LONGLINK_MFC;
-	tuple.Attributes = TUPLE_RETURN_COMMON | TUPLE_RETURN_LINK;
-	info->multi = (first_tuple(handle, &tuple, &parse) == CS_SUCCESS);
+	tuple->DesiredTuple = CISTPL_LONGLINK_MFC;
+	tuple->Attributes = TUPLE_RETURN_COMMON | TUPLE_RETURN_LINK;
+	info->multi = (first_tuple(handle, tuple, parse) == CS_SUCCESS);
 
 	/* Is this a multiport card? */
-	tuple.DesiredTuple = CISTPL_MANFID;
-	if (first_tuple(handle, &tuple, &parse) == CS_SUCCESS) {
+	tuple->DesiredTuple = CISTPL_MANFID;
+	if (first_tuple(handle, tuple, parse) == CS_SUCCESS) {
 		info->manfid = le16_to_cpu(buf[0]);
 		info->prodid = le16_to_cpu(buf[1]);
 		for (i = 0; i < MULTI_COUNT; i++)
@@ -663,13 +711,13 @@ void serial_config(dev_link_t * link)
 
 	/* Another check for dual-serial cards: look for either serial or
 	   multifunction cards that ask for appropriate IO port ranges */
-	tuple.DesiredTuple = CISTPL_FUNCID;
+	tuple->DesiredTuple = CISTPL_FUNCID;
 	if ((info->multi == 0) &&
-	    ((first_tuple(handle, &tuple, &parse) != CS_SUCCESS) ||
-	     (parse.funcid.func == CISTPL_FUNCID_MULTI) ||
-	     (parse.funcid.func == CISTPL_FUNCID_SERIAL))) {
-		tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-		if (first_tuple(handle, &tuple, &parse) == CS_SUCCESS) {
+	    ((first_tuple(handle, tuple, parse) != CS_SUCCESS) ||
+	     (parse->funcid.func == CISTPL_FUNCID_MULTI) ||
+	     (parse->funcid.func == CISTPL_FUNCID_SERIAL))) {
+		tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
+		if (first_tuple(handle, tuple, parse) == CS_SUCCESS) {
 			if ((cf->io.nwin == 1) && (cf->io.win[0].len % 8 == 0))
 				info->multi = cf->io.win[0].len >> 3;
 			if ((cf->io.nwin == 2) && (cf->io.win[0].len == 8) &&
@@ -704,6 +752,7 @@ void serial_config(dev_link_t * link)
 
 	link->dev = &info->node[0];
 	link->state &= ~DEV_CONFIG_PENDING;
+	kfree(cfg_mem);
 	return;
 
  cs_failed:
@@ -711,6 +760,7 @@ void serial_config(dev_link_t * link)
  failed:
 	serial_remove(link);
 	link->state &= ~DEV_CONFIG_PENDING;
+	kfree(cfg_mem);
 }
 
 /*======================================================================
