Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVIDXac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVIDXac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVIDXab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:31 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:32641 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932115AbVIDXaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:15 -0400
Message-Id: <20050904232319.786756000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:09 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-formatting-fixes.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 10/54] core: dvb_demux formatting fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Formatting fixes (Lindent + some handwork).

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_demux.c |  469 ++++++++++++++++-----------------
 drivers/media/dvb/dvb-core/dvb_demux.h |  109 +++----
 2 files changed, 284 insertions(+), 294 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:58.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:59.000000000 +0200
@@ -38,55 +38,52 @@
 */
 // #define DVB_DEMUX_SECTION_LOSS_LOG
 
-
 /******************************************************************************
  * static inlined helper functions
  ******************************************************************************/
 
-
 static inline u16 section_length(const u8 *buf)
 {
-	return 3+((buf[1]&0x0f)<<8)+buf[2];
+	return 3 + ((buf[1] & 0x0f) << 8) + buf[2];
 }
 
-
 static inline u16 ts_pid(const u8 *buf)
 {
-	return ((buf[1]&0x1f)<<8)+buf[2];
+	return ((buf[1] & 0x1f) << 8) + buf[2];
 }
 
-
 static inline u8 payload(const u8 *tsp)
 {
-	if (!(tsp[3] & 0x10)) // no payload?
+	if (!(tsp[3] & 0x10))	// no payload?
 		return 0;
-	if (tsp[3] & 0x20) {  // adaptation field?
-		if (tsp[4] > 183)    // corrupted data?
+
+	if (tsp[3] & 0x20) {	// adaptation field?
+		if (tsp[4] > 183)	// corrupted data?
 			return 0;
 		else
-			return 184-1-tsp[4];
+			return 184 - 1 - tsp[4];
 	}
+
 	return 184;
 }
 
-
-static u32 dvb_dmx_crc32 (struct dvb_demux_feed *f, const u8 *src, size_t len)
+static u32 dvb_dmx_crc32(struct dvb_demux_feed *f, const u8 *src, size_t len)
 {
-	return (f->feed.sec.crc_val = crc32_be (f->feed.sec.crc_val, src, len));
+	return (f->feed.sec.crc_val = crc32_be(f->feed.sec.crc_val, src, len));
 }
 
-
-static void dvb_dmx_memcopy (struct dvb_demux_feed *f, u8 *d, const u8 *s, size_t len)
+static void dvb_dmx_memcopy(struct dvb_demux_feed *f, u8 *d, const u8 *s,
+			    size_t len)
 {
-	memcpy (d, s, len);
+	memcpy(d, s, len);
 }
 
-
 /******************************************************************************
  * Software filter functions
  ******************************************************************************/
 
-static inline int dvb_dmx_swfilter_payload (struct dvb_demux_feed *feed, const u8 *buf)
+static inline int dvb_dmx_swfilter_payload(struct dvb_demux_feed *feed,
+					   const u8 *buf)
 {
 	int count = payload(buf);
 	int p;
@@ -96,32 +93,31 @@ static inline int dvb_dmx_swfilter_paylo
 	if (count == 0)
 		return -1;
 
-	p = 188-count;
+	p = 188 - count;
 
 	/*
-	cc=buf[3]&0x0f;
-	ccok=((dvbdmxfeed->cc+1)&0x0f)==cc ? 1 : 0;
-	dvbdmxfeed->cc=cc;
+	cc = buf[3] & 0x0f;
+	ccok = ((feed->cc + 1) & 0x0f) == cc;
+	feed->cc = cc;
 	if (!ccok)
 		printk("missed packet!\n");
 	*/
 
-	if (buf[1] & 0x40)  // PUSI ?
+	if (buf[1] & 0x40)	// PUSI ?
 		feed->peslen = 0xfffa;
 
 	feed->peslen += count;
 
-	return feed->cb.ts (&buf[p], count, NULL, 0, &feed->feed.ts, DMX_OK);
+	return feed->cb.ts(&buf[p], count, NULL, 0, &feed->feed.ts, DMX_OK);
 }
 
-
-static int dvb_dmx_swfilter_sectionfilter (struct dvb_demux_feed *feed,
-				    struct dvb_demux_filter *f)
+static int dvb_dmx_swfilter_sectionfilter(struct dvb_demux_feed *feed,
+					  struct dvb_demux_filter *f)
 {
 	u8 neq = 0;
 	int i;
 
-	for (i=0; i<DVB_DEMUX_MASK_MAX; i++) {
+	for (i = 0; i < DVB_DEMUX_MASK_MAX; i++) {
 		u8 xor = f->filter.filter_value[i] ^ feed->feed.sec.secbuf[i];
 
 		if (f->maskandmode[i] & xor)
@@ -133,12 +129,11 @@ static int dvb_dmx_swfilter_sectionfilte
 	if (f->doneq && !neq)
 		return 0;
 
-	return feed->cb.sec (feed->feed.sec.secbuf, feed->feed.sec.seclen,
-			     NULL, 0, &f->filter, DMX_OK);
+	return feed->cb.sec(feed->feed.sec.secbuf, feed->feed.sec.seclen,
+			    NULL, 0, &f->filter, DMX_OK);
 }
 
-
-static inline int dvb_dmx_swfilter_section_feed (struct dvb_demux_feed *feed)
+static inline int dvb_dmx_swfilter_section_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
 	struct dvb_demux_filter *f = feed->filter;
@@ -168,26 +163,24 @@ static inline int dvb_dmx_swfilter_secti
 	return 0;
 }
 
-
 static void dvb_dmx_swfilter_section_new(struct dvb_demux_feed *feed)
 {
 	struct dmx_section_feed *sec = &feed->feed.sec;
 
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
-	if(sec->secbufp < sec->tsfeedp)
-	{
+	if (sec->secbufp < sec->tsfeedp) {
 		int i, n = sec->tsfeedp - sec->secbufp;
 
-		/* section padding is done with 0xff bytes entirely.
-		** due to speed reasons, we won't check all of them
-		** but just first and last
-		*/
-		if(sec->secbuf[0] != 0xff || sec->secbuf[n-1] != 0xff)
-		{
+		/*
+		 * Section padding is done with 0xff bytes entirely.
+		 * Due to speed reasons, we won't check all of them
+		 * but just first and last.
+		 */
+		if (sec->secbuf[0] != 0xff || sec->secbuf[n - 1] != 0xff) {
 			printk("dvb_demux.c section ts padding loss: %d/%d\n",
 			       n, sec->tsfeedp);
 			printk("dvb_demux.c pad data:");
-			for(i = 0; i < n; i++)
+			for (i = 0; i < n; i++)
 				printk(" %02x", sec->secbuf[i]);
 			printk("\n");
 		}
@@ -199,82 +192,81 @@ static void dvb_dmx_swfilter_section_new
 }
 
 /*
-** Losless Section Demux 1.4.1 by Emard
-** Valsecchi Patrick:
-**  - middle of section A  (no PUSI)
-**  - end of section A and start of section B
-**    (with PUSI pointing to the start of the second section)
-**
-**  In this case, without feed->pusi_seen you'll receive a garbage section
-**  consisting of the end of section A. Basically because tsfeedp
-**  is incemented and the use=0 condition is not raised
-**  when the second packet arrives.
-**
-** Fix:
-** when demux is started, let feed->pusi_seen = 0 to
-** prevent initial feeding of garbage from the end of
-** previous section. When you for the first time see PUSI=1
-** then set feed->pusi_seen = 1
-*/
-static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed, const u8 *buf, u8 len)
+ * Losless Section Demux 1.4.1 by Emard
+ * Valsecchi Patrick:
+ *  - middle of section A  (no PUSI)
+ *  - end of section A and start of section B
+ *    (with PUSI pointing to the start of the second section)
+ *
+ *  In this case, without feed->pusi_seen you'll receive a garbage section
+ *  consisting of the end of section A. Basically because tsfeedp
+ *  is incemented and the use=0 condition is not raised
+ *  when the second packet arrives.
+ *
+ * Fix:
+ * when demux is started, let feed->pusi_seen = 0 to
+ * prevent initial feeding of garbage from the end of
+ * previous section. When you for the first time see PUSI=1
+ * then set feed->pusi_seen = 1
+ */
+static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed,
+					      const u8 *buf, u8 len)
 {
 	struct dvb_demux *demux = feed->demux;
 	struct dmx_section_feed *sec = &feed->feed.sec;
 	u16 limit, seclen, n;
 
-	if(sec->tsfeedp >= DMX_MAX_SECFEED_SIZE)
+	if (sec->tsfeedp >= DMX_MAX_SECFEED_SIZE)
 		return 0;
 
-	if(sec->tsfeedp + len > DMX_MAX_SECFEED_SIZE)
-	{
+	if (sec->tsfeedp + len > DMX_MAX_SECFEED_SIZE) {
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
 		printk("dvb_demux.c section buffer full loss: %d/%d\n",
-		       sec->tsfeedp + len - DMX_MAX_SECFEED_SIZE, DMX_MAX_SECFEED_SIZE);
+		       sec->tsfeedp + len - DMX_MAX_SECFEED_SIZE,
+		       DMX_MAX_SECFEED_SIZE);
 #endif
 		len = DMX_MAX_SECFEED_SIZE - sec->tsfeedp;
 	}
 
-	if(len <= 0)
+	if (len <= 0)
 		return 0;
 
 	demux->memcopy(feed, sec->secbuf_base + sec->tsfeedp, buf, len);
 	sec->tsfeedp += len;
 
-	/* -----------------------------------------------------
-	** Dump all the sections we can find in the data (Emard)
-	*/
-
+	/*
+	 * Dump all the sections we can find in the data (Emard)
+	 */
 	limit = sec->tsfeedp;
-	if(limit > DMX_MAX_SECFEED_SIZE)
-		return -1; /* internal error should never happen */
+	if (limit > DMX_MAX_SECFEED_SIZE)
+		return -1;	/* internal error should never happen */
 
 	/* to be sure always set secbuf */
 	sec->secbuf = sec->secbuf_base + sec->secbufp;
 
-	for(n = 0; sec->secbufp + 2 < limit; n++)
-	{
+	for (n = 0; sec->secbufp + 2 < limit; n++) {
 		seclen = section_length(sec->secbuf);
-		if(seclen <= 0 || seclen > DMX_MAX_SECFEED_SIZE
-		   || seclen + sec->secbufp > limit)
+		if (seclen <= 0 || seclen > DMX_MAX_SECFEED_SIZE
+		    || seclen + sec->secbufp > limit)
 			return 0;
 		sec->seclen = seclen;
 		sec->crc_val = ~0;
 		/* dump [secbuf .. secbuf+seclen) */
-		if(feed->pusi_seen)
+		if (feed->pusi_seen)
 			dvb_dmx_swfilter_section_feed(feed);
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
 		else
 			printk("dvb_demux.c pusi not seen, discarding section data\n");
 #endif
-		sec->secbufp += seclen; /* secbufp and secbuf moving together is */
-		sec->secbuf += seclen; /* redundand but saves pointer arithmetic */
+		sec->secbufp += seclen;	/* secbufp and secbuf moving together is */
+		sec->secbuf += seclen;	/* redundant but saves pointer arithmetic */
 	}
 
 	return 0;
 }
 
-
-static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed, const u8 *buf)
+static int dvb_dmx_swfilter_section_packet(struct dvb_demux_feed *feed,
+					   const u8 *buf)
 {
 	u8 p, count;
 	int ccok, dc_i = 0;
@@ -282,10 +274,10 @@ static int dvb_dmx_swfilter_section_pack
 
 	count = payload(buf);
 
-	if (count == 0)  /* count == 0 if no payload or out of range */
+	if (count == 0)		/* count == 0 if no payload or out of range */
 		return -1;
 
-	p = 188 - count; /* payload start */
+	p = 188 - count;	/* payload start */
 
 	cc = buf[3] & 0x0f;
 	ccok = ((feed->cc + 1) & 0x0f) == cc;
@@ -299,51 +291,53 @@ static int dvb_dmx_swfilter_section_pack
 
 	if (!ccok || dc_i) {
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
-		printk("dvb_demux.c discontinuity detected %d bytes lost\n", count);
-		/* those bytes under sume circumstances will again be reported
-		** in the following dvb_dmx_swfilter_section_new
-		*/
+		printk("dvb_demux.c discontinuity detected %d bytes lost\n",
+		       count);
+		/*
+		 * those bytes under sume circumstances will again be reported
+		 * in the following dvb_dmx_swfilter_section_new
+		 */
 #endif
-		/* Discontinuity detected. Reset pusi_seen = 0 to
-		** stop feeding of suspicious data until next PUSI=1 arrives
-		*/
+		/*
+		 * Discontinuity detected. Reset pusi_seen = 0 to
+		 * stop feeding of suspicious data until next PUSI=1 arrives
+		 */
 		feed->pusi_seen = 0;
 		dvb_dmx_swfilter_section_new(feed);
 	}
 
 	if (buf[1] & 0x40) {
-		// PUSI=1 (is set), section boundary is here
+		/* PUSI=1 (is set), section boundary is here */
 		if (count > 1 && buf[p] < count) {
-			const u8 *before = buf+p+1;
+			const u8 *before = &buf[p + 1];
 			u8 before_len = buf[p];
-			const u8 *after = before+before_len;
-			u8 after_len = count-1-before_len;
+			const u8 *after = &before[before_len];
+			u8 after_len = count - 1 - before_len;
 
-			dvb_dmx_swfilter_section_copy_dump(feed, before, before_len);
+			dvb_dmx_swfilter_section_copy_dump(feed, before,
+							   before_len);
 			/* before start of new section, set pusi_seen = 1 */
 			feed->pusi_seen = 1;
 			dvb_dmx_swfilter_section_new(feed);
-			dvb_dmx_swfilter_section_copy_dump(feed, after, after_len);
+			dvb_dmx_swfilter_section_copy_dump(feed, after,
+							   after_len);
 		}
 #ifdef DVB_DEMUX_SECTION_LOSS_LOG
-		else
-			if (count > 0)
-				printk("dvb_demux.c PUSI=1 but %d bytes lost\n", count);
+		else if (count > 0)
+			printk("dvb_demux.c PUSI=1 but %d bytes lost\n", count);
 #endif
 	} else {
-		// PUSI=0 (is not set), no section boundary
-		const u8 *entire = buf+p;
-		u8 entire_len = count;
-
-		dvb_dmx_swfilter_section_copy_dump(feed, entire, entire_len);
+		/* PUSI=0 (is not set), no section boundary */
+		dvb_dmx_swfilter_section_copy_dump(feed, &buf[p], count);
 	}
+
 	return 0;
 }
 
-
-static inline void dvb_dmx_swfilter_packet_type(struct dvb_demux_feed *feed, const u8 *buf)
+static inline void dvb_dmx_swfilter_packet_type(struct dvb_demux_feed *feed,
+						const u8 *buf)
 {
-	switch(feed->type) {
+	switch (feed->type) {
 	case DMX_TYPE_TS:
 		if (!feed->feed.ts.is_filtering)
 			break;
@@ -351,7 +345,8 @@ static inline void dvb_dmx_swfilter_pack
 			if (feed->ts_type & TS_PAYLOAD_ONLY)
 				dvb_dmx_swfilter_payload(feed, buf);
 			else
-				feed->cb.ts(buf, 188, NULL, 0, &feed->feed.ts, DMX_OK);
+				feed->cb.ts(buf, 188, NULL, 0, &feed->feed.ts,
+					    DMX_OK);
 		}
 		if (feed->ts_type & TS_DECODER)
 			if (feed->demux->write_to_decoder)
@@ -362,7 +357,7 @@ static inline void dvb_dmx_swfilter_pack
 		if (!feed->feed.sec.is_filtering)
 			break;
 		if (dvb_dmx_swfilter_section_packet(feed, buf) < 0)
-			feed->feed.sec.seclen = feed->feed.sec.secbufp=0;
+			feed->feed.sec.seclen = feed->feed.sec.secbufp = 0;
 		break;
 
 	default:
@@ -378,7 +373,7 @@ static inline void dvb_dmx_swfilter_pack
 static void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
 {
 	struct dvb_demux_feed *feed;
-	struct list_head *pos, *head=&demux->feed_list;
+	struct list_head *pos, *head = &demux->feed_list;
 	u16 pid = ts_pid(buf);
 	int dvr_done = 0;
 
@@ -404,21 +399,21 @@ static void dvb_dmx_swfilter_packet(stru
 	}
 }
 
-void dvb_dmx_swfilter_packets(struct dvb_demux *demux, const u8 *buf, size_t count)
+void dvb_dmx_swfilter_packets(struct dvb_demux *demux, const u8 *buf,
+			      size_t count)
 {
 	spin_lock(&demux->lock);
 
 	while (count--) {
-		if(buf[0] == 0x47) {
-		        dvb_dmx_swfilter_packet(demux, buf);
-		}
+		if (buf[0] == 0x47)
+			dvb_dmx_swfilter_packet(demux, buf);
 		buf += 188;
 	}
 
 	spin_unlock(&demux->lock);
 }
-EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
 
+EXPORT_SYMBOL(dvb_dmx_swfilter_packets);
 
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count)
 {
@@ -426,8 +421,10 @@ void dvb_dmx_swfilter(struct dvb_demux *
 
 	spin_lock(&demux->lock);
 
-	if ((i = demux->tsbufp)) {
-		if (count < (j=188-i)) {
+	if (demux->tsbufp) {
+		i = demux->tsbufp;
+		j = 188 - i;
+		if (count < j) {
 			memcpy(&demux->tsbuf[i], buf, count);
 			demux->tsbufp += count;
 			goto bailout;
@@ -441,13 +438,13 @@ void dvb_dmx_swfilter(struct dvb_demux *
 
 	while (p < count) {
 		if (buf[p] == 0x47) {
-			if (count-p >= 188) {
-				dvb_dmx_swfilter_packet(demux, buf+p);
+			if (count - p >= 188) {
+				dvb_dmx_swfilter_packet(demux, &buf[p]);
 				p += 188;
 			} else {
-				i = count-p;
-				memcpy(demux->tsbuf, buf+p, i);
-				demux->tsbufp=i;
+				i = count - p;
+				memcpy(demux->tsbuf, &buf[p], i);
+				demux->tsbufp = i;
 				goto bailout;
 			}
 		} else
@@ -457,24 +454,29 @@ void dvb_dmx_swfilter(struct dvb_demux *
 bailout:
 	spin_unlock(&demux->lock);
 }
+
 EXPORT_SYMBOL(dvb_dmx_swfilter);
 
 void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count)
 {
-	int p = 0,i, j;
+	int p = 0, i, j;
 	u8 tmppack[188];
+
 	spin_lock(&demux->lock);
 
-	if ((i = demux->tsbufp)) {
-		if (count < (j=204-i)) {
+	if (demux->tsbufp) {
+		i = demux->tsbufp;
+		j = 204 - i;
+		if (count < j) {
 			memcpy(&demux->tsbuf[i], buf, count);
 			demux->tsbufp += count;
 			goto bailout;
 		}
 		memcpy(&demux->tsbuf[i], buf, j);
-		if ((demux->tsbuf[0] == 0x47)|(demux->tsbuf[0]==0xB8))  {
+		if ((demux->tsbuf[0] == 0x47) | (demux->tsbuf[0] == 0xB8)) {
 			memcpy(tmppack, demux->tsbuf, 188);
-			if (tmppack[0] == 0xB8) tmppack[0] = 0x47;
+			if (tmppack[0] == 0xB8)
+				tmppack[0] = 0x47;
 			dvb_dmx_swfilter_packet(demux, tmppack);
 		}
 		demux->tsbufp = 0;
@@ -482,16 +484,17 @@ void dvb_dmx_swfilter_204(struct dvb_dem
 	}
 
 	while (p < count) {
-		if ((buf[p] == 0x47)|(buf[p] == 0xB8)) {
-			if (count-p >= 204) {
-				memcpy(tmppack, buf+p, 188);
-				if (tmppack[0] == 0xB8) tmppack[0] = 0x47;
+		if ((buf[p] == 0x47) | (buf[p] == 0xB8)) {
+			if (count - p >= 204) {
+				memcpy(tmppack, &buf[p], 188);
+				if (tmppack[0] == 0xB8)
+					tmppack[0] = 0x47;
 				dvb_dmx_swfilter_packet(demux, tmppack);
 				p += 204;
 			} else {
-				i = count-p;
-				memcpy(demux->tsbuf, buf+p, i);
-				demux->tsbufp=i;
+				i = count - p;
+				memcpy(demux->tsbuf, &buf[p], i);
+				demux->tsbufp = i;
 				goto bailout;
 			}
 		} else {
@@ -502,14 +505,14 @@ void dvb_dmx_swfilter_204(struct dvb_dem
 bailout:
 	spin_unlock(&demux->lock);
 }
-EXPORT_SYMBOL(dvb_dmx_swfilter_204);
 
+EXPORT_SYMBOL(dvb_dmx_swfilter_204);
 
-static struct dvb_demux_filter * dvb_dmx_filter_alloc(struct dvb_demux *demux)
+static struct dvb_demux_filter *dvb_dmx_filter_alloc(struct dvb_demux *demux)
 {
 	int i;
 
-	for (i=0; i<demux->filternum; i++)
+	for (i = 0; i < demux->filternum; i++)
 		if (demux->filter[i].state == DMX_STATE_FREE)
 			break;
 
@@ -521,11 +524,11 @@ static struct dvb_demux_filter * dvb_dmx
 	return &demux->filter[i];
 }
 
-static struct dvb_demux_feed * dvb_dmx_feed_alloc(struct dvb_demux *demux)
+static struct dvb_demux_feed *dvb_dmx_feed_alloc(struct dvb_demux *demux)
 {
 	int i;
 
-	for (i=0; i<demux->feednum; i++)
+	for (i = 0; i < demux->feednum; i++)
 		if (demux->feed[i].state == DMX_STATE_FREE)
 			break;
 
@@ -553,7 +556,7 @@ static void dvb_demux_feed_add(struct dv
 	spin_lock_irq(&feed->demux->lock);
 	if (dvb_demux_feed_find(feed)) {
 		printk(KERN_ERR "%s: feed already in list (type=%x state=%x pid=%x)\n",
-				__FUNCTION__, feed->type, feed->state, feed->pid);
+		       __FUNCTION__, feed->type, feed->state, feed->pid);
 		goto out;
 	}
 
@@ -567,7 +570,7 @@ static void dvb_demux_feed_del(struct dv
 	spin_lock_irq(&feed->demux->lock);
 	if (!(dvb_demux_feed_find(feed))) {
 		printk(KERN_ERR "%s: feed not in list (type=%x state=%x pid=%x)\n",
-				__FUNCTION__, feed->type, feed->state, feed->pid);
+		       __FUNCTION__, feed->type, feed->state, feed->pid);
 		goto out;
 	}
 
@@ -576,17 +579,17 @@ out:
 	spin_unlock_irq(&feed->demux->lock);
 }
 
-static int dmx_ts_feed_set (struct dmx_ts_feed* ts_feed, u16 pid, int ts_type,
-		     enum dmx_ts_pes pes_type, size_t circular_buffer_size,
-		     struct timespec timeout)
+static int dmx_ts_feed_set(struct dmx_ts_feed *ts_feed, u16 pid, int ts_type,
+			   enum dmx_ts_pes pes_type,
+			   size_t circular_buffer_size, struct timespec timeout)
 {
-	struct dvb_demux_feed *feed = (struct dvb_demux_feed *) ts_feed;
+	struct dvb_demux_feed *feed = (struct dvb_demux_feed *)ts_feed;
 	struct dvb_demux *demux = feed->demux;
 
 	if (pid > DMX_MAX_PID)
 		return -EINVAL;
 
-	if (down_interruptible (&demux->mutex))
+	if (down_interruptible(&demux->mutex))
 		return -ERESTARTSYS;
 
 	if (ts_type & TS_DECODER) {
@@ -615,7 +618,7 @@ static int dmx_ts_feed_set (struct dmx_t
 
 	if (feed->buffer_size) {
 #ifdef NOBUFS
-		feed->buffer=NULL;
+		feed->buffer = NULL;
 #else
 		feed->buffer = vmalloc(feed->buffer_size);
 		if (!feed->buffer) {
@@ -631,14 +634,13 @@ static int dmx_ts_feed_set (struct dmx_t
 	return 0;
 }
 
-
-static int dmx_ts_feed_start_filtering(struct dmx_ts_feed* ts_feed)
+static int dmx_ts_feed_start_filtering(struct dmx_ts_feed *ts_feed)
 {
-	struct dvb_demux_feed *feed = (struct dvb_demux_feed *) ts_feed;
+	struct dvb_demux_feed *feed = (struct dvb_demux_feed *)ts_feed;
 	struct dvb_demux *demux = feed->demux;
 	int ret;
 
-	if (down_interruptible (&demux->mutex))
+	if (down_interruptible(&demux->mutex))
 		return -ERESTARTSYS;
 
 	if (feed->state != DMX_STATE_READY || feed->type != DMX_TYPE_TS) {
@@ -665,13 +667,13 @@ static int dmx_ts_feed_start_filtering(s
 	return 0;
 }
 
-static int dmx_ts_feed_stop_filtering(struct dmx_ts_feed* ts_feed)
+static int dmx_ts_feed_stop_filtering(struct dmx_ts_feed *ts_feed)
 {
-	struct dvb_demux_feed *feed = (struct dvb_demux_feed *) ts_feed;
+	struct dvb_demux_feed *feed = (struct dvb_demux_feed *)ts_feed;
 	struct dvb_demux *demux = feed->demux;
 	int ret;
 
-	if (down_interruptible (&demux->mutex))
+	if (down_interruptible(&demux->mutex))
 		return -ERESTARTSYS;
 
 	if (feed->state < DMX_STATE_GO) {
@@ -695,13 +697,14 @@ static int dmx_ts_feed_stop_filtering(st
 	return ret;
 }
 
-static int dvbdmx_allocate_ts_feed (struct dmx_demux *dmx, struct dmx_ts_feed **ts_feed,
-			     dmx_ts_cb callback)
+static int dvbdmx_allocate_ts_feed(struct dmx_demux *dmx,
+				   struct dmx_ts_feed **ts_feed,
+				   dmx_ts_cb callback)
 {
-	struct dvb_demux *demux = (struct dvb_demux *) dmx;
+	struct dvb_demux *demux = (struct dvb_demux *)dmx;
 	struct dvb_demux_feed *feed;
 
-	if (down_interruptible (&demux->mutex))
+	if (down_interruptible(&demux->mutex))
 		return -ERESTARTSYS;
 
 	if (!(feed = dvb_dmx_feed_alloc(demux))) {
@@ -724,7 +727,6 @@ static int dvbdmx_allocate_ts_feed (stru
 	(*ts_feed)->stop_filtering = dmx_ts_feed_stop_filtering;
 	(*ts_feed)->set = dmx_ts_feed_set;
 
-
 	if (!(feed->filter = dvb_dmx_filter_alloc(demux))) {
 		feed->state = DMX_STATE_FREE;
 		up(&demux->mutex);
@@ -740,22 +742,22 @@ static int dvbdmx_allocate_ts_feed (stru
 	return 0;
 }
 
-static int dvbdmx_release_ts_feed(struct dmx_demux *dmx, struct dmx_ts_feed *ts_feed)
+static int dvbdmx_release_ts_feed(struct dmx_demux *dmx,
+				  struct dmx_ts_feed *ts_feed)
 {
-	struct dvb_demux *demux = (struct dvb_demux *) dmx;
-	struct dvb_demux_feed *feed = (struct dvb_demux_feed *) ts_feed;
+	struct dvb_demux *demux = (struct dvb_demux *)dmx;
+	struct dvb_demux_feed *feed = (struct dvb_demux_feed *)ts_feed;
 
-	if (down_interruptible (&demux->mutex))
+	if (down_interruptible(&demux->mutex))
 		return -ERESTARTSYS;
 
 	if (feed->state == DMX_STATE_FREE) {
 		up(&demux->mutex);
 		return -EINVAL;
 	}
-
 #ifndef NOBUFS
 	vfree(feed->buffer);
-	feed->buffer=0;
+	feed->buffer = NULL;
 #endif
 
 	feed->state = DMX_STATE_FREE;
@@ -772,19 +774,18 @@ static int dvbdmx_release_ts_feed(struct
 	return 0;
 }
 
-
 /******************************************************************************
  * dmx_section_feed API calls
  ******************************************************************************/
 
-static int dmx_section_feed_allocate_filter(struct dmx_section_feed* feed,
-				     struct dmx_section_filter** filter)
+static int dmx_section_feed_allocate_filter(struct dmx_section_feed *feed,
+					    struct dmx_section_filter **filter)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
 	struct dvb_demux *dvbdemux = dvbdmxfeed->demux;
 	struct dvb_demux_filter *dvbdmxfilter;
 
-	if (down_interruptible (&dvbdemux->mutex))
+	if (down_interruptible(&dvbdemux->mutex))
 		return -ERESTARTSYS;
 
 	dvbdmxfilter = dvb_dmx_filter_alloc(dvbdemux);
@@ -808,18 +809,17 @@ static int dmx_section_feed_allocate_fil
 	return 0;
 }
 
-
-static int dmx_section_feed_set(struct dmx_section_feed* feed,
-			 u16 pid, size_t circular_buffer_size,
-			 int check_crc)
+static int dmx_section_feed_set(struct dmx_section_feed *feed,
+				u16 pid, size_t circular_buffer_size,
+				int check_crc)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 
 	if (pid > 0x1fff)
 		return -EINVAL;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
 	dvb_demux_feed_add(dvbdmxfeed);
@@ -831,7 +831,7 @@ static int dmx_section_feed_set(struct d
 #ifdef NOBUFS
 	dvbdmxfeed->buffer = NULL;
 #else
-	dvbdmxfeed->buffer=vmalloc(dvbdmxfeed->buffer_size);
+	dvbdmxfeed->buffer = vmalloc(dvbdmxfeed->buffer_size);
 	if (!dvbdmxfeed->buffer) {
 		up(&dvbdmx->mutex);
 		return -ENOMEM;
@@ -843,7 +843,6 @@ static int dmx_section_feed_set(struct d
 	return 0;
 }
 
-
 static void prepare_secfilters(struct dvb_demux_feed *dvbdmxfeed)
 {
 	int i;
@@ -851,12 +850,12 @@ static void prepare_secfilters(struct dv
 	struct dmx_section_filter *sf;
 	u8 mask, mode, doneq;
 
-	if (!(f=dvbdmxfeed->filter))
+	if (!(f = dvbdmxfeed->filter))
 		return;
 	do {
 		sf = &f->filter;
 		doneq = 0;
-		for (i=0; i<DVB_DEMUX_MASK_MAX; i++) {
+		for (i = 0; i < DVB_DEMUX_MASK_MAX; i++) {
 			mode = sf->filter_mode[i];
 			mask = sf->filter_mask[i];
 			f->maskandmode[i] = mask & mode;
@@ -866,14 +865,13 @@ static void prepare_secfilters(struct dv
 	} while ((f = f->next));
 }
 
-
 static int dmx_section_feed_start_filtering(struct dmx_section_feed *feed)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	int ret;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
 	if (feed->is_filtering) {
@@ -912,14 +910,13 @@ static int dmx_section_feed_start_filter
 	return 0;
 }
 
-
-static int dmx_section_feed_stop_filtering(struct dmx_section_feed* feed)
+static int dmx_section_feed_stop_filtering(struct dmx_section_feed *feed)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	int ret;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
 	if (!dvbdmx->stop_feed) {
@@ -938,15 +935,14 @@ static int dmx_section_feed_stop_filteri
 	return ret;
 }
 
-
 static int dmx_section_feed_release_filter(struct dmx_section_feed *feed,
-				struct dmx_section_filter* filter)
+					   struct dmx_section_filter *filter)
 {
-	struct dvb_demux_filter *dvbdmxfilter = (struct dvb_demux_filter *) filter, *f;
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
+	struct dvb_demux_filter *dvbdmxfilter = (struct dvb_demux_filter *)filter, *f;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
 	if (dvbdmxfilter->feed != dvbdmxfeed) {
@@ -963,7 +959,7 @@ static int dmx_section_feed_release_filt
 	if (f == dvbdmxfilter) {
 		dvbdmxfeed->filter = dvbdmxfilter->next;
 	} else {
-		while(f->next != dvbdmxfilter)
+		while (f->next != dvbdmxfilter)
 			f = f->next;
 		f->next = f->next->next;
 	}
@@ -978,10 +974,10 @@ static int dvbdmx_allocate_section_feed(
 					struct dmx_section_feed **feed,
 					dmx_section_cb callback)
 {
-	struct dvb_demux *dvbdmx = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdmx = (struct dvb_demux *)demux;
 	struct dvb_demux_feed *dvbdmxfeed;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
 	if (!(dvbdmxfeed = dvb_dmx_feed_alloc(dvbdmx))) {
@@ -999,7 +995,7 @@ static int dvbdmx_allocate_section_feed(
 	dvbdmxfeed->filter = NULL;
 	dvbdmxfeed->buffer = NULL;
 
-	(*feed)=&dvbdmxfeed->feed.sec;
+	(*feed) = &dvbdmxfeed->feed.sec;
 	(*feed)->is_filtering = 0;
 	(*feed)->parent = demux;
 	(*feed)->priv = NULL;
@@ -1017,21 +1013,21 @@ static int dvbdmx_allocate_section_feed(
 static int dvbdmx_release_section_feed(struct dmx_demux *demux,
 				       struct dmx_section_feed *feed)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
-	struct dvb_demux *dvbdmx = (struct dvb_demux *) demux;
+	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)feed;
+	struct dvb_demux *dvbdmx = (struct dvb_demux *)demux;
 
-	if (down_interruptible (&dvbdmx->mutex))
+	if (down_interruptible(&dvbdmx->mutex))
 		return -ERESTARTSYS;
 
-	if (dvbdmxfeed->state==DMX_STATE_FREE) {
+	if (dvbdmxfeed->state == DMX_STATE_FREE) {
 		up(&dvbdmx->mutex);
 		return -EINVAL;
 	}
 #ifndef NOBUFS
 	vfree(dvbdmxfeed->buffer);
-	dvbdmxfeed->buffer=0;
+	dvbdmxfeed->buffer = NULL;
 #endif
-	dvbdmxfeed->state=DMX_STATE_FREE;
+	dvbdmxfeed->state = DMX_STATE_FREE;
 
 	dvb_demux_feed_del(dvbdmxfeed);
 
@@ -1041,14 +1037,13 @@ static int dvbdmx_release_section_feed(s
 	return 0;
 }
 
-
 /******************************************************************************
  * dvb_demux kernel data API calls
  ******************************************************************************/
 
 static int dvbdmx_open(struct dmx_demux *demux)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
 	if (dvbdemux->users >= MAX_DVB_DEMUX_USERS)
 		return -EUSERS;
@@ -1057,10 +1052,9 @@ static int dvbdmx_open(struct dmx_demux 
 	return 0;
 }
 
-
 static int dvbdmx_close(struct dmx_demux *demux)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
 	if (dvbdemux->users == 0)
 		return -ENODEV;
@@ -1070,15 +1064,14 @@ static int dvbdmx_close(struct dmx_demux
 	return 0;
 }
 
-
 static int dvbdmx_write(struct dmx_demux *demux, const char *buf, size_t count)
 {
-	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
 	if ((!demux->frontend) || (demux->frontend->source != DMX_MEMORY_FE))
 		return -EINVAL;
 
-	if (down_interruptible (&dvbdemux->mutex))
+	if (down_interruptible(&dvbdemux->mutex))
 		return -ERESTARTSYS;
 	dvb_dmx_swfilter(dvbdemux, buf, count);
 	up(&dvbdemux->mutex);
@@ -1088,10 +1081,10 @@ static int dvbdmx_write(struct dmx_demux
 	return count;
 }
 
-
-static int dvbdmx_add_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
+static int dvbdmx_add_frontend(struct dmx_demux *demux,
+			       struct dmx_frontend *frontend)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 	struct list_head *head = &dvbdemux->frontend_list;
 
 	list_add(&(frontend->connectivity_list), head);
@@ -1099,13 +1092,13 @@ static int dvbdmx_add_frontend(struct dm
 	return 0;
 }
 
-
-static int dvbdmx_remove_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
+static int dvbdmx_remove_frontend(struct dmx_demux *demux,
+				  struct dmx_frontend *frontend)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 	struct list_head *pos, *n, *head = &dvbdemux->frontend_list;
 
-	list_for_each_safe (pos, n, head) {
+	list_for_each_safe(pos, n, head) {
 		if (DMX_FE_ENTRY(pos) == frontend) {
 			list_del(pos);
 			return 0;
@@ -1115,25 +1108,25 @@ static int dvbdmx_remove_frontend(struct
 	return -ENODEV;
 }
 
-
-static struct list_head * dvbdmx_get_frontends(struct dmx_demux *demux)
+static struct list_head *dvbdmx_get_frontends(struct dmx_demux *demux)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
 	if (list_empty(&dvbdemux->frontend_list))
 		return NULL;
+
 	return &dvbdemux->frontend_list;
 }
 
-
-static int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
+static int dvbdmx_connect_frontend(struct dmx_demux *demux,
+				   struct dmx_frontend *frontend)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
 	if (demux->frontend)
 		return -EINVAL;
 
-	if (down_interruptible (&dvbdemux->mutex))
+	if (down_interruptible(&dvbdemux->mutex))
 		return -ERESTARTSYS;
 
 	demux->frontend = frontend;
@@ -1141,12 +1134,11 @@ static int dvbdmx_connect_frontend(struc
 	return 0;
 }
 
-
 static int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
-	if (down_interruptible (&dvbdemux->mutex))
+	if (down_interruptible(&dvbdemux->mutex))
 		return -ERESTARTSYS;
 
 	demux->frontend = NULL;
@@ -1154,44 +1146,42 @@ static int dvbdmx_disconnect_frontend(st
 	return 0;
 }
 
-
-static int dvbdmx_get_pes_pids(struct dmx_demux *demux, u16 *pids)
+static int dvbdmx_get_pes_pids(struct dmx_demux *demux, u16 * pids)
 {
-	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
+	struct dvb_demux *dvbdemux = (struct dvb_demux *)demux;
 
-	memcpy(pids, dvbdemux->pids, 5*sizeof(u16));
+	memcpy(pids, dvbdemux->pids, 5 * sizeof(u16));
 	return 0;
 }
 
-
 int dvb_dmx_init(struct dvb_demux *dvbdemux)
 {
 	int i;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
 	dvbdemux->users = 0;
-	dvbdemux->filter = vmalloc(dvbdemux->filternum*sizeof(struct dvb_demux_filter));
+	dvbdemux->filter = vmalloc(dvbdemux->filternum * sizeof(struct dvb_demux_filter));
 
 	if (!dvbdemux->filter)
 		return -ENOMEM;
 
-	dvbdemux->feed = vmalloc(dvbdemux->feednum*sizeof(struct dvb_demux_feed));
+	dvbdemux->feed = vmalloc(dvbdemux->feednum * sizeof(struct dvb_demux_feed));
 	if (!dvbdemux->feed) {
 		vfree(dvbdemux->filter);
 		return -ENOMEM;
 	}
-	for (i=0; i<dvbdemux->filternum; i++) {
+	for (i = 0; i < dvbdemux->filternum; i++) {
 		dvbdemux->filter[i].state = DMX_STATE_FREE;
 		dvbdemux->filter[i].index = i;
 	}
-	for (i=0; i<dvbdemux->feednum; i++) {
+	for (i = 0; i < dvbdemux->feednum; i++) {
 		dvbdemux->feed[i].state = DMX_STATE_FREE;
 		dvbdemux->feed[i].index = i;
 	}
 
 	INIT_LIST_HEAD(&dvbdemux->frontend_list);
 
-	for (i=0; i<DMX_TS_PES_OTHER; i++) {
+	for (i = 0; i < DMX_TS_PES_OTHER; i++) {
 		dvbdemux->pesfilter[i] = NULL;
 		dvbdemux->pids[i] = 0xffff;
 	}
@@ -1205,11 +1195,11 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 	if (!dvbdemux->check_crc32)
 		dvbdemux->check_crc32 = dvb_dmx_crc32;
 
-	 if (!dvbdemux->memcopy)
-		 dvbdemux->memcopy = dvb_dmx_memcopy;
+	if (!dvbdemux->memcopy)
+		dvbdemux->memcopy = dvb_dmx_memcopy;
 
 	dmx->frontend = NULL;
-	dmx->priv = (void *) dvbdemux;
+	dmx->priv = dvbdemux;
 	dmx->open = dvbdmx_open;
 	dmx->close = dvbdmx_close;
 	dmx->write = dvbdmx_write;
@@ -1230,12 +1220,13 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 
 	return 0;
 }
-EXPORT_SYMBOL(dvb_dmx_init);
 
+EXPORT_SYMBOL(dvb_dmx_init);
 
 void dvb_dmx_release(struct dvb_demux *dvbdemux)
 {
 	vfree(dvbdemux->filter);
 	vfree(dvbdemux->feed);
 }
+
 EXPORT_SYMBOL(dvb_dmx_release);
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:27:57.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:27:59.000000000 +0200
@@ -20,7 +20,6 @@
  *
  */
 
-
 #ifndef _DVB_DEMUX_H_
 #define _DVB_DEMUX_H_
 
@@ -44,98 +43,98 @@
 #define DVB_DEMUX_MASK_MAX 18
 
 struct dvb_demux_filter {
-        struct dmx_section_filter filter;
-        u8 maskandmode    [DMX_MAX_FILTER_SIZE];
-        u8 maskandnotmode [DMX_MAX_FILTER_SIZE];
+	struct dmx_section_filter filter;
+	u8 maskandmode[DMX_MAX_FILTER_SIZE];
+	u8 maskandnotmode[DMX_MAX_FILTER_SIZE];
 	int doneq;
 
-        struct dvb_demux_filter *next;
-        struct dvb_demux_feed *feed;
-        int index;
-        int state;
-        int type;
+	struct dvb_demux_filter *next;
+	struct dvb_demux_feed *feed;
+	int index;
+	int state;
+	int type;
 
-        u16 hw_handle;
-        struct timer_list timer;
+	u16 hw_handle;
+	struct timer_list timer;
 };
 
-
 #define DMX_FEED_ENTRY(pos) list_entry(pos, struct dvb_demux_feed, list_head)
 
 struct dvb_demux_feed {
-        union {
-	        struct dmx_ts_feed ts;
-	        struct dmx_section_feed sec;
+	union {
+		struct dmx_ts_feed ts;
+		struct dmx_section_feed sec;
 	} feed;
 
-        union {
-	        dmx_ts_cb ts;
-	        dmx_section_cb sec;
+	union {
+		dmx_ts_cb ts;
+		dmx_section_cb sec;
 	} cb;
 
-        struct dvb_demux *demux;
+	struct dvb_demux *demux;
 	void *priv;
-        int type;
-        int state;
-        u16 pid;
-        u8 *buffer;
-        int buffer_size;
-
-        struct timespec timeout;
-        struct dvb_demux_filter *filter;
+	int type;
+	int state;
+	u16 pid;
+	u8 *buffer;
+	int buffer_size;
+
+	struct timespec timeout;
+	struct dvb_demux_filter *filter;
 
-        int ts_type;
-        enum dmx_ts_pes pes_type;
+	int ts_type;
+	enum dmx_ts_pes pes_type;
 
-        int cc;
-        int pusi_seen; /* prevents feeding of garbage from previous section */
+	int cc;
+	int pusi_seen;		/* prevents feeding of garbage from previous section */
 
-        u16 peslen;
+	u16 peslen;
 
 	struct list_head list_head;
-	unsigned int index; /* a unique index for each feed (can be used as hardware pid filter index) */
+	unsigned int index;	/* a unique index for each feed (can be used as hardware pid filter index) */
 };
 
 struct dvb_demux {
-        struct dmx_demux dmx;
-        void *priv;
-        int filternum;
-        int feednum;
-        int (*start_feed) (struct dvb_demux_feed *feed);
-        int (*stop_feed) (struct dvb_demux_feed *feed);
-        int (*write_to_decoder) (struct dvb_demux_feed *feed,
+	struct dmx_demux dmx;
+	void *priv;
+	int filternum;
+	int feednum;
+	int (*start_feed)(struct dvb_demux_feed *feed);
+	int (*stop_feed)(struct dvb_demux_feed *feed);
+	int (*write_to_decoder)(struct dvb_demux_feed *feed,
 				 const u8 *buf, size_t len);
-	u32 (*check_crc32) (struct dvb_demux_feed *feed,
+	u32 (*check_crc32)(struct dvb_demux_feed *feed,
 			    const u8 *buf, size_t len);
-	void (*memcopy) (struct dvb_demux_feed *feed, u8 *dst,
+	void (*memcopy)(struct dvb_demux_feed *feed, u8 *dst,
 			 const u8 *src, size_t len);
 
-        int users;
+	int users;
 #define MAX_DVB_DEMUX_USERS 10
-        struct dvb_demux_filter *filter;
-        struct dvb_demux_feed *feed;
+	struct dvb_demux_filter *filter;
+	struct dvb_demux_feed *feed;
 
-        struct list_head frontend_list;
+	struct list_head frontend_list;
 
-        struct dvb_demux_feed *pesfilter[DMX_TS_PES_OTHER];
-        u16 pids[DMX_TS_PES_OTHER];
-        int playing;
-        int recording;
+	struct dvb_demux_feed *pesfilter[DMX_TS_PES_OTHER];
+	u16 pids[DMX_TS_PES_OTHER];
+	int playing;
+	int recording;
 
 #define DMX_MAX_PID 0x2000
 	struct list_head feed_list;
-        u8 tsbuf[204];
-        int tsbufp;
+	u8 tsbuf[204];
+	int tsbufp;
 
 	struct semaphore mutex;
 	spinlock_t lock;
 };
 
-
 int dvb_dmx_init(struct dvb_demux *dvbdemux);
 void dvb_dmx_release(struct dvb_demux *dvbdemux);
-void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf, size_t count);
+void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf,
+			      size_t count);
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count);
-void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count);
+void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf,
+			  size_t count);
 
 #endif /* _DVB_DEMUX_H_ */

--

