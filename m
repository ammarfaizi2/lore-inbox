Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCFV0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCFV0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCFV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:26:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:39598
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932289AbWCFV0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:26:15 -0500
Date: Mon, 6 Mar 2006 13:25:52 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Cc: seife@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] USB Serial: fix use-after-free bug in usb-serial core
Message-ID: <20060306212552.GA16432@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a use-after-free bug in the usb-serial core.  It is simple to
trigger this (open a usb-serial port, then yank the device out before
closing the port.)  Thanks to Stefan Seyfried <seife@suse.de> for
reporting this, and to the slab debugging code which enabled it to be
tracked down.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/usb-serial.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/drivers/usb/serial/usb-serial.c
+++ gregkh-2.6/drivers/usb/serial/usb-serial.c
@@ -242,8 +242,10 @@ static void serial_close(struct tty_stru
 
 	down(&port->sem);
 
-	if (port->open_count == 0)
-		goto out;
+	if (port->open_count == 0) {
+		up(&port->sem);
+		return;
+	}
 
 	--port->open_count;
 	if (port->open_count == 0) {
@@ -260,10 +262,8 @@ static void serial_close(struct tty_stru
 		module_put(port->serial->type->driver.owner);
 	}
 
-	kref_put(&port->serial->kref, destroy_serial);
-
-out:
 	up(&port->sem);
+	kref_put(&port->serial->kref, destroy_serial);
 }
 
 static int serial_write (struct tty_struct * tty, const unsigned char *buf, int count)
