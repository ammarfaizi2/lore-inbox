Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTAICqy>; Wed, 8 Jan 2003 21:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAICqx>; Wed, 8 Jan 2003 21:46:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:10211 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261456AbTAICpL>;
	Wed, 8 Jan 2003 21:45:11 -0500
Date: Wed, 8 Jan 2003 18:53:51 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : SIR Wrapper partial rewrite
Message-ID: <20030109025351.GD19178@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_new_wrapper-3.diff :
------------------------
	o [FEATURE] Properly inline in wrapper Tx path
	o [FEATURE] Rewrite/simplify/optimise wrapper Rx path
		Lower CPU overhead *and* kernel image size
	o [FEATURE] Add ZeroCopy in wrapper Rx path for drivers that support it
		I'll update drivers later on...


diff -u -p linux/include/net/irda/wrapper.d7.h linux/include/net/irda/wrapper.h
--- linux/include/net/irda/wrapper.d7.h	Fri Nov  8 17:12:16 2002
+++ linux/include/net/irda/wrapper.h	Fri Nov 15 11:55:10 2002
@@ -52,8 +52,6 @@ enum {
 
 /* Proto definitions */
 int async_wrap_skb(struct sk_buff *skb, __u8 *tx_buff, int buffsize);
-void async_bump(struct net_device *dev, struct net_device_stats *stats,
-		__u8 *buf, int len);
 void async_unwrap_char(struct net_device *dev, struct net_device_stats *stats,
 		       iobuff_t *buf, __u8 byte);
 
diff -u -p linux/include/net/irda/irda_device.d7.h linux/include/net/irda/irda_device.h
--- linux/include/net/irda/irda_device.d7.h	Fri Nov 15 11:50:45 2002
+++ linux/include/net/irda/irda_device.h	Fri Nov 15 15:23:39 2002
@@ -173,12 +173,33 @@ typedef struct {
 
 	__u8 *head;	      /* start of buffer */
 	__u8 *data;	      /* start of data in buffer */
-	__u8 *tail;           /* end of data in buffer */
 
-	int len;	      /* length of data */
-	int truesize;	      /* total size of buffer */
+	int len;	      /* current length of data */
+	int truesize;	      /* total allocated size of buffer */
 	__u16 fcs;
+
+	struct sk_buff *skb;	/* ZeroCopy Rx in async_unwrap_char() */
 } iobuff_t;
+
+/* Maximum SIR frame (skb) that we expect to receive *unwrapped*.
+ * Max LAP MTU (I field) is 2048 bytes max (IrLAP 1.1, chapt 6.6.5, p40).
+ * Max LAP header is 2 bytes (for now).
+ * Max CRC is 2 bytes at SIR, 4 bytes at FIR. 
+ * Need 1 byte for skb_reserve() to align IP header for IrLAN.
+ * Add a few extra bytes just to be safe (buffer is power of two anyway)
+ * Jean II */
+#define IRDA_SKB_MAX_MTU	2064
+/* Maximum SIR frame that we expect to send, wrapped (i.e. with XBOFS
+ * and escaped characters on top of above). */
+#define IRDA_SIR_MAX_FRAME	4269
+
+/* The SIR unwrapper async_unwrap_char() will use a Rx-copy-break mechanism
+ * when using the optional ZeroCopy Rx, where only small frames are memcpy
+ * to a smaller skb to save memory. This is the thresold under which copy
+ * will happen (and over which it won't happen).
+ * Some FIR drivers may use this #define as well...
+ * This is the same value as various Ethernet drivers. - Jean II */
+#define IRDA_RX_COPY_THRESHOLD  256
 
 /* Function prototypes */
 int  irda_device_init(void);
diff -u -p linux/net/irda/irsyms.d7.c linux/net/irda/irsyms.c
--- linux/net/irda/irsyms.d7.c	Fri Nov  8 17:27:10 2002
+++ linux/net/irda/irsyms.c	Fri Nov  8 18:14:52 2002
@@ -165,6 +165,7 @@ EXPORT_SYMBOL(irda_task_delete);
 EXPORT_SYMBOL(async_wrap_skb);
 EXPORT_SYMBOL(async_unwrap_char);
 EXPORT_SYMBOL(irda_calc_crc16);
+EXPORT_SYMBOL(irda_crc16_table);
 EXPORT_SYMBOL(irda_start_timer);
 EXPORT_SYMBOL(setup_dma);
 EXPORT_SYMBOL(infrared_mode);
diff -u -p linux/net/irda/wrapper.d7.c linux/net/irda/wrapper.c
--- linux/net/irda/wrapper.d7.c	Fri Nov  8 14:23:15 2002
+++ linux/net/irda/wrapper.c	Fri Nov 15 17:24:50 2002
@@ -13,6 +13,7 @@
  *
  *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
+ *     Copyright (c) 2000-2002 Jean Tourrilhes <jt@hpl.hp.com>
  *
  *     This program is free software; you can redistribute it and/or
  *     modify it under the terms of the GNU General Public License as
@@ -37,29 +38,41 @@
 #include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 
-static inline int stuff_byte(__u8 byte, __u8 *buf);
-
-static void state_outside_frame(struct net_device *dev,
-				struct net_device_stats *stats,
-				iobuff_t *rx_buff, __u8 byte);
-static void state_begin_frame(struct net_device *dev,
-			      struct net_device_stats *stats,
-			      iobuff_t *rx_buff, __u8 byte);
-static void state_link_escape(struct net_device *dev,
-			      struct net_device_stats *stats,
-			      iobuff_t *rx_buff, __u8 byte);
-static void state_inside_frame(struct net_device *dev,
-			       struct net_device_stats *stats,
-			       iobuff_t *rx_buff, __u8 byte);
+/************************** FRAME WRAPPING **************************/
+/*
+ * Unwrap and unstuff SIR frames
+ *
+ * Note : at FIR and MIR, HDLC framing is used and usually handled
+ * by the controller, so we come here only for SIR... Jean II
+ */
 
-static void (*state[])(struct net_device *dev, struct net_device_stats *stats,
-		       iobuff_t *rx_buff, __u8 byte) =
+/*
+ * Function stuff_byte (byte, buf)
+ *
+ *    Byte stuff one single byte and put the result in buffer pointed to by
+ *    buf. The buffer must at all times be able to have two bytes inserted.
+ *
+ * This is in a tight loop, better inline it, so need to be prior to callers.
+ * (2000 bytes on P6 200MHz, non-inlined ~370us, inline ~170us) - Jean II
+ */
+static inline int stuff_byte(__u8 byte, __u8 *buf)
 {
-	state_outside_frame,
-	state_begin_frame,
-	state_link_escape,
-	state_inside_frame,
-};
+	switch (byte) {
+	case BOF: /* FALLTHROUGH */
+	case EOF: /* FALLTHROUGH */
+	case CE:
+		/* Insert transparently coded */
+		buf[0] = CE;               /* Send link escape */
+		buf[1] = byte^IRDA_TRANS;    /* Complement bit 5 */
+		return 2;
+		/* break; */
+	default:
+		 /* Non-special value, no transparency required */
+		buf[0] = byte;
+		return 1;
+		/* break; */
+	}
+}
 
 /*
  * Function async_wrap (skb, *tx_buff, buffsize)
@@ -107,7 +120,7 @@ int async_wrap_skb(struct sk_buff *skb, 
 		xbofs = 163;
 	}
 
-	memset(tx_buff+n, XBOF, xbofs);
+	memset(tx_buff + n, XBOF, xbofs);
 	n += xbofs;
 
 	/* Start of packet character BOF */
