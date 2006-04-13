Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWDMTRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWDMTRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDMTRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:17:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29931 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751107AbWDMTRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:17:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Fix] swsusp: take lowmem reserves into account
Date: Thu, 13 Apr 2006 21:15:49 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604132115.49764.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp allocates memory from the normal zone, so it cannot use lowmem reserve
pages from the lower zones.  Therefore it should not count these pages as
available to it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/swsusp.c	2006-04-12 07:09:20.000000000 +0200
+++ linux-2.6.17-rc1-mm2/kernel/power/swsusp.c	2006-04-13 20:38:23.000000000 +0200
@@ -192,8 +192,10 @@ int swsusp_shrink_memory(void)
 			PAGES_FOR_IO;
 		tmp = size;
 		for_each_zone (zone)
-			if (!is_highmem(zone))
+			if (!is_highmem(zone) && populated_zone(zone)) {
 				tmp -= zone->free_pages;
+				tmp += zone->lowmem_reserve[ZONE_NORMAL];
+			}
 		if (tmp > 0) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			if (!tmp)
