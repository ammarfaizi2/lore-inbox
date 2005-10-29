Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVJ2K4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVJ2K4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVJ2K4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:56:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44978 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750926AbVJ2K4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:56:14 -0400
Date: Sat, 29 Oct 2005 11:56:13 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] idmouse cleanup and overflow fix
Message-ID: <20051029105613.GG7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	switched to simple_read_from_buffer(), killed broken use of min().
Incidentally, that use of min() had been fixed once, only to be reintroduced
in
    [PATCH] USB: upgrade of the idmouse driver
[snip]
-       if (count > IMGSIZE - *ppos)
-               count = IMGSIZE - *ppos;
+       count = min ((loff_t)count, IMGSIZE - (*ppos));

Note the lovely use of cast to shut the warning about misuse of min() up...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/usb/misc/idmouse.c current/drivers/usb/misc/idmouse.c
--- RC14-base/drivers/usb/misc/idmouse.c	2005-10-29 02:47:52.000000000 -0400
+++ current/drivers/usb/misc/idmouse.c	2005-10-29 06:07:49.000000000 -0400
@@ -319,20 +319,8 @@
 		return -ENODEV;
 	}
 
-	if (*ppos >= IMGSIZE) {
-		up (&dev->sem);
-		return 0;
-	}
-
-	count = min ((loff_t)count, IMGSIZE - (*ppos));
-
-	if (copy_to_user (buffer, dev->bulk_in_buffer + *ppos, count)) {
-		result = -EFAULT;
-	} else {
-		result = count;
-		*ppos += count;
-	}
-
+	result = simple_read_from_buffer(buffer, count, ppos,
+					dev->bulk_in_buffer, IMGSIZE);
 	/* unlock the device */
 	up(&dev->sem);
 	return result;
