Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVG1Tzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVG1Tzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVG1Tzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:55:40 -0400
Received: from graphe.net ([209.204.138.32]:64691 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261437AbVG1Ty1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:54:27 -0400
Date: Thu, 28 Jul 2005 12:54:24 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Task notifier: Allow the removal of a notifier from the
 notifier handler
In-Reply-To: <20050728193433.GA1856@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507281251040.12675@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a notifier to remove itself from the notifier list.

This is done by retrieving the pointer to the next notifier from the list before the
notifier call. If a notifier removes itself in the current kernel then the 
pointer to the current notifier is invalid and notifier_call_chain 
will fail.

Signed-off-by: Christoph Lameter <christoph@lameter.com>

Index: linux-2.6.13-rc3/kernel/sys.c
===================================================================
--- linux-2.6.13-rc3.orig/kernel/sys.c	2005-07-12 21:46:46.000000000 -0700
+++ linux-2.6.13-rc3/kernel/sys.c	2005-07-28 11:26:00.000000000 -0700
@@ -171,15 +171,18 @@
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
