Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUDSIER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUDSIER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:04:17 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:17366 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264238AbUDSIEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:04:15 -0400
Date: Mon, 19 Apr 2004 10:04:13 +0200
From: Romain Lievin <lkml@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah <greg@kroah.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] tipar char driver: wrong timeout value
Message-ID: <20040419080413.GA13695@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch (2.4 & 2.6) fixes a bug about the timeout value. The formula 
used to calculate jiffies from timeout is wrong.
The new formula is ok and takes care of integer computation/rounding.
There is the same bug in the tiglusb.c module which will be fixed by another
patch.

Please apply, Romain.
==============================[cut here]================================
diff -Naur linux-2.4.26.orig/drivers/char/tipar.c linux-2.4.26/drivers/char/tipar.c
--- linux-2.4.26.orig/drivers/char/tipar.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.26/drivers/char/tipar.c	2004-04-19 09:22:36.000000000 +0200
@@ -124,7 +124,7 @@
 
 /* ----- global defines ----------------------------------------------- */
 
-#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define START(x) { x = jiffies + (HZ * timeout) / 10; }
 #define WAIT(x)  { \
   if (time_before((x), jiffies)) return -1; \
   if (need_resched()) schedule(); }

==============================[cut here]================================
diff -Naur linux-2.6.5.orig/drivers/char/tipar.c linux-2.6.5/drivers/char/tipar.c
--- linux-2.6.5.orig/drivers/char/tipar.c	2004-04-04 05:37:37.000000000 +0200
+++ linux-2.6.5/drivers/char/tipar.c	2004-04-19 09:23:25.000000000 +0200
@@ -121,7 +121,7 @@
 
 /* ----- global defines ----------------------------------------------- */
 
-#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define START(x) { x = jiffies + (HZ * timeout) / 10; }
 #define WAIT(x)  { \
   if (time_before((x), jiffies)) return -1; \
   if (need_resched()) schedule(); }

==============================[cut here]================================
-- 
Romain Liévin (roms):         <lkml@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






