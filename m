Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVDUWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVDUWDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVDUWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:03:13 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:58499 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261336AbVDUWCm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=afebIpiB5f8LMuN2pPh9bg7NPGMmmZYyjsAO0cK42lXHQJAMFX1HI3mbHT/U3YhhiJhrRKAiMTAOnCiajZ/hj2JCW13tKmvhBBWtcXp1X7qMYLNWJTDpLxJBykLbkgLpNDDwxYRyIkZ10lXx23h8QvUEQ/p+kqzGRJnAVYk60AI=
Message-ID: <df35dfeb05042115021c24638b@mail.gmail.com>
Date: Thu, 21 Apr 2005 15:02:42 -0700
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Cc: dahinds@users.sourceforge.net, joern@wohnheim.fh-wedel.de,
       rddunlap@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces the stack usage of the function smc91c92_event() in
smc91c92_cs driver from 3540 to 132. Currently this is the highest
stack user in linux-2.6.12-rc2-mm3. I used a patched version of gcc
3.4.3 on i386 with -fno-unit-at-a-time disabled.

The patch has only been compile tested. It would be nice to get
feedback if someone that owns the hardware can actually test this
patch.

Acked-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

 smc91c92_cs.c |  287 ++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 189 insertions(+), 98 deletions(-)

diff -Nupr -X dontdiff
linux-2.6.12-rc2-mm3.a/drivers/net/pcmcia/smc91c92_cs.c
linux-2.6.12-rc2-mm3.b/drivers/net/pcmcia/smc91c92_cs.c
--- linux-2.6.12-rc2-mm3.a/drivers/net/pcmcia/smc91c92_cs.c	2005-04-14
22:15:43.000000000 -0700
+++ linux-2.6.12-rc2-mm3.b/drivers/net/pcmcia/smc91c92_cs.c	2005-04-20
18:12:00.000000000 -0700
@@ -127,6 +127,12 @@ struct smc_private {
     int				rx_ovrn;
 };
 
+struct smc_cfg_mem {
+    tuple_t tuple;
+    cisparse_t parse;
+    u_char buf[255];
+};
+
 /* Special definitions for Megahertz multifunction cards */
 #define MEGAHERTZ_ISR		0x0380
 
