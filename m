Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVIITXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVIITXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVIITXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:23:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30653 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030299AbVIITXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:23:04 -0400
Date: Fri, 9 Sep 2005 20:23:03 +0100
From: viro@ZenIV.linux.org.uk
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] epca iomem annotations + several missing readw()
Message-ID: <20050909192303.GV9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* iomem pointers marked as such
	* several direct dereferencings of such pointers replaced with
read[bw]().
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/char/epca.c current/drivers/char/epca.c
--- RC13-git8-base/drivers/char/epca.c	2005-09-08 10:17:39.000000000 -0400
+++ current/drivers/char/epca.c	2005-09-08 23:53:33.000000000 -0400
@@ -534,7 +534,7 @@
 
 	unsigned long flags;
 	struct tty_struct *tty;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 
 	if (!(ch->asyncflags & ASYNC_INITIALIZED)) 
 		return;
@@ -618,7 +618,7 @@
 	struct channel *ch;
 	unsigned long flags;
 	int remain;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 
 	/* ----------------------------------------------------------------
 		pc_write is primarily called directly by the kernel routine
@@ -685,7 +685,7 @@
 		------------------------------------------------------------------- */
 
 		dataLen = min(bytesAvailable, dataLen);
-		memcpy(ch->txptr + head, buf, dataLen);
+		memcpy_toio(ch->txptr + head, buf, dataLen);
 		buf += dataLen;
 		head += dataLen;
 		amountCopied += dataLen;
@@ -726,7 +726,7 @@
 	struct channel *ch;
 	unsigned long flags;
 	unsigned int head, tail;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 
 	remain = 0;
 
@@ -773,7 +773,7 @@
 	int remain;
 	unsigned long flags;
 	struct channel *ch;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 
 	/* ---------------------------------------------------------
 		verifyChannel returns the channel from the tty struct
@@ -830,7 +830,7 @@
 	unsigned int tail;
 	unsigned long flags;
 	struct channel *ch;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	/* ---------------------------------------------------------
 		verifyChannel returns the channel from the tty struct
 		if it is valid.  This serves as a sanity check.
@@ -976,7 +976,7 @@
 	struct channel *ch;
 	unsigned long flags;
 	int line, retval, boardnum;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	unsigned int head;
 
 	line = tty->index;
@@ -1041,7 +1041,7 @@
 	ch->statusflags = 0;
 
 	/* Save boards current modem status */
-	ch->imodem = bc->mstat;
+	ch->imodem = readb(&bc->mstat);
 
 	/* ----------------------------------------------------------------
 	   Set receive head and tail ptrs to each other.  This indicates
@@ -1399,10 +1399,10 @@
 { /* Begin post_fep_init */
 
 	int i;
-	unsigned char *memaddr;
-	struct global_data *gd;
+	unsigned char __iomem *memaddr;
+	struct global_data __iomem *gd;
 	struct board_info *bd;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	struct channel *ch; 
 	int shrinkmem = 0, lowwater ; 
  
@@ -1461,7 +1461,7 @@
 		8 and 64 of these structures.
 	-------------------------------------------------------------------- */
 
-	bc = (struct board_chan *)(memaddr + CHANSTRUCT);
+	bc = (struct board_chan __iomem *)(memaddr + CHANSTRUCT);
 
 	/* -------------------------------------------------------------------
 		The below assignment will set gd to point at the BEGINING of
@@ -1470,7 +1470,7 @@
 		pointer begins at 0xd10.
 	---------------------------------------------------------------------- */
 
-	gd = (struct global_data *)(memaddr + GLOBAL);
+	gd = (struct global_data __iomem *)(memaddr + GLOBAL);
 
 	/* --------------------------------------------------------------------
 		XEPORTS (address 0xc22) points at the number of channels the
@@ -1493,6 +1493,7 @@
 
 	for (i = 0; i < bd->numports; i++, ch++, bc++)  { /* Begin for each port */
 		unsigned long flags;
+		u16 tseg, rseg;
 
 		ch->brdchan        = bc;
 		ch->mailbox        = gd; 
@@ -1553,50 +1554,53 @@
 			shrinkmem = 0;
 		}
 
