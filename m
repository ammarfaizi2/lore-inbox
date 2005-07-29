Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVG2Ufo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVG2Ufo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVG2UdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:33:23 -0400
Received: from graphe.net ([209.204.138.32]:10454 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262788AbVG2UcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:32:04 -0400
Date: Fri, 29 Jul 2005 13:32:01 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Task notifier against mm: Allow notifier to remove itself
Message-ID: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for Pavel against 2.6.13-rc3-mm3 (after removal of the TIF_FREEZE 
patch). The same patch was posted yesterday against 2.6.13-rc3. I verified
again that this patch works fine on i386.

---

Allow notifier to remove itself.
This is done by retrieving the pointer to the next notifier from the list before the
notifier call. 

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3-mm3/kernel/sys.c
===================================================================
--- linux-2.6.13-rc3-mm3.orig/kernel/sys.c	2005-07-29 10:38:39.000000000 -0700
+++ linux-2.6.13-rc3-mm3/kernel/sys.c	2005-07-29 12:29:18.000000000 -0700
@@ -172,15 +172,18 @@
 {
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
+	struct notifier_block *next;
 
 	while(nb)
 	{
-		ret=nb->notifier_call(nb,val,v);
+		/* Determining next here allows the notifier to unregister itself */
+		next = nb->next;
+		ret = nb->notifier_call(nb,val,v);
 		if(ret&NOTIFY_STOP_MASK)
 		{
 			return ret;
 		}
-		nb=nb->next;
+		nb = next;
 	}
 	return ret;
 }
