Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEZAYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEZAYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 20:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVEZAYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 20:24:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:61358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261622AbVEZAYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 20:24:25 -0400
Date: Wed, 25 May 2005 17:25:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice.Goglin@ens-lyon.org
Cc: Brice.Goglin@ens-lyon.fr, alexandre.buisse@ens-lyon.fr,
       linux-kernel@vger.kernel.org, pcaulfie@redhat.com, teigland@redhat.com
Subject: Re: dlm-lockspaces-callbacks-directory-fix.patch added to -mm tree
Message-Id: <20050525172500.0d8458f1.akpm@osdl.org>
In-Reply-To: <42951138.1090404@ens-lyon.fr>
References: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>
	<4294F718.8040107@ens-lyon.fr>
	<20050525162318.511cdc9b.akpm@osdl.org>
	<42951138.1090404@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
>
> Looks like Alexandre's patch was damaged by mistake.
> An 'extern' appeared in the removed part of lvb_table.h
> I guess the patch didn't actually apply to your tree.
> This would explain why the lvb_table.h part of the version
> you commited to -mm is different.
> 
> The attached patch should be good.
> 
> Note that dlm_lvb_operations is kept exported in lvb_table.h
> so that drivers/dlm/device.c uses it. That was the point of
> Alexandre's initial bug report: dlm_lvm_operations was defined
> twice when both DLM and DLM_DEVICE are set.

OK, thanks.  Here's what I currently have:

--- 25/drivers/dlm/lock.c~dlm-lockspaces-callbacks-directory-fix	Wed May 25 16:23:04 2005
+++ 25-akpm/drivers/dlm/lock.c	Wed May 25 17:24:08 2005
@@ -104,6 +104,26 @@ const int __dlm_compat_matrix[8][8] = {
         {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
 };
 
+/*
+ * This defines the direction of transfer of LVB data.
+ * Granted mode is the row; requested mode is the column.
+ * Usage: matrix[grmode+1][rqmode+1]
+ * 1 = LVB is returned to the caller
+ * 0 = LVB is written to the resource
+ * -1 = nothing happens to the LVB
+ */
+const int dlm_lvb_operations[8][8] = {
+        /* UN   NL  CR  CW  PR  PW  EX  PD*/
+        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
+        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
+        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
+        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
+        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
+        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
+};
+
 #define modes_compat(gr, rq) \
 	__dlm_compat_matrix[(gr)->lkb_grmode + 1][(rq)->lkb_rqmode + 1]
 
diff -puN drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix drivers/dlm/lvb_table.h
--- 25/drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix	Wed May 25 16:23:04 2005
+++ 25-akpm/drivers/dlm/lvb_table.h	Wed May 25 17:24:17 2005
@@ -13,26 +13,6 @@
 #ifndef __LVB_TABLE_DOT_H__
 #define __LVB_TABLE_DOT_H__
 
-/*
- * This defines the direction of transfer of LVB data.
- * Granted mode is the row; requested mode is the column.
- * Usage: matrix[grmode+1][rqmode+1]
- * 1 = LVB is returned to the caller
- * 0 = LVB is written to the resource
- * -1 = nothing happens to the LVB
- */
-
-const int dlm_lvb_operations[8][8] = {
-        /* UN   NL  CR  CW  PR  PW  EX  PD*/
-        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
-        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
-        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
-        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
-        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
-        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
-        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
-};
+extern const int dlm_lvb_operations[8][8];
 
 #endif
-
_

