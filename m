Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLDXA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLDXA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLDXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:00:54 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52905 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932368AbVLDXAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:00:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2][Fix][mm] swsusp: fix enough_free_mem
Date: Mon, 5 Dec 2005 00:00:35 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512042346.11731.rjw@sisk.pl>
In-Reply-To: <200512042346.11731.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512050000.35842.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with the function enough_free_mem() used by
swsusp to verify if there is a sufficient number of memory pages available to
it to create and save the suspend image.

Namely, enough_free_mem() uses nr_free_pages() to obtain the number
of free memory pages, which is incorrect, because this function returns the
total number of free pages, including free highmem pages, and the highmem
pages cannot be used by swsusp for storing the image data.

The patch makes enough_free_mem() avoid counting the free highmem
pages as available to swsusp.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/snapshot.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-04 14:24:10.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-04 14:38:58.000000000 +0100
@@ -437,8 +437,14 @@
 
 static int enough_free_mem(unsigned int nr_pages)
 {
-	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
-	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
+	struct zone *zone;
+	unsigned int n = 0;
+
+	for_each_zone (zone)
+		if (!is_highmem(zone))
+			n += zone->free_pages;
+	pr_debug("swsusp: available memory: %u pages\n", n);
+	return n > (nr_pages + PAGES_FOR_IO +
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
