Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVCHLDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVCHLDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVCHLCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:02:48 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:26859 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261971AbVCHLAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:00:18 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:57:26 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dvb list <linux-dvb@linuxtv.org>
Subject: [patch] dvb: add pll lib
Message-ID: <20050308105726.GA30986@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This adds some helper code to handle tuning for dvb cards,
with a struct describing the pll and a function calculating
the command sequence needed to program it.

This one was discussed + accepted on the linuxtv list and
also is in the linuxtv cvs.  As the the cx88 driver update
I want finally get out of the door depends on this one I'll
go submit it myself instead of waiting for the dvb guys doing
it.

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/dvb/frontends/Makefile  |    1 
 drivers/media/dvb/frontends/dvb-pll.c |  168 ++++++++++++++++++++++++++
 drivers/media/dvb/frontends/dvb-pll.h |   34 +++++
 3 files changed, 203 insertions(+)

Index: linux-2.6.11-rc4/drivers/media/dvb/frontends/Makefile
===================================================================
--- linux-2.6.11-rc4.orig/drivers/media/dvb/frontends/Makefile	2005-02-14 15:21:59.000000000 +0100
+++ linux-2.6.11-rc4/drivers/media/dvb/frontends/Makefile	2005-02-15 12:31:40.000000000 +0100
@@ -4,6 +4,7 @@
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
 
+obj-$(CONFIG_DVB_CORE) += dvb-pll.o
 obj-$(CONFIG_DVB_STV0299) += stv0299.o
 obj-$(CONFIG_DVB_SP8870) += sp8870.o
 obj-$(CONFIG_DVB_CX22700) += cx22700.o
