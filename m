Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVJYMdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVJYMdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 08:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVJYMdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 08:33:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932138AbVJYMdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 08:33:22 -0400
Subject: Re: 2.6.14-rc5-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Badari Pulavarty <pbadari@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051025095441.GA5329@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <1130168434.6831.1.camel@localhost.localdomain>
	 <20051024154342.GA24527@stusta.de>
	 <1130174497.12873.30.camel@localhost.localdomain>
	 <20051025095441.GA5329@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Oct 2005 14:00:15 +0100
Message-Id: <1130245216.25191.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-25 at 11:54 +0200, Adrian Bunk wrote:
> The other ones I know about on i386 are:
>   drivers/char/stallion.c
>   drivers/char/istallion.c
>   drivers/char/riscom8.c
>   drivers/char/rio/riointr.c

Looking at the code I doubt they worked anyway given the cli() use and
the like but the patch is attached for them.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.14-rc4-mm1/drivers/char/stallion.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/char/stallion.c	2005-10-25 13:22:06.843730000 +0100
@@ -2902,7 +2902,8 @@
 	if (portp->tty != (struct tty_struct *) NULL) {
 		if (portp->tty->driver_data == portp) {
 			portp->stats.ttystate = portp->tty->flags;
-			portp->stats.rxbuffered = portp->tty->flip.count;
+			/* No longer available as a statistic */
+			portp->stats.rxbuffered = 1; /*portp->tty->flip.count; */
 			if (portp->tty->termios != (struct termios *) NULL) {
 				portp->stats.cflags = portp->tty->termios->c_cflag;
 				portp->stats.iflags = portp->tty->termios->c_iflag;
@@ -4046,9 +4047,7 @@
 	if ((ioack & ACK_TYPMASK) == ACK_TYPRXGOOD) {
 		outb((RDCR + portp->uartaddr), ioaddr);
 		len = inb(ioaddr + EREG_DATA);
-		if ((tty == (struct tty_struct *) NULL) ||
-		    (tty->flip.char_buf_ptr == (char *) NULL) ||
-		    ((buflen = TTY_FLIPBUF_SIZE - tty->flip.count) == 0)) {
+		if (tty == NULL || (buflen = tty_buffer_request_room(tty, len)) == 0) {
 			len = MIN(len, sizeof(stl_unwanted));
 			outb((RDSR + portp->uartaddr), ioaddr);
 			insb((ioaddr + EREG_DATA), &stl_unwanted[0], len);
@@ -4057,12 +4056,10 @@
 		} else {
 			len = MIN(len, buflen);
 			if (len > 0) {
+				unsigned char *ptr;
 				outb((RDSR + portp->uartaddr), ioaddr);
-				insb((ioaddr + EREG_DATA), tty->flip.char_buf_ptr, len);
-				memset(tty->flip.flag_buf_ptr, 0, len);
-				tty->flip.flag_buf_ptr += len;
-				tty->flip.char_buf_ptr += len;
-				tty->flip.count += len;
+				tty_prepare_flip_string(tty, &ptr, len);
+				insb((ioaddr + EREG_DATA), ptr, len);
 				tty_schedule_flip(tty);
 				portp->stats.rxtotal += len;
 			}
@@ -4086,8 +4083,7 @@
 				portp->stats.txxoff++;
 			goto stl_rxalldone;
 		}
-		if ((tty != (struct tty_struct *) NULL) &&
-		    ((portp->rxignoremsk & status) == 0)) {
+		if (tty != NULL && (portp->rxignoremsk & status) == 0) {
 			if (portp->rxmarkmsk & status) {
 				if (status & ST_BREAK) {
 					status = TTY_BREAK;
@@ -4107,14 +4103,8 @@
 			} else {
 				status = 0;
 			}
-			if (tty->flip.char_buf_ptr != (char *) NULL) {
-				if (tty->flip.count < TTY_FLIPBUF_SIZE) {
-					*tty->flip.flag_buf_ptr++ = status;
-					*tty->flip.char_buf_ptr++ = ch;
-					tty->flip.count++;
-				}
-				tty_schedule_flip(tty);
-			}
+			tty_insert_flip_char(tty, ch, status);
+			tty_schedule_flip(tty);
 		}
 	} else {
 		printk("STALLION: bad RX interrupt ack value=%x\n", ioack);
@@ -5013,9 +5003,7 @@
 	len = inb(ioaddr + XP_DATA) + 1;
 
 	if ((iack & IVR_TYPEMASK) == IVR_RXDATA) {
-		if ((tty == (struct tty_struct *) NULL) ||
-		    (tty->flip.char_buf_ptr == (char *) NULL) ||
-		    ((buflen = TTY_FLIPBUF_SIZE - tty->flip.count) == 0)) {
+		if (tty == NULL || (buflen = tty_buffer_request_room(tty, len)) == 0) {
 			len = MIN(len, sizeof(stl_unwanted));
 			outb(GRXFIFO, (ioaddr + XP_ADDR));
 			insb((ioaddr + XP_DATA), &stl_unwanted[0], len);
@@ -5024,12 +5012,10 @@
 		} else {
 			len = MIN(len, buflen);
 			if (len > 0) {
+				unsigned char *ptr;
 				outb(GRXFIFO, (ioaddr + XP_ADDR));
-				insb((ioaddr + XP_DATA), tty->flip.char_buf_ptr, len);
-				memset(tty->flip.flag_buf_ptr, 0, len);
-				tty->flip.flag_buf_ptr += len;
-				tty->flip.char_buf_ptr += len;
-				tty->flip.count += len;
+				tty_prepare_flip_string(tty, &ptr, len);
+				insb((ioaddr + XP_DATA), ptr, len);
 				tty_schedule_flip(tty);
 				portp->stats.rxtotal += len;
 			}
@@ -5097,14 +5083,8 @@
 			status = 0;
 		}
 
-		if (tty->flip.char_buf_ptr != (char *) NULL) {
-			if (tty->flip.count < TTY_FLIPBUF_SIZE) {
-				*tty->flip.flag_buf_ptr++ = status;
-				*tty->flip.char_buf_ptr++ = ch;
-				tty->flip.count++;
-			}
-			tty_schedule_flip(tty);
-		}
+		tty_insert_flip_char(tty, ch, status);
+		tty_schedule_flip(tty);
 
 		if (status == 0)
 			portp->stats.rxtotal++;
--- linux.vanilla-2.6.14-rc4-mm1/drivers/char/istallion.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/char/istallion.c	2005-10-25 13:22:06.858728000 +0100
@@ -2714,17 +2714,13 @@
 		stlen = size - tail;
 	}
 
-	len = MIN(len, (TTY_FLIPBUF_SIZE - tty->flip.count));
+	len = tty_buffer_request_room(tty, len);
+	/* FIXME : iomap ? */
 	shbuf = (volatile char *) EBRDGETMEMPTR(brdp, portp->rxoffset);
 
 	while (len > 0) {
 		stlen = MIN(len, stlen);
-		memcpy(tty->flip.char_buf_ptr, (char *) (shbuf + tail), stlen);
-		memset(tty->flip.flag_buf_ptr, 0, stlen);
-		tty->flip.char_buf_ptr += stlen;
-		tty->flip.flag_buf_ptr += stlen;
-		tty->flip.count += stlen;
-
+		tty_insert_flip_string(tty, (char *)(shbuf + tail), stlen);
 		len -= stlen;
 		tail += stlen;
 		if (tail >= size) {
@@ -2909,16 +2905,12 @@
 
 		if ((nt.data & DT_RXBREAK) && (portp->rxmarkmsk & BRKINT)) {
 			if (tty != (struct tty_struct *) NULL) {
-				if (tty->flip.count < TTY_FLIPBUF_SIZE) {
-					tty->flip.count++;
-					*tty->flip.flag_buf_ptr++ = TTY_BREAK;
-					*tty->flip.char_buf_ptr++ = 0;
-					if (portp->flags & ASYNC_SAK) {
-						do_SAK(tty);
-						EBRDENABLE(brdp);
-					}
-					tty_schedule_flip(tty);
+				tty_insert_flip_char(tty, 0, TTY_BREAK);
+				if (portp->flags & ASYNC_SAK) {
+					do_SAK(tty);
+					EBRDENABLE(brdp);
 				}
+				tty_schedule_flip(tty);
 			}
 		}
 
@@ -4943,7 +4935,7 @@
 	if (portp->tty != (struct tty_struct *) NULL) {
 		if (portp->tty->driver_data == portp) {
 			stli_comstats.ttystate = portp->tty->flags;
-			stli_comstats.rxbuffered = portp->tty->flip.count;
+			stli_comstats.rxbuffered = -1 /*portp->tty->flip.count*/; 
 			if (portp->tty->termios != (struct termios *) NULL) {
 				stli_comstats.cflags = portp->tty->termios->c_cflag;
 				stli_comstats.iflags = portp->tty->termios->c_iflag;
--- linux.vanilla-2.6.14-rc4-mm1/drivers/char/riscom8.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/char/riscom8.c	2005-10-25 13:22:06.865726000 +0100
@@ -399,7 +399,7 @@
 		flag = TTY_NORMAL;
 	
 	tty_insert_flip_char(tty, ch, flag);
-	schedule_delayed_work(&tty->flip.work, 1);
+	tty_flip_buffer_push(tty);
 }
 
 static inline void rc_receive(struct riscom_board const * bp)
@@ -428,7 +428,7 @@
 		}
 		tty_insert_flip_char(tty, rc_in(bp, CD180_RDR), TTY_NORMAL);
 	}
-	schedule_delayed_work(&tty->flip.work, 1);
+	tty_flip_buffer_push(tty);
 }
 
 static inline void rc_transmit(struct riscom_board const * bp)
--- linux.vanilla-2.6.14-rc4-mm1/drivers/char/rio/riointr.c	2005-10-20 16:09:44.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/char/rio/riointr.c	2005-10-25 13:22:06.871726000 +0100
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
@@ -560,6 +561,7 @@
   struct PKT *PacketP;
   register uint	DataCnt;
   uchar *	ptr;
+  unsigned char *buf;
   int copied =0;
 
   static int intCount, RxIntCnt;
@@ -657,8 +659,7 @@
 	  ** and available space.
 	  */
 			
-	  transCount = min_t(unsigned int, PacketP->len & PKT_LEN_MASK,
-			   TTY_FLIPBUF_SIZE - TtyP->flip.count);
+	  transCount = tty_buffer_request_room(TtyP, PacketP->len & PKT_LEN_MASK);
 	  rio_dprintk (RIO_DEBUG_REC,  "port %d: Copy %d bytes\n", 
 				      PortP->PortNum, transCount);
 	  /*
@@ -678,9 +679,8 @@
 #endif
 	  ptr = (uchar *) PacketP->data + PortP->RxDataStart;
 
-	  rio_memcpy_fromio (TtyP->flip.char_buf_ptr, ptr, transCount);
-	  memset(TtyP->flip.flag_buf_ptr, TTY_NORMAL, transCount);
-
+	  tty_prepare_flip_string(TtyP, &buf, transCount);
+	  rio_memcpy_fromio (buf, ptr, transCount);
 #ifdef STATS
 	  /*
 	  ** keep a count for statistical purposes
@@ -690,9 +690,6 @@
 	  PortP->RxDataStart	+= transCount;
 	  PacketP->len		-= transCount;
 	  copied += transCount;
-	  TtyP->flip.count += transCount;
-	  TtyP->flip.char_buf_ptr += transCount;
-	  TtyP->flip.flag_buf_ptr += transCount;
 
 
 #ifdef ___DEBUG_IT___

