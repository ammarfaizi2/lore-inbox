Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVD0OP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVD0OP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVD0OP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:15:28 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:24532 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261612AbVD0OPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:15:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 27 Apr 2005 16:10:51 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>,
       dvb list <linux-dvb@linuxtv.org>
Subject: [patch 1/2] cx88-dvb oops fix
Message-ID: <20050427141050.GA15017@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup error path, without that one the driver kills the machine by
oopsing in the IRQ handler in case the frontend initialization fails.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/cx88/cx88-dvb.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.12-rc3/drivers/media/video/cx88/cx88-dvb.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/cx88/cx88-dvb.c	2005-04-27 14:40:38.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/cx88/cx88-dvb.c	2005-04-27 15:19:38.000000000 +0200
@@ -243,10 +243,8 @@ static int dvb_register(struct cx8802_de
 		break;
 #endif
 	default:
-		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n"
-		       "%s: you might want to look out for patches here:\n"
-		       "%s:     http://dl.bytesex.org/patches/\n",
-		       dev->core->name, dev->core->name, dev->core->name);
+		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n",
+		       dev->core->name);
 		break;
 	}
 	if (NULL == dev->dvb.frontend) {
@@ -308,9 +306,11 @@ static int __devinit dvb_probe(struct pc
 			    dev);
 	err = dvb_register(dev);
 	if (0 != err)
-		goto fail_free;
+		goto fail_fini;
 	return 0;
 
+ fail_fini:
+	cx8802_fini_common(dev);
  fail_free:
 	kfree(dev);
  fail_core:

-- 
#define printk(args...) fprintf(stderr, ## args)
