Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWAYTFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWAYTFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWAYTFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:05:00 -0500
Received: from ns1.coraid.com ([65.14.39.133]:10121 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1750902AbWAYTE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:04:59 -0500
Message-ID: <2e79ef7c147c1d99d483ae489e1c1ea5@coraid.com>
Date: Wed, 25 Jan 2006 13:54:44 -0500
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.15-git9a] aoe [1/1]: do not stop retransmit timer when device goes down
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a bugfix that follows and depends on the
eight aoe driver patches sent January 19th.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

When taking an AoE device down, keep the retransmit timer
going so that it re-appears properly when detected later.

diff -upr 2.6.15-git9a-orig/drivers/block/aoe/aoecmd.c 2.6.15-git9a-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.15-git9a-orig/drivers/block/aoe/aoecmd.c	2006-01-19 13:31:23.000000000 -0500
+++ 2.6.15-git9a-aoe/drivers/block/aoe/aoecmd.c	2006-01-25 13:49:07.000000000 -0500
@@ -331,7 +331,7 @@ rexmit_timer(ulong vp)
 	spin_lock_irqsave(&d->lock, flags);
 
 	if (d->flags & DEVFL_TKILL) {
-tdie:		spin_unlock_irqrestore(&d->lock, flags);
+		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
 	f = d->frames;
@@ -342,7 +342,7 @@ tdie:		spin_unlock_irqrestore(&d->lock, 
 			n /= HZ;
 			if (n > MAXWAIT) { /* waited too long.  device failure. */
 				aoedev_downdev(d);
-				goto tdie;
+				break;
 			}
 			rexmit(d, f);
 		}


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
