Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVC1Rq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVC1Rq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVC1RqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:46:20 -0500
Received: from webmail.topspin.com ([12.162.17.3]:28019 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261974AbVC1RmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:42:12 -0500
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce <linux/debugfs.h> dependencies
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Mon, 28 Mar 2005 09:16:58 -0800
Message-ID: <52ll87y9kl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Mar 2005 17:16:58.0289 (UTC) FILETIME=[F2A67A10:01C533B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current <linux/debugfs.h> include file is a little fragile in that
it is not self-contained and hence may cause compile warnings or
errors depending on the files included before it, the kernel config
and the architecture.  This patch makes things a little more robust by:

 - including <linux/types.h> to get definitions of u32, mode_t, and so on.
 - forward declaring struct file_operations.
 - including <linux/err.h> when CONFIG_DEBUG_FS is not set

The last change is particularly useful, as a kernel developer is
likely to build with debugfs always enabled and never see the build
breakage cased if debugfs is disabled.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-export/include/linux/debugfs.h
===================================================================
--- linux-export.orig/include/linux/debugfs.h	2005-01-10 11:48:00.000000000 -0800
+++ linux-export/include/linux/debugfs.h	2005-03-28 09:08:40.982161696 -0800
@@ -15,6 +15,10 @@
 #ifndef _DEBUGFS_H_
 #define _DEBUGFS_H_
 
+#include <linux/types.h>
+
+struct file_operations;
+
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
@@ -34,6 +38,9 @@
 				  struct dentry *parent, u32 *value);
 
 #else
+
+#include <linux/err.h>
+
 /* 
  * We do not return NULL from these functions if CONFIG_DEBUG_FS is not enabled
  * so users have a chance to detect if there was a real error or not.  We don't
