Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTLSMsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTLSMsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:48:38 -0500
Received: from mail.convergence.de ([212.84.236.4]:29626 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262794AbTLSM2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:43 -0500
Subject: [PATCH 5/12] Update DVB core
In-Reply-To: <10718369211552@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:41 +0100
Message-Id: <1071836921644@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - add a parameter to dvb_filter_pes2ts function to specify whether the packet is a payload unit start or not.
DVB: - new section demux code by emard
DVB: - change license GPL -> LGPL for dvb_ringbuffer, like all other DVB core files
DVB: - fix rare crash on invalid packets, patch by Asier Aguirre
DVB: - i2c: copy the data variable as well on register client so that detach sees it.
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/demux.h linux-2.6.0-p/drivers/media/dvb/dvb-core/demux.h
--- linux-2.6.0/drivers/media/dvb/dvb-core/demux.h	2003-12-18 03:58:40.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/demux.h	2003-12-08 16:19:00.000000000 +0100
@@ -44,6 +44,15 @@
 #endif 
 
 /*
+ * DMX_MAX_SECFEED_SIZE: Maximum length (in bytes) of a private section feed filter.
+ */ 
+
+#ifndef DMX_MAX_SECFEED_SIZE 
+#define DMX_MAX_SECFEED_SIZE 4096
+#endif 
+
+
+/*
  * enum dmx_success: Success codes for the Demux Callback API. 
  */ 
 
@@ -143,9 +152,9 @@
         int check_crc;
 	u32 crc_val;
 
-        u8 secbuf[4096];
-        int secbufp;
-        int seclen;
+        u8 *secbuf;
+        u8 secbuf_base[DMX_MAX_SECFEED_SIZE];
+        u16 secbufp, seclen, tsfeedp;
 
         int (*set) (struct dmx_section_feed* feed, 
 		    u16 pid, 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_demux.c	2003-12-18 03:58:16.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_demux.c	2003-12-08 16:19:00.000000000 +0100
@@ -34,6 +34,11 @@
 #include "dvb_functions.h"
 
 #define NOBUFS  
+/* 
+** #define DVB_DEMUX_SECTION_LOSS_LOG to monitor payload loss in the syslog
+*/
+// #define DVB_DEMUX_SECTION_LOSS_LOG
+
 
 LIST_HEAD(dmx_muxs);
 
@@ -87,7 +92,7 @@
 }
 
 
-static inline int payload(const u8 *tsp)
+static inline u8 payload(const u8 *tsp)
 {
 	if (!(tsp[3]&0x10)) // no payload?
 		return 0;
@@ -188,9 +195,7 @@
 	struct dvb_demux_filter *f = feed->filter;
 	struct dmx_section_feed *sec = &feed->feed.sec;
 	u8 *buf = sec->secbuf;
-
-	if (sec->secbufp != sec->seclen)
-		return -1;
+	int section_syntax_indicator;
 
 	if (!sec->is_filtering)
 		return 0;
@@ -198,15 +203,19 @@
 	if (!f)
 		return 0;
 
-	if (sec->check_crc && demux->check_crc32(feed, sec->secbuf, sec->seclen))
+	if (sec->check_crc) {
+		section_syntax_indicator = ((sec->secbuf[1] & 0x80) != 0);
+		if (section_syntax_indicator &&
+		    demux->check_crc32(feed, sec->secbuf, sec->seclen))
 		return -1;
+	}
 
 	do {
 		if (dvb_dmx_swfilter_sectionfilter(feed, f) < 0)
 			return -1;
 	} while ((f = f->next) && sec->is_filtering);
 
-	sec->secbufp = sec->seclen = 0;
+	sec->seclen = 0;
 
 	memset(buf, 0, DVB_DEMUX_MASK_MAX);
  
@@ -214,128 +223,147 @@
 }
 
 
-static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed, const u8 *buf) 
+static void dvb_dmx_swfilter_section_new(struct dvb_demux_feed *feed)
 {
-	struct dvb_demux *demux = feed->demux;
 	struct dmx_section_feed *sec = &feed->feed.sec;
-	int p, count;
-	int ccok, rest;
-	u8 cc;
 
-	if (!(count = payload(buf)))
-		return -1;
-
-	p = 188-count;
-
-	cc = buf[3] & 0x0f;
-	ccok = ((feed->cc+1) & 0x0f) == cc ? 1 : 0;
-	feed->cc = cc;
-
-	if (buf[1] & 0x40) { // PUSI set
-		// offset to start of first section is in buf[p] 
-		if (p+buf[p]>187) // trash if it points beyond packet
-			return -1;
-
-		if (buf[p] && ccok) { // rest of previous section?
-			// did we have enough data in last packet to calc length?
-			int tmp = 3 - sec->secbufp;
-
-			if (tmp > 0 && tmp != 3) {
-				if (p + tmp >= 187)
-					return -1;
-
-				demux->memcopy (feed, sec->secbuf+sec->secbufp,
-					       buf+p+1, tmp);
-
-				sec->seclen = section_length(sec->secbuf);
+#ifdef DVB_DEMUX_SECTION_LOSS_LOG
+	if(sec->secbufp < sec->tsfeedp)
+	{
+		int i, n = sec->tsfeedp - sec->secbufp;
 
-				if (sec->seclen > 4096) 
-					return -1;
+		/* section padding is done with 0xff bytes entirely.
+		** due to speed reasons, we won't check all of them
+		** but just first and last
+		*/
+		if(sec->secbuf[0] != 0xff || sec->secbuf[n-1] != 0xff)
+		{
+			printk("dvb_demux.c section ts padding loss: %d/%d\n", 
+			       n, sec->tsfeedp);
+			printk("dvb_demux.c pad data:");
+			for(i = 0; i < n; i++)
+				printk(" %02x", sec->secbuf[i]);
+			printk("\n");
 			}
-
-			rest = sec->seclen - sec->secbufp;
-
-			if (rest == buf[p] && sec->seclen) {
-				demux->memcopy (feed, sec->secbuf + sec->secbufp,
-					       buf+p+1, buf[p]);
-				sec->secbufp += buf[p];
-				dvb_dmx_swfilter_section_feed(feed);
 			}
+#endif
+
+	sec->tsfeedp = sec->secbufp = sec->seclen = 0;
+	sec->secbuf = sec->secbuf_base;
 		}
 
-		p += buf[p] + 1; 		// skip rest of last section
-		count = 188 - p;
+/* 
+** Losless Section Demux 1.4 by Emard
+*/
+static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed, const u8 *buf, u8 len)
+{
+	struct dvb_demux *demux = feed->demux;
+	struct dmx_section_feed *sec = &feed->feed.sec;
+	u16 limit, seclen, n;
 
-		while (count) {
+	if(sec->tsfeedp >= DMX_MAX_SECFEED_SIZE)
+		return 0;
 
-			sec->crc_val = ~0;
+	if(sec->tsfeedp + len > DMX_MAX_SECFEED_SIZE)
+	{
+#ifdef DVB_DEMUX_SECTION_LOSS_LOG
+		printk("dvb_demux.c section buffer full loss: %d/%d\n", 
+		       sec->tsfeedp + len - DMX_MAX_SECFEED_SIZE, DMX_MAX_SECFEED_SIZE);
+#endif
+		len = DMX_MAX_SECFEED_SIZE - sec->tsfeedp;
+	}
 
-			if ((count>2) && // enough data to determine sec length?
-			    ((sec->seclen = section_length(buf+p)) <= count)) {
-				if (sec->seclen>4096) 
-					return -1;
+	if(len <= 0)
+		return 0;
 
-				demux->memcopy (feed, sec->secbuf, buf+p,
-					       sec->seclen);
+	demux->memcopy(feed, sec->secbuf_base + sec->tsfeedp, buf, len);
+	sec->tsfeedp += len;
 
-				sec->secbufp = sec->seclen;
-				p += sec->seclen;
-				count = 188 - p;
+	/* -----------------------------------------------------
+	** Dump all the sections we can find in the data (Emard)
+	*/
 
-				dvb_dmx_swfilter_section_feed(feed);
+	limit = sec->tsfeedp;
+	if(limit > DMX_MAX_SECFEED_SIZE)
+		return -1; /* internal error should never happen */
 
-				// filling bytes until packet end?
-				if (count && buf[p]==0xff) 
-					count=0;
+	/* to be sure always set secbuf */
+	sec->secbuf = sec->secbuf_base + sec->secbufp;
 
-			} else { // section continues to following TS packet
-				demux->memcopy(feed, sec->secbuf, buf+p, count);
-				sec->secbufp+=count;
-				count=0;
-			}
+	for(n = 0; sec->secbufp + 2 < limit; n++)
+	{
+		seclen = section_length(sec->secbuf);
+		if(seclen <= 0 || seclen > DMX_MAX_SECFEED_SIZE 
+		   || seclen + sec->secbufp > limit)
+			return 0;
+		sec->seclen = seclen;
+		sec->crc_val = ~0;
+		/* dump [secbuf .. secbuf+seclen) */
+		dvb_dmx_swfilter_section_feed(feed);
+		sec->secbufp += seclen; /* secbufp and secbuf moving together is */
+		sec->secbuf += seclen; /* redundand but saves pointer arithmetic */
 		}
 
 		return 0;
 	}
 
-	// section continued below
-	if (!ccok)
-		return -1;
 
-	if (!sec->secbufp) // any data in last ts packet?
-		return -1;
+static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed, const u8 *buf) 
+{
+	u8 p, count;
+	int ccok;
+	u8 cc;
 
-	// did we have enough data in last packet to calc section length?
-	if (sec->secbufp < 3) {
-		int tmp = 3 - sec->secbufp;
+	count = payload(buf);
 		
-		if (tmp>count)
+	if (count == 0)  /* count == 0 if no payload or out of range */
 			return -1;
 
-		sec->crc_val = ~0;
-
-		demux->memcopy (feed, sec->secbuf + sec->secbufp, buf+p, tmp);
+	p = 188-count; /* payload start */
 
-		sec->seclen = section_length(sec->secbuf);
-
-		if (sec->seclen > 4096) 
-			return -1;
+	cc = buf[3] & 0x0f;
+	ccok = ((feed->cc+1) & 0x0f) == cc ? 1 : 0;
+	feed->cc = cc;
+	if(ccok == 0)
+	{
+#ifdef DVB_DEMUX_SECTION_LOSS_LOG
+		printk("dvb_demux.c discontinuity detected %d bytes lost\n", count);
+		/* those bytes under sume circumstances will again be reported
+		** in the following dvb_dmx_swfilter_section_new
+		*/
+#endif
+		dvb_dmx_swfilter_section_new(feed);
+		return 0;
 	}
 
-	rest = sec->seclen - sec->secbufp;
-
-	if (rest < 0)
-		return -1;
+	if(buf[1] & 0x40)
+	{
+		// PUSI=1 (is set), section boundary is here
+		if(count > 1 && buf[p] < count)
+		{
+			const u8 *before = buf+p+1;
+			u8 before_len = buf[p];
+			const u8 *after = before+before_len;
+			u8 after_len = count-1-before_len;
 
-	if (rest <= count) {	// section completed in this TS packet
-		demux->memcopy (feed, sec->secbuf + sec->secbufp, buf+p, rest);
-		sec->secbufp += rest;
-		dvb_dmx_swfilter_section_feed(feed);
-	} else 	{	// section continues in following ts packet
-		demux->memcopy (feed, sec->secbuf + sec->secbufp, buf+p, count);
-		sec->secbufp += count;
+			dvb_dmx_swfilter_section_copy_dump(feed, before, before_len);
+			dvb_dmx_swfilter_section_new(feed);
+			dvb_dmx_swfilter_section_copy_dump(feed, after, after_len);
+		}
+#ifdef DVB_DEMUX_SECTION_LOSS_LOG
+		else
+			if(count > 0)
+				printk("dvb_demux.c PUSI=1 but %d bytes lost\n", count);
+#endif
 	}
+	else
+	{
+		// PUSI=0 (is not set), no section boundary
+		const u8 *entire = buf+p;
+		u8 entire_len = count;
 
+		dvb_dmx_swfilter_section_copy_dump(feed, entire, entire_len);
+	}
 	return 0;
 }
 
@@ -439,6 +467,50 @@
 	spin_unlock(&demux->lock);
 }
 
+void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count)
+{
+	int p = 0,i, j;
+	u8 tmppack[188];
+	spin_lock(&demux->lock);
+
+	if ((i = demux->tsbufp)) {
+		if (count < (j=204-i)) {
+			memcpy(&demux->tsbuf[i], buf, count);
+			demux->tsbufp += count;
+			goto bailout;
+		}
+		memcpy(&demux->tsbuf[i], buf, j);
+		if ((demux->tsbuf[0] == 0x47)|(demux->tsbuf[0]==0xB8))  {
+			memcpy(tmppack, demux->tsbuf, 188);
+			if (tmppack[0] == 0xB8) tmppack[0] = 0x47;
+			dvb_dmx_swfilter_packet(demux, tmppack);
+		}
+		demux->tsbufp = 0;
+		p += j;
+	}
+
+	while (p < count) {
+		if ((buf[p] == 0x47)|(buf[p] == 0xB8)) {
+			if (count-p >= 204) {
+				memcpy(tmppack, buf+p, 188);
+				if (tmppack[0] == 0xB8) tmppack[0] = 0x47;
+				dvb_dmx_swfilter_packet(demux, tmppack);
+				p += 204;
+			} else {
+				i = count-p;
+				memcpy(demux->tsbuf, buf+p, i);
+				demux->tsbufp=i;
+				goto bailout;
+			}
+		} else { 
+			p++;
+		}
+	}
+
+bailout:
+	spin_unlock(&demux->lock);
+}
+
 
 static struct dvb_demux_filter * dvb_dmx_filter_alloc(struct dvb_demux *demux)
 {
@@ -848,6 +924,9 @@
 		up(&dvbdmx->mutex);
 		return -EINVAL;
 	}
+
+	dvbdmxfeed->feed.sec.tsfeedp = 0;
+	dvbdmxfeed->feed.sec.secbuf = dvbdmxfeed->feed.sec.secbuf_base;
 	dvbdmxfeed->feed.sec.secbufp=0;
 	dvbdmxfeed->feed.sec.seclen=0;
 	
@@ -946,7 +1032,9 @@
 	dvbdmxfeed->cb.sec=callback;
 	dvbdmxfeed->demux=dvbdmx;
 	dvbdmxfeed->pid=0xffff;
-	dvbdmxfeed->feed.sec.secbufp=0;
+	dvbdmxfeed->feed.sec.secbuf = dvbdmxfeed->feed.sec.secbuf_base;
+	dvbdmxfeed->feed.sec.secbufp = dvbdmxfeed->feed.sec.seclen = 0;
+	dvbdmxfeed->feed.sec.tsfeedp = 0;
 	dvbdmxfeed->filter=0;
 	dvbdmxfeed->buffer=0;
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_demux.h linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_demux.h
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_demux.h	2003-12-18 03:58:41.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_demux.h	2003-10-13 12:52:18.000000000 +0200
@@ -127,7 +127,7 @@
 
 #define DMX_MAX_PID 0x2000
 	struct list_head feed_list;
-        u8 tsbuf[188];
+        u8 tsbuf[204];
         int tsbufp;
 
 	struct semaphore mutex;
@@ -140,6 +140,7 @@
 void dvb_dmx_swfilter_packet(struct dvb_demux *dvbdmx, const u8 *buf);
 void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf, size_t count);
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count);
+void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count);
 
 int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend);
 int dvbdmx_disconnect_frontend(struct dmx_demux *demux);
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_filter.c linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_filter.c
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_filter.c	2003-12-18 04:00:01.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_filter.c	2003-12-10 13:50:15.000000000 +0100
@@ -564,14 +564,18 @@
 	p2ts->priv=priv;
 }
 
