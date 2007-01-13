Return-Path: <linux-kernel-owner+w=401wt.eu-S1422675AbXAMOGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbXAMOGU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 09:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbXAMOGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 09:06:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3715 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422675AbXAMOGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 09:06:19 -0500
Date: Sat, 13 Jan 2007 15:06:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/sc/: proper prototypes
Message-ID: <20070113140623.GM7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes in a header file for global code under 
drivers/isdn/sc/.

Since the GNU C compiler is now able do tell us that caller and callee 
disagreed about the number of arguments of setup_buffers(), this patch 
also fixes this bug.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Jan 2007

 drivers/isdn/sc/card.h      |   30 ++++++++++++++++++++++++++++++
 drivers/isdn/sc/command.c   |   17 ++---------------
 drivers/isdn/sc/event.c     |    3 ---
 drivers/isdn/sc/init.c      |    6 ------
 drivers/isdn/sc/interrupt.c |   10 ----------
 drivers/isdn/sc/ioctl.c     |   10 ----------
 drivers/isdn/sc/message.c   |   10 ----------
 drivers/isdn/sc/packet.c    |   10 ----------
 drivers/isdn/sc/scioc.h     |    6 ++++++
 drivers/isdn/sc/shmem.c     |    6 ------
 drivers/isdn/sc/timer.c     |    8 --------
 11 files changed, 38 insertions(+), 78 deletions(-)

--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/card.h.old	2007-01-03 22:10:02.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/card.h	2007-01-03 22:42:13.000000000 +0100
@@ -26,7 +26,9 @@
 #include <linux/timer.h>
 #include <linux/time.h>
 #include <linux/isdnif.h>
+#include <linux/irqreturn.h>
 #include "message.h"
+#include "scioc.h"
 
 /*
  * Amount of time to wait for a reset to complete
@@ -98,4 +100,32 @@
 	spinlock_t lock;		/* local lock */
 } board;
 
+
+extern board *sc_adapter[];
+extern int cinst;
+
+void memcpy_toshmem(int card, void *dest, const void *src, size_t n);
+void memcpy_fromshmem(int card, void *dest, const void *src, size_t n);
+int get_card_from_id(int driver);
+int indicate_status(int card, int event, ulong Channel, char *Data);
+irqreturn_t interrupt_handler(int interrupt, void *cardptr);
+int sndpkt(int devId, int channel, struct sk_buff *data);
+void rcvpkt(int card, RspMessage *rcvmsg);
+int command(isdn_ctrl *cmd);
+int reset(int card);
+int startproc(int card);
+int send_and_receive(int card, unsigned int procid, unsigned char type,
+		     unsigned char class, unsigned char code,
+		     unsigned char link, unsigned char data_len, 
+		     unsigned char *data,  RspMessage *mesgdata, int timeout);
+void flushreadfifo (int card);
+int sendmessage(int card, unsigned int procid, unsigned int type,
+		unsigned int class, unsigned int code, unsigned int link, 
+		unsigned int data_len, unsigned int *data);
+int receivemessage(int card, RspMessage *rspmsg);
+int sc_ioctl(int card, scs_ioctl *data);
+int setup_buffers(int card, int c);
+void check_reset(unsigned long data);
+void check_phystat(unsigned long data);
+
 #endif /* CARD_H */
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/scioc.h.old	2007-01-03 22:44:10.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/scioc.h	2007-01-03 22:44:52.000000000 +0100
@@ -1,3 +1,6 @@
+#ifndef __ISDN_SC_SCIOC_H__
+#define __ISDN_SC_SCIOC_H__
+
 /*
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
@@ -103,3 +106,6 @@
 		POTInfo potsinfo;
 	} info;
 } boardInfo;
+
+#endif  /*  __ISDN_SC_SCIOC_H__  */
+
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/packet.c.old	2007-01-03 22:10:42.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/packet.c	2007-01-03 22:31:00.000000000 +0100
@@ -20,16 +20,6 @@
 #include "message.h"
 #include "card.h"
 
