Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVCGSLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVCGSLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVCGSIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:08:39 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:61700 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261205AbVCGSHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:07:50 -0500
Message-Id: <200503072037.j27Kbrbc003972@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/16] UML - Fix a shutdown hang caused by a failed ifconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The network driver wasn't checking that the host side of an interface had
been successfully opened before trying to close it at shuwtdown.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/net_kern.c	2005-03-05 12:07:28.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/net_kern.c	2005-03-05 12:12:13.000000000 -0500
@@ -728,7 +728,8 @@
 
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
-		if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
+		if((lp->close != NULL) && (lp->fd >= 0))
+			(*lp->close)(lp->fd, &lp->user);
 		if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	}
 }

