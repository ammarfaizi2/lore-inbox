Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUCPAEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUCPAED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:04:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:6063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262880AbUCPACA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:00 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951462388@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:07 -0800
Message-Id: <10793951461961@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.4, 2004/03/10 16:05:28-08:00, chrisw@osdl.org

[PATCH] class_simple cleanup in input

Doesn't catch error on class_simple_add, and existing error return paths
forget to class_simple_destroy.


 drivers/input/input.c |    4 ++++
 1 files changed, 4 insertions(+)


diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Mon Mar 15 15:29:55 2004
+++ b/drivers/input/input.c	Mon Mar 15 15:29:55 2004
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

