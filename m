Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUCPObB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUCPOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:30:10 -0500
Received: from styx.suse.cz ([82.208.2.94]:3970 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261951AbUCPOTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:49 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467783462@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 37/44] Restore LED state in atkbd.c after resume
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467782227@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.11, 2004-03-08 14:09:15+01:00, szuk@telusplanet.net
  input: Restore LED state in atkbd.c after resume.


 atkbd.c |    9 +++++++++
 1 files changed, 9 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:17:49 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:17:49 2004
@@ -798,6 +798,7 @@
 {
 	struct atkbd *atkbd = serio->private;
 	struct serio_dev *dev = serio->dev;
+	unsigned char param[1];
 
 	if (!dev) {
 		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
@@ -805,11 +806,19 @@
 	}
 
 	if (atkbd->write) {
+		param[0] = (test_bit(LED_SCROLLL, atkbd->dev.led) ? 1 : 0)
+		         | (test_bit(LED_NUML,    atkbd->dev.led) ? 2 : 0)
+ 		         | (test_bit(LED_CAPSL,   atkbd->dev.led) ? 4 : 0);
+		
 		if (atkbd_probe(atkbd))
 			return -1;
 		if (atkbd->set != atkbd_set_3(atkbd))
 			return -1;
+		
 		atkbd_enable(atkbd);
+
+		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+			return -1;
 	}
 
 	return 0;