@@ -140,31 +153,45 @@ int async_wrap_skb(struct sk_buff *skb, 
 	return n;
 }
 
+/************************* FRAME UNWRAPPING *************************/
 /*
- * Function stuff_byte (byte, buf)
+ * Unwrap and unstuff SIR frames
  *
- *    Byte stuff one single byte and put the result in buffer pointed to by
- *    buf. The buffer must at all times be able to have two bytes inserted.
+ * Complete rewrite by Jean II :
+ * More inline, faster, more compact, more logical. Jean II
+ * (16 bytes on P6 200MHz, old 5 to 7 us, new 4 to 6 us)
+ * (24 bytes on P6 200MHz, old 9 to 10 us, new 7 to 8 us)
+ * (for reference, 115200 b/s is 1 byte every 69 us)
+ * And reduce wrapper.o by ~900B in the process ;-)
+ *
+ * Then, we have the addition of ZeroCopy, which is optional
+ * (i.e. the driver must initiate it) and improve final processing.
+ * (2005 B frame + EOF on P6 200MHz, without 30 to 50 us, with 10 to 25 us)
  *
+ * Note : at FIR and MIR, HDLC framing is used and usually handled
+ * by the controller, so we come here only for SIR... Jean II
  */
-static inline int stuff_byte(__u8 byte, __u8 *buf)
-{
-	switch (byte) {
-	case BOF: /* FALLTHROUGH */
-	case EOF: /* FALLTHROUGH */
-	case CE:
-		/* Insert transparently coded */
-		buf[0] = CE;               /* Send link escape */
-		buf[1] = byte^IRDA_TRANS;    /* Complement bit 5 */
-		return 2;
-		/* break; */
-	default:
-		 /* Non-special value, no transparency required */
-		buf[0] = byte;
-		return 1;
-		/* break; */
-	}
-}
+
+/*
+ * We can also choose where we want to do the CRC calculation. We can
+ * do it "inline", as we receive the bytes, or "postponed", when
+ * receiving the End-Of-Frame.
+ * (16 bytes on P6 200MHz, inlined 4 to 6 us, postponed 4 to 5 us)
+ * (24 bytes on P6 200MHz, inlined 7 to 8 us, postponed 5 to 7 us)
+ * With ZeroCopy :
+ * (2005 B frame on P6 200MHz, inlined 10 to 25 us, postponed 140 to 180 us)
+ * Without ZeroCopy :
+ * (2005 B frame on P6 200MHz, inlined 30 to 50 us, postponed 150 to 180 us)
+ * (Note : numbers taken with irq disabled)
+ *
+ * From those numbers, it's not clear which is the best strategy, because
+ * we end up running through a lot of data one way or another (i.e. cache
+ * misses). I personally prefer to avoid the huge latency spike of the
+ * "postponed" solution, because it come just at the time when we have
+ * lot's of protocol processing to do and it will hurt our ability to
+ * reach low link turnaround times... Jean II
+ */
+//#define POSTPONE_RX_CRC
 
 /*
  * Function async_bump (buf, len, stats)
@@ -172,136 +199,228 @@ static inline int stuff_byte(__u8 byte, 
  *    Got a frame, make a copy of it, and pass it up the stack! We can try
  *    to inline it since it's only called from state_inside_frame
  */
