Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbULQVuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbULQVuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 16:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbULQVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 16:50:11 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:48068 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262173AbULQVrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 16:47:14 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041217214735.7127.91238.40236@localhost.localdomain>
Subject: [PATCH] ip2: fix compile warnings
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 15:47:13 -0600
Date: Fri, 17 Dec 2004 15:47:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following compile errors in the ip2 and ip2main drivers:

  CC      drivers/char/ip2main.o
drivers/char/ip2main.c:470: warning: initialization from incompatible pointer type
drivers/char/ip2main.c: In function `ip2_tiocmget':
drivers/char/ip2main.c:2004: warning: unused variable `wait'
drivers/char/ip2/i2lib.c: At top level:
drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
drivers/char/ip2main.c:205: warning: `set_modem_info' declared `static' but never defined
drivers/char/ip2/i2ellis.c:108: warning: `iiEllisCleanup' defined but not used


Diffstat output:
 ip2/i2cmd.c   |    4 +++-
 ip2/i2cmd.h   |    2 ++
 ip2/i2ellis.c |    2 ++
 ip2main.c     |    6 +++---
 4 files changed, 10 insertions(+), 4 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2cmd.c linux-2.6.10-rc3-mm1/drivers/char/ip2/i2cmd.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2cmd.c	2004-12-03 16:53:20.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/ip2/i2cmd.c	2004-12-17 16:21:34.592613441 -0500
@@ -139,7 +139,9 @@
 //static UCHAR ct86[]={ 2, BTH,     0x56,0                   }; // RCV_ENABLE
 static UCHAR ct87[] = { 1, BYP,     0x57                     }; // HW_TEST
 //static UCHAR ct88[]={ 3, BTH,     0x58,0,0                 }; // RCV_THRESHOLD
-static UCHAR ct89[]={ 1, BYP,     0x59                     }; // DSS_NOW
+#ifdef ENABLE_DSSNOW
+static UCHAR ct89[]={ 1, BYP,     0x59                     }; // DSS_NOW
+#endif
 //static UCHAR ct90[]={ 3, BYP,     0x5A,0,0                 }; // Set SILO
 //static UCHAR ct91[]={ 2, BYP,     0x5B,0                   }; // timed break
 
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2cmd.h linux-2.6.10-rc3-mm1/drivers/char/ip2/i2cmd.h
--- linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2cmd.h	2004-12-03 16:52:47.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/ip2/i2cmd.h	2004-12-17 16:22:05.205480594 -0500
@@ -637,9 +637,11 @@
 			((cmdSyntaxPtr)(ct88))->cmd[2] = (ms), \
 			(cmdSyntaxPtr)(ct88))
 
+#ifdef ENABLE_DSSNOW
 // Makes the loadware report DSS signals for this channel immediately.
 //
 #define CMD_DSS_NOW (cmdSyntaxPtr)(ct89)
+#endif
 	
 // Set the receive silo parameters 
 // 	timeout is ms idle wait until delivery       (~VTIME)
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2ellis.c linux-2.6.10-rc3-mm1/drivers/char/ip2/i2ellis.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/ip2/i2ellis.c	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/ip2/i2ellis.c	2004-12-17 16:18:33.041123541 -0500
@@ -92,6 +92,7 @@
 	LOCK_INIT(&Dl_spinlock);
 }
 
+#ifdef MODULE
 //******************************************************************************
 // Function:   iiEllisCleanup()
 // Parameters: None
@@ -110,6 +111,7 @@
 		kfree ( pDelayTimer );
 	}
 }
+#endif
 
 //******************************************************************************
 // Function:   iiSetAddress(pB, address, delay)
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c linux-2.6.10-rc3-mm1/drivers/char/ip2main.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c	2004-12-03 16:55:03.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c	2004-12-17 16:24:24.094730049 -0500
@@ -202,7 +202,6 @@
 static void ip2_wait_until_sent(PTTY,int);
 
 static void set_params (i2ChanStrPtr, struct termios *);
-static int set_modem_info(i2ChanStrPtr, unsigned int, unsigned int *);
 static int get_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 static int set_serial_info(i2ChanStrPtr, struct serial_struct __user *);
 
@@ -467,7 +466,7 @@
 static struct tty_operations ip2_ops = {
 	.open            = ip2_open,
 	.close           = ip2_close,
-	.write           = ip2_write,
+	.write           = (void *) ip2_write,
 	.put_char        = ip2_putchar,
 	.flush_chars     = ip2_flush_chars,
 	.write_room      = ip2_write_room,
@@ -2001,7 +2000,6 @@
 static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	i2ChanStrPtr pCh = DevTable[tty->index];
-	wait_queue_t wait;
 
 	if (pCh == NULL)
 		return -ENODEV;
@@ -2018,6 +2016,8 @@
 		/\/\|=mhw=|\/\/			*/
 
 #ifdef	ENABLE_DSSNOW
+	wait_queue_t wait;
+
 	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);
 
 	init_waitqueue_entry(&wait, current);
