Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVIDXmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVIDXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIDXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:53 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:26753 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932107AbVIDXaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:03 -0400
Message-Id: <20050904232318.963134000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-remove-more-unsused-stuff.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 08/54] core: dvb_demux: remove more unused cruft
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Removed more unused variables and constants.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/demux.h     |    7 -------
 drivers/media/dvb/dvb-core/dmxdev.c    |    4 ++--
 drivers/media/dvb/dvb-core/dvb_demux.c |   18 ++----------------
 drivers/media/dvb/dvb-core/dvb_demux.h |    7 +------
 drivers/media/dvb/dvb-core/dvb_net.c   |    4 +---
 5 files changed, 6 insertions(+), 34 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:56.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:57.000000000 +0200
@@ -125,9 +125,7 @@ struct dmx_ts_feed {
 		    u16 pid,
 		    int type,
 		    enum dmx_ts_pes pes_type,
-		    size_t callback_length,
 		    size_t circular_buffer_size,
-		    int descramble,
 		    struct timespec timeout);
         int (*start_filtering) (struct dmx_ts_feed* feed);
         int (*stop_filtering) (struct dmx_ts_feed* feed);
@@ -160,7 +158,6 @@ struct dmx_section_feed {
         int (*set) (struct dmx_section_feed* feed,
 		    u16 pid,
 		    size_t circular_buffer_size,
-		    int descramble,
 		    int check_crc);
         int (*allocate_filter) (struct dmx_section_feed* feed,
 				struct dmx_section_filter** filter);
@@ -208,7 +205,6 @@ struct dmx_frontend {
         struct list_head connectivity_list; /* List of front-ends that can
 					       be connected to a particular
 					       demux */
-        void* priv;     /* Pointer to private data of the API client */
         enum dmx_frontend_source source;
 };
 
@@ -226,8 +222,6 @@ struct dmx_frontend {
 #define DMX_MEMORY_BASED_FILTERING              8    /* write() available */
 #define DMX_CRC_CHECKING                        16
 #define DMX_TS_DESCRAMBLING                     32
-#define DMX_SECTION_PAYLOAD_DESCRAMBLING        64
-#define DMX_MAC_ADDRESS_DESCRAMBLING            128
 
 /*
  * Demux resource type identifier.
@@ -246,7 +240,6 @@ struct dmx_demux {
         u32 capabilities;            /* Bitfield of capability flags */
         struct dmx_frontend* frontend;    /* Front-end connected to the demux */
         void* priv;                  /* Pointer to private data of the API client */
-        int users;                   /* Number of users */
         int (*open) (struct dmx_demux* demux);
         int (*close) (struct dmx_demux* demux);
         int (*write) (struct dmx_demux* demux, const char* buf, size_t count);
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-09-04 22:27:52.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dmxdev.c	2005-09-04 22:27:57.000000000 +0200
@@ -571,7 +571,7 @@ static int dvb_dmxdev_filter_start(struc
 				return ret;
 			}
 
-			ret=(*secfeed)->set(*secfeed, para->pid, 32768, 0,
+			ret=(*secfeed)->set(*secfeed, para->pid, 32768,
 					    (para->flags & DMX_CHECK_CRC) ? 1 : 0);
 
 			if (ret<0) {
@@ -654,7 +654,7 @@ static int dvb_dmxdev_filter_start(struc
 		(*tsfeed)->priv = (void *) filter;
 
 		ret = (*tsfeed)->set(*tsfeed, para->pid, ts_type, ts_pes,
-				     188, 32768, 0, timeout);
+				     32768, timeout);
 
 		if (ret < 0) {
 			dmxdev->demux->release_ts_feed(dmxdev->demux, *tsfeed);
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:56.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:57.000000000 +0200
@@ -577,8 +577,7 @@ out:
 }
 
 static int dmx_ts_feed_set (struct dmx_ts_feed* ts_feed, u16 pid, int ts_type,
-		     enum dmx_ts_pes pes_type, size_t callback_length,
-		     size_t circular_buffer_size, int descramble,
+		     enum dmx_ts_pes pes_type, size_t circular_buffer_size,
 		     struct timespec timeout)
 {
 	struct dvb_demux_feed *feed = (struct dvb_demux_feed *) ts_feed;
@@ -610,17 +609,10 @@ static int dmx_ts_feed_set (struct dmx_t
 
 	feed->pid = pid;
 	feed->buffer_size = circular_buffer_size;
-	feed->descramble = descramble;
 	feed->timeout = timeout;
-	feed->cb_length = callback_length;
 	feed->ts_type = ts_type;
 	feed->pes_type = pes_type;
 
-	if (feed->descramble) {
-		up(&demux->mutex);
-		return -ENOSYS;
-	}
-
 	if (feed->buffer_size) {
 #ifdef NOBUFS
 		feed->buffer=NULL;
@@ -819,7 +811,7 @@ static int dmx_section_feed_allocate_fil
 
 static int dmx_section_feed_set(struct dmx_section_feed* feed,
 			 u16 pid, size_t circular_buffer_size,
-			 int descramble, int check_crc)
+			 int check_crc)
 {
 	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) feed;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
@@ -834,12 +826,6 @@ static int dmx_section_feed_set(struct d
 
 	dvbdmxfeed->pid = pid;
 	dvbdmxfeed->buffer_size = circular_buffer_size;
-	dvbdmxfeed->descramble = descramble;
-	if (dvbdmxfeed->descramble) {
-		up(&dvbdmx->mutex);
-		return -ENOSYS;
-	}
-
 	dvbdmxfeed->feed.sec.check_crc = check_crc;
 
 #ifdef NOBUFS
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:27:55.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:27:57.000000000 +0200
@@ -54,12 +54,9 @@ struct dvb_demux_filter {
         int index;
         int state;
         int type;
-	int pesto;
 
-        u16 handle;
         u16 hw_handle;
         struct timer_list timer;
-	int ts_state;
 };
 
 
@@ -83,11 +80,9 @@ struct dvb_demux_feed {
         u16 pid;
         u8 *buffer;
         int buffer_size;
-        int descramble;
 
         struct timespec timeout;
         struct dvb_demux_filter *filter;
-        int cb_length;
 
         int ts_type;
         enum dmx_ts_pes pes_type;
@@ -98,7 +93,7 @@ struct dvb_demux_feed {
         u16 peslen;
 
 	struct list_head list_head;
-		int index; /* a unique index for each feed (can be used as hardware pid filter index) */
+	unsigned int index; /* a unique index for each feed (can be used as hardware pid filter index) */
 };
 
 struct dvb_demux {
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_net.c	2005-09-04 22:27:49.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_net.c	2005-09-04 22:27:57.000000000 +0200
@@ -903,7 +903,7 @@ static int dvb_net_feed_start(struct net
 			return ret;
 		}
 
-		ret = priv->secfeed->set(priv->secfeed, priv->pid, 32768, 0, 1);
+		ret = priv->secfeed->set(priv->secfeed, priv->pid, 32768, 1);
 
 		if (ret<0) {
 			printk("%s: could not set section feed\n", dev->name);
@@ -955,9 +955,7 @@ static int dvb_net_feed_start(struct net
 		priv->tsfeed->priv = (void *)dev;
 		ret = priv->tsfeed->set(priv->tsfeed, priv->pid,
 					TS_PACKET, DMX_TS_PES_OTHER,
-					188 * 100, /* nr. of bytes delivered per callback */
 					32768,     /* circular buffer size */
-					0,         /* descramble */
 					timeout);
 
 		if (ret < 0) {

--

