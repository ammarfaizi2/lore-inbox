Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUGEPDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUGEPDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUGEPDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:03:45 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5629 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266131AbUGEO7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:59:42 -0400
Date: Mon, 5 Jul 2004 17:00:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: ctc driver changes.
Message-ID: <20040705150008.GD3756@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: ctc driver changes.

From: Peter Tiedemann <ptiedem@de.ibm.com>

ctc driver changes:
 - Make use of the debug feature to ease debugging.
 - ctctty: use dev_alloc_name to allocate a network device name.
 - ctctty: avoid deadlock of ctc_tty_close vs ctc_tty_flush_buffer.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/Makefile  |    2 
 drivers/s390/net/ctcdbug.c |   83 ++++++++++++++++++++++++++++++
 drivers/s390/net/ctcdbug.h |  123 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/net/ctcmain.c |   73 +++++++++++++++++++++++---
 drivers/s390/net/ctctty.c  |   59 +++++++++++++++++----
 5 files changed, 319 insertions(+), 21 deletions(-)

diff -urN linux-2.6/drivers/s390/net/Makefile linux-2.6-s390/drivers/s390/net/Makefile
--- linux-2.6/drivers/s390/net/Makefile	Wed Jun 16 07:19:13 2004
+++ linux-2.6-s390/drivers/s390/net/Makefile	Mon Jul  5 16:12:50 2004
@@ -2,7 +2,7 @@
 # S/390 network devices
 #
 
-ctc-objs := ctcmain.o ctctty.o
+ctc-objs := ctcmain.o ctctty.o ctcdbug.o
 
 obj-$(CONFIG_IUCV) += iucv.o
 obj-$(CONFIG_NETIUCV) += netiucv.o fsm.o
