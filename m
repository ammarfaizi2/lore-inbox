Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVCVB4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVCVB4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCVBz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:55:28 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:34187 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262341AbVCVBf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:59 -0500
Message-Id: <20050322013459.966954000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:14 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Domen Puncer <domen@coderock.org>
Content-Disposition: inline; filename=dvb-janitor-vfree.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 41/48] vfree() checking cleanups
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-core/dmxdev.c         |   16 +++++-----------
 dvb-core/dvb_ca_en50221.c |    3 +--
 ttpci/budget-core.c       |    3 +--
 3 files changed, 7 insertions(+), 15 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dmxdev.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dmxdev.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dmxdev.c	2005-03-22 00:28:04.000000000 +0100
@@ -304,8 +304,7 @@ static int dvb_dmxdev_set_buffer_size(st
 	buf->size=size;
 	buf->pwrite=buf->pread=0;
 	spin_unlock_irq(&dmxdevfilter->dev->lock);
-	if (mem)
-		vfree(mem);
+	vfree(mem);
 
 	if (buf->size) {
 		mem=vmalloc(dmxdevfilter->buffer.size);
@@ -1129,15 +1128,10 @@ dvb_dmxdev_release(struct dmxdev *dmxdev
 	dvb_unregister_device(dmxdev->dvbdev);
 	dvb_unregister_device(dmxdev->dvr_dvbdev);
 
-	if (dmxdev->filter) {
-		vfree(dmxdev->filter);
-		dmxdev->filter=NULL;
-	}
-
-	if (dmxdev->dvr) {
-		vfree(dmxdev->dvr);
-		dmxdev->dvr=NULL;
-	}
+	vfree(dmxdev->filter);
+	dmxdev->filter=NULL;
+	vfree(dmxdev->dvr);
+	dmxdev->dvr=NULL;
 	dmxdev->demux->close(dmxdev->demux);
 }
 EXPORT_SYMBOL(dvb_dmxdev_release);
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget-core.c	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-core.c	2005-03-22 00:28:04.000000000 +0100
@@ -415,8 +415,7 @@ int ttpci_budget_init(struct budget *bud
 err:
 	i2c_del_adapter(&budget->i2c_adap);
 
-	if (budget->grabbing)
-		vfree(budget->grabbing);
+	vfree(budget->grabbing);
 
 	dvb_unregister_adapter(budget->dvb_adapter);
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:27:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:28:04.000000000 +0100
@@ -804,8 +804,7 @@ static int dvb_ca_en50221_slot_shutdown(
 	down_write(&ca->slot_info[slot].sem);
 	ca->pub->slot_shutdown(ca->pub, slot);
 	ca->slot_info[slot].slot_state = DVB_CA_SLOTSTATE_NONE;
-	if (ca->slot_info[slot].rx_buffer.data)
-		vfree(ca->slot_info[slot].rx_buffer.data);
+	vfree(ca->slot_info[slot].rx_buffer.data);
 	ca->slot_info[slot].rx_buffer.data = NULL;
 	up_write(&ca->slot_info[slot].sem);
 

--

