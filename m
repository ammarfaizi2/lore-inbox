Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVBIDBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVBIDBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVBIDBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:01:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261769AbVBIC7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:59:01 -0500
Date: Wed, 9 Feb 2005 03:58:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/sc/: possible cleanups
Message-ID: <20050209025856.GE2978@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanips:
- make some needlessly global code static
- remove the compiled but completely unused debug.c
- remove or #if 0 the following unused global functions:
  - command.c: loopback
  - command.c: loadproc
  - init.c: irq_supported
  - packet.c: print_skb
  - shmem.c: memset_shmem
  - timer.c: trace_timer

Signed-off-by: Adrian Bunk <bunk@stusta.de>

 drivers/isdn/sc/Makefile    |    2 
 drivers/isdn/sc/command.c   |   88 ++++++------------------------------
 drivers/isdn/sc/debug.c     |   46 ------------------
 drivers/isdn/sc/init.c      |   21 +-------
 drivers/isdn/sc/interrupt.c |    2 
 drivers/isdn/sc/ioctl.c     |    5 --
 drivers/isdn/sc/packet.c    |   16 ------
 drivers/isdn/sc/shmem.c     |    2 
 drivers/isdn/sc/timer.c     |   18 -------
 9 files changed, 27 insertions(+), 173 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/command.c.old	2005-02-09 03:30:43.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/command.c	2005-02-09 03:34:19.000000000 +0100
@@ -22,14 +22,14 @@
 #include "card.h"
 #include "scioc.h"
 
-int dial(int card, unsigned long channel, setup_parm setup);
-int hangup(int card, unsigned long channel);
-int answer(int card, unsigned long channel);
-int clreaz(int card, unsigned long channel);
-int seteaz(int card, unsigned long channel, char *);
-int setl2(int card, unsigned long arg);
-int setl3(int card, unsigned long arg);
-int acceptb(int card, unsigned long channel);
+static int dial(int card, unsigned long channel, setup_parm setup);
+static int hangup(int card, unsigned long channel);
+static int answer(int card, unsigned long channel);
+static int clreaz(int card, unsigned long channel);
+static int seteaz(int card, unsigned long channel, char *);
+static int setl2(int card, unsigned long arg);
+static int setl3(int card, unsigned long arg);
+static int acceptb(int card, unsigned long channel);
 
 extern int cinst;
 extern board *sc_adapter[];
@@ -148,56 +148,6 @@
 }
 
 /*
- * Confirm our ability to communicate with the board.  This test assumes no
- * other message activity is present
- */
-int loopback(int card) 
-{
-
-	int status;
-	static char testmsg[] = "Test Message";
-	RspMessage rspmsg;
-
-	if(!IS_VALID_CARD(card)) {
-		pr_debug("Invalid param: %d is not a valid card id\n", card);
-		return -ENODEV;
-	}
-
-	pr_debug("%s: Sending loopback message\n",
-		sc_adapter[card]->devicename);
-
-	/*
-	 * Send the loopback message to confirm that memory transfer is
-	 * operational
-	 */
-	status = send_and_receive(card, CMPID, cmReqType1,
-				  cmReqClass0,
-				  cmReqMsgLpbk,
-				  0,
-				  (unsigned char) strlen(testmsg),
-				  (unsigned char *)testmsg,
-				  &rspmsg, SAR_TIMEOUT);
-
-
-	if (!status) {
-		pr_debug("%s: Loopback message successfully sent\n",
-			sc_adapter[card]->devicename);
-		if(strcmp(rspmsg.msg_data.byte_array, testmsg)) {
-			pr_debug("%s: Loopback return != sent\n",
-				sc_adapter[card]->devicename);
-			return -EIO;
-		}
-		return 0;
-	}
-	else {
-		pr_debug("%s: Send loopback message failed\n",
-			sc_adapter[card]->devicename);
-		return -EIO;
-	}
-
-}
-
-/*
  * start the onboard firmware
  */
 int startproc(int card) 
@@ -222,16 +172,10 @@
 }
 
 
-int loadproc(int card, char *data) 
-{
-	return -1;
-}
-
-
 /*
  * Dials the number passed in 
  */
