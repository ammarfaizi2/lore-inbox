Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUG2Ops@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUG2Ops (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUG2OpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:45:18 -0400
Received: from styx.suse.cz ([82.119.242.94]:10134 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264853AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 11/47] Make atkbd.c's atkbd_command() function immune to keys being pressed while running
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110194629@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101941969@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.84.3, 2004-06-02 15:46:14+02:00, vojtech@suse.cz
  input: Make atkbd.c's atkbd_command() function immune to keys being pressed
         and scancodes coming from the keyboard while it's executing.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 atkbd.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:41:36 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:41:36 2004
@@ -252,6 +252,11 @@
 		switch (code) {
 			case ATKBD_RET_ACK:
 				atkbd->nak = 0;
+				if (atkbd->cmdcnt) {
+					set_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+					set_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
+					set_bit(ATKBD_FLAG_ID, &atkbd->flags);
+				}
 				clear_bit(ATKBD_FLAG_ACK, &atkbd->flags);
 				goto out;
 			case ATKBD_RET_NAK:
@@ -414,6 +419,7 @@
 #endif
 
 	set_bit(ATKBD_FLAG_ACK, &atkbd->flags);
+	clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
 	if (serio_write(atkbd->serio, byte))
 		return -1;
 	while (test_bit(ATKBD_FLAG_ACK, &atkbd->flags) && timeout--) udelay(1);
@@ -443,23 +449,13 @@
 		for (i = 0; i < receive; i++)
 			atkbd->cmdbuf[(receive - 1) - i] = param[i];
 
-	if (receive) {
-		set_bit(ATKBD_FLAG_CMD, &atkbd->flags);
-		set_bit(ATKBD_FLAG_CMD1, &atkbd->flags);
-		set_bit(ATKBD_FLAG_ID, &atkbd->flags);
-	}
-
 	if (command & 0xff)
-		if (atkbd_sendbyte(atkbd, command & 0xff)) {
-			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+		if (atkbd_sendbyte(atkbd, command & 0xff))
 			return -1;
-		}
 
 	for (i = 0; i < send; i++)
-		if (atkbd_sendbyte(atkbd, param[i])) {
-			clear_bit(ATKBD_FLAG_CMD, &atkbd->flags);
+		if (atkbd_sendbyte(atkbd, param[i]))
 			return -1;
-		}
 
 	while (test_bit(ATKBD_FLAG_CMD, &atkbd->flags) && timeout--) {
 

