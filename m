Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271025AbTG1CTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTG1AA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272945AbTG0XCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:14 -0400
Message-ID: <3F242835.9060001@colorfullife.com>
Date: Sun, 27 Jul 2003 21:29:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Barzilay <eli@barzilay.org>, linux-kernel@vger.kernel.org
CC: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Repost: Bug with select?
Content-Type: multipart/mixed;
 boundary="------------000900050104020403030703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000900050104020403030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eli,

The problem is normal_poll in drivers/char/n_tty.c:

 > if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
 >                mask |= POLLOUT | POLLWRNORM;

It assumes that a following write will succeed if less than 256 bytes 
are in the write buffer right now. This assumption is wrong for 
con_write_room: if the console is stopped, it returns 0 bytes buffer 
size (con_write_room()). Dito for pty_write_room.

The attached patch fixes your test case, but I don't understand tty 
devices good enough to guarantee anything.

--
    Manfred

--------------000900050104020403030703
Content-Type: text/plain;
 name="patch-tty-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tty-fix"

--- 2.5/drivers/char/n_tty.c	2003-07-05 09:13:01.000000000 +0200
+++ build-2.5/drivers/char/n_tty.c	2003-07-27 20:44:58.000000000 +0200
@@ -1251,7 +1251,8 @@
 		else
 			tty->minimum_to_wake = 1;
 	}
-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
+	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
+			tty->driver->write_room(tty) > 0)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }

--------------000900050104020403030703--

