Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUAZWNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUAZWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:13:32 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24075 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265467AbUAZWNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:13:23 -0500
Date: Mon, 26 Jan 2004 22:13:20 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: monochrome display fix.
Message-ID: <Pine.LNX.4.44.0401262212140.5445-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[CONSOLE] Don't let a monochrome display stomp all over the console color 
values.

--- linus-2.6/drivers/char/vt.c	2004-01-26 13:34:39.000000000 -0800
+++ fbdev-2.5/drivers/char/vt.c	2004-01-21 17:36:26.000000000 -0800
@@ -1062,7 +1062,8 @@
 	underline = 0;
 	reverse = 0;
 	blink = 0;
-	color = def_color;
+	if (can_do_color)
+		color = def_color;
 }
 
 /* console_sem is held */
@@ -1135,7 +1136,8 @@
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
+				if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
@@ -1143,19 +1145,23 @@
 				  * Reset colour to default? It did this
 				  * before...
 				  */
-				color = (def_color & 0x0f) | background;
+				if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 0;
 				break;
 			case 49:
-				color = (def_color & 0xf0) | foreground;
+				if (can_do_color)
+					color = (def_color & 0xf0) | foreground;
 				break;
 			default:
-				if (par[i] >= 30 && par[i] <= 37)
-					color = color_table[par[i]-30]
-						| background;
-				else if (par[i] >= 40 && par[i] <= 47)
-					color = (color_table[par[i]-40]<<4)
-						| foreground;
+				if (can_do_color) {
+					if (par[i] >= 30 && par[i] <= 37)
+						color = color_table[par[i]-30]
+							| background;
+					else if (par[i] >= 40 && par[i] <= 47)
+						color = (color_table[par[i]-40]<<4)
+							| foreground;
+				}
 				break;
 		}
 	update_attr(currcons);
@@ -1290,9 +1296,11 @@
 			}
 			break;
 		case 8:	/* store colors as defaults */
-			def_color = attr;
-			if (hi_font_mask == 0x100)
-				def_color >>= 1;
+			if (can_do_color) {
+				def_color = attr;
+				if (hi_font_mask == 0x100)
+					def_color >>= 1;
+			}	
 			default_attr(currcons);
 			update_attr(currcons);
 			break;

