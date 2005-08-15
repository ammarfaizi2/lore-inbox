Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVHOXh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVHOXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVHOXh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:37:26 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26376 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965033AbVHOXhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:37:25 -0400
Message-Id: <200508152325.j7FNP2sn008999@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 1/4] UML - Fix signal frame copy_user 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Aug 2005 19:25:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

The copy_user stuff in the signal frame code was broke.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-i386/signal.c	2005-08-15 12:03:10.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-i386/signal.c	2005-08-15 12:04:08.000000000 -0400
@@ -122,9 +122,9 @@
 	int err;
 
 	to_fp = to->fpstate;
-	from_fp = from->fpstate;
 	sigs = to->oldmask;
 	err = copy_from_user(to, from, sizeof(*to));
+	from_fp = to->fpstate;
 	to->oldmask = sigs;
 	to->fpstate = to_fp;
 	if(to_fp != NULL)
Index: linux-2.6.13-rc6/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-x86_64/signal.c	2005-08-15 12:03:10.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-x86_64/signal.c	2005-08-15 12:04:08.000000000 -0400
@@ -104,28 +104,35 @@
 int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
                         int fpsize)
 {
-       struct _fpstate *to_fp, *from_fp;
-       unsigned long sigs;
-       int err;
-
-       to_fp = to->fpstate;
-       from_fp = from->fpstate;
-       sigs = to->oldmask;
-       err = copy_from_user(to, from, sizeof(*to));
-       to->oldmask = sigs;
-       return(err);
+	struct _fpstate *to_fp, *from_fp;
+	unsigned long sigs;
+	int err;
+
+	to_fp = to->fpstate;
+	sigs = to->oldmask;
+	err = copy_from_user(to, from, sizeof(*to));
+	from_fp = to->fpstate;
+	to->fpstate = to_fp;
+	to->oldmask = sigs;
+	if(to_fp != NULL)
+		err |= copy_from_user(to_fp, from_fp, fpsize);
+	return(err);
 }
 
 int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
                       struct sigcontext *from, int fpsize)
 {
-       struct _fpstate *to_fp, *from_fp;
-       int err;
+	struct _fpstate *to_fp, *from_fp;
+	int err;
 
-       to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
-       from_fp = from->fpstate;
-       err = copy_to_user(to, from, sizeof(*to));
-       return(err);
+	to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
+	from_fp = from->fpstate;
+	err = copy_to_user(to, from, sizeof(*to));
+	if(from_fp != NULL){
+		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
+		err |= copy_to_user(to_fp, from_fp, fpsize);
+	}
+	return(err);
 }
 
 #endif

