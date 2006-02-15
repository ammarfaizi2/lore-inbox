Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWBOOlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWBOOlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBOOlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:41:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:33408 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932456AbWBOOlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:41:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/2] swsusp: userland interface fixes
Date: Wed, 15 Feb 2006 14:45:09 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200602151434.03575.rjw@sisk.pl>
In-Reply-To: <200602151434.03575.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151445.10395.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two bugs in the swsusp userland interface:

1) Prevent the SNAPSHOT_FREE_SWAP_PAGES ioctl from leaking swap pages
due to the wrong condition.

2) Pevent snapshot_write_next() and snapshot_read_next() from using a freed
page (this could happend if the snapshot ioctls were called repeatedly
without closing the device, eg. when attempting to create the image for the
second time with image_size = 0).


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    5 ++---
 kernel/power/user.c     |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc3-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/user.c	2006-02-14 22:37:24.000000000 +0100
+++ linux-2.6.16-rc3-mm1/kernel/power/user.c	2006-02-14 22:38:07.000000000 +0100
@@ -237,7 +237,7 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_FREE_SWAP_PAGES:
-		if (data->swap >= 0 && data->swap < MAX_SWAPFILES) {
+		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
 			error = -ENODEV;
 			break;
 		}
Index: linux-2.6.16-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.16-rc3-mm1.orig/kernel/power/snapshot.c	2006-02-14 22:46:17.000000000 +0100
+++ linux-2.6.16-rc3-mm1/kernel/power/snapshot.c	2006-02-14 22:47:02.000000000 +0100
@@ -37,6 +37,7 @@
 struct pbe *pagedir_nosave;
 static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
+static unsigned long *buffer;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
@@ -421,6 +422,7 @@ void swsusp_free(void)
 	nr_copy_pages = 0;
 	nr_meta_pages = 0;
 	pagedir_nosave = NULL;
+	buffer = NULL;
 }
 
 
@@ -573,8 +575,6 @@ static inline struct pbe *pack_orig_addr
 
 int snapshot_read_next(struct snapshot_handle *handle, size_t count)
 {
-	static unsigned long *buffer;
-
 	if (handle->page > nr_meta_pages + nr_copy_pages)
 		return 0;
 	if (!buffer) {
@@ -779,7 +779,6 @@ static int create_image(struct snapshot_
 
 int snapshot_write_next(struct snapshot_handle *handle, size_t count)
 {
-	static unsigned long *buffer;
 	int error = 0;
 
 	if (handle->prev && handle->page > nr_meta_pages + nr_copy_pages)

