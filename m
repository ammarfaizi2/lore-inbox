Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVLRPps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVLRPps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVLRPp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:45:26 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:40375 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965180AbVLRPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:45:23 -0500
Subject: [PATCH 1/5] - Fix 64-bit compile warnings
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: linux-kernel@vger.kernel.org
Cc: js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Date: Sun, 18 Dec 2005 13:23:45 -0200
Message-Id: <1134920704.6702.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 64-bit compile warnings

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/common/saa7146_hlp.c        |    2 +-
 drivers/media/dvb/dvb-core/dvb_frontend.c |    6 +++---
 drivers/media/dvb/dvb-core/dvb_net.c      |    4 ++--
 drivers/media/dvb/frontends/bcm3510.c     |    4 ++--
 drivers/media/dvb/frontends/or51211.c     |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

e0c2a5cc6f2365d95917f3a3fffadd9f88d28746
diff --git a/drivers/media/common/saa7146_hlp.c b/drivers/media/common/saa7146_hlp.c
index ec52dff..be34ec4 100644
--- a/drivers/media/common/saa7146_hlp.c
+++ b/drivers/media/common/saa7146_hlp.c
@@ -562,7 +562,7 @@ static void saa7146_set_position(struct 
 
 	int b_depth = vv->ov_fmt->depth;
 	int b_bpl = vv->ov_fb.fmt.bytesperline;
-	u32 base = (u32)vv->ov_fb.base;
+	u32 base = (u32)(unsigned long)vv->ov_fb.base;
 
 	struct	saa7146_video_dma vdma1;
 
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.c b/drivers/media/dvb/dvb-core/dvb_frontend.c
index 95ea509..ae9c1d2 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -747,7 +747,7 @@ static int dvb_frontend_ioctl(struct ino
 
 	case FE_DISHNETWORK_SEND_LEGACY_CMD:
 		if (fe->ops->dishnetwork_send_legacy_command) {
-			err = fe->ops->dishnetwork_send_legacy_command(fe, (unsigned int) parg);
+			err = fe->ops->dishnetwork_send_legacy_command(fe, (unsigned long) parg);
 			fepriv->state = FESTATE_DISEQC;
 			fepriv->status = 0;
 		} else if (fe->ops->set_voltage) {
@@ -767,7 +767,7 @@ static int dvb_frontend_ioctl(struct ino
 			 * initialization, so parg is 8 bits and does not
 			 * include the initialization or start bit
 			 */
-			unsigned int cmd = ((unsigned int) parg) << 1;
+			unsigned int cmd = ((unsigned long) parg) << 1;
 			struct timeval nexttime;
 			struct timeval tv[10];
 			int i;
@@ -814,7 +814,7 @@ static int dvb_frontend_ioctl(struct ino
 
 	case FE_ENABLE_HIGH_LNB_VOLTAGE:
 		if (fe->ops->enable_high_lnb_voltage)
-			err = fe->ops->enable_high_lnb_voltage(fe, (int) parg);
+			err = fe->ops->enable_high_lnb_voltage(fe, (long) parg);
 		break;
 
 	case FE_SET_FRONTEND: {
diff --git a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
index 86bba81..95d991f 100644
--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ b/drivers/media/dvb/dvb-core/dvb_net.c
@@ -1296,9 +1296,9 @@ static int dvb_net_do_ioctl(struct inode
 
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if ((unsigned int) parg >= DVB_NET_DEVICES_MAX)
+		if ((unsigned long) parg >= DVB_NET_DEVICES_MAX)
 			return -EINVAL;
-		ret = dvb_net_remove_if(dvbnet, (unsigned int) parg);
+		ret = dvb_net_remove_if(dvbnet, (unsigned long) parg);
 		if (!ret)
 			module_put(dvbdev->adapter->module);
 		return ret;
diff --git a/drivers/media/dvb/frontends/bcm3510.c b/drivers/media/dvb/frontends/bcm3510.c
index 8ceb9a3..e9b3636 100644
--- a/drivers/media/dvb/frontends/bcm3510.c
+++ b/drivers/media/dvb/frontends/bcm3510.c
@@ -623,13 +623,13 @@ static int bcm3510_download_firmware(str
 		err("could not load firmware (%s): %d",BCM3510_DEFAULT_FIRMWARE,ret);
 		return ret;
 	}
-	deb_info("got firmware: %d\n",fw->size);
+	deb_info("got firmware: %zd\n",fw->size);
 
 	b = fw->data;
 	for (i = 0; i < fw->size;) {
 		addr = le16_to_cpu( *( (u16 *)&b[i] ) );
 		len  = le16_to_cpu( *( (u16 *)&b[i+2] ) );
-		deb_info("firmware chunk, addr: 0x%04x, len: 0x%04x, total length: 0x%04x\n",addr,len,fw->size);
+		deb_info("firmware chunk, addr: 0x%04x, len: 0x%04x, total length: 0x%04zx\n",addr,len,fw->size);
 		if ((ret = bcm3510_write_ram(st,addr,&b[i+4],len)) < 0) {
 			err("firmware download failed: %d\n",ret);
 			return ret;
diff --git a/drivers/media/dvb/frontends/or51211.c b/drivers/media/dvb/frontends/or51211.c
index 531f762..8d631ca 100644
--- a/drivers/media/dvb/frontends/or51211.c
+++ b/drivers/media/dvb/frontends/or51211.c
@@ -112,7 +112,7 @@ static int or51211_load_firmware (struct
 	u8 tudata[585];
 	int i;
 
-	dprintk("Firmware is %d bytes\n",fw->size);
+	dprintk("Firmware is %zd bytes\n",fw->size);
 
 	/* Get eprom data */
 	tudata[0] = 17;
-- 
0.99.9.GIT

