Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUG2O46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUG2O46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUG2Oxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:53:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:26006 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264946AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 27/47] Fix array overflows in keyboard.c when KEY_MAX > keycode > NR_KEYS > 128
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101952172@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110195551@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.14, 2004-06-23 08:06:20+02:00, vojtech@suse.cz
  input: Fix array overflows in keyboard.c when KEY_MAX > keycode > NR_KEYS > 128.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 keyboard.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Thu Jul 29 14:40:08 2004
+++ b/drivers/char/keyboard.c	Thu Jul 29 14:40:08 2004
@@ -124,7 +124,7 @@
  */
 
 static struct input_handler kbd_handler;
-static unsigned long key_down[256/BITS_PER_LONG];	/* keyboard key bitmap */
+static unsigned long key_down[NBITS(KEY_MAX)];		/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static int dead_key_next;
 static int npadch = -1;					/* -1 or number assembled on pad */
@@ -143,7 +143,7 @@
 /* Simple translation table for the SysRq keys */
 
 #ifdef CONFIG_MAGIC_SYSRQ
-unsigned char kbd_sysrq_xlate[128] =
+unsigned char kbd_sysrq_xlate[KEY_MAX] =
         "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
         "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
         "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
@@ -1132,6 +1132,9 @@
 		kbd->slockstate = 0;
 		return;
 	}
+
+	if (keycode > NR_KEYS)
+		return;
 
 	keysym = key_map[keycode];
 	type = KTYP(keysym);

