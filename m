Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbUCPB0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbUCPBYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:24:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:33967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262908AbUCPACl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:41 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951472400@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:07 -0800
Message-Id: <10793951472062@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.8, 2004/03/11 10:57:27-08:00, ogasawara@osdl.org

[PATCH] Fix class_register() always returns 0

I noticed that the class_register() function in drivers/base/class.c
always returns 0 and thus will never fail.  Patch below inserts simple
error checking to return any errors if they occur.  Feedback welcome.
Thanks,


 drivers/base/class.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Mon Mar 15 15:29:19 2004
+++ b/drivers/base/class.c	Mon Mar 15 15:29:19 2004
@@ -102,13 +102,21 @@
 
 int class_register(struct class * cls)
 {
+	int error;
+
 	pr_debug("device class '%s': registering\n",cls->name);
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	kobject_set_name(&cls->subsys.kset.kobj,cls->name);
+	error = kobject_set_name(&cls->subsys.kset.kobj,cls->name);
+	if (error)
+		return error;
+
 	subsys_set_kset(cls,class_subsys);
-	subsystem_register(&cls->subsys);
+
+	error = subsystem_register(&cls->subsys);
+	if (error)
+		return error;
 
 	return 0;
 }