-extern board *sc_adapter[];
-extern unsigned int cinst;
-
-extern int get_card_from_id(int);
-extern int indicate_status(int, int,ulong, char*);
-extern void memcpy_toshmem(int, void *, const void *, size_t);
-extern void memcpy_fromshmem(int, void *, const void *, size_t);
-extern int sendmessage(int, unsigned int, unsigned int, unsigned int,
-                unsigned int, unsigned int, unsigned int, unsigned int *);
-
 int sndpkt(int devId, int channel, struct sk_buff *data)
 {
 	LLData	ReqLnkWrite;
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/shmem.c.old	2007-01-03 22:12:09.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/shmem.c	2007-01-03 22:12:18.000000000 +0100
@@ -22,12 +22,6 @@
 #include "card.h"
 
 /*
- * Main adapter array
- */
-extern board *sc_adapter[];
-extern int cinst;
-
-/*
  *
  */
 void memcpy_toshmem(int card, void *dest, const void *src, size_t n)
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/command.c.old	2007-01-03 22:12:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/command.c	2007-01-03 22:50:27.000000000 +0100
@@ -31,19 +31,6 @@
 static int setl3(int card, unsigned long arg);
 static int acceptb(int card, unsigned long channel);
 
-extern int cinst;
-extern board *sc_adapter[];
-
-extern int sc_ioctl(int, scs_ioctl *);
-extern int setup_buffers(int, int, unsigned int);
-extern int indicate_status(int, int,ulong,char*);
-extern void check_reset(unsigned long);
-extern int send_and_receive(int, unsigned int, unsigned char, unsigned char,
-                unsigned char, unsigned char, unsigned char, unsigned char *,
-                RspMessage *, int);
-extern int sendmessage(int, unsigned int, unsigned int, unsigned int,
-                unsigned int, unsigned int, unsigned int, unsigned int *);
-
 #ifdef DEBUG
 /*
  * Translate command codes to strings
@@ -208,7 +195,7 @@
 		return -ENODEV;
 	}
 
-	if(setup_buffers(card, channel+1, BUFFER_SIZE)) {
+	if(setup_buffers(card, channel+1)) {
 		hangup(card, channel+1);
 		return -ENOBUFS;
 	}
@@ -297,7 +284,7 @@
 		return -ENODEV;
 	}
 
-	if(setup_buffers(card, channel+1, BUFFER_SIZE))
+	if(setup_buffers(card, channel+1))
 	{
 		hangup(card, channel+1);
 		return -ENOBUFS;
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/event.c.old	2007-01-03 22:12:49.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/event.c	2007-01-03 22:12:55.000000000 +0100
@@ -20,9 +20,6 @@
 #include "message.h"
 #include "card.h"
 
-extern int cinst;
-extern board *sc_adapter[];
-
 #ifdef DEBUG
 static char *events[] = { "ISDN_STAT_STAVAIL",
 			  "ISDN_STAT_ICALL",
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/interrupt.c.old	2007-01-03 22:13:11.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/interrupt.c	2007-01-03 22:34:36.000000000 +0100
@@ -21,16 +21,6 @@
 #include "card.h"
 #include <linux/interrupt.h>
 
-extern int indicate_status(int, int, ulong, char *);
-extern void check_phystat(unsigned long);
-extern int receivemessage(int, RspMessage *);
-extern int sendmessage(int, unsigned int, unsigned int, unsigned int,
-        unsigned int, unsigned int, unsigned int, unsigned int *);
-extern void rcvpkt(int, RspMessage *);
-
-extern int cinst;
-extern board *sc_adapter[];
-
 static int get_card_from_irq(int irq)
 {
 	int i;
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/ioctl.c.old	2007-01-03 22:13:26.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/ioctl.c	2007-01-03 22:25:25.000000000 +0100
@@ -12,16 +12,6 @@
 #include "card.h"
 #include "scioc.h"
 
-extern int indicate_status(int, int, unsigned long, char *);
-extern int startproc(int);
-extern int reset(int);
-extern int send_and_receive(int, unsigned int, unsigned char,unsigned char,
-		unsigned char,unsigned char, 
-		unsigned char, unsigned char *, RspMessage *, int);
-
-extern board *sc_adapter[];
-
-
 static int GetStatus(int card, boardInfo *);
 
 /*
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/message.c.old	2007-01-03 22:13:57.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/message.c	2007-01-03 22:19:53.000000000 +0100
@@ -22,16 +22,6 @@
 #include "message.h"
 #include "card.h"
 
-extern board *sc_adapter[];
-extern unsigned int cinst;
-
-/*
- * Obligatory function prototypes
- */
-extern int indicate_status(int,ulong,char*);
-extern int scm_command(isdn_ctrl *);
-
-
 /*
  * receive a message from the board
  */
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/timer.c.old	2007-01-03 22:14:14.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/timer.c	2007-01-03 22:28:23.000000000 +0100
@@ -20,14 +20,6 @@
 #include "message.h"
 #include "card.h"
 
-extern board *sc_adapter[];
-
-extern void flushreadfifo(int);
-extern int  startproc(int);
-extern int  indicate_status(int, int, unsigned long, char *);
-extern int  sendmessage(int, unsigned int, unsigned int, unsigned int,
-        unsigned int, unsigned int, unsigned int, unsigned int *);
-
 
 /*
  * Write the proper values into the I/O ports following a reset
--- linux-2.6.20-rc2-mm1/drivers/isdn/sc/init.c.old	2007-01-03 22:19:00.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/isdn/sc/init.c	2007-01-03 22:22:04.000000000 +0100
@@ -35,12 +35,6 @@
 module_param_array(ram, int, NULL, 0);
 module_param(do_reset, bool, 0);
 
-extern irqreturn_t interrupt_handler(int, void *);
-extern int sndpkt(int, int, int, struct sk_buff *);
-extern int command(isdn_ctrl *);
-extern int indicate_status(int, int, ulong, char*);
-extern int reset(int);
-
 static int identify_board(unsigned long, unsigned int);
 
 static int __init sc_init(void)

