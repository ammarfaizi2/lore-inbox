Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263326AbTIWMvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTIWMvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:51:04 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:42954 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263326AbTIWMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:50:59 -0400
Message-Id: <200309231250.h8NCopkT023939@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
Cc: Remi Colinet <remi.colinet@wanadoo.fr>, linux-kernel@vger.kernel.org
Reply-To: chas3@users.sourceforge.net
Subject: Re: [Patch] Compile fix for 2.6.0-test5-mm4 in net/atm/proc.c 
In-Reply-To: Message from Remi Colinet <remi.colinet@wanadoo.fr> 
   of "Mon, 22 Sep 2003 21:51:10 +0200." <3F6F52AE.3080206@wanadoo.fr> 
Date: Tue, 23 Sep 2003 08:50:52 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-2.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F6F52AE.3080206@wanadoo.fr>,Remi Colinet writes:
>
>        state->family = family;
>+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
>        state->clip_info = try_atm_clip_ops();
>+#endif
>

instead of doing this, it would probably be cleaner to put the
ifdef inside the clip header file and just return 0 when !CLIP.

dave, can you apply this to 2.6?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1446  -> 1.1447 
#	      net/atm/proc.c	1.29    -> 1.30   
#	include/net/atmclip.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/23	chas@relax.cmf.nrl.navy.mil	1.1447
# [ATM]: if !CLIP try_atm_clip_ops() should always fail
# --------------------------------------------
#
diff -Nru a/include/net/atmclip.h b/include/net/atmclip.h
--- a/include/net/atmclip.h	Tue Sep 23 08:48:18 2003
+++ b/include/net/atmclip.h	Tue Sep 23 08:48:18 2003
@@ -67,7 +67,15 @@
 };
 
 void atm_clip_ops_set(struct atm_clip_ops *);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 int try_atm_clip_ops(void);
+#else
+static inline int try_atm_clip_ops(void)
+{
+	return 0;
+}
+#endif
+
 
 extern struct neigh_table *clip_tbl_hook;
 extern struct atm_clip_ops *atm_clip_ops;
diff -Nru a/net/atm/proc.c b/net/atm/proc.c
--- a/net/atm/proc.c	Tue Sep 23 08:48:18 2003
+++ b/net/atm/proc.c	Tue Sep 23 08:48:18 2003
@@ -32,10 +32,8 @@
 #include "common.h" /* atm_proc_init prototype */
 #include "signaling.h" /* to get sigd - ugly too */
 
-#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 #include <net/atmclip.h>
 #include "ipcommon.h"
-#endif
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 #include "lec.h"