-int dial(int card, unsigned long channel, setup_parm setup) 
+static int dial(int card, unsigned long channel, setup_parm setup) 
 {
 	int status;
 	char Phone[48];
@@ -261,7 +205,7 @@
 /*
  * Answer an incoming call 
  */
-int answer(int card, unsigned long channel) 
+static int answer(int card, unsigned long channel) 
 {
 	if(!IS_VALID_CARD(card)) {
 		pr_debug("Invalid param: %d is not a valid card id\n", card);
@@ -282,7 +226,7 @@
 /*
  * Hangup up the call on specified channel
  */
-int hangup(int card, unsigned long channel) 
+static int hangup(int card, unsigned long channel) 
 {
 	int status;
 
@@ -305,7 +249,7 @@
 /*
  * Set the layer 2 protocol (X.25, HDLC, Raw)
  */
-int setl2(int card, unsigned long arg) 
+static int setl2(int card, unsigned long arg) 
 {
 	int status =0;
 	int protocol,channel;
@@ -340,7 +284,7 @@
 /*
  * Set the layer 3 protocol
  */
-int setl3(int card, unsigned long channel) 
+static int setl3(int card, unsigned long channel) 
 {
 	int protocol = channel >> 8;
 
@@ -355,7 +299,7 @@
 	return 0;
 }
 
-int acceptb(int card, unsigned long channel)
+static int acceptb(int card, unsigned long channel)
 {
 	if(!IS_VALID_CARD(card)) {
 		pr_debug("Invalid param: %d is not a valid card id\n", card);
@@ -374,7 +318,7 @@
 	return 0;
 }
 
-int clreaz(int card, unsigned long arg)
+static int clreaz(int card, unsigned long arg)
 {
 	if(!IS_VALID_CARD(card)) {
 		pr_debug("Invalid param: %d is not a valid card id\n", card);
@@ -388,7 +332,7 @@
 	return 0;
 }
 
-int seteaz(int card, unsigned long arg, char *num)
+static int seteaz(int card, unsigned long arg, char *num)
 {
 	if(!IS_VALID_CARD(card)) {
 		pr_debug("Invalid param: %d is not a valid card id\n", card);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/ioctl.c.old	2005-02-09 03:32:19.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/ioctl.c	2005-02-09 03:32:47.000000000 +0100
@@ -14,7 +14,6 @@
 
 extern int indicate_status(int, int, unsigned long, char *);
 extern int startproc(int);
-extern int loadproc(int, char *record);
 extern int reset(int);
 extern int send_and_receive(int, unsigned int, unsigned char,unsigned char,
 		unsigned char,unsigned char, 
@@ -23,7 +22,7 @@
 extern board *sc_adapter[];
 
 
-int GetStatus(int card, boardInfo *);
+static int GetStatus(int card, boardInfo *);
 
 /*
  * Process private IOCTL messages (typically from scctrl)
@@ -428,7 +427,7 @@
 	return 0;
 }
 
-int GetStatus(int card, boardInfo *bi)
+static int GetStatus(int card, boardInfo *bi)
 {
 	RspMessage rcvmsg;
 	int i, status;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/Makefile.old	2005-02-09 03:35:21.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/Makefile	2005-02-09 03:35:31.000000000 +0100
@@ -6,5 +6,5 @@
 
 # Multipart objects.
 
-sc-y				:= shmem.o init.o debug.o packet.o command.o event.o \
+sc-y				:= shmem.o init.o packet.o command.o event.o \
 		   		   ioctl.o interrupt.o message.o timer.o	
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/init.c.old	2005-02-09 03:35:57.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/init.c	2005-02-09 03:42:17.000000000 +0100
@@ -20,9 +20,9 @@
 int cinst;
 
 static char devname[] = "scX";
-const char version[] = "2.0b1";
+static const char version[] = "2.0b1";
 
-const char *boardname[] = { "DataCommute/BRI", "DataCommute/PRI", "TeleCommute/BRI" };
+static const char *boardname[] = { "DataCommute/BRI", "DataCommute/PRI", "TeleCommute/BRI" };
 
 /* insmod set parameters */
 static unsigned int io[] = {0,0,0,0};
@@ -35,26 +35,13 @@
 module_param_array(ram, int, NULL, 0);
 module_param(do_reset, bool, 0);
 
-static int sup_irq[] = { 11, 10, 9, 5, 12, 14, 7, 3, 4, 6 };
-#define MAX_IRQS	10
-
 extern irqreturn_t interrupt_handler(int, void *, struct pt_regs *);
 extern int sndpkt(int, int, int, struct sk_buff *);
 extern int command(isdn_ctrl *);
 extern int indicate_status(int, int, ulong, char*);
 extern int reset(int);
 
-int identify_board(unsigned long, unsigned int);
-
-int irq_supported(int irq_x)
-{
-	int i;
-	for(i=0 ; i < MAX_IRQS ; i++) {
-		if(sup_irq[i] == irq_x)
-			return 1;
-	}
-	return 0;
-}
+static int identify_board(unsigned long, unsigned int);
 
 static int __init sc_init(void)
 {
@@ -454,7 +441,7 @@
 	pr_info("SpellCaster ISA ISDN Adapter Driver Unloaded.\n");
 }
 
-int identify_board(unsigned long rambase, unsigned int iobase) 
+static int identify_board(unsigned long rambase, unsigned int iobase) 
 {
 	unsigned int pgport;
 	unsigned long sig;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/interrupt.c.old	2005-02-09 03:37:09.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/interrupt.c	2005-02-09 03:37:18.000000000 +0100
@@ -31,7 +31,7 @@
 extern int cinst;
 extern board *sc_adapter[];
 
-int get_card_from_irq(int irq)
+static int get_card_from_irq(int irq)
 {
 	int i;
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/packet.c.old	2005-02-09 03:37:32.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/packet.c	2005-02-09 03:37:41.000000000 +0100
@@ -213,19 +213,3 @@
 	return 0;
 }
 
-int print_skb(int card,char *skb_p, int len){
-	int i,data;
-	pr_debug("%s: data at 0x%x len: 0x%x\n", sc_adapter[card]->devicename,
-			skb_p,len);
-	for(i=1;i<=len;i++,skb_p++){
-		data = (int) (0xff & (*skb_p));
-		pr_debug("%s: data =  0x%x", sc_adapter[card]->devicename,data);
-		if(!(i%4))
-			pr_debug(" ");
-		if(!(i%32))
-			pr_debug("\n");
-	}
-	pr_debug("\n");
-	return 0;
-}		
-
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/shmem.c.old	2005-02-09 03:38:00.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/shmem.c	2005-02-09 03:38:19.000000000 +0100
@@ -108,6 +108,7 @@
 		sc_adapter[card]->rambase + ((unsigned long) src %0x4000), (unsigned long) dest); */
 }
 
+#if 0
 void memset_shmem(int card, void *dest, int c, size_t n)
 {
 	unsigned long flags;
@@ -141,3 +142,4 @@
 		((sc_adapter[card]->shmem_magic + ch * SRAM_PAGESIZE)>>14)|0x80);
 	spin_unlock_irqrestore(&sc_adapter[card]->lock, flags);
 }
+#endif  /*  0  */
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/timer.c.old	2005-02-09 03:38:39.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/timer.c	2005-02-09 03:39:16.000000000 +0100
@@ -32,7 +32,7 @@
 /*
  * Write the proper values into the I/O ports following a reset
  */
-void setup_ports(int card)
+static void setup_ports(int card)
 {
 
 	outb((sc_adapter[card]->rambase >> 12), sc_adapter[card]->ioport[EXP_BASE]);
@@ -129,19 +129,3 @@
 		ceReqPhyStatus,0,0,NULL);
 }
 
-/*
- * When in trace mode, this callback is used to swap the working shared
- * RAM page to the trace page(s) and process all received messages. It
- * must be called often enough to get all of the messages out of RAM before
- * it loops around.
- * Trace messages are \n terminated strings.
- * We output the messages in 64 byte chunks through readstat. Each chunk
- * is scanned for a \n followed by a time stamp. If the timerstamp is older
- * than the current time, scanning stops and the page and offset are recorded
- * as the starting point the next time the trace timer is called. The final
- * step is to restore the working page and reset the timer.
- */
-void trace_timer(unsigned long data)
-{
-	/* not implemented */
-}
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/sc/debug.c	2004-12-24 22:34:57.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,46 +0,0 @@
-/* $Id: debug.c,v 1.5.6.1 2001/09/23 22:24:59 kai Exp $
- *
- * Copyright (C) 1996  SpellCaster Telecommunications Inc.
- *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
- * For more information, please contact gpl-info@spellcast.com or write:
- *
- *     SpellCaster Telecommunications Inc.
- *     5621 Finch Avenue East, Unit #3
- *     Scarborough, Ontario  Canada
- *     M1B 2T9
- *     +1 (416) 297-8565
- *     +1 (416) 297-6433 Facsimile
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-int dbg_level = 0;
-static char dbg_funcname[255];
-
-void dbg_endfunc(void)
-{
-	if (dbg_level) {
-		printk("<-- Leaving function %s\n", dbg_funcname);
-		strcpy(dbg_funcname, "");
-	}
-}
-
-void dbg_func(char *func)
-{
-	strcpy(dbg_funcname, func);
-	if(dbg_level)
-		printk("--> Entering function %s\n", dbg_funcname);
-}
-
-inline void pullphone(char *dn, char *str)
-{
-	int i = 0;
-
-	while(dn[i] != ',')
-		str[i] = dn[i], i++;
-	str[i] = 0x0;
-}