+		tseg = readw(&bc->tseg);
+		rseg = readw(&bc->rseg);
+
 		switch (bd->type) {
 
 			case PCIXEM:
 			case PCIXRJ:
 			case PCIXR:
 				/* Cover all the 2MEG cards */
-				ch->txptr = memaddr + (((bc->tseg) << 4) & 0x1fffff);
-				ch->rxptr = memaddr + (((bc->rseg) << 4) & 0x1fffff);
-				ch->txwin = FEPWIN | ((bc->tseg) >> 11);
-				ch->rxwin = FEPWIN | ((bc->rseg) >> 11);
+				ch->txptr = memaddr + ((tseg << 4) & 0x1fffff);
+				ch->rxptr = memaddr + ((rseg << 4) & 0x1fffff);
+				ch->txwin = FEPWIN | (tseg >> 11);
+				ch->rxwin = FEPWIN | (rseg >> 11);
 				break;
 
 			case PCXEM:
 			case EISAXEM:
 				/* Cover all the 32K windowed cards */
 				/* Mask equal to window size - 1 */
-				ch->txptr = memaddr + (((bc->tseg) << 4) & 0x7fff);
-				ch->rxptr = memaddr + (((bc->rseg) << 4) & 0x7fff);
-				ch->txwin = FEPWIN | ((bc->tseg) >> 11);
-				ch->rxwin = FEPWIN | ((bc->rseg) >> 11);
+				ch->txptr = memaddr + ((tseg << 4) & 0x7fff);
+				ch->rxptr = memaddr + ((rseg << 4) & 0x7fff);
+				ch->txwin = FEPWIN | (tseg >> 11);
+				ch->rxwin = FEPWIN | (rseg >> 11);
 				break;
 
 			case PCXEVE:
 			case PCXE:
-				ch->txptr = memaddr + (((bc->tseg - bd->memory_seg) << 4) & 0x1fff);
-				ch->txwin = FEPWIN | ((bc->tseg - bd->memory_seg) >> 9);
-				ch->rxptr = memaddr + (((bc->rseg - bd->memory_seg) << 4) & 0x1fff);
-				ch->rxwin = FEPWIN | ((bc->rseg - bd->memory_seg) >>9 );
+				ch->txptr = memaddr + (((tseg - bd->memory_seg) << 4) & 0x1fff);
+				ch->txwin = FEPWIN | ((tseg - bd->memory_seg) >> 9);
+				ch->rxptr = memaddr + (((rseg - bd->memory_seg) << 4) & 0x1fff);
+				ch->rxwin = FEPWIN | ((rseg - bd->memory_seg) >>9 );
 				break;
 
 			case PCXI:
 			case PC64XE:
-				ch->txptr = memaddr + ((bc->tseg - bd->memory_seg) << 4);
-				ch->rxptr = memaddr + ((bc->rseg - bd->memory_seg) << 4);
+				ch->txptr = memaddr + ((tseg - bd->memory_seg) << 4);
+				ch->rxptr = memaddr + ((rseg - bd->memory_seg) << 4);
 				ch->txwin = ch->rxwin = 0;
 				break;
 
 		} /* End switch bd->type */
 
 		ch->txbufhead = 0;
-		ch->txbufsize = bc->tmax + 1;
+		ch->txbufsize = readw(&bc->tmax) + 1;
 	
 		ch->rxbufhead = 0;
-		ch->rxbufsize = bc->rmax + 1;
+		ch->rxbufsize = readw(&bc->rmax) + 1;
 	
 		lowwater = ch->txbufsize >= 2000 ? 1024 : (ch->txbufsize / 2);
 
