Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUCDECT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUCDEBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:01:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:30130 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbUCDEBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:01:48 -0500
Date: Wed, 3 Mar 2004 20:01:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] class_simple cleanup in input
Message-ID: <20040303200146.L21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't catch error on class_simple_add, and existing error return paths
forget to class_simple_destroy.

===== drivers/input/input.c 1.42 vs edited =====
--- 1.42/drivers/input/input.c	Thu Jan 15 03:05:57 2004
+++ edited/drivers/input/input.c	Wed Mar  3 19:46:20 2004
@@ -727,6 +727,8 @@
 	int retval = -ENOMEM;
 
 	input_class = class_simple_create(THIS_MODULE, "input");
+	if (IS_ERR(input_class))
+		return PTR_ERR(input_class);
 	input_proc_init();
 	retval = register_chrdev(INPUT_MAJOR, "input", &input_fops);
 	if (retval) {
@@ -734,6 +736,7 @@
 		remove_proc_entry("devices", proc_bus_input_dir);
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
+		class_simple_destroy(input_class);
 		return retval;
 	}
 
@@ -743,6 +746,7 @@
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		unregister_chrdev(INPUT_MAJOR, "input");
+		class_simple_destroy(input_class);
 	}
 	return retval;
 }

