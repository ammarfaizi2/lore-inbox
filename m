Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWF0ATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWF0ATy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWF0ATy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:19:54 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:60368 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S1030248AbWF0ATx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:19:53 -0400
Date: Mon, 26 Jun 2006 20:19:51 -0400
From: Sonny Rao <sonny@burdell.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: a.zummo@towertech.it
Subject: [PATCH] fix idr locking in rtc class
Message-ID: <20060627001951.GA24726@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to serialize access to the global rtc_idr even in this error path.

Signed-off-by: Sonny Rao <sonny@burdell.org>

--- linux-2.6.17/drivers/rtc/class.c~orig	2006-06-26 19:10:44.738511816 -0500
+++ linux-2.6.17/drivers/rtc/class.c	2006-06-26 19:12:22.008724496 -0500
@@ -93,7 +93,9 @@ exit_kfree:
 	kfree(rtc);
 
 exit_idr:
+	mutex_lock(&idr_lock);
 	idr_remove(&rtc_idr, id);
+	mutex_unlock(&idr_lock);
 
 exit:
 	dev_err(dev, "rtc core: unable to register %s, err = %d\n",
