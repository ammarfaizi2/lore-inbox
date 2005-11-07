Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVKGVDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVKGVDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVKGVCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:02:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932360AbVKGVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:02:42 -0500
Date: Mon, 7 Nov 2005 15:02:49 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dlm: cleanup unused functions
Message-ID: <20051107210249.GC4287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused functions and make others static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: David Teigland <teigland@redhat.com>

----

diff -urN a/drivers/dlm/device.c b/drivers/dlm/device.c
--- a/drivers/dlm/device.c	2005-11-07 14:35:14.622152250 -0600
+++ b/drivers/dlm/device.c	2005-11-07 14:35:23.202841071 -0600
@@ -39,7 +39,6 @@
 #include <linux/dlm_device.h>
 
 #include "lvb_table.h"
-#include "device.h"
 
 static struct file_operations _dlm_fops;
 static const char *name_prefix="dlm";
@@ -1032,26 +1031,6 @@
 		return status;
 }
 
-/* Called when the cluster is shutdown uncleanly, all lockspaces
-   have been summarily removed */
-void dlm_device_free_devices()
-{
-	struct user_ls *tmp;
-	struct user_ls *lsinfo;
-
-	down(&user_ls_lock);
-	list_for_each_entry_safe(lsinfo, tmp, &user_ls_list, ls_list) {
-		misc_deregister(&lsinfo->ls_miscinfo);
-
-		/* Tidy up, but don't delete the lsinfo struct until
-		   all the users have closed their devices */
-		list_del(&lsinfo->ls_list);
-		set_bit(LS_FLAG_DELETED, &lsinfo->ls_flags);
-		lsinfo->ls_lockspace = NULL;
-	}
-	up(&user_ls_lock);
-}
-
 static struct file_operations _dlm_fops = {
       .open    = dlm_open,
       .release = dlm_close,
@@ -1071,7 +1050,7 @@
 /*
  * Create control device
  */
-int __init dlm_device_init(void)
+static int __init dlm_device_init(void)
 {
 	int r;
 
@@ -1092,7 +1071,7 @@
 	return 0;
 }
 
-void __exit dlm_device_exit(void)
+static void __exit dlm_device_exit(void)
 {
 	misc_deregister(&ctl_device);
 }
diff -urN a/drivers/dlm/device.h b/drivers/dlm/device.h
--- a/drivers/dlm/device.h	2005-11-07 14:35:14.623152097 -0600
+++ b/drivers/dlm/device.h	1969-12-31 17:00:00.000000000 -0700
@@ -1,21 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
-**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-#ifndef __DEVICE_DOT_H__
-#define __DEVICE_DOT_H__
-
-extern void dlm_device_free_devices(void);
-extern int dlm_device_init(void);
-extern void dlm_device_exit(void);
-#endif				/* __DEVICE_DOT_H__ */
-
diff -urN a/drivers/dlm/lock.c b/drivers/dlm/lock.c
--- a/drivers/dlm/lock.c	2005-11-07 14:35:14.625151792 -0600
+++ b/drivers/dlm/lock.c	2005-11-07 14:35:23.206840460 -0600
@@ -152,7 +152,7 @@
         {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
 };
 
-void dlm_print_lkb(struct dlm_lkb *lkb)
+static void dlm_print_lkb(struct dlm_lkb *lkb)
 {
 	printk(KERN_ERR "lkb: nodeid %d id %x remid %x exflags %x flags %x\n"
 	       "     status %d rqmode %d grmode %d wait_type %d ast_type %d\n",
@@ -751,11 +751,6 @@
 	return error;
 }
 
-int dlm_remove_from_waiters(struct dlm_lkb *lkb)
-{
-	return remove_from_waiters(lkb);
-}
-
 static void dir_remove(struct dlm_rsb *r)
 {
 	int to_nodeid;
diff -urN a/drivers/dlm/lock.h b/drivers/dlm/lock.h
--- a/drivers/dlm/lock.h	2005-11-07 14:35:14.626151639 -0600
+++ b/drivers/dlm/lock.h	2005-11-07 14:35:23.206840460 -0600
@@ -13,7 +13,6 @@
 #ifndef __LOCK_DOT_H__
 #define __LOCK_DOT_H__
 
-void dlm_print_lkb(struct dlm_lkb *lkb);
 void dlm_print_rsb(struct dlm_rsb *r);
 int dlm_receive_message(struct dlm_header *hd, int nodeid, int recovery);
 int dlm_modes_compat(int mode1, int mode2);
@@ -22,7 +21,6 @@
 void dlm_put_rsb(struct dlm_rsb *r);
 void dlm_hold_rsb(struct dlm_rsb *r);
 int dlm_put_lkb(struct dlm_lkb *lkb);
-int dlm_remove_from_waiters(struct dlm_lkb *lkb);
 void dlm_scan_rsbs(struct dlm_ls *ls);
 
 int dlm_purge_locks(struct dlm_ls *ls);
diff -urN a/drivers/dlm/lockspace.c b/drivers/dlm/lockspace.c
--- a/drivers/dlm/lockspace.c	2005-11-07 14:35:14.626151639 -0600
+++ b/drivers/dlm/lockspace.c	2005-11-07 14:36:46.047181974 -0600
@@ -222,7 +222,7 @@
 	kthread_stop(scand_task);
 }
 
-static struct dlm_ls *find_lockspace_name(char *name, int namelen)
+static struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen)
 {
 	struct dlm_ls *ls;
 
@@ -239,11 +239,6 @@
 	return ls;
 }
 
-struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen)
-{
-	return find_lockspace_name(name, namelen);
-}
-
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
 	struct dlm_ls *ls;
@@ -349,7 +344,7 @@
 	if (!try_module_get(THIS_MODULE))
 		return -EINVAL;
 
-	ls = find_lockspace_name(name, namelen);
+	ls = dlm_find_lockspace_name(name, namelen);
 	if (ls) {
 		*lockspace = ls;
 		module_put(THIS_MODULE);
diff -urN a/drivers/dlm/lockspace.h b/drivers/dlm/lockspace.h
--- a/drivers/dlm/lockspace.h	2005-11-07 14:35:14.627151486 -0600
+++ b/drivers/dlm/lockspace.h	2005-11-07 14:35:23.208840154 -0600
@@ -18,7 +18,6 @@
 void dlm_lockspace_exit(void);
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
 struct dlm_ls *dlm_find_lockspace_local(void *id);
-struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen);
 void dlm_put_lockspace(struct dlm_ls *ls);
 
 #endif				/* __LOCKSPACE_DOT_H__ */