-inline void async_bump(struct net_device *dev, struct net_device_stats *stats,
-		       __u8 *buf, int len)
+static inline void
+async_bump(struct net_device *dev,
+	   struct net_device_stats *stats,
+	   iobuff_t *rx_buff)
 {
-	struct sk_buff *skb;
-
-	skb = dev_alloc_skb(len+1);
-	if (!skb)  {
+	struct sk_buff *newskb;
+	struct sk_buff *dataskb;
+	int		docopy;
+
+	/* Check if we need to copy the data to a new skb or not.
+	 * If the driver doesn't use ZeroCopy Rx, we have to do it.
+	 * With ZeroCopy Rx, the rx_buff already point to a valid
+	 * skb. But, if the frame is small, it is more efficient to
+	 * copy it to save memory (copy will be fast anyway - that's
+	 * called Rx-copy-break). Jean II */
+	docopy = ((rx_buff->skb == NULL) ||
+		  (rx_buff->len < IRDA_RX_COPY_THRESHOLD));
+
+	/* Allocate a new skb */
+	newskb = dev_alloc_skb(docopy ? rx_buff->len + 1 : rx_buff->truesize);
+	if (!newskb)  {
 		stats->rx_dropped++;
+		/* We could deliver the current skb if doing ZeroCopy Rx,
+		 * but this would stall the Rx path. Better drop the
+		 * packet... Jean II */
 		return;
 	}
 
-	/* Align IP header to 20 bytes */
-	skb_reserve(skb, 1);
+	/* Align IP header to 20 bytes (i.e. increase skb->data)
+	 * Note this is only useful with IrLAN, as PPP has a variable
+	 * header size (2 or 1 bytes) - Jean II */
+	skb_reserve(newskb, 1);
+
+	if(docopy) {
+		/* Copy data without CRC (lenght already checked) */
+		memcpy(newskb->data, rx_buff->data, rx_buff->len - 2);
+		/* Deliver this skb */
+		dataskb = newskb;
+	} else {
+		/* We are using ZeroCopy. Deliver old skb */
+		dataskb = rx_buff->skb;
+		/* And hook the new skb to the rx_buff */
+		rx_buff->skb = newskb;
+		rx_buff->head = newskb->data;	/* NOT newskb->head */
+		//printk(KERN_DEBUG "ZeroCopy : len = %d, dataskb = %p, newskb = %p\n", rx_buff->len, dataskb, newskb);
+	}
 
-        /* Copy data without CRC */
-	memcpy(skb_put(skb, len-2), buf, len-2);
+	/* Set proper length on skb (without CRC) */
+	skb_put(dataskb, rx_buff->len - 2);
 
 	/* Feed it to IrLAP layer */
-	skb->dev = dev;
-	skb->mac.raw  = skb->data;
-	skb->protocol = htons(ETH_P_IRDA);
+	dataskb->dev = dev;
+	dataskb->mac.raw  = dataskb->data;
+	dataskb->protocol = htons(ETH_P_IRDA);
 
-	netif_rx(skb);
+	netif_rx(dataskb);
 
 	stats->rx_packets++;
-	stats->rx_bytes += len;
+	stats->rx_bytes += rx_buff->len;
+
+	/* Clean up rx_buff (redundant with async_unwrap_bof() ???) */
+	rx_buff->data = rx_buff->head;
+	rx_buff->len = 0;
 }
 
 /*
- * Function async_unwrap_char (dev, rx_buff, byte)
+ * Function async_unwrap_bof(dev, byte)
  *
- *    Parse and de-stuff frame received from the IrDA-port
+ *    Handle Beggining Of Frame character received within a frame
  *
  */
-inline void async_unwrap_char(struct net_device *dev,
-			      struct net_device_stats *stats,
-			      iobuff_t *rx_buff, __u8 byte)
+static inline void
+async_unwrap_bof(struct net_device *dev,
+		 struct net_device_stats *stats,
+		 iobuff_t *rx_buff, __u8 byte)
 {
-	(*state[rx_buff->state])(dev, stats, rx_buff, byte);
+	switch(rx_buff->state) {
+	case LINK_ESCAPE:
+	case INSIDE_FRAME:
+		/* Not supposed to happen, the previous frame is not
+		 * finished - Jean II */
+		IRDA_DEBUG(1, "%s(), Discarding incomplete frame\n",
+			   __FUNCTION__);
+		stats->rx_errors++;
+		stats->rx_missed_errors++;
+		irda_device_set_media_busy(dev, TRUE);
+		break;
+
+	case OUTSIDE_FRAME:
+	case BEGIN_FRAME:
+	default:
+		/* We may receive multiple BOF at the start of frame */ 
+		break;
+	}
+
+	/* Now receiving frame */
+	rx_buff->state = BEGIN_FRAME;
+	rx_buff->in_frame = TRUE;
+
+	/* Time to initialize receive buffer */
+	rx_buff->data = rx_buff->head;
+	rx_buff->len = 0;
+	rx_buff->fcs = INIT_FCS;
 }
 
 /*
- * Function state_outside_frame (dev, rx_buff, byte)
+ * Function async_unwrap_eof(dev, byte)
  *
- *    Not receiving any frame (or just bogus data)
+ *    Handle End Of Frame character received within a frame
  *
  */
-static void state_outside_frame(struct net_device *dev,
-				struct net_device_stats *stats,
-				iobuff_t *rx_buff, __u8 byte)
+static inline void
+async_unwrap_eof(struct net_device *dev,
+		 struct net_device_stats *stats,
+		 iobuff_t *rx_buff, __u8 byte)
 {
-	switch (byte) {
-	case BOF:
-		rx_buff->state = BEGIN_FRAME;
-		rx_buff->in_frame = TRUE;
-		break;
-	case XBOF:
-		/* idev->xbofs++; */
-		break;
-	case EOF:
+#ifdef POSTPONE_RX_CRC
+	int	i;
+#endif
+
+	switch(rx_buff->state) {
+	case OUTSIDE_FRAME:
+		/* Probably missed the BOF */
+		stats->rx_errors++;
+		stats->rx_missed_errors++;
 		irda_device_set_media_busy(dev, TRUE);
 		break;
+
+	case BEGIN_FRAME:
+	case LINK_ESCAPE:
+	case INSIDE_FRAME:
 	default:
-		irda_device_set_media_busy(dev, TRUE);
+		/* Note : in the case of BEGIN_FRAME and LINK_ESCAPE,
+		 * the fcs will most likely not match and generate an
+		 * error, as expected - Jean II */
+		rx_buff->state = OUTSIDE_FRAME;
+		rx_buff->in_frame = FALSE;
+
+#ifdef POSTPONE_RX_CRC
+		/* If we haven't done the CRC as we receive bytes, we
+		 * must do it now... Jean II */
+		for(i = 0; i < rx_buff->len; i++)
+			rx_buff->fcs = irda_fcs(rx_buff->fcs,
+						rx_buff->data[i]);
+#endif
+
+		/* Test FCS and signal success if the frame is good */
+		if (rx_buff->fcs == GOOD_FCS) {
+			/* Deliver frame */
+			async_bump(dev, stats, rx_buff);
+			break;
+		} else {
+			/* Wrong CRC, discard frame!  */
+			irda_device_set_media_busy(dev, TRUE);
+
+			IRDA_DEBUG(1, "%s(), crc error\n", __FUNCTION__);
+			stats->rx_errors++;
+			stats->rx_crc_errors++;
+		}
 		break;
 	}
 }
 
 /*
- * Function state_begin_frame (idev, byte)
+ * Function async_unwrap_ce(dev, byte)
  *
- *    Begin of frame detected
+ *    Handle Character Escape character received within a frame
  *
  */
-static void state_begin_frame(struct net_device *dev,
-			      struct net_device_stats *stats,
-			      iobuff_t *rx_buff, __u8 byte)
+static inline void
+async_unwrap_ce(struct net_device *dev,
+		 struct net_device_stats *stats,
+		 iobuff_t *rx_buff, __u8 byte)
 {
-	/* Time to initialize receive buffer */
-	rx_buff->data = rx_buff->head;
-	rx_buff->len = 0;
-	rx_buff->fcs = INIT_FCS;
-
-	switch (byte) {
-	case BOF:
-		/* Continue */
-		break;
-	case CE:
-		/* Stuffed byte */
-		rx_buff->state = LINK_ESCAPE;
+	switch(rx_buff->state) {
+	case OUTSIDE_FRAME:
+		/* Activate carrier sense */
+		irda_device_set_media_busy(dev, TRUE);
 		break;
-	case EOF:
-		/* Abort frame */
-		rx_buff->state = OUTSIDE_FRAME;
-		IRDA_DEBUG(1, "%s(), abort frame\n", __FUNCTION__);
-		stats->rx_errors++;
-		stats->rx_frame_errors++;
+
+	case LINK_ESCAPE:
+		WARNING("%s: state not defined\n", __FUNCTION__);
 		break;
+
+	case BEGIN_FRAME:
+	case INSIDE_FRAME:
 	default:
-		rx_buff->data[rx_buff->len++] = byte;
-		rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
-		rx_buff->state = INSIDE_FRAME;
+		/* Stuffed byte comming */
+		rx_buff->state = LINK_ESCAPE;
 		break;
 	}
 }
 
 /*
- * Function state_link_escape (dev, byte)
+ * Function async_unwrap_other(dev, byte)
  *
- *    Found link escape character
+ *    Handle other characters received within a frame
  *
  */
-static void state_link_escape(struct net_device *dev,
-			      struct net_device_stats *stats,
-			      iobuff_t *rx_buff, __u8 byte)
+static inline void
+async_unwrap_other(struct net_device *dev,
+		   struct net_device_stats *stats,
+		   iobuff_t *rx_buff, __u8 byte)
 {
-	switch (byte) {
-	case BOF: /* New frame? */
-		IRDA_DEBUG(1, "%s(), Discarding incomplete frame\n",
-			   __FUNCTION__);
-		rx_buff->state = BEGIN_FRAME;
-		irda_device_set_media_busy(dev, TRUE);
-		break;
-	case CE:
-		WARNING("%s: state not defined\n", __FUNCTION__);
-		break;
-	case EOF: /* Abort frame */
-		rx_buff->state = OUTSIDE_FRAME;
+	switch(rx_buff->state) {
+		/* This is on the critical path, case are ordered by
+		 * probability (most frequent first) - Jean II */
+	case INSIDE_FRAME:
+		/* Must be the next byte of the frame */
+		if (rx_buff->len < rx_buff->truesize)  {
+			rx_buff->data[rx_buff->len++] = byte;
+#ifndef POSTPONE_RX_CRC
+			rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
+#endif
+		} else {
+			IRDA_DEBUG(1, "%s(), Rx buffer overflow, aborting\n",
+				   __FUNCTION__);
+			rx_buff->state = OUTSIDE_FRAME;
+		}
 		break;
-	default:
+
+	case LINK_ESCAPE:
 		/*
 		 *  Stuffed char, complement bit 5 of byte
 		 *  following CE, IrLAP p.114
@@ -309,67 +428,58 @@ static void state_link_escape(struct net
 		byte ^= IRDA_TRANS;
 		if (rx_buff->len < rx_buff->truesize)  {
 			rx_buff->data[rx_buff->len++] = byte;
+#ifndef POSTPONE_RX_CRC
 			rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
+#endif
 			rx_buff->state = INSIDE_FRAME;
 		} else {
-			IRDA_DEBUG(1, "%s(), rx buffer overflow\n",
+			IRDA_DEBUG(1, "%s(), Rx buffer overflow, aborting\n",
 				   __FUNCTION__);
 			rx_buff->state = OUTSIDE_FRAME;
 		}
 		break;
+
+	case OUTSIDE_FRAME:
+		/* Activate carrier sense */
+		if(byte != XBOF)
+			irda_device_set_media_busy(dev, TRUE);
+		break;
+
+	case BEGIN_FRAME:
+	default:
+		rx_buff->data[rx_buff->len++] = byte;
+#ifndef POSTPONE_RX_CRC
+		rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
+#endif
+		rx_buff->state = INSIDE_FRAME;
+		break;
 	}
 }
 
 /*
- * Function state_inside_frame (dev, byte)
+ * Function async_unwrap_char (dev, rx_buff, byte)
  *
- *    Handle bytes received within a frame
+ *    Parse and de-stuff frame received from the IrDA-port
  *
+ * This is the main entry point for SIR drivers.
  */
-static void state_inside_frame(struct net_device *dev,
-			       struct net_device_stats *stats,
-			       iobuff_t *rx_buff, __u8 byte)
+void async_unwrap_char(struct net_device *dev,
+		       struct net_device_stats *stats,
+		       iobuff_t *rx_buff, __u8 byte)
 {
-	int ret = 0;
-
-	switch (byte) {
-	case BOF: /* New frame? */
-		IRDA_DEBUG(1, "%s(), Discarding incomplete frame\n",
-			   __FUNCTION__);
-		rx_buff->state = BEGIN_FRAME;
-		irda_device_set_media_busy(dev, TRUE);
+	switch(byte) {
+	case CE:
+		async_unwrap_ce(dev, stats, rx_buff, byte);
 		break;
-	case CE: /* Stuffed char */
-		rx_buff->state = LINK_ESCAPE;
+	case BOF:
+		async_unwrap_bof(dev, stats, rx_buff, byte);
 		break;
-	case EOF: /* End of frame */
-		rx_buff->state = OUTSIDE_FRAME;
-		rx_buff->in_frame = FALSE;
-
-		/* Test FCS and signal success if the frame is good */
-		if (rx_buff->fcs == GOOD_FCS) {
-			/* Deliver frame */
-			async_bump(dev, stats, rx_buff->data, rx_buff->len);
-			ret = TRUE;
-			break;
-		} else {
-			/* Wrong CRC, discard frame!  */
-			irda_device_set_media_busy(dev, TRUE);
-
-			IRDA_DEBUG(1, "%s(), crc error\n", __FUNCTION__);
-			stats->rx_errors++;
-			stats->rx_crc_errors++;
-		}
+	case EOF:
+		async_unwrap_eof(dev, stats, rx_buff, byte);
 		break;
-	default: /* Must be the next byte of the frame */
-		if (rx_buff->len < rx_buff->truesize)  {
-			rx_buff->data[rx_buff->len++] = byte;
-			rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
-		} else {
-			IRDA_DEBUG(1, "%s(), Rx buffer overflow, aborting\n",
-				   __FUNCTION__);
-			rx_buff->state = OUTSIDE_FRAME;
-		}
+	default:
+		async_unwrap_other(dev, stats, rx_buff, byte);
 		break;
 	}
 }
+