@@ -1718,11 +1722,11 @@
 static void doevent(int crd)
 { /* Begin doevent */
 
-	void *eventbuf;
+	void __iomem *eventbuf;
 	struct channel *ch, *chan0;
 	static struct tty_struct *tty;
 	struct board_info *bd;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	unsigned int tail, head;
 	int event, channel;
 	int mstat, lstat;
@@ -1817,7 +1821,7 @@
 static void fepcmd(struct channel *ch, int cmd, int word_or_byte,
                    int byte2, int ncmds, int bytecmd)
 { /* Begin fepcmd */
-	unchar *memaddr;
+	unchar __iomem *memaddr;
 	unsigned int head, cmdTail, cmdStart, cmdMax;
 	long count;
 	int n;
@@ -2000,7 +2004,7 @@
 
 	unsigned int cmdHead;
 	struct termios *ts;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	unsigned mval, hflow, cflag, iflag;
 
 	bc = ch->brdchan;
@@ -2010,7 +2014,7 @@
 	ts = tty->termios;
 	if ((ts->c_cflag & CBAUD) == 0)  { /* Begin CBAUD detected */
 		cmdHead = readw(&bc->rin);
-		bc->rout = cmdHead;
+		writew(cmdHead, &bc->rout);
 		cmdHead = readw(&bc->tin);
 		/* Changing baud in mid-stream transmission can be wonderful */
 		/* ---------------------------------------------------------------
@@ -2116,7 +2120,7 @@
 	unchar *rptr;
 	struct termios *ts = NULL;
 	struct tty_struct *tty;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	int dataToRead, wrapgap, bytesAvailable;
 	unsigned int tail, head;
 	unsigned int wrapmask;
@@ -2154,7 +2158,7 @@
 	--------------------------------------------------------------------- */
 
 	if (!tty || !ts || !(ts->c_cflag & CREAD))  {
-		bc->rout = head;
+		writew(head, &bc->rout);
 		return;
 	}
 
@@ -2270,7 +2274,7 @@
 static int pc_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	struct channel *ch = (struct channel *) tty->driver_data;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	unsigned int mstat, mflag = 0;
 	unsigned long flags;
 
@@ -2351,7 +2355,7 @@
 	unsigned long flags;
 	unsigned int mflag, mstat;
 	unsigned char startc, stopc;
-	struct board_chan *bc;
+	struct board_chan __iomem *bc;
 	struct channel *ch = (struct channel *) tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	
@@ -2633,7 +2637,7 @@
 		spin_lock_irqsave(&epca_lock, flags);
 		/* Just in case output was resumed because of a change in Digi-flow */
 		if (ch->statusflags & TXSTOPPED)  { /* Begin transmit resume requested */
-			struct board_chan *bc;
+			struct board_chan __iomem *bc;
 			globalwinon(ch);
 			bc = ch->brdchan;
 			if (ch->statusflags & LOWWAIT)
@@ -2727,7 +2731,7 @@
 static void setup_empty_event(struct tty_struct *tty, struct channel *ch)
 { /* Begin setup_empty_event */
 
-	struct board_chan *bc = ch->brdchan;
+	struct board_chan __iomem *bc = ch->brdchan;
 
 	globalwinon(ch);
 	ch->statusflags |= EMPTYWAIT;
diff -urN RC13-git8-base/drivers/char/epca.h current/drivers/char/epca.h
--- RC13-git8-base/drivers/char/epca.h	2005-09-08 10:17:39.000000000 -0400
+++ current/drivers/char/epca.h	2005-09-08 23:53:33.000000000 -0400
@@ -128,17 +128,17 @@
 	unsigned long  c_cflag;
 	unsigned long  c_lflag;
 	unsigned long  c_oflag;
-	unsigned char *txptr;
-	unsigned char *rxptr;
+	unsigned char __iomem *txptr;
+	unsigned char __iomem *rxptr;
 	unsigned char *tmp_buf;
 	struct board_info           *board;
-	struct board_chan	    *brdchan;
+	struct board_chan	    __iomem *brdchan;
 	struct digi_struct          digiext;
 	struct tty_struct           *tty;
 	wait_queue_head_t           open_wait;
 	wait_queue_head_t           close_wait;
 	struct work_struct          tqueue;
-	struct global_data 	    *mailbox;
+	struct global_data 	    __iomem *mailbox;
 };
 
 struct board_info	
@@ -150,7 +150,7 @@
 	unsigned long port;
 	unsigned long membase;
 	unsigned char __iomem *re_map_port;
-	unsigned char *re_map_membase;
+	unsigned char __iomem *re_map_membase;
 	unsigned long  memory_seg;
 	void ( * memwinon )	(struct board_info *, unsigned int) ;
 	void ( * memwinoff ) 	(struct board_info *, unsigned int) ;
