Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161618AbWAMBEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161618AbWAMBEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161623AbWAMBEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:04:42 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:59355 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161618AbWAMBEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:04:42 -0500
Date: Thu, 12 Jan 2006 20:02:00 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] kobject: don't oops on null kobject.name
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601122004_MC3-1-B5C5-4B72@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_get_path() will oops if one of the component names is
NULL.  Fix that by returning NULL instead of oopsing.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

Helge, this fixes your "2.6.15 OOPS while trying to mount cdrom".

Probably not the best fix, but It Works For Me (TM).

--- 2.6.15a.orig/lib/kobject.c
+++ 2.6.15a/lib/kobject.c
@@ -72,6 +72,8 @@ static int get_kobj_path_length(struct k
 	 * Add 1 to strlen for leading '/' of each level.
 	 */
 	do {
+		if (kobject_name(parent) == NULL)
+			return 0;
 		length += strlen(kobject_name(parent)) + 1;
 		parent = parent->parent;
 	} while (parent);
@@ -107,6 +109,8 @@ char *kobject_get_path(struct kobject *k
 	int len;
 
 	len = get_kobj_path_length(kobj);
+	if (len == 0)
+		return NULL;
 	path = kmalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
