Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVBYE2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVBYE2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 23:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVBYE2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 23:28:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11947 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262443AbVBYE1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 23:27:55 -0500
Message-ID: <421EA8FF.1050906@sgi.com>
Date: Thu, 24 Feb 2005 20:26:39 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
Content-Type: multipart/mixed;
 boundary="------------080107060108000901050306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080107060108000901050306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Since my idea of providing an accounting framework was considered
'overkill', here i submit a tiny patch just to allow CSA to
handle end-of-process (eop) situation by saving off accounting
data before a task_struct is disposed.

This patch is to modify the acct_process() in acct.c, which is
invoked from do_exit() to handle eop for BSD accounting. Now
the acct_process() wrapper will also take care of CSA, if it has
been loaded. If the CSA module has been loaded, a CSA routine
will be invoked to construct a CSA job record and to write the
record to the CSA accounting file.

This patch only touchs one file: kernel/acct.c.

Signed-off-by: Jay Lan <jlan@sgi.com>



--------------080107060108000901050306
Content-Type: text/plain;
 name="acct-csa-eop"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct-csa-eop"

Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2005-02-24 15:55:05.519092861 -0800
+++ linux/kernel/acct.c	2005-02-24 16:33:56.381584083 -0800
@@ -73,6 +73,11 @@ int acct_parm[3] = {4, 2, 30};
 /*
  * External references and all of the globals.
  */
+
+/* do_exit hook used by CSA */
+void (*do_exit_csa)(int, struct task_struct *) = NULL;
+EXPORT_SYMBOL_GPL(do_exit_csa);
+
 static void do_acct_process(long, struct file *);
 
 /*
@@ -504,12 +509,17 @@ static void do_acct_process(long exitcod
 }
 
 /*
- * acct_process - now just a wrapper around do_acct_process
+ * acct_process - now just a wrapper around
+ *	do_acct_process	- for BSD accounting
+ *	do_exit_csa	- for CSA
  */
 void acct_process(long exitcode)
 {
 	struct file *file = NULL;
 
+	if (do_exit_csa != NULL)
+		do_exit_csa(exitcode, current);
+
 	/*
 	 * accelerate the common fastpath:
 	 */

--------------080107060108000901050306--

