Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWJNRjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWJNRjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWJNRjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:39:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:28723 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030334AbWJNRjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=PJLFhPPP/7oazuzV7RO6z7r2iZlTW/tdUYscwVGkNDJRrAZQtKfiXJhYBEh8169JQJ2OzTjhiH+4WN1Q4wINomqqbx4TlAVLOlvQUUTNMNwvXxF2t+6gj/GNMzBBslzm+N6tDfdwGZna0Lgx7dPKT4oboHBrnR0IbO8HSpVVftI=
Message-ID: <453120EC.8030503@gmail.com>
Date: Sat, 14 Oct 2006 13:39:56 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] V4L/DVB: potential leak in dvb-bt8xx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If dvb_attach
<http://www.coverity.com:7448/display-error.cgi?user=fmalita&magic=8997c91336813f372812011c89e0e75e&source=2693a21be69533084392e43c4f3c5220&runid=86&table=file&line=107>(dst_attach,
...) fails in *frontend_init*(), the previously allocated 'state' is
leaked (Coverity ID 1437).

Also, when allocating 'state' the result of kmalloc() needs to be checked.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index fb6c4cc..d22ba4e 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -665,6 +665,9 @@ static void frontend_init(struct dvb_bt8
 	case BTTV_BOARD_TWINHAN_DST:
 		/*	DST is not a frontend driver !!!		*/
 		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
+		if (!state)
+			break;
+
 		/*	Setup the Card					*/
 		state->config = &dst_config;
 		state->i2c = card->i2c_adapter;
@@ -673,6 +676,7 @@ static void frontend_init(struct dvb_bt8
 		/*	DST is not a frontend, attaching the ASIC	*/
 		if (dvb_attach(dst_attach, state, &card->dvb_adapter) == NULL) {
 			printk("%s: Could not find a Twinhan DST.\n", __FUNCTION__);
+			kfree(state);
 			break;
 		}
 		/*	Attach other DST peripherals if any		*/


