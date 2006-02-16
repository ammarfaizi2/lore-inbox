Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWBPPE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWBPPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWBPPE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:04:26 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:45703 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932538AbWBPPEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:04:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/1] swsusp: fix breakage with swap on LVM
Date: Thu, 16 Feb 2006 16:05:25 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200602161558.57702.rjw@sisk.pl>
In-Reply-To: <200602161558.57702.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602161605.25686.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the compatibility with the older code and make it possible to
suspend if the kernel command line doesn't contain the "resume="
argument.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/swap.h |    1 +
 kernel/power/swap.c  |    3 ++-
 mm/swapfile.c        |   17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc3-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc3-mm1.orig/include/linux/swap.h
+++ linux-2.6.16-rc3-mm1/include/linux/swap.h
@@ -246,6 +246,7 @@ extern int valid_swaphandles(swp_entry_t
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
 extern int swap_type_of(dev_t);
+extern int find_swap(void);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
Index: linux-2.6.16-rc3-mm1/kernel/power/swap.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/swap.c
+++ linux-2.6.16-rc3-mm1/kernel/power/swap.c
@@ -75,8 +75,9 @@ static int mark_swapfiles(swp_entry_t st
 
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
-	int res = swap_type_of(swsusp_resume_device);
+	int res;
 
+	res = swsusp_resume_device ? swap_type_of(swsusp_resume_device) : find_swap();
 	if (res >= 0) {
 		root_swap = res;
 		return 0;
Index: linux-2.6.16-rc3-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/mm/swapfile.c
+++ linux-2.6.16-rc3-mm1/mm/swapfile.c
@@ -448,6 +448,23 @@ int swap_type_of(dev_t device)
 }
 
 /*
+ * Find first writeable swap.
+ *
+ * This is needed for software suspend in case the resume device is not
+ * specified in the kernel command line
+ */
+int find_swap(void)
+{
+	int i = 0;
+
+	spin_lock(&swap_lock);
+	while (i < nr_swapfiles && !(swap_info[i].flags & SWP_WRITEOK))
+		i++;
+	spin_unlock(&swap_lock);
+	return i < nr_swapfiles ? i : -ENODEV;
+}
+
+/*
  * Return either the total number of swap pages of given type, or the number
  * of free pages of that type (depending on @free)
  *
