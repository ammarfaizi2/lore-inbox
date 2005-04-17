Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDQNp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDQNp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 09:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDQNp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 09:45:28 -0400
Received: from server5.hostpoint.ch ([217.26.52.15]:3081 "EHLO
	server5.hostpoint.ch") by vger.kernel.org with ESMTP
	id S261316AbVDQNpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 09:45:14 -0400
Date: Sun, 17 Apr 2005 15:42:23 +0200
From: Andreas Jaggi <andreas.jaggi@waterwave.ch>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-input@atrey.karlen.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       debian-powerpc@lists.debian.org
Subject: [PATCH 2.6.11.7] macintosh/adbhid.c: adb buttons support for
 aluminium PowerBook G4
Message-ID: <20050417154223.6d1af254@localhost>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
X-Face: ~'tADa1faeey.m~:h}X+Y,gdK*18AQQun"fQ6e-FE@0&cEf&{p1`$bqU[Zr^D]G<fqBU;"P
 2X\'U16EWS^zbPX?:[nRF)evEb_4|[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server5.hostpoint.ch
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [26 6]
X-AntiAbuse: Sender Address Domain - waterwave.ch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for the special adb buttons of the aluminium
PowerBook G4.

Signed-off-by: Andreas Jaggi <andreas.jaggi@waterwave.ch>


diff -uNr a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
--- a/drivers/macintosh/adbhid.c	2005-04-09 22:49:49.000000000 +0200
+++ b/drivers/macintosh/adbhid.c	2005-04-10 15:27:54.000000000 +0200
@@ -555,6 +555,42 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
 			input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSUP, down);
 			break;
+
+		case 0xc:	/* videomode switch */
+			input_report_key(&adbhid[id]->input, KEY_SWITCHVIDEOMODE, down);
+			break;
+
+		case 0xd:	/* keyboard illumination toggle */
+			input_report_key(&adbhid[id]->input, KEY_KBDILLUMTOGGLE, down);
+			break;
+
+		case 0xe:	/* keyboard illumination decrease */
+			input_report_key(&adbhid[id]->input, KEY_KBDILLUMDOWN, down);
+			break;
+
+		case 0xf:
+			switch (data[1]) {
+			case 0x8f:
+			case 0x0f:
+				/* keyboard illumination increase */
+				input_report_key(&adbhid[id]->input, KEY_KBDILLUMUP, down);
+				break;
+
+			case 0x7f:
+			case 0xff:
+				/* keypad overlay toogle */
+				break;
+
+			default:
+				printk(KERN_INFO "Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
+				       data[0], data[1], data[2], data[3]);
+				break;
+			}
+			break;
+		default:
+			printk(KERN_INFO "Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
+			       data[0], data[1], data[2], data[3]);
+			break;
 		}
 	  }
 	  break;
@@ -775,6 +811,10 @@
 			set_bit(KEY_BRIGHTNESSUP, adbhid[id]->input.keybit);
 			set_bit(KEY_BRIGHTNESSDOWN, adbhid[id]->input.keybit);
 			set_bit(KEY_EJECTCD, adbhid[id]->input.keybit);
+			set_bit(KEY_SWITCHVIDEOMODE, adbhid[id]->input.keybit);
+			set_bit(KEY_KBDILLUMTOGGLE, adbhid[id]->input.keybit);
+			set_bit(KEY_KBDILLUMDOWN, adbhid[id]->input.keybit);
+			set_bit(KEY_KBDILLUMUP, adbhid[id]->input.keybit);
 			break;
 		}
 		if (adbhid[id]->name[0])
diff -uNr a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2005-04-09 22:49:49.000000000 +0200
+++ b/include/linux/input.h	2005-04-10 15:28:33.214974136 +0200
@@ -328,6 +328,11 @@
 #define KEY_BRIGHTNESSUP	225
 #define KEY_MEDIA		226
 
+#define KEY_SWITCHVIDEOMODE	227
+#define KEY_KBDILLUMTOGGLE	228
+#define KEY_KBDILLUMDOWN	229
+#define KEY_KBDILLUMUP		230
+
 #define KEY_UNKNOWN		240
 
 #define BTN_MISC		0x100
