Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTFUNjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTFUNjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:39:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21410 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264030AbTFUNiE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:04 -0400
Subject: [PATCH 2/11] input: Fix misdetection of PS/2 mice as AT keyboards
In-Reply-To: <1056203517244@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035172703@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1360, 2003-06-21 04:33:11-07:00, vojtech@kernel.bkbits.net
  input: Fix misdetection of PS2 mice as AT keyboards on non-PC machines
         where ATKBD_CMD_RESET_BAT is used.


 atkbd.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sat Jun 21 15:24:59 2003
+++ b/drivers/input/keyboard/atkbd.c	Sat Jun 21 15:24:59 2003
@@ -89,7 +89,7 @@
 #define ATKBD_CMD_GETID		0x02f2
 #define ATKBD_CMD_ENABLE	0x00f4
 #define ATKBD_CMD_RESET_DIS	0x00f5
-#define ATKBD_CMD_RESET_BAT	0x01ff
+#define ATKBD_CMD_RESET_BAT	0x02ff
 #define ATKBD_CMD_SETALL_MB	0x00f8
 #define ATKBD_CMD_RESEND	0x00fe
 #define ATKBD_CMD_EX_ENABLE	0x10ea
@@ -255,7 +255,8 @@
 
 	while (atkbd->cmdcnt && timeout--) {
 
-		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_RESET_BAT)
+		if (atkbd->cmdcnt == 1 &&
+		    command == ATKBD_CMD_RESET_BAT && timeout > 100000)
 			timeout = 100000;
 
 		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_GETID &&
@@ -270,6 +271,9 @@
 	if (param)
 		for (i = 0; i < receive; i++)
 			param[i] = atkbd->cmdbuf[(receive - 1) - i];
+
+	if (command == ATKBD_CMD_RESET_BAT && atkbd->cmdcnt == 1)
+		atkbd->cmdcnt = 0;
 
 	if (atkbd->cmdcnt) {
 		atkbd->cmdcnt = 0;

