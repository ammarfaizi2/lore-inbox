Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUIMVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUIMVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIMVX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:23:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41859 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268966AbUIMVXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:23:39 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix sysrq handling bug in sn_console.c
Date: Mon, 13 Sep 2004 14:23:33 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V/gRBaGQvv/BCwo"
Message-Id: <200409131423.33665.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_V/gRBaGQvv/BCwo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix a stupid bug in the sysrq handling in sn_console.c.  Instead of eating all 
characters in the sysrq string (preventing them from getting to the tty 
layer), only eat those following 'ESC' since that's a pretty important 
character for various things.  Please apply before 2.6.9 is released as the 
console is very unfriendly to use without it.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_V/gRBaGQvv/BCwo
Content-Type: text/plain;
  charset="us-ascii";
  name="sn-console-esc-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sn-console-esc-fix-2.patch"

--- linux-2.5-stock/drivers/serial/sn_console.c	2004-09-10 15:06:37.000000000 -0700
+++ linux-2.6.9-rc1-mm5/drivers/serial/sn_console.c	2004-09-13 14:08:03.000000000 -0700
@@ -596,10 +596,15 @@
                                 sysrq_requested = jiffies;
                                 sysrq_serial_ptr = sysrq_serial_str;
                         }
-			continue; /* ignore the whole sysrq string */
+			/*
+			 * ignore the whole sysrq string except for the
+			 * leading escape
+			 */
+			if (ch != '\e')
+				continue;
                 }
                 else
-                        sysrq_serial_ptr = sysrq_serial_str;
+			sysrq_serial_ptr = sysrq_serial_str;
 #endif /* CONFIG_MAGIC_SYSRQ */
 
 		/* record the character to pass up to the tty layer */
@@ -611,8 +616,6 @@
 			if (tty->flip.count == TTY_FLIPBUF_SIZE)
 				break;
 		}
-		else {
-		}
 		port->sc_port.icount.rx++;
 	}
 

--Boundary-00=_V/gRBaGQvv/BCwo--
