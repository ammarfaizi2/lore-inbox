Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUKGQR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUKGQR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUKGQQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:16:53 -0500
Received: from mout1.freenet.de ([194.97.50.132]:60559 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261646AbUKGQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:16:40 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix warning and compiletime error in neighbour.c
Date: Sun, 7 Nov 2004 14:46:23 +0100
User-Agent: KMail/1.7.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200411071446.23659.mbuesch@freenet.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vcijBpSMhYiG1es"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vcijBpSMhYiG1es
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

This patch fixes the following:
gcc -D__KERNEL__ -I/home/mb/kernel/linux-2.4.28-rc1-bk4/include \
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing \
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 \
-march=i586    -nostdinc -iwithprefix include \
-DKBUILD_BASENAME=neighbour  -c -o neighbour.o neighbour.c
neighbour.c: In function `neigh_seq_stop':
neighbour.c:1805: warning: unused variable `tbl'
neighbour.c: At top level:
neighbour.c:1901: `THIS_MODULE' undeclared here (not in a function)
neighbour.c:1901: initializer element is not constant
neighbour.c:1901: (near initialization for `neigh_stat_seq_fops.owner')

Sorry for the attachment. My mailer is currently broken and
corrupts diffs.

--Boundary-00=_vcijBpSMhYiG1es
Content-Type: text/x-diff;
  charset="us-ascii";
  name="net-neighbour-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net-neighbour-fix.diff"

--- linux-2.4.28-rc1-bk4/net/core/neighbour.c.orig	Sun Nov  7 15:09:36 2004
+++ linux-2.4.28-rc1-bk4/net/core/neighbour.c	Sun Nov  7 15:16:10 2004
@@ -31,6 +31,7 @@
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
 #include <linux/random.h>
+#include <linux/module.h>
 
 #define NEIGH_DEBUG 1
 
@@ -1801,10 +1802,7 @@
 
 void neigh_seq_stop(struct seq_file *seq, void *v)
 {
-	struct neigh_seq_state *state = seq->private;
-	struct neigh_table *tbl = state->tbl;
-
-	read_unlock_bh(&tbl->lock);
+	read_unlock_bh(&seq->private->tbl->lock);
 }
 
 /* statistics via seq_file */

--Boundary-00=_vcijBpSMhYiG1es--
