Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWIKKf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWIKKf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIKKf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:35:58 -0400
Received: from smurf.noris.de ([192.109.102.42]:21658 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750782AbWIKKf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:35:57 -0400
Date: Mon, 11 Sep 2006 12:35:20 +0200
To: gregkh@suse.de, akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] usbserial: Reference leak
Message-ID: <20060911103520.GA20178@kiste.smurf.noris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A sufficiently-large number of USB serial devices causes a reference leak
when /proc/tty/drivers/usbserial is read.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
---
This should be in 2.6.18, for obvious reasons.
It also applies to older 2.6 kernels.)
---
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 3e96350..fae1410 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -471,8 +471,10 @@ static int serial_read_proc (char *page,
 		length += sprintf (page+length, " path:%s", tmp);
 			
 		length += sprintf (page+length, "\n");
-		if ((length + begin) > (off + count))
+		if ((length + begin) > (off + count)) {
+			usb_serial_put(serial);
 			goto done;
+		}
 		if ((length + begin) < off) {
 			begin += length;
 			length = 0;
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
