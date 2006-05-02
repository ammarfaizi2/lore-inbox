Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWEBW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWEBW5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEBW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:57:54 -0400
Received: from amdext4.amd.com ([163.181.251.6]:13984 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S965035AbWEBW5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:57:53 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Tue, 2 May 2006 17:12:39 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
cc: david.hollister@amd.com
Subject: [PATCH] vt: Delay the update of the visible framebuffer console
Message-ID: <20060502231239.GB23644@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 May 2006 22:57:34.0354 (UTC)
 FILETIME=[CCBA8720:01C66E3B]
X-WSS-ID: 68493C574KW5913700-01-01
Content-Type: multipart/mixed;
 boundary=CE+1k2dSO48ffgeK
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is a patch that delays updating the visible framebuffer console
until the other consoles have been initialized in order to avoid losing
output lines.  This problem was discovered when loading a framebuffer driver
as a module.  Comments welcome.

Jordan

--CE+1k2dSO48ffgeK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=vt.patch
Content-Transfer-Encoding: 7bit

[PATCH] vt:  Delay the update of the visible framebuffer console

From: David Hollister <david.hollister@amd.com>

This patch delays the update of the visible framebuffer console until
all other consoles have been initialized in order to avoid losing
information.  This only seems to be a problem with modules, not with
built-in drivers.

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/char/vt.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index acc5d47..30f0f24 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2700,9 +2700,11 @@ int take_over_console(const struct consw
 		if (!vc || !vc->vc_sw)
 			continue;
 
-		j = i;
-		if (CON_IS_VISIBLE(vc))
+		if (CON_IS_VISIBLE(vc)) {
+			j = i;
 			save_screen(vc);
+		}
+
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
@@ -2718,17 +2720,21 @@ int take_over_console(const struct consw
 		 */
 		if (old_was_color != vc->vc_can_do_color)
 			clear_buffer_attributes(vc);
-
-		if (CON_IS_VISIBLE(vc))
-			update_screen(vc);
 	}
+
 	printk("Console: switching ");
 	if (!deflt)
 		printk("consoles %d-%d ", first+1, last+1);
-	if (j >= 0)
+	if (j >= 0) {
+		struct vc_data *vc = vc_cons[j].d;
+
 		printk("to %s %s %dx%d\n",
-		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
-		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
+		       vc->vc_can_do_color ? "colour" : "mono",
+		       desc, vc->vc_cols, vc->vc_rows);
+
+		if (CON_IS_VISIBLE(vc))
+			update_screen(vc);
+	}
 	else
 		printk("to %s\n", desc);
 

--CE+1k2dSO48ffgeK--