-int dvb_filter_pes2ts(struct dvb_filter_pes2ts *p2ts, unsigned char *pes, int len)
+int dvb_filter_pes2ts(struct dvb_filter_pes2ts *p2ts, unsigned char *pes,
+		      int len, int payload_start)
 {
 	unsigned char *buf=p2ts->buf;
 	int ret=0, rest;
 	
 	//len=6+((pes[4]<<8)|pes[5]);
 
+	if (payload_start)
 	buf[1]|=0x40;
+	else
+		buf[1]&=~0x40;
 	while (len>=184) {
 		buf[3]=0x10|((p2ts->cc++)&0x0f);
 		memcpy(buf+4, pes, 184);
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_filter.h linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_filter.h
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_filter.h	2003-12-18 03:58:28.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_filter.h	2003-12-10 13:50:15.000000000 +0100
@@ -37,7 +37,8 @@
 void dvb_filter_pes2ts_init(struct dvb_filter_pes2ts *p2ts, unsigned short pid, 
 		 	    dvb_filter_pes2ts_cb_t *cb, void *priv);
 
-int dvb_filter_pes2ts(struct dvb_filter_pes2ts *p2ts, unsigned char *pes, int len);
+int dvb_filter_pes2ts(struct dvb_filter_pes2ts *p2ts, unsigned char *pes,
+		      int len, int payload_start);
 
 
 #define PROG_STREAM_MAP  0xBC
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_i2c.c linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_i2c.c
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-12-18 03:59:16.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_i2c.c	2003-10-28 10:39:42.000000000 +0100
@@ -51,6 +51,7 @@
 
 	client->detach = dev->detach;
 	client->owner = dev->owner;
+	client->data = dev->data;
 
 	INIT_LIST_HEAD(&client->list_head);
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ksyms.c linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ksyms.c
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-12-18 03:59:53.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-10-13 12:52:18.000000000 +0200
@@ -18,6 +18,7 @@
 EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
 EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
 EXPORT_SYMBOL(dvb_dmx_swfilter);
+EXPORT_SYMBOL(dvb_dmx_swfilter_204);
 EXPORT_SYMBOL(dvbdmx_connect_frontend);
 EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ringbuffer.c linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ringbuffer.c
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2003-11-20 09:44:03.000000000 +0100
@@ -9,24 +9,18 @@
  *                       & Marcus Metzler for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
  * of the License, or (at your option) any later version.
  * 
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
+ * GNU Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
- * 
- *
- * the project's page is at http://www.linuxtv.org/dvb/
  */
 
 
@@ -167,11 +161,11 @@
 }
 
 
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_init);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_empty);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_free);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_avail);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_flush);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_flush_spinlock_wakeup);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_read);
-EXPORT_SYMBOL_GPL(dvb_ringbuffer_write);
+EXPORT_SYMBOL(dvb_ringbuffer_init);
+EXPORT_SYMBOL(dvb_ringbuffer_empty);
+EXPORT_SYMBOL(dvb_ringbuffer_free);
+EXPORT_SYMBOL(dvb_ringbuffer_avail);
+EXPORT_SYMBOL(dvb_ringbuffer_flush);
+EXPORT_SYMBOL(dvb_ringbuffer_flush_spinlock_wakeup);
+EXPORT_SYMBOL(dvb_ringbuffer_read);
+EXPORT_SYMBOL(dvb_ringbuffer_write);
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ringbuffer.h linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ringbuffer.h
--- linux-2.6.0/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-12-18 03:59:58.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-11-20 09:44:03.000000000 +0100
@@ -16,7 +16,7 @@
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * GNU Lesser General Public License for more details.
  * 
  * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, write to the Free Software

