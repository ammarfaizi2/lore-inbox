Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275809AbRI1DEg>; Thu, 27 Sep 2001 23:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275810AbRI1DE1>; Thu, 27 Sep 2001 23:04:27 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:12807 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S275809AbRI1DEL>; Thu, 27 Sep 2001 23:04:11 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81B2@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'Randy.Dunlap'" <rddunlap@osdlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: apm suspend broken in 2.4.10
Date: Thu, 27 Sep 2001 20:03:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The plot thickens!  Here's what I did:

In kernel/pm.c, at around line 242, I inserted these lines:

	if (status) {
		// inserted by awc

		printk( "awc: APM Suspend vetoed by: \n");
		printk( "  type = %d", dev->type );
		printk( " id = %d", dev->id );
		printk( " callback = %d", dev->callback );
		printk( " data = %d", dev->data );
		printk( " flags = %d", dev->flags );
		printk( " state = %d", dev->state );
		printk( " prev_state = %d\n", dev->prev_state );
	
		// we now return to your regularly scheduled kernel...

...and after compiling, installing, rebooting and entering "apm --suspend"
at a vc, I found this in syslog:

Sep 27 19:39:09 onus kernel: awc: APM Suspend vetoed by: 
Sep 27 19:39:09 onus kernel:   type = 1 id = 1104151299 callback =
-1072064644 data = 0 flags = 0 state = 0 prev_state = 0

1104151299 is 0x41D00303, which if you consult your include/linux/pm.h
(PM_SYS_DEV = 1, PM_SYS_KBC = 0x41d00303), would seem AFAICT to indicate
that it's the keyboard driver--or something upstream of it--who's vetoing my
suspend.  Am I crazy?

Obviously, apart from the final CR after typing "apm --suspend", I'm not
touching the keyboard before it fails.  I tried asking KLaptop (the KDE
power applet) to suspend using the mouse, and I found exactly the same debug
output repeated in syslog.

-0xe1a
