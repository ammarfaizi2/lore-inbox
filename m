Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTJPFvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 01:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTJPFvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 01:51:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42420 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262729AbTJPFvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 01:51:12 -0400
Date: Wed, 15 Oct 2003 22:48:21 -0700
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: pberger@brimson.com, borchers@steinerpoint.com, greg@kroah.com
Subject: [PATCH][2.6.0-test7] digi_acceleport.c has bogus "address of" operator
Message-ID: <20031016054821.GA22005@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1365

The digi_acceleport.c USB serial driver has a bogus "address of" operator
that results in panics like this:

kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#1]
Call Trace:
 [<f88e9000>] digi_wakeup_write_lock+0x0/0xaa [digi_acceleport]
 [<c0236842>] console_callback+0xa0/0xc2
 [<c0136ebc>] worker_thread+0x228/0x3ce
 [<f88e9000>] digi_wakeup_write_lock+0x0/0xaa [digi_acceleport]
 [<c011e8b6>] default_wake_function+0x0/0x2e
 [<c010993e>] ret_from_fork+0x6/0x14
 [<c011e8b6>] default_wake_function+0x0/0x2e
 [<c0136c94>] worker_thread+0x0/0x3ce
 [<c010740d>] kernel_thread_helper+0x5/0xc

The problem is that digi_wakeup_write_lock() takes a pointer to a struct
usb_serial_port. However, what gets passed is a pointer to a pointer to a
struct usb_serial_port.

=== diff -rup drivers/usb/serial/digi_acceleport.c.orig drivers/usb/serial/digi_acceleport.c
--- drivers/usb/serial/digi_acceleport.c.orig   2003-10-15 22:03:26.000000000 -0700
+++ drivers/usb/serial/digi_acceleport.c        2003-10-15 21:10:21.000000000 -0700
@@ -1728,8 +1728,7 @@ dbg( "digi_startup: TOP" );
                init_waitqueue_head( &priv->dp_flush_wait );
                priv->dp_in_close = 0;
                init_waitqueue_head( &priv->dp_close_wait );
-               INIT_WORK(&priv->dp_wakeup_work, (void *)digi_wakeup_write_lock,
-                               (void *)(&serial->port[i]));
+               INIT_WORK(&priv->dp_wakeup_work, digi_wakeup_write_lock, serial->port[i]);
 
                /* initialize write wait queue for this port */
                init_waitqueue_head( &serial->port[i]->write_wait );

-- 
Kurtis D. Rader, Systems Support Engineer    service: 800-IBM-SERV
IBM Integrated Technology Services           email: kdrader@us.ibm.com
15300 SW Koll Pkwy, MS RHE2-O2               DID: +1 503-578-3714
Beaverton, OR 97006-6063                     http://www.ibm.com
