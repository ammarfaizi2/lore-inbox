Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWBRBft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBRBft (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWBRBft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:35:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:65434 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750704AbWBRBfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:35:48 -0500
Date: Sat, 18 Feb 2006 02:35:47 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: kjournald keeps reference to namespace
Message-ID: <20060218013547.GA32706@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

when creating a private namespace (CLONE_NS) and
then mounting an ext3 filesystem, a new kernel
thread (kjournald) is created, which keeps a
reference to the namespace, which after the the
process exits, remains and blocks access to the
block device, as it is still bd_claim-ed.

this leaves a private namespace behind and a
block device which cannot be opened exclusively.
unmount is not an option, as the namespace is
not longer reachable.

this behaviour seems to be there since ever,
well since namespaces and kjournald exists :)

the following 'cruel' hack 'solves' this issue

best,
Herbert


--- fs/jbd/journal.c.orig	2006-01-03 17:29:56 +0100
+++ fs/jbd/journal.c	2006-02-18 02:23:21 +0100
@@ -33,6 +33,7 @@
 #include <linux/mm.h>
 #include <linux/suspend.h>
 #include <linux/pagemap.h>
+#include <linux/namespace.h>
 #include <asm/uaccess.h>
 #include <asm/page.h>
 #include <linux/proc_fs.h>
@@ -116,6 +117,13 @@ static int kjournald(void *arg)
 	struct timer_list timer;
 
 	daemonize("kjournald");
+	{
+		struct namespace *ns = current->namespace;
+
+		current->namespace = NULL;
+		put_namespace(ns);
+	}
+
 
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */

