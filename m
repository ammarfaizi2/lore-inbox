Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265071AbUELAAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUELAAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265068AbUELAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:00:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:52910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265079AbUEKX4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:56:42 -0400
Date: Tue, 11 May 2004 16:56:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] add disable param to capabilities module
Message-ID: <20040511165639.Q21045@build.pdx.osdl.net>
References: <20040511164640.O21045@build.pdx.osdl.net> <20040511165000.P21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511165000.P21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 04:50:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add disable param to capabilities module.  Similar to the SELinux param
for disabling at boot time.  This allows vendors to ship single binary
image with capabilities compiled statically, and disable it if they
provide another security model compiled as module.

--- linus-2.5/security/capability.c~disable	2004-05-11 16:14:36.121676768 -0700
+++ linus-2.5/security/capability.c	2004-05-11 16:19:25.906622760 -0700
@@ -22,6 +22,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
+#include <linux/moduleparam.h>
 
 static struct security_operations capability_ops = {
 	.ptrace =			cap_ptrace,
@@ -52,9 +53,16 @@
 /* flag to keep track of how we were registered */
 static int secondary;
 
+static int capability_disable;
+module_param_named(disable, capability_disable, int, 0);
+MODULE_PARM_DESC(disable, "To disable capabilities module set disable = 1");
 
 static int __init capability_init (void)
 {
+	if (capability_disable) {
+		printk(KERN_INFO "Capabilities disabled at initialization\n");
+		return 0;
+	}
 	/* register ourselves with the security framework */
 	if (register_security (&capability_ops)) {
 		/* try registering with primary module */
@@ -72,6 +80,8 @@
 
 static void __exit capability_exit (void)
 {
+	if (capability_disable)
+		return;
 	/* remove ourselves from the security framework */
 	if (secondary) {
 		if (mod_unreg_security (MY_NAME, &capability_ops))
