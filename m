Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbREBHe1>; Wed, 2 May 2001 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREBHeR>; Wed, 2 May 2001 03:34:17 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:4508 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S130446AbREBHeL>; Wed, 2 May 2001 03:34:11 -0400
Date: Wed, 2 May 2001 00:33:59 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Patch: softdog and WDIOS_DISABLECARD
Message-ID: <20010502003359.A20841@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found a potential problem with the current
implementation of the software watchdog.  I have
CONFIG_WATCHDOG_NOWAYOUT set for a reliable watchdog. 
However, there are instances where I want to explicitly
shut it down.  The problem with disabling
CONFIG_WATCHDOG_NOWAYOUT is that events other than an
explicit shutdown can disable the timer.  A SIGSEGV
perhaps or the daemon being killed by the OOM handler.  In
cases like this, the system should reboot IMO.

This small patch adds the appropriate options to enable and
disable the timer explicitly.

--- softdog.c.orig	Wed May  2 00:15:56 2001
+++ softdog.c	Wed May  2 00:15:19 2001
@@ -130,6 +130,7 @@
 	static struct watchdog_info ident = {
 		identity: "Software Watchdog",
 	};
+	int rv;
 	switch (cmd) {
 		default:
 			return -ENOIOCTLCMD;
@@ -140,6 +141,25 @@
 		case WDIOC_GETSTATUS:
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0,(int *)arg);
+		case WDIOC_SETOPTIONS:
+			if(copy_from_user(&rv, (int*) arg, sizeof(int)))
+				return -EFAULT;
+
+			if (rv & WDIOS_DISABLECARD) {
+				lock_kernel();
+				del_timer(&watchdog_ticktock);
+				unlock_kernel();
+			return 0;
+			}
+
+			if (rv & WDIOS_ENABLECARD) {
+				lock_kernel();
+				mod_timer(&watchdog_ticktock, jiffies +
+				   (soft_margin * HZ));
+				unlock_kernel();
+				return 0;
+			}
+
 		case WDIOC_KEEPALIVE:
 			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
 			return 0;

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
