Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132106AbRAKSwd>; Thu, 11 Jan 2001 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132495AbRAKSwZ>; Thu, 11 Jan 2001 13:52:25 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:3332 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S132106AbRAKSwN>;
	Thu, 11 Jan 2001 13:52:13 -0500
Date: Thu, 11 Jan 2001 19:50:30 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: torvalds@transmeta.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ATM breakage introduced in 2.4.0
Message-ID: <20010111195030.A4961@sith.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-ac6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
2.4.0 introduced serious breakage to LANE. It's impossible to do
ifdown lec? ; ifup lec? because memory allocated by lec? is freed but
unregister_netdev() is not called, so SIOCGIFFLAGS tells me ok, but 
SIOCSIFFLAGS tells me -ENODEV. No, rmmod lec ; insmod lec does not help.
Patch follows

--- linux/net/atm/lec.c.orig	Thu Jan 11 19:40:50 2001
+++ linux/net/atm/lec.c	Thu Jan 11 19:42:20 2001
@@ -858,8 +858,11 @@
                 if (dev_lec[i] != NULL) {
                         priv = (struct lec_priv *)dev_lec[i]->priv;
 #if defined(CONFIG_TR)
-                        unregister_trdev(dev_lec[i]);
+                	if (priv->is_trdev)
+                        	unregister_trdev(dev_lec[i]);
+                	else
 #endif
+                        unregister_netdev(dev_lec[i]);
                         kfree(dev_lec[i]);
                         dev_lec[i] = NULL;
                 }

And it would be nice if I was able to build Fore 200e driver in 2.4.1 ;)

--- linux/drivers/atm/Makefile.orig	Tue Jan  2 10:18:25 2001
+++ linux/drivers/atm/Makefile	Tue Jan  2 12:00:05 2001
@@ -46,7 +46,7 @@
   endif
 endif
 
-obj-$(CONFIG_ATM_FORE200E) += fore200e.o $(FORE200E_FW_OBJS)
+obj-$(CONFIG_ATM_FORE200E) += fore_200e.o
 
 include $(TOPDIR)/Rules.make

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
