Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFCNCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFCNCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVFCNCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:02:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45029 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261251AbVFCNBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:01:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alan Cox <alan@redhat.com>
Subject: [PATCH] moxa: do not ignore input
Date: Fri, 3 Jun 2005 16:01:21 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
References: <200506021220.47138.vda@ilport.com.ua> <200506021554.07316.vda@ilport.com.ua> <20050602225805.GB9628@devserv.devel.redhat.com>
In-Reply-To: <20050602225805.GB9628@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hSFoChOrmgDeSum"
Message-Id: <200506031601.21180.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hSFoChOrmgDeSum
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Stop using tty internal structure in mxser_receive_chars(),
use tty_insert_flip_char(tty, ch flag); istead.

Without this change driver ignores any rx'ed chars.

Run tested, please apply.

Any suggestions on further cleanups this driver may need
while I have access to this hardware?
--
vda

--Boundary-00=_hSFoChOrmgDeSum
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mxser.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mxser.c.diff"

--- linux-2.6.12-rc2.src/drivers/char/mxser.c.orig	Fri Jun  3 15:48:04 2005
+++ linux-2.6.12-rc2.src/drivers/char/mxser.c	Fri Jun  3 15:45:05 2005
@@ -1995,9 +1995,6 @@ static void mxser_receive_chars(struct m
 	unsigned char ch, gdl;
 	int ignored = 0;
 	int cnt = 0;
-	unsigned char *cp;
-	char *fp;
-	int count;
 	int recv_room;
 	int max = 256;
 	unsigned long flags;
@@ -2011,10 +2008,6 @@ static void mxser_receive_chars(struct m
 		//return;
 	}
 
-	cp = tty->flip.char_buf;
-	fp = tty->flip.flag_buf;
-	count = 0;
-
 	// following add by Victor Yu. 09-02-2002
 	if (info->IsMoxaMustChipFlag != MOXA_OTHER_UART) {
 
@@ -2041,12 +2034,10 @@ static void mxser_receive_chars(struct m
 		}
 		while (gdl--) {
 			ch = inb(info->base + UART_RX);
-			count++;
-			*cp++ = ch;
-			*fp++ = 0;
+			tty_insert_flip_char(tty, ch, 0);
 			cnt++;
 			/*
-			   if((count>=HI_WATER) && (info->stop_rx==0)){
+			   if((cnt>=HI_WATER) && (info->stop_rx==0)){
 			   mxser_stoprx(tty);
 			   info->stop_rx=1;
 			   break;
@@ -2061,7 +2052,7 @@ intr_old:
 		if (max-- < 0)
 			break;
 		/*
-		   if((count>=HI_WATER) && (info->stop_rx==0)){
+		   if((cnt>=HI_WATER) && (info->stop_rx==0)){
 		   mxser_stoprx(tty);
 		   info->stop_rx=1;
 		   break;
@@ -2078,36 +2069,33 @@ intr_old:
 			if (++ignored > 100)
 				break;
 		} else {
-			count++;
+			char flag = 0;
 			if (*status & UART_LSR_SPECIAL) {
 				if (*status & UART_LSR_BI) {
-					*fp++ = TTY_BREAK;
+					flag = TTY_BREAK;
 /* added by casper 1/11/2000 */
 					info->icount.brk++;
-
 /* */
 					if (info->flags & ASYNC_SAK)
 						do_SAK(tty);
 				} else if (*status & UART_LSR_PE) {
-					*fp++ = TTY_PARITY;
+					flag = TTY_PARITY;
 /* added by casper 1/11/2000 */
 					info->icount.parity++;
 /* */
 				} else if (*status & UART_LSR_FE) {
-					*fp++ = TTY_FRAME;
+					flag = TTY_FRAME;
 /* added by casper 1/11/2000 */
 					info->icount.frame++;
 /* */
 				} else if (*status & UART_LSR_OE) {
-					*fp++ = TTY_OVERRUN;
+					flag = TTY_OVERRUN;
 /* added by casper 1/11/2000 */
 					info->icount.overrun++;
 /* */
-				} else
-					*fp++ = 0;
-			} else
-				*fp++ = 0;
-			*cp++ = ch;
+				}
+			}
+			tty_insert_flip_char(tty, ch, flag);
 			cnt++;
 			if (cnt >= recv_room) {
 				if (!info->ldisc_stop_rx) {
@@ -2132,13 +2120,13 @@ intr_old:
 		// above add by Victor Yu. 09-02-2002
 	} while (*status & UART_LSR_DR);
 
-      end_intr:		// add by Victor Yu. 09-02-2002
+end_intr:		// add by Victor Yu. 09-02-2002
 
 	mxvar_log.rxcnt[info->port] += cnt;
 	info->mon_data.rxcnt += cnt;
 	info->mon_data.up_rxcnt += cnt;
 	spin_unlock_irqrestore(&info->slock, flags);
-	
+
 	tty_flip_buffer_push(tty);
 }
 

--Boundary-00=_hSFoChOrmgDeSum--