@@ -498,14 +504,24 @@ static int mhz_mfc_config(dev_link_t *li
 {
     struct net_device *dev = link->priv;
     struct smc_private *smc = netdev_priv(dev);
-    tuple_t tuple;
-    cisparse_t parse;
-    u_char buf[255];
-    cistpl_cftable_entry_t *cf = &parse.cftable_entry;
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    cisparse_t *parse;
+    cistpl_cftable_entry_t *cf;
+    u_char *buf;
     win_req_t req;
     memreq_t mem;
     int i, k;
 
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+        return CS_OUT_OF_RESOURCE;
+
+    tuple = &cfg_mem->tuple;
+    parse = &cfg_mem->parse;
+    cf = &parse->cftable_entry;
+    buf = cfg_mem->buf;
+
     link->conf.Attributes |= CONF_ENABLE_SPKR;
     link->conf.Status = CCSR_AUDIO_ENA;
     link->irq.Attributes =
@@ -514,12 +530,12 @@ static int mhz_mfc_config(dev_link_t *li
     link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
     link->io.NumPorts2 = 8;
 
-    tuple.Attributes = tuple.TupleOffset = 0;
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleDataMax = sizeof(buf);
-    tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+    tuple->Attributes = tuple->TupleOffset = 0;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 255;
+    tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
 
-    i = first_tuple(link->handle, &tuple, &parse);
+    i = first_tuple(link->handle, tuple, parse);
     /* The Megahertz combo cards have modem-like CIS entries, so
        we have to explicitly try a bunch of port combinations. */
     while (i == CS_SUCCESS) {
@@ -532,10 +548,10 @@ static int mhz_mfc_config(dev_link_t *li
 	    if (i == CS_SUCCESS) break;
 	}
 	if (i == CS_SUCCESS) break;
-	i = next_tuple(link->handle, &tuple, &parse);
+	i = next_tuple(link->handle, tuple, parse);
     }
     if (i != CS_SUCCESS)
-	return i;
+	goto free_cfg_mem;
     dev->base_addr = link->io.BasePort1;
 
     /* Allocate a memory window, for accessing the ISR */
@@ -544,7 +560,7 @@ static int mhz_mfc_config(dev_link_t *li
     req.AccessSpeed = 0;
     i = pcmcia_request_window(&link->handle, &req, &link->win);
     if (i != CS_SUCCESS)
-	return i;
+	goto free_cfg_mem;
     smc->base = ioremap(req.Base, req.Size);
     mem.CardOffset = mem.Page = 0;
     if (smc->manfid == MANFID_MOTOROLA)
@@ -556,6 +572,8 @@ static int mhz_mfc_config(dev_link_t *li
 	&& (smc->cardid == PRODID_MEGAHERTZ_EM3288))
 	mhz_3288_power(link);
 
+free_cfg_mem:
+    kfree(cfg_mem);
     return i;
 }
 
@@ -563,39 +581,61 @@ static int mhz_setup(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
     struct net_device *dev = link->priv;
-    tuple_t tuple;
-    cisparse_t parse;
-    u_char buf[255], *station_addr;
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    cisparse_t *parse;
+    u_char *buf, *station_addr;
+    int rc;
+
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+	return -1;
 
-    tuple.Attributes = tuple.TupleOffset = 0;
-    tuple.TupleData = buf;
-    tuple.TupleDataMax = sizeof(buf);
+    tuple = &cfg_mem->tuple;
+    parse = &cfg_mem->parse;
+    buf = cfg_mem->buf;
+
+    tuple->Attributes = tuple->TupleOffset = 0;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 255;
 
     /* Read the station address from the CIS.  It is stored as the last
        (fourth) string in the Version 1 Version/ID tuple. */
-    tuple.DesiredTuple = CISTPL_VERS_1;
-    if (first_tuple(handle, &tuple, &parse) != CS_SUCCESS)
-	return -1;
+    tuple->DesiredTuple = CISTPL_VERS_1;
+    if (first_tuple(handle, tuple, parse) != CS_SUCCESS) {
+	rc = -1;
+	goto free_cfg_mem;
+    }
     /* Ugh -- the EM1144 card has two VERS_1 tuples!?! */
-    if (next_tuple(handle, &tuple, &parse) != CS_SUCCESS)
-	first_tuple(handle, &tuple, &parse);
-    if (parse.version_1.ns > 3) {
-	station_addr = parse.version_1.str + parse.version_1.ofs[3];
-	if (cvt_ascii_address(dev, station_addr) == 0)
-	    return 0;
+    if (next_tuple(handle, tuple, parse) != CS_SUCCESS)
+	first_tuple(handle, tuple, parse);
+    if (parse->version_1.ns > 3) {
+	station_addr = parse->version_1.str + parse->version_1.ofs[3];
+	if (cvt_ascii_address(dev, station_addr) == 0) {
+		rc = 0;
+		goto free_cfg_mem;
+	}
     }
 
     /* Another possibility: for the EM3288, in a special tuple */
-    tuple.DesiredTuple = 0x81;
-    if (pcmcia_get_first_tuple(handle, &tuple) != CS_SUCCESS)
-	return -1;
-    if (pcmcia_get_tuple_data(handle, &tuple) != CS_SUCCESS)
-	return -1;
+    tuple->DesiredTuple = 0x81;
+    if (pcmcia_get_first_tuple(handle, tuple) != CS_SUCCESS) {
+	rc = -1;
+	goto free_cfg_mem;
+    }
+    if (pcmcia_get_tuple_data(handle, tuple) != CS_SUCCESS) {
+	rc = -1;
+	goto free_cfg_mem;
+    }
     buf[12] = '\0';
-    if (cvt_ascii_address(dev, buf) == 0)
-	return 0;
-
-    return -1;
+    if (cvt_ascii_address(dev, buf) == 0) {
+	rc = 0;
+	goto free_cfg_mem;
+   }
+    rc = -1;
+free_cfg_mem:
+   kfree(cfg_mem);
+   return rc;
 }
 
 /*======================================================================
@@ -665,19 +705,29 @@ static int mot_setup(dev_link_t *link)
 static int smc_config(dev_link_t *link)
 {
     struct net_device *dev = link->priv;
-    tuple_t tuple;
-    cisparse_t parse;
-    u_char buf[255];
-    cistpl_cftable_entry_t *cf = &parse.cftable_entry;
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    cisparse_t *parse;
+    cistpl_cftable_entry_t *cf;
+    u_char *buf;
     int i;
 
-    tuple.Attributes = tuple.TupleOffset = 0;
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleDataMax = sizeof(buf);
-    tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+	return CS_OUT_OF_RESOURCE;
+
+    tuple = &cfg_mem->tuple;
+    parse = &cfg_mem->parse;
+    cf = &parse->cftable_entry;
+    buf = cfg_mem->buf;
+
+    tuple->Attributes = tuple->TupleOffset = 0;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 255;
+    tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
 
     link->io.NumPorts1 = 16;
-    i = first_tuple(link->handle, &tuple, &parse);
+    i = first_tuple(link->handle, tuple, parse);
     while (i != CS_NO_MORE_ITEMS) {
 	if (i == CS_SUCCESS) {
 	    link->conf.ConfigIndex = cf->index;
@@ -686,10 +736,12 @@ static int smc_config(dev_link_t *link)
 	    i = pcmcia_request_io(link->handle, &link->io);
 	    if (i == CS_SUCCESS) break;
 	}
-	i = next_tuple(link->handle, &tuple, &parse);
+	i = next_tuple(link->handle, tuple, parse);
     }
     if (i == CS_SUCCESS)
 	dev->base_addr = link->io.BasePort1;
+
+    kfree(cfg_mem);
     return i;
 }
 
@@ -697,41 +749,58 @@ static int smc_setup(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
     struct net_device *dev = link->priv;
-    tuple_t tuple;
-    cisparse_t parse;
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    cisparse_t *parse;
     cistpl_lan_node_id_t *node_id;
-    u_char buf[255], *station_addr;
-    int i;
+    u_char *buf, *station_addr;
+    int i, rc;
 
-    tuple.Attributes = tuple.TupleOffset = 0;
-    tuple.TupleData = buf;
-    tuple.TupleDataMax = sizeof(buf);
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+	return CS_OUT_OF_RESOURCE;
+
+    tuple = &cfg_mem->tuple;
+    parse = &cfg_mem->parse;
+    buf = cfg_mem->buf;
+
+    tuple->Attributes = tuple->TupleOffset = 0;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 255;
 
     /* Check for a LAN function extension tuple */
-    tuple.DesiredTuple = CISTPL_FUNCE;
-    i = first_tuple(handle, &tuple, &parse);
+    tuple->DesiredTuple = CISTPL_FUNCE;
+    i = first_tuple(handle, tuple, parse);
     while (i == CS_SUCCESS) {
-	if (parse.funce.type == CISTPL_FUNCE_LAN_NODE_ID)
+	if (parse->funce.type == CISTPL_FUNCE_LAN_NODE_ID)
 	    break;
-	i = next_tuple(handle, &tuple, &parse);
+	i = next_tuple(handle, tuple, parse);
     }
     if (i == CS_SUCCESS) {
-	node_id = (cistpl_lan_node_id_t *)parse.funce.data;
+	node_id = (cistpl_lan_node_id_t *)parse->funce.data;
 	if (node_id->nb == 6) {
 	    for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = node_id->id[i];
-	    return 0;
+	    rc = 0;
+	    goto free_cfg_mem;
 	}
     }
     /* Try the third string in the Version 1 Version/ID tuple. */
-    tuple.DesiredTuple = CISTPL_VERS_1;
-    if (first_tuple(handle, &tuple, &parse) != CS_SUCCESS)
-	return -1;
-    station_addr = parse.version_1.str + parse.version_1.ofs[2];
-    if (cvt_ascii_address(dev, station_addr) == 0)
-	return 0;
+    tuple->DesiredTuple = CISTPL_VERS_1;
+    if (first_tuple(handle, tuple, parse) != CS_SUCCESS) {
+	rc = -1;
+	goto free_cfg_mem;
+    }
+    station_addr = parse->version_1.str + parse->version_1.ofs[2];
+    if (cvt_ascii_address(dev, station_addr) == 0) {
+	rc = 0;
+	goto free_cfg_mem;
+    }
 
-    return -1;
+    rc = -1;
+free_cfg_mem:
+    kfree(cfg_mem);
+    return rc;
 }
 
 /*====================================================================*/
@@ -773,26 +842,36 @@ static int osi_setup(dev_link_t *link, u
 {
     client_handle_t handle = link->handle;
     struct net_device *dev = link->priv;
-    tuple_t tuple;
-    u_char buf[255];
-    int i;
-
-    tuple.Attributes = TUPLE_RETURN_COMMON;
-    tuple.TupleData = buf;
-    tuple.TupleDataMax = sizeof(buf);
-    tuple.TupleOffset = 0;
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    u_char *buf;
+    int i, rc;
+
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+        return -1;
+
+    tuple = &cfg_mem->tuple;
+    buf = cfg_mem->buf;
+
+    tuple->Attributes = TUPLE_RETURN_COMMON;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 255;
+    tuple->TupleOffset = 0;
 
     /* Read the station address from tuple 0x90, subtuple 0x04 */
-    tuple.DesiredTuple = 0x90;
-    i = pcmcia_get_first_tuple(handle, &tuple);
+    tuple->DesiredTuple = 0x90;
+    i = pcmcia_get_first_tuple(handle, tuple);
     while (i == CS_SUCCESS) {
-	i = pcmcia_get_tuple_data(handle, &tuple);
+	i = pcmcia_get_tuple_data(handle, tuple);
 	if ((i != CS_SUCCESS) || (buf[0] == 0x04))
 	    break;
-	i = pcmcia_get_next_tuple(handle, &tuple);
+	i = pcmcia_get_next_tuple(handle, tuple);
+    }
+    if (i != CS_SUCCESS) {
+	rc = -1;
+	goto free_cfg_mem;
     }
-    if (i != CS_SUCCESS)
-	return -1;
     for (i = 0; i < 6; i++)
 	dev->dev_addr[i] = buf[i+2];
 
@@ -814,8 +893,10 @@ static int osi_setup(dev_link_t *link, u
 	      inw(link->io.BasePort1 + OSITECH_AUI_PWR),
 	      inw(link->io.BasePort1 + OSITECH_RESET_ISR));
     }
-
-    return 0;
+    rc = 0;
+free_cfg_mem:
+   kfree(cfg_mem);
+   return rc;
 }
 
 /*======================================================================
@@ -887,9 +968,10 @@ static void smc91c92_config(dev_link_t *
     client_handle_t handle = link->handle;
     struct net_device *dev = link->priv;
     struct smc_private *smc = netdev_priv(dev);
-    tuple_t tuple;
-    cisparse_t parse;
-    u_short buf[32];
+    struct smc_cfg_mem *cfg_mem;
+    tuple_t *tuple;
+    cisparse_t *parse;
+    u_char *buf;
     char *name;
     int i, j, rev;
     kio_addr_t ioaddr;
@@ -897,21 +979,29 @@ static void smc91c92_config(dev_link_t *
 
     DEBUG(0, "smc91c92_config(0x%p)\n", link);
 
-    tuple.Attributes = tuple.TupleOffset = 0;
-    tuple.TupleData = (cisdata_t *)buf;
-    tuple.TupleDataMax = sizeof(buf);
+    cfg_mem = kmalloc(sizeof(struct smc_cfg_mem), GFP_KERNEL);
+    if (!cfg_mem)
+	goto config_failed;
+
+    tuple = &cfg_mem->tuple;
+    parse = &cfg_mem->parse;
+    buf = cfg_mem->buf;
+	
+    tuple->Attributes = tuple->TupleOffset = 0;
+    tuple->TupleData = (cisdata_t *)buf;
+    tuple->TupleDataMax = 64;
 
-    tuple.DesiredTuple = CISTPL_CONFIG;
-    i = first_tuple(handle, &tuple, &parse);
+    tuple->DesiredTuple = CISTPL_CONFIG;
+    i = first_tuple(handle, tuple, parse);
     CS_EXIT_TEST(i, ParseTuple, config_failed);
-    link->conf.ConfigBase = parse.config.base;
-    link->conf.Present = parse.config.rmask[0];
+    link->conf.ConfigBase = parse->config.base;
+    link->conf.Present = parse->config.rmask[0];
 
-    tuple.DesiredTuple = CISTPL_MANFID;
-    tuple.Attributes = TUPLE_RETURN_COMMON;
-    if (first_tuple(handle, &tuple, &parse) == CS_SUCCESS) {
-	smc->manfid = parse.manfid.manf;
-	smc->cardid = parse.manfid.card;
+    tuple->DesiredTuple = CISTPL_MANFID;
+    tuple->Attributes = TUPLE_RETURN_COMMON;
+    if (first_tuple(handle, tuple, parse) == CS_SUCCESS) {
+	smc->manfid = parse->manfid.manf;
+	smc->cardid = parse->manfid.card;
     }
 
     /* Configure card */
@@ -1046,7 +1136,7 @@ static void smc91c92_config(dev_link_t *
     	    printk(KERN_NOTICE "  No MII transceivers found!\n");
 	}
     }
-
+    kfree(cfg_mem);
     return;
 
 config_undo:
@@ -1054,6 +1144,7 @@ config_undo:
 config_failed:			/* CS_EXIT_TEST() calls jump to here... */
     smc91c92_release(link);
     link->state &= ~DEV_CONFIG_PENDING;
+    kfree(cfg_mem);
 
 } /* smc91c92_config */