Index: linux-2.6.11-rc4/drivers/media/dvb/frontends/dvb-pll.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc4/drivers/media/dvb/frontends/dvb-pll.c	2005-02-15 12:31:51.000000000 +0100
@@ -0,0 +1,168 @@
+/*
+ * $Id: dvb-pll.c,v 1.7 2005/02/10 11:52:02 kraxel Exp $
+ *
+ * descriptions + helper functions for simple dvb plls.
+ *
+ * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/dvb/frontend.h>
+#include <asm/types.h>
+
+#include "dvb-pll.h"
+
+/* ----------------------------------------------------------- */
+/* descriptions                                                */
+
+struct dvb_pll_desc dvb_pll_thomson_dtt7579 = {
+	.name  = "Thomson dtt7579",
+	.min   = 177000000,
+	.max   = 858000000,
+	.count = 5,
+	.entries = {
+		{          0, 36166667, 166666, 0xb4, 0x03 }, /* go sleep */
+		{  443250000, 36166667, 166666, 0xb4, 0x02 },
+		{  542000000, 36166667, 166666, 0xb4, 0x08 },
+		{  771000000, 36166667, 166666, 0xbc, 0x08 },
+		{  999999999, 36166667, 166666, 0xf4, 0x08 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_thomson_dtt7579);
+
+struct dvb_pll_desc dvb_pll_thomson_dtt7610 = {
+	.name  = "Thomson dtt7610",
+	.min   =  44000000,
+	.max   = 958000000,
+	.count = 3,
+	.entries = {
+		{ 157250000, 44000000, 62500, 0x8e, 0x39 },
+		{ 454000000, 44000000, 62500, 0x8e, 0x3a },
+		{ 999999999, 44000000, 62500, 0x8e, 0x3c },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_thomson_dtt7610);
+
+static void thomson_dtt759x_bw(u8 *buf, int bandwidth)
+{
+	if (BANDWIDTH_7_MHZ == bandwidth)
+		buf[3] |= 0x10;
+}
+
+struct dvb_pll_desc dvb_pll_thomson_dtt759x = {
+	.name  = "Thomson dtt759x",
+	.min   = 177000000,
+	.max   = 896000000,
+	.setbw = thomson_dtt759x_bw,
+	.count = 6,
+	.entries = {
+		{          0, 36166667, 166666, 0x84, 0x03 },
+		{  264000000, 36166667, 166666, 0xb4, 0x02 },
+		{  470000000, 36166667, 166666, 0xbc, 0x02 },
+		{  735000000, 36166667, 166666, 0xbc, 0x08 },
+		{  835000000, 36166667, 166666, 0xf4, 0x08 },
+		{  999999999, 36166667, 166666, 0xfc, 0x08 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_thomson_dtt759x);
+
+struct dvb_pll_desc dvb_pll_lg_z201 = {
+	.name  = "LG z201",
+	.min   = 174000000,
+	.max   = 862000000,
+	.count = 5,
+	.entries = {
+		{          0, 36166667, 166666, 0xbc, 0x03 },
+		{  443250000, 36166667, 166666, 0xbc, 0x01 },
+		{  542000000, 36166667, 166666, 0xbc, 0x02 },
+		{  830000000, 36166667, 166666, 0xf4, 0x02 },
+		{  999999999, 36166667, 166666, 0xfc, 0x02 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_lg_z201);
+
+struct dvb_pll_desc dvb_pll_unknown_1 = {
+	.name  = "unknown 1", /* used by dntv live dvb-t */
+	.min   = 174000000,
+	.max   = 862000000,
+	.count = 9,
+	.entries = {
+		{  150000000, 36166667, 166666, 0xb4, 0x01 },
+		{  173000000, 36166667, 166666, 0xbc, 0x01 },
+		{  250000000, 36166667, 166666, 0xb4, 0x02 },
+		{  400000000, 36166667, 166666, 0xbc, 0x02 },
+		{  420000000, 36166667, 166666, 0xf4, 0x02 },
+		{  470000000, 36166667, 166666, 0xfc, 0x02 },
+		{  600000000, 36166667, 166666, 0xbc, 0x08 },
+		{  730000000, 36166667, 166666, 0xf4, 0x08 },
+		{  999999999, 36166667, 166666, 0xfc, 0x08 },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_unknown_1);
+
+/* ----------------------------------------------------------- */
+/* code                                                        */
+
+static int debug = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "enable verbose debug messages");
+
+int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
+		      u32 freq, int bandwidth)
+{
+	u32 div;
+	int i;
+
+	if (freq != 0 && (freq < desc->min || freq > desc->max))
+	    return -EINVAL;
+
+	for (i = 0; i < desc->count; i++) {
+		if (freq > desc->entries[i].limit)
+			continue;
+		break;
+	}
+	if (debug)
+		printk("pll: %s: freq=%d bw=%d | i=%d/%d\n",
+		       desc->name, freq, bandwidth, i, desc->count);
+	BUG_ON(i == desc->count);
+
+	div = (freq + desc->entries[i].offset) / desc->entries[i].stepsize;
+	buf[0] = div >> 8;
+	buf[1] = div & 0xff;
+	buf[2] = desc->entries[i].cb1;
+	buf[3] = desc->entries[i].cb2;
+
+	if (desc->setbw)
+		desc->setbw(buf, bandwidth);
+
+	if (debug)
+		printk("pll: %s: div=%d | buf=0x%02x,0x%02x,0x%02x,0x%02x\n",
+		       desc->name, div, buf[0], buf[1], buf[2], buf[3]);
+
+	return 0;
+}
+EXPORT_SYMBOL(dvb_pll_configure);
+
+MODULE_DESCRIPTION("dvb pll library");
+MODULE_AUTHOR("Gerd Knorr");
+MODULE_LICENSE("GPL");
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2.6.11-rc4/drivers/media/dvb/frontends/dvb-pll.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11-rc4/drivers/media/dvb/frontends/dvb-pll.h	2005-02-15 12:31:51.000000000 +0100
@@ -0,0 +1,34 @@
+/*
+ * $Id: dvb-pll.h,v 1.2 2005/02/10 11:43:41 kraxel Exp $
+ */
+
+struct dvb_pll_desc {
+	char *name;
+	u32  min;
+	u32  max;
+	void (*setbw)(u8 *buf, int bandwidth);
+	int  count;
+	struct {
+		u32 limit;
+		u32 offset;
+		u32 stepsize;
+		u8  cb1;
+		u8  cb2;
+	} entries[];
+};
+
+extern struct dvb_pll_desc dvb_pll_thomson_dtt7579;
+extern struct dvb_pll_desc dvb_pll_thomson_dtt759x;
+extern struct dvb_pll_desc dvb_pll_thomson_dtt7610;
+extern struct dvb_pll_desc dvb_pll_lg_z201;
+extern struct dvb_pll_desc dvb_pll_unknown_1;
+
+int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
+		      u32 freq, int bandwidth);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * compile-command: "make DVB=1"
+ * End:
+ */

-- 
#define printk(args...) fprintf(stderr, ## args)
