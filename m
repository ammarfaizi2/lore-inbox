Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWBGPnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWBGPnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWBGPnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:43:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29378 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932078AbWBGPlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:46 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/16] FIX: Multiple usage of VP7045-based devices
Date: Tue, 07 Feb 2006 13:33:33 -0200
Message-id: <20060207153333.PS13014200011@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Reassigning function pointers in a static led to infinite loops when using
multiple VP7045-based device at the same time on one system. Using kmalloc'd
copies for reassignments is better.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/vp7045-fe.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/vp7045-fe.c b/drivers/media/dvb/dvb-usb/vp7045-fe.c
index 5242cca..9999336 100644
--- a/drivers/media/dvb/dvb-usb/vp7045-fe.c
+++ b/drivers/media/dvb/dvb-usb/vp7045-fe.c
@@ -23,10 +23,11 @@
 
 struct vp7045_fe_state {
 	struct dvb_frontend fe;
+	struct dvb_frontend_ops ops;
+
 	struct dvb_usb_device *d;
 };
 
-
 static int vp7045_fe_read_status(struct dvb_frontend* fe, fe_status_t *status)
 {
 	struct vp7045_fe_state *state = fe->demodulator_priv;
@@ -150,7 +151,8 @@ struct dvb_frontend * vp7045_fe_attach(s
 		goto error;
 
 	s->d = d;
-	s->fe.ops = &vp7045_fe_ops;
+	memcpy(&s->ops, &vp7045_fe_ops, sizeof(struct dvb_frontend_ops));
+	s->fe.ops = &s->ops;
 	s->fe.demodulator_priv = s;
 
 	goto success;

