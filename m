Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTEGXDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTEGXD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:64900 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264288AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349387730@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493861009@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1099, 2003/05/07 14:59:42-07:00, hannal@us.ibm.com

[PATCH] rio  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/rio/rio_linux.c |   26 +-------------------------
 drivers/char/rio/rio_linux.h |    3 ---
 drivers/char/rio/riotty.c    |    5 -----
 3 files changed, 1 insertion(+), 33 deletions(-)


diff -Nru a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
--- a/drivers/char/rio/rio_linux.c	Wed May  7 16:01:14 2003
+++ b/drivers/char/rio/rio_linux.c	Wed May  7 16:01:14 2003
@@ -389,29 +389,6 @@
   udelay (usecs);
 }
 
-
-void rio_inc_mod_count (void)
-{
-#ifdef MODULE
-  func_enter ();
-  rio_dprintk (RIO_DEBUG_MOD_COUNT, "rio_inc_mod_count\n");
-  MOD_INC_USE_COUNT; 
-  func_exit ();
-#endif
-}
-
-
-void rio_dec_mod_count (void)
-{
-#ifdef MODULE
-  func_enter ();
-  rio_dprintk (RIO_DEBUG_MOD_COUNT, "rio_dec_mod_count\n");
-  MOD_DEC_USE_COUNT; 
-  func_exit ();
-#endif
-}
-
-
 static int rio_set_real_termios (void *ptr)
 {
   int rv, modem;
@@ -660,7 +637,6 @@
   
   PortP = (struct Port *)ptr;
   PortP->gs.tty = NULL;
-  rio_dec_mod_count (); 
 
   func_exit ();
 }
@@ -686,7 +662,6 @@
   }                
 
   PortP->gs.tty = NULL;
-  rio_dec_mod_count ();
   func_exit ();
 }
 
@@ -908,6 +883,7 @@
 
   memset(&rio_driver, 0, sizeof(rio_driver));
   rio_driver.magic = TTY_DRIVER_MAGIC;
+  rio_driver.owner = THIS_MODULE;
   rio_driver.driver_name = "specialix_rio";
   rio_driver.name = "ttySR";
   rio_driver.major = RIO_NORMAL_MAJOR0;
diff -Nru a/drivers/char/rio/rio_linux.h b/drivers/char/rio/rio_linux.h
--- a/drivers/char/rio/rio_linux.h	Wed May  7 16:01:14 2003
+++ b/drivers/char/rio/rio_linux.h	Wed May  7 16:01:14 2003
@@ -87,9 +87,6 @@
 #endif
 
 
-void rio_dec_mod_count (void);
-void rio_inc_mod_count (void);
-
 /* Allow us to debug "in the field" without requiring clients to
    recompile.... */
 #if 1
diff -Nru a/drivers/char/rio/riotty.c b/drivers/char/rio/riotty.c
--- a/drivers/char/rio/riotty.c	Wed May  7 16:01:14 2003
+++ b/drivers/char/rio/riotty.c	Wed May  7 16:01:14 2003
@@ -139,7 +139,6 @@
 
 
 extern struct rio_info *p;
-extern void rio_inc_mod_count (void);
 
 
 int
@@ -205,8 +204,6 @@
 	tty->driver_data = PortP;
 
 	PortP->gs.tty = tty;
-	if (!PortP->gs.count)
-		rio_inc_mod_count ();
 	PortP->gs.count++;
 
 	rio_dprintk (RIO_DEBUG_TTY, "%d bytes in tx buffer\n",
@@ -215,8 +212,6 @@
 	retval = gs_init_port (&PortP->gs);
 	if (retval) {
 		PortP->gs.count--;
-		if (PortP->gs.count)
-			rio_dec_mod_count ();
 		return -ENXIO;
 	}
 	/*

