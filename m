Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLDXAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLDXAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLDXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:00:53 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:51625 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932365AbVLDXAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:00:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2][Fix][mm] swsusp: fix counting of highmem pages
Date: Sun, 4 Dec 2005 23:49:13 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512042346.11731.rjw@sisk.pl>
In-Reply-To: <200512042346.11731.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042349.13588.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with swsusp that causes suspend to
fail on systems with the highmem zone, if many highmem pages are in use.

The patch makes swsusp count the non-free highmem pages in a correct way
and, consequently, release a sufficient amount of memory before suspend.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/swsusp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-04 14:24:10.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-04 14:42:08.000000000 +0100
@@ -635,7 +635,8 @@
 	printk("Shrinking memory...  ");
 	do {
 #ifdef FAST_FREE
-		tmp = count_data_pages() + count_highmem_pages();
+		tmp = 2 * count_highmem_pages();
+		tmp += tmp / 50 + count_data_pages();
 		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
 		for_each_zone (zone)

