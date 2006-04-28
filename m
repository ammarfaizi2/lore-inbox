Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWD1AVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWD1AVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWD1AVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:21:02 -0400
Received: from ns1.suse.de ([195.135.220.2]:40921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751818AbWD1AUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:20:53 -0400
Date: Thu, 27 Apr 2006 17:19:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Michael Krufky <mkrufky@linuxtv.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 11/24] cxusb-bluebird: bug-fix: power down corrupts frontend
Message-ID: <20060428001920.GL18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cxusb-bluebird-bug-fix-power-down-corrupts-frontend.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Krufky <mkrufky@linuxtv.org>

This patch prevents a bug where the frontend is unable to tune after waking
from powered down state. Now, the device remains powered on until it is
disconnected, just like the windows driver. It seems that the bluebird
firmware is unable to successfully handle tuning after a powered down state.

This patch fixes all of the FusionHDTV Bluebird USB2 devices. The Medion
MD95700 will still behave as before, since it was unaffected by this bug.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/media/dvb/dvb-usb/cxusb.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- linux-2.6.16.11.orig/drivers/media/dvb/dvb-usb/cxusb.c
+++ linux-2.6.16.11/drivers/media/dvb/dvb-usb/cxusb.c
@@ -149,6 +149,15 @@ static int cxusb_power_ctrl(struct dvb_u
 		return cxusb_ctrl_msg(d, CMD_POWER_OFF, &b, 1, NULL, 0);
 }
 
+static int cxusb_bluebird_power_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	u8 b = 0;
+	if (onoff)
+		return cxusb_ctrl_msg(d, CMD_POWER_ON, &b, 1, NULL, 0);
+	else
+		return 0;
+}
+
 static int cxusb_streaming_ctrl(struct dvb_usb_device *d, int onoff)
 {
 	u8 buf[2] = { 0x03, 0x00 };
@@ -505,7 +514,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_lgdt3303_frontend_attach,
 	.tuner_attach     = cxusb_lgh064f_tuner_attach,
 
@@ -545,7 +554,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_dee1601_frontend_attach,
 	.tuner_attach     = cxusb_dee1601_tuner_attach,
 
@@ -594,7 +603,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_mt352_frontend_attach,
 	.tuner_attach     = cxusb_lgz201_tuner_attach,
 
@@ -634,7 +643,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_mt352_frontend_attach,
 	.tuner_attach     = cxusb_dtt7579_tuner_attach,
 

--