diff -urN linux-2.6/drivers/s390/net/ctcdbug.c linux-2.6-s390/drivers/s390/net/ctcdbug.c
--- linux-2.6/drivers/s390/net/ctcdbug.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.c	Mon Jul  5 16:12:50 2004
@@ -0,0 +1,83 @@
+/*
+ *
+ * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.1 $)
+ *
+ * Linux on zSeries OSA Express and HiperSockets support
+ *
+ * Copyright 2000,2003 IBM Corporation
+ *
+ *    Author(s): Original Code written by
+ *			  Peter Tiedemann (ptiedem@de.ibm.com)
+ *
+ *    $Revision: 1.1 $	 $Date: 2004/07/02 16:31:22 $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "ctcdbug.h"
+
+/**
+ * Debug Facility Stuff
+ */
+debug_info_t *dbf_setup = NULL;
+debug_info_t *dbf_data = NULL;
+debug_info_t *dbf_trace = NULL;
+
+DEFINE_PER_CPU(char[256], dbf_txt_buf);
+
+void
+unregister_dbf_views(void)
+{
+	if (dbf_setup)
+		debug_unregister(dbf_setup);
+	if (dbf_data)
+		debug_unregister(dbf_data);
+	if (dbf_trace)
+		debug_unregister(dbf_trace);
+}
+int
+register_dbf_views(void)
+{
+	dbf_setup = debug_register(CTC_DBF_SETUP_NAME,
+					CTC_DBF_SETUP_INDEX,
+					CTC_DBF_SETUP_NR_AREAS,
+					CTC_DBF_SETUP_LEN);
+	dbf_data = debug_register(CTC_DBF_DATA_NAME,
+				       CTC_DBF_DATA_INDEX,
+				       CTC_DBF_DATA_NR_AREAS,
+				       CTC_DBF_DATA_LEN);
+	dbf_trace = debug_register(CTC_DBF_TRACE_NAME,
+					CTC_DBF_TRACE_INDEX,
+					CTC_DBF_TRACE_NR_AREAS,
+					CTC_DBF_TRACE_LEN);
+
+	if ((dbf_setup == NULL) || (dbf_data == NULL) ||
+	    (dbf_trace == NULL)) {
+		unregister_dbf_views();
+		return -ENOMEM;
+	}
+	debug_register_view(dbf_setup, &debug_hex_ascii_view);
+	debug_set_level(dbf_setup, CTC_DBF_SETUP_LEVEL);
+
+	debug_register_view(dbf_data, &debug_hex_ascii_view);
+	debug_set_level(dbf_data, CTC_DBF_DATA_LEVEL);
+
+	debug_register_view(dbf_trace, &debug_hex_ascii_view);
+	debug_set_level(dbf_trace, CTC_DBF_TRACE_LEVEL);
+
+	return 0;
+}
+
+
diff -urN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-s390/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.h	Mon Jul  5 16:12:50 2004
@@ -0,0 +1,123 @@
+/*
+ *
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.1 $)
+ *
+ * Linux on zSeries OSA Express and HiperSockets support
+ *
+ * Copyright 2000,2003 IBM Corporation
+ *
+ *    Author(s): Original Code written by
+ *			  Peter Tiedemann (ptiedem@de.ibm.com)
+ *
+ *    $Revision: 1.1 $	 $Date: 2004/07/02 16:31:22 $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+
+#include <asm/debug.h>
+/**
+ * Debug Facility stuff
+ */
+#define CTC_DBF_SETUP_NAME "ctc_setup"
+#define CTC_DBF_SETUP_LEN 16
+#define CTC_DBF_SETUP_INDEX 3
+#define CTC_DBF_SETUP_NR_AREAS 1
+#define CTC_DBF_SETUP_LEVEL 3
+
+#define CTC_DBF_DATA_NAME "ctc_data"
+#define CTC_DBF_DATA_LEN 128
+#define CTC_DBF_DATA_INDEX 3
+#define CTC_DBF_DATA_NR_AREAS 1
+#define CTC_DBF_DATA_LEVEL 2
+
+#define CTC_DBF_TRACE_NAME "ctc_trace"
+#define CTC_DBF_TRACE_LEN 16
+#define CTC_DBF_TRACE_INDEX 2
+#define CTC_DBF_TRACE_NR_AREAS 2
+#define CTC_DBF_TRACE_LEVEL 3
+
+#define DBF_TEXT(name,level,text) \
+	do { \
+		debug_text_event(dbf_##name,level,text); \
+	} while (0)
+
+#define DBF_HEX(name,level,addr,len) \
+	do { \
+		debug_event(dbf_##name,level,(void*)(addr),len); \
+	} while (0)
+
+extern DEFINE_PER_CPU(char[256], dbf_txt_buf);
+extern debug_info_t *dbf_setup;
+extern debug_info_t *dbf_data;
+extern debug_info_t *dbf_trace;
+
+
+#define DBF_TEXT_(name,level,text...)				\
+	do {								\
+		char* dbf_txt_buf = get_cpu_var(dbf_txt_buf);	\
+		sprintf(dbf_txt_buf, text);			  	\
+		debug_text_event(dbf_##name,level,dbf_txt_buf);	\
+		put_cpu_var(dbf_txt_buf);				\
+	} while (0)
+
+#define DBF_SPRINTF(name,level,text...) \
+	do { \
+		debug_sprintf_event(dbf_trace, level, ##text ); \
+		debug_sprintf_event(dbf_trace, level, text ); \
+	} while (0)
+
+
+int register_dbf_views(void);
+
+void unregister_dbf_views(void);
+
+/**
+ * some more debug stuff
+ */
+
+#define HEXDUMP16(importance,header,ptr) \
+PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x  " \
+		   "%02x %02x %02x %02x  %02x %02x %02x %02x\n", \
+		   *(((char*)ptr)),*(((char*)ptr)+1),*(((char*)ptr)+2), \
+		   *(((char*)ptr)+3),*(((char*)ptr)+4),*(((char*)ptr)+5), \
+		   *(((char*)ptr)+6),*(((char*)ptr)+7),*(((char*)ptr)+8), \
+		   *(((char*)ptr)+9),*(((char*)ptr)+10),*(((char*)ptr)+11), \
+		   *(((char*)ptr)+12),*(((char*)ptr)+13), \
+		   *(((char*)ptr)+14),*(((char*)ptr)+15)); \
+PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x  " \
+		   "%02x %02x %02x %02x  %02x %02x %02x %02x\n", \
+		   *(((char*)ptr)+16),*(((char*)ptr)+17), \
+		   *(((char*)ptr)+18),*(((char*)ptr)+19), \
+		   *(((char*)ptr)+20),*(((char*)ptr)+21), \
+		   *(((char*)ptr)+22),*(((char*)ptr)+23), \
+		   *(((char*)ptr)+24),*(((char*)ptr)+25), \
+		   *(((char*)ptr)+26),*(((char*)ptr)+27), \
+		   *(((char*)ptr)+28),*(((char*)ptr)+29), \
+		   *(((char*)ptr)+30),*(((char*)ptr)+31));
+
+static inline void
+hex_dump(unsigned char *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (i && !(i % 16))
+			printk("\n");
+		printk("%02x ", *(buf + i));
+	}
+	printk("\n");
+}
+
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Mon Jul  5 16:12:27 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Mon Jul  5 16:12:50 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.60 2004/06/18 15:13:51 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.61 2004/07/02 16:31:22 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.60 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.61 $
  *
  */
 
@@ -73,6 +73,7 @@
 #include "ctctty.h"
 #include "fsm.h"
 #include "cu3088.h"
+#include "ctcdbug.h"
 
 MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
 MODULE_DESCRIPTION("Linux for S/390 CTC/Escon Driver");
@@ -319,7 +320,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.60 $";
+	char vbuf[] = "$Revision: 1.61 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -616,8 +617,9 @@
 {
 	struct net_device *dev = ch->netdev;
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
-
 	__u16 len = *((__u16 *) pskb->data);
+
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	skb_put(pskb, 2 + LL_HEADER_LENGTH);
 	skb_pull(pskb, 2);
 	pskb->dev = dev;
@@ -759,6 +761,7 @@
 static void inline
 ccw_check_return_code(struct channel *ch, int return_code, char *msg)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	switch (return_code) {
 		case 0:
 			fsm_event(ch->fsm, CH_EVENT_IO_SUCCESS, ch);
@@ -793,6 +796,7 @@
 static void inline
 ccw_unit_check(struct channel *ch, unsigned char sense)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (sense & SNS0_INTERVENTION_REQ) {
 		if (sense & 0x01) {
 			if (ch->protocol != CTC_PROTO_LINUX_TTY)
@@ -838,6 +842,8 @@
 {
 	struct sk_buff *skb;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
+
 	while ((skb = skb_dequeue(q))) {
 		atomic_dec(&skb->users);
 		dev_kfree_skb_irq(skb);
@@ -847,6 +853,7 @@
 static __inline__ int
 ctc_checkalloc_buffer(struct channel *ch, int warn)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((ch->trans_skb == NULL) ||
 	    (ch->flags & CHANNEL_FLAGS_BUFSIZE_CHANGED)) {
 		if (ch->trans_skb != NULL)
@@ -913,9 +920,12 @@
 	struct sk_buff *skb;
 	int first = 1;
 	int i;
-
+	unsigned long duration;
 	struct timespec done_stamp = xtime;
-	unsigned long duration =
+
+	DBF_TEXT(trace, 2, __FUNCTION__);
+
+	duration =
 	    (done_stamp.tv_sec - ch->prof.send_stamp.tv_sec) * 1000000 +
 	    (done_stamp.tv_nsec - ch->prof.send_stamp.tv_nsec) / 1000;
 	if (duration > ch->prof.tx_time)
@@ -996,6 +1006,7 @@
 {
 	struct channel *ch = (struct channel *) arg;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_TXIDLE);
 	fsm_event(((struct ctc_priv *) ch->netdev->priv)->fsm, DEV_EVENT_TXUP,
@@ -1022,6 +1033,7 @@
 	int check_len;
 	int rc;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (len < 8) {
 		ctc_pr_debug("%s: got packet with length %d < 8\n",
@@ -1092,6 +1104,8 @@
 	struct channel *ch = (struct channel *) arg;
 	int rc;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
+
 	if (fsm_getstate(fi) == CH_STATE_TXIDLE)
 		ctc_pr_debug("%s: remote side issued READ?, init ...\n", ch->id);
 	fsm_deltimer(&ch->timer);
@@ -1166,6 +1180,7 @@
 	__u16 buflen;
 	int rc;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	buflen = *((__u16 *) ch->trans_skb->data);
 #ifdef DEBUG
@@ -1205,6 +1220,7 @@
 	int rc;
 	unsigned long saveflags;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	fsm_newstate(fi, CH_STATE_SETUPWAIT);
@@ -1236,6 +1252,7 @@
 	int rc;
 	struct net_device *dev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (ch == NULL) {
 		ctc_pr_warn("ch_action_start ch=NULL\n");
 		return;
@@ -1315,6 +1332,7 @@
 	int rc;
 	int oldstate;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	if (event == CH_EVENT_STOP)
@@ -1347,6 +1365,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_STOPPED);
 	if (ch->trans_skb != NULL) {
@@ -1398,6 +1417,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_NOTOP);
 	if (CHANNEL_DIRECTION(ch->flags) == READ) {
@@ -1428,6 +1448,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	/**
 	 * Special case: Got UC_RCRESET on setmode.
 	 * This means that remote side isn't setup. In this case
@@ -1480,6 +1501,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	ctc_pr_debug("%s: %s channel restart\n", dev->name,
 		     (CHANNEL_DIRECTION(ch->flags) == READ) ? "RX" : "TX");
@@ -1514,6 +1536,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	if (event == CH_EVENT_TIMER) {
 		fsm_deltimer(&ch->timer);
 		ctc_pr_debug("%s: Timeout during RX init handshake\n", dev->name);
@@ -1542,6 +1565,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	fsm_newstate(fi, CH_STATE_RXERR);
 	ctc_pr_warn("%s: RX initialization failed\n", dev->name);
 	ctc_pr_warn("%s: RX <-> RX connection detected\n", dev->name);
@@ -1562,6 +1586,7 @@
 	struct channel *ch2;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	ctc_pr_debug("%s: Got remote disconnect, re-initializing ...\n",
 		     dev->name);
@@ -1593,6 +1618,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	if (event == CH_EVENT_TIMER) {
 		fsm_deltimer(&ch->timer);
 		ctc_pr_debug("%s: Timeout during TX init handshake\n", dev->name);
@@ -1621,6 +1647,7 @@
 	struct net_device *dev = ch->netdev;
 	unsigned long saveflags;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (ch->retry++ > 3) {
 		ctc_pr_debug("%s: TX retry failed, restarting channel\n",
@@ -1678,6 +1705,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (CHANNEL_DIRECTION(ch->flags) == READ) {
 		ctc_pr_debug("%s: RX I/O error\n", dev->name);
@@ -1699,6 +1727,7 @@
  	struct net_device *dev = ch->netdev;
  	struct ctc_priv *privptr = dev->priv;
  
+	DBF_TEXT(trace, 2, __FUNCTION__);
  	ch_action_iofatal(fi, event, arg);
  	fsm_addtimer(&privptr->restart_timer, 1000, DEV_EVENT_RESTART, dev);
 }
@@ -1849,6 +1878,7 @@
 	struct channel **c = &channels;
 	struct channel *ch;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((ch =
 	     (struct channel *) kmalloc(sizeof (struct channel),
 					GFP_KERNEL)) == NULL) {
@@ -1954,6 +1984,7 @@
 {
 	struct channel **c = &channels;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (ch == NULL)
 		return;
 
@@ -1990,6 +2021,7 @@
 {
 	struct channel *ch = channels;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 #ifdef DEBUG
 	ctc_pr_debug("ctc: %s(): searching for ch with id %s and type %d\n",
 		     __func__, id, type);
@@ -2085,6 +2117,7 @@
 	struct net_device *dev;
 	struct ctc_priv *priv;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (__ctc_check_irb_error(cdev, irb))
 		return;
 
@@ -2178,6 +2211,7 @@
 	struct ctc_priv *privptr = dev->priv;
 	int direction;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	fsm_deltimer(&privptr->restart_timer);
 	fsm_newstate(fi, DEV_STATE_STARTWAIT_RXTX);
 	for (direction = READ; direction <= WRITE; direction++) {
@@ -2200,6 +2234,7 @@
 	struct ctc_priv *privptr = dev->priv;
 	int direction;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	fsm_newstate(fi, DEV_STATE_STOPWAIT_RXTX);
 	for (direction = READ; direction <= WRITE; direction++) {
 		struct channel *ch = privptr->channel[direction];
@@ -2212,6 +2247,7 @@
 	struct net_device *dev = (struct net_device *)arg;
 	struct ctc_priv *privptr = dev->priv;
 	
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	ctc_pr_debug("%s: Restarting\n", dev->name);
 	dev_action_stop(fi, event, arg);
 	fsm_event(privptr->fsm, DEV_EVENT_STOP, dev);
@@ -2233,6 +2269,7 @@
 	struct net_device *dev = (struct net_device *) arg;
 	struct ctc_priv *privptr = dev->priv;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_STARTWAIT_RXTX:
 			if (event == DEV_EVENT_RXUP)
@@ -2285,6 +2322,7 @@
 	struct net_device *dev = (struct net_device *) arg;
 	struct ctc_priv *privptr = dev->priv;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
 			if (privptr->protocol == CTC_PROTO_LINUX_TTY)
@@ -2386,6 +2424,7 @@
 	struct ll_header header;
 	int rc = 0;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (fsm_getstate(ch->fsm) != CH_STATE_TXIDLE) {
 		int l = skb->len + LL_HEADER_LENGTH;
 
@@ -2558,6 +2597,7 @@
 	int rc = 0;
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	/**
 	 * Some sanity checks ...
 	 */
@@ -2615,6 +2655,7 @@
 {
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((new_mtu < 576) || (new_mtu > 65527) ||
 	    (new_mtu > (privptr->channel[READ]->max_bufsize -
 			LL_HEADER_LENGTH - 2)))
@@ -2659,6 +2700,7 @@
 	struct net_device *ndev;
 	int bs1;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -2703,6 +2745,7 @@
 	struct ctc_priv *priv;
 	int ll1;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -2720,6 +2763,7 @@
 	char *sbuf;
 	char *p;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!priv)
 		return;
 	sbuf = (char *)kmalloc(2048, GFP_KERNEL);
@@ -2849,6 +2893,7 @@
 	if (!privptr)
 		return NULL;
 
+	DBF_TEXT(setup, 2, __FUNCTION__);
 	if (alloc_device) {
 		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
 		if (!dev)
@@ -2900,6 +2945,7 @@
 	struct ctc_priv *priv;
 	int value;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	priv = dev->driver_data;
@@ -2971,6 +3017,7 @@
 	int rc;
 
 	pr_debug("%s() called\n", __FUNCTION__);
+	DBF_TEXT(trace, 2, __FUNCTION__);
 
 	if (!get_device(&cgdev->dev))
 		return -ENODEV;
@@ -3017,6 +3064,7 @@
 	int ret;
 
 	pr_debug("%s() called\n", __FUNCTION__);
+	DBF_TEXT(setup, 2, __FUNCTION__);
 
 	privptr = cgdev->dev.driver_data;
 	if (!privptr)
@@ -3110,7 +3158,7 @@
 	struct ctc_priv *priv;
 	struct net_device *ndev;
 		
-
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	priv = cgdev->dev.driver_data;
@@ -3161,6 +3209,7 @@
 	struct ctc_priv *priv;
 
 	pr_debug("%s() called\n", __FUNCTION__);
+	DBF_TEXT(trace, 2, __FUNCTION__);
 
 	priv = cgdev->dev.driver_data;
 	if (!priv)
@@ -3199,6 +3248,7 @@
 {
 	unregister_cu3088_discipline(&ctc_group_driver);
 	ctc_tty_cleanup();
+	unregister_dbf_views();
 	ctc_pr_info("CTC driver unloaded\n");
 }
 
@@ -3215,10 +3265,17 @@
 
 	print_banner();
 
+	ret = register_dbf_views();
+	if (ret){
+		ctc_pr_crit("ctc_init failed with register_dbf_views rc = %d\n", ret);
+		return ret;
+	}
 	ctc_tty_init();
 	ret = register_cu3088_discipline(&ctc_group_driver);
-	if (ret) 
+	if (ret) {
 		ctc_tty_cleanup();
+		unregister_dbf_views();
+	}
 	return ret;
 }
 
diff -urN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-s390/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	Wed Jun 16 07:19:35 2004
+++ linux-2.6-s390/drivers/s390/net/ctctty.c	Mon Jul  5 16:12:50 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.17 2004/03/31 17:06:34 ptiedem Exp $
+ * $Id: ctctty.c,v 1.21 2004/07/02 16:31:22 ptiedem Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -30,6 +30,7 @@
 #include <asm/uaccess.h>
 #include <linux/devfs_fs_kernel.h>
 #include "ctctty.h"
+#include "ctcdbug.h"
 
 #define CTC_TTY_MAJOR       43
 #define CTC_TTY_MAX_DEVICES 64
@@ -103,6 +104,7 @@
 	int len;
 	struct tty_struct *tty;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
 			c = TTY_FLIPBUF_SIZE - tty->flip.count;
@@ -132,6 +134,7 @@
 	int ret = 1;
 	struct tty_struct *tty;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
 			int c = TTY_FLIPBUF_SIZE - tty->flip.count;
@@ -165,6 +168,7 @@
 {
 	int i;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((!driver) || ctc_tty_shuttingdown)
 		return;
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
@@ -185,6 +189,7 @@
 	int i;
 	ctc_tty_info *info = NULL;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!skb)
 		return;
 	if ((!skb->dev) || (!driver) || ctc_tty_shuttingdown) {
@@ -249,6 +254,7 @@
 	int wake = 1;
 	int rc;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!info->netdev) {
 		if (skb)
 			kfree_skb(skb);
@@ -341,6 +347,7 @@
 	int skb_res;
 	struct sk_buff *skb;
 	
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		return;
 	skb_res = info->netdev->hard_header_len + sizeof(info->mcr) +
@@ -361,6 +368,7 @@
 static void
 ctc_tty_transmit_status(ctc_tty_info *info)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
@@ -374,6 +382,7 @@
 	unsigned int quot;
 	int i;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!info->tty || !info->tty->termios)
 		return;
 	cflag = info->tty->termios->c_cflag;
@@ -412,6 +421,7 @@
 static int
 ctc_tty_startup(ctc_tty_info * info)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (info->flags & CTC_ASYNC_INITIALIZED)
 		return 0;
 #ifdef CTC_DEBUG_MODEM_OPEN
@@ -454,6 +464,7 @@
 static void
 ctc_tty_shutdown(ctc_tty_info * info)
 {
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!(info->flags & CTC_ASYNC_INITIALIZED))
 		return;
 #ifdef CTC_DEBUG_MODEM_OPEN
@@ -486,14 +497,17 @@
 	int total = 0;
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
-		return 0;
+		goto ex;
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_write"))
-		return 0;
+		goto ex;
 	if (!tty)
-		return 0;
-	if (!info->netdev)
-		return -ENODEV;
+		goto ex;
+	if (!info->netdev) {
+		total = -ENODEV;
+		goto ex;
+	}
 	if (from_user)
 		down(&info->write_sem);
 	while (1) {
@@ -530,6 +544,8 @@
 	}
 	if (from_user)
 		up(&info->write_sem);
+ex:
+	DBF_TEXT(trace, 6, __FUNCTION__);
 	return total;
 }
 
@@ -559,13 +575,14 @@
 	ctc_tty_info *info;
 	unsigned long flags;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if (!tty)
-		return;
+		goto ex;
 	spin_lock_irqsave(&ctc_tty_lock, flags);
 	info = (ctc_tty_info *) tty->driver_data;
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_flush_buffer")) {
 		spin_unlock_irqrestore(&ctc_tty_lock, flags);
-		return;
+		goto ex;
 	}
 	skb_queue_purge(&info->tx_queue);
 	info->lsr |= UART_LSR_TEMT;
@@ -574,6 +591,9 @@
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
 	    tty->ldisc.write_wakeup)
 		(tty->ldisc.write_wakeup) (tty);
+ex:
+	DBF_TEXT_(trace, 2, "ex: %s ", __FUNCTION__);
+	return;
 }
 
 static void
@@ -783,7 +803,6 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 	unsigned int cflag = tty->termios->c_cflag;
-
 	ctc_tty_change_speed(info);
 
 	/* Handle transition to B0 */
@@ -1032,8 +1051,10 @@
 		}
 	}
 	ctc_tty_shutdown(info);
-	if (tty->driver->flush_buffer)
-		tty->driver->flush_buffer(tty);
+	if (tty->driver->flush_buffer) {
+		skb_queue_purge(&info->tx_queue);
+		info->lsr |= UART_LSR_TEMT;
+	}
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 	info->tty = 0;
@@ -1059,7 +1080,6 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *)tty->driver_data;
 	unsigned long saveflags;
-
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_hangup"))
 		return;
 	ctc_tty_shutdown(info);
@@ -1185,6 +1205,21 @@
 		       "with NULL dev or NULL dev-name\n");
 		return -1;
 	}
+
+	/*
+	 *	If the name is a format string the caller wants us to
+	 *	do a name allocation : format string must end with %d
+	 */
+	if (strchr(dev->name, '%'))
+	{
+		int err = dev_alloc_name(dev, dev->name);	// dev->name is changed by this
+		if (err < 0) {
+			printk(KERN_DEBUG "dev_alloc returned error %d\n", err);
+			return err;
+		}
+
+	}
+
 	for (p = dev->name; p && ((*p < '0') || (*p > '9')); p++);
 	ttynum = simple_strtoul(p, &err, 0);
 	if ((ttynum < 0) || (ttynum >= CTC_TTY_MAX_DEVICES) ||
