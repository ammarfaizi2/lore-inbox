Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVIDXjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVIDXjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVIDXa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:56 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:27777 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932109AbVIDXaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:04 -0400
Message-Id: <20050904232318.356330000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:05 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-core-demux-remove-unsused-stuff.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 06/54] core: dvb_demux: remove unused cruft
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Removed some useless functions and variables.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/demux.h     |   13 -----------
 drivers/media/dvb/dvb-core/dvb_demux.c |   39 +--------------------------------
 drivers/media/dvb/dvb-core/dvb_demux.h |    2 -
 3 files changed, 3 insertions(+), 51 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:52.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/demux.h	2005-09-04 22:27:55.000000000 +0200
@@ -245,7 +245,6 @@ struct dmx_frontend {
 struct dmx_demux {
         u32 capabilities;            /* Bitfield of capability flags */
         struct dmx_frontend* frontend;    /* Front-end connected to the demux */
-        struct list_head reg_list;   /* List of registered demuxes */
         void* priv;                  /* Pointer to private data of the API client */
         int users;                   /* Number of users */
         int (*open) (struct dmx_demux* demux);
@@ -291,16 +290,4 @@ struct dmx_demux {
 			u64 *stc, unsigned int *base);
 };
 
-/*--------------------------------------------------------------------------*/
-/* Demux directory */
-/*--------------------------------------------------------------------------*/
-
-/*
- * DMX_DIR_ENTRY(): Casts elements in the list of registered
- * demuxes from the generic type struct list_head* to the type struct dmx_demux
- *.
- */
-
-#define DMX_DIR_ENTRY(list) list_entry(list, struct dmx_demux, reg_list)
-
 #endif /* #ifndef __DEMUX_H */
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:54.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.c	2005-09-04 22:27:55.000000000 +0200
@@ -39,33 +39,6 @@
 // #define DVB_DEMUX_SECTION_LOSS_LOG
 
 
-static LIST_HEAD(dmx_muxs);
-
-
-static int dmx_register_demux(struct dmx_demux *demux)
-{
-	demux->users = 0;
-	list_add(&demux->reg_list, &dmx_muxs);
-	return 0;
-}
-
-static int dmx_unregister_demux(struct dmx_demux* demux)
-{
-	struct list_head *pos, *n, *head=&dmx_muxs;
-
-	list_for_each_safe (pos, n, head) {
-		if (DMX_DIR_ENTRY(pos) == demux) {
-			if (demux->users>0)
-				return -EINVAL;
-			list_del(pos);
-			return 0;
-		}
-	}
-
-	return -ENODEV;
-}
-
-
 /******************************************************************************
  * static inlined helper functions
  ******************************************************************************/
@@ -1207,7 +1180,7 @@ static int dvbdmx_get_pes_pids(struct dm
 
 int dvb_dmx_init(struct dvb_demux *dvbdemux)
 {
-	int i, err;
+	int i;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
 	dvbdemux->users = 0;
@@ -1250,7 +1223,6 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 		 dvbdemux->memcopy = dvb_dmx_memcopy;
 
 	dmx->frontend = NULL;
-	dmx->reg_list.prev = dmx->reg_list.next = &dmx->reg_list;
 	dmx->priv = (void *) dvbdemux;
 	dmx->open = dvbdmx_open;
 	dmx->close = dvbdmx_close;
@@ -1273,21 +1245,14 @@ int dvb_dmx_init(struct dvb_demux *dvbde
 	sema_init(&dvbdemux->mutex, 1);
 	spin_lock_init(&dvbdemux->lock);
 
-	if ((err = dmx_register_demux(dmx)) < 0)
-		return err;
-
 	return 0;
 }
 EXPORT_SYMBOL(dvb_dmx_init);
 
 
-int dvb_dmx_release(struct dvb_demux *dvbdemux)
+void dvb_dmx_release(struct dvb_demux *dvbdemux)
 {
-	struct dmx_demux *dmx = &dvbdemux->dmx;
-
-	dmx_unregister_demux(dmx);
 	vfree(dvbdemux->filter);
 	vfree(dvbdemux->feed);
-	return 0;
 }
 EXPORT_SYMBOL(dvb_dmx_release);
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-core/dvb_demux.h	2005-09-04 22:27:55.000000000 +0200
@@ -138,7 +138,7 @@ struct dvb_demux {
 
 
 int dvb_dmx_init(struct dvb_demux *dvbdemux);
-int dvb_dmx_release(struct dvb_demux *dvbdemux);
+void dvb_dmx_release(struct dvb_demux *dvbdemux);
 void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf, size_t count);
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count);
 void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count);

--

