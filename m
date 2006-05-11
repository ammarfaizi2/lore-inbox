Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWEKCKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWEKCKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWEKCKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:10:01 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:37060 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1751405AbWEKCKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:10:00 -0400
Message-ID: <44629D10.80803@maintech.de>
Date: Thu, 11 May 2006 04:10:24 +0200
From: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060508)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards
 if IO space is not available
Content-Type: multipart/mixed;
 boundary="------------010307030203070203020403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307030203070203020403
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



--------------010307030203070203020403
Content-Type: text/x-patch;
 name="ide_cd.mem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_cd.mem.patch"

diff -uprN l1/drivers/ide/legacy/ide-cs.c l2/drivers/ide/legacy/ide-cs.c
--- l1/drivers/ide/legacy/ide-cs.c	2006-05-11 00:19:59.000000000 +0200
+++ l2/drivers/ide/legacy/ide-cs.c	2006-05-11 03:38:03.000000000 +0200
@@ -263,6 +263,29 @@ static int ide_config(struct pcmcia_devi
 	    break;
 	}
 
+	if ((cfg->mem.nwin > 0) || (stk->dflt.mem.nwin > 0)) {
+	    win_req_t req;
+	    memreq_t map;
+
+	    cistpl_mem_t *mem = (cfg->mem.nwin) ? &cfg->mem : &stk->dflt.mem;
+	    req.Attributes = WIN_DATA_WIDTH_16|WIN_MEMORY_TYPE_CM;
+	    req.Attributes |= WIN_ENABLE;
+	    req.Base = mem->win[0].host_addr;
+	    req.Size = mem->win[0].len;
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
+
+	    break;
+	}
+
     next_entry:
 	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
 	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));

--------------010307030203070203020403--
