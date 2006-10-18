Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWJRUQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWJRUQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWJRUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37866 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422844AbWJRUJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:38 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/15] aoe: module parameter for device timeout
Date: Wed, 18 Oct 2006 13:09:01 -0700
Message-Id: <1161202179462-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021753859-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

The aoe_deadsecs module parameter sets the number of seconds that
elapse before a nonresponsive AoE device is marked as dead.

This is runtime settable in sysfs or settable with a module load or
kernel boot parameter.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoecmd.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 9ebc98a..f2b8f55 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -15,7 +15,10 @@ #include "aoe.h"
 #define TIMERTICK (HZ / 10)
 #define MINTIMER (2 * TIMERTICK)
 #define MAXTIMER (HZ << 1)
-#define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
+
+static int aoe_deadsecs = 60 * 3;
+module_param(aoe_deadsecs, int, 0644);
+MODULE_PARM_DESC(aoe_deadsecs, "After aoe_deadsecs seconds, give up and fail dev.");
 
 struct sk_buff *
 new_skb(ulong len)
@@ -373,7 +376,7 @@ rexmit_timer(ulong vp)
 		if (f->tag != FREETAG && tsince(f->tag) >= timeout) {
 			n = f->waited += timeout;
 			n /= HZ;
-			if (n > MAXWAIT) { /* waited too long.  device failure. */
+			if (n > aoe_deadsecs) { /* waited too long for response */
 				aoedev_downdev(d);
 				break;
 			}
-- 
1.4.2.4

