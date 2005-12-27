Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVL0RIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVL0RIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVL0RIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:08:53 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:60859 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751121AbVL0RIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:08:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/3] mm: add a new function (needed for swap suspend)
Date: Tue, 27 Dec 2005 17:52:46 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200512271747.43374.rjw@sisk.pl>
In-Reply-To: <200512271747.43374.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512271752.47003.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the function get_swap_page_of_type() allowing us to
specify an index in swap_info[] and select a swap_info_struct
structure to be used for allocating a swap page.

This function (or another one of similar functionality) will be necessary for
implementing the image-writing part of swsusp in the user space.  It can also
be used for simplifying the current in-kernel implementation of the
image-writing part of swsusp.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/swap.h |    1 +
 mm/swapfile.c        |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

Index: linux-2.6.15-rc5-mm3/mm/swapfile.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/swapfile.c	2005-12-15 12:01:39.000000000 +0100
+++ linux-2.6.15-rc5-mm3/mm/swapfile.c	2005-12-15 19:00:45.000000000 +0100
@@ -211,6 +211,26 @@
 	return (swp_entry_t) {0};
 }
 
+swp_entry_t get_swap_page_of_type(int type)
+{
+	struct swap_info_struct *si;
+	pgoff_t offset;
+
+	spin_lock(&swap_lock);
+	si = swap_info + type;
+	if (si->flags & SWP_WRITEOK) {
+		nr_swap_pages--;
+		offset = scan_swap_map(si);
+		if (offset) {
+			spin_unlock(&swap_lock);
+			return swp_entry(type, offset);
+		}
+		nr_swap_pages++;
+	}
+	spin_unlock(&swap_lock);
+	return (swp_entry_t) {0};
+}
+
 static struct swap_info_struct * swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct * p;
Index: linux-2.6.15-rc5-mm3/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/swap.h	2005-12-15 12:03:26.000000000 +0100
+++ linux-2.6.15-rc5-mm3/include/linux/swap.h	2005-12-15 19:00:46.000000000 +0100
@@ -216,6 +216,7 @@
 extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(void);
+extern swp_entry_t get_swap_page_of_type(int type);
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);

