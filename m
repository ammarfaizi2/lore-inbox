Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUHALlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUHALlU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUHALlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:41:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:26554 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265823AbUHALks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:40:48 -0400
Date: Sun, 1 Aug 2004 13:45:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>
Subject: [PATCH] fix inlining errors in drivers/scsi/aic7xxx/aic79xx_osm.c
Message-ID: <Pine.LNX.4.60.0408011338560.2535@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the following build error (in 2.6.8-rc2-mm1) when using 
gcc 3.4.0

drivers/scsi/aic7xxx/aic79xx_osm.c: In function `ahd_linux_dv_transition':
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3070: sorry, unimplemented: called from here
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3093: sorry, unimplemented: called from here
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3144: sorry, unimplemented: called from here
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3257: sorry, unimplemented: called from here
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3288: sorry, unimplemented: called from here
drivers/scsi/aic7xxx/aic79xx_osm.c:522: sorry, unimplemented: inlining failed in call to 'ahd_linux_dv_fallback': function body not available
drivers/scsi/aic7xxx/aic79xx_osm.c:3317: sorry, unimplemented: called from here

It first removes a duplicate forward declaration of ahd_linux_dv_fallback 
and then moves the function before its first use so inlining can succeed.

Patch is against 2.6.8-rc2-mm1

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.8-rc2-mm1-orig/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.8-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.8-rc2-mm1-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-16 07:19:36.000000000 +0200
+++ linux-2.6.8-rc2-mm1/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-07-31 22:40:57.000000000 +0200
@@ -513,9 +513,6 @@ static void ahd_linux_dv_su(struct ahd_s
 			    struct scsi_cmnd *cmd,
 			    struct ahd_devinfo *devinfo,
 			    struct ahd_linux_target *targ);
-static __inline int
-	   ahd_linux_dv_fallback(struct ahd_softc *ahd,
-				 struct ahd_devinfo *devinfo);
 static int ahd_linux_fallback(struct ahd_softc *ahd,
 			      struct ahd_devinfo *devinfo);
 static __inline int ahd_linux_dv_fallback(struct ahd_softc *ahd,
@@ -2915,6 +2912,19 @@ out:
 	ahd_unlock(ahd, &s);
 }
 
+static __inline int
+ahd_linux_dv_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
+{
+	u_long s;
+	int retval;
+
+	ahd_lock(ahd, &s);
+	retval = ahd_linux_fallback(ahd, devinfo);
+	ahd_unlock(ahd, &s);
+
+	return (retval);
+}
+
 static void
 ahd_linux_dv_transition(struct ahd_softc *ahd, struct scsi_cmnd *cmd,
 			struct ahd_devinfo *devinfo,
@@ -3551,19 +3561,6 @@ ahd_linux_dv_su(struct ahd_softc *ahd, s
 	cmd->cmnd[4] = le | SSS_START;
 }
 
-static __inline int
-ahd_linux_dv_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
-{
-	u_long s;
-	int retval;
-
-	ahd_lock(ahd, &s);
-	retval = ahd_linux_fallback(ahd, devinfo);
-	ahd_unlock(ahd, &s);
-
-	return (retval);
-}
-
 static int
 ahd_linux_fallback(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 {


Please CC me on replies from linux-scsi since I'm not subscribed to that 
list - not nessesary if linux-kernel is kept in the CC since I am 
subscribed there.

--
Jesper Juhl <juhl-lkml@dif.dk>

