Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVAYU1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVAYU1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAYU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:27:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:64658 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262110AbVAYUZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:25:52 -0500
Date: Tue, 25 Jan 2005 12:24:29 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, tj@home-tj.org,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Modules: Allow sysfs module parameters to be written to.
Message-ID: <20050125202429.GA12084@kroah.com>
References: <200501132234.30762.rathamahata@ehouse.ru> <20050114005948.GD4140@kroah.com> <1106463261.8118.13.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106463261.8118.13.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply this to your tree, it fixes the module parameter
stuff in sysfs so that it actually works.  Was verified by Marcel.

-----------

Fixes a bug in the current tree preventing the sysfs module parameters from being able
to be changed at all from userspace.  It's as if someone just forgot to write this function...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	2005-01-24 21:07:40 -08:00
+++ b/kernel/params.c	2005-01-24 21:07:40 -08:00
@@ -640,9 +640,33 @@
 	return ret;
 }
 
+static ssize_t module_attr_store(struct kobject *kobj,
+				struct attribute *attr,
+				const char *buf, size_t len)
+{
+	struct module_attribute *attribute;
+	struct module_kobject *mk;
+	int ret;
+
+	attribute = to_module_attr(attr);
+	mk = to_module_kobject(kobj);
+
+	if (!attribute->store)
+		return -EPERM;
+
+	if (!try_module_get(mk->mod))
+		return -ENODEV;
+
+	ret = attribute->store(attribute, mk->mod, buf, len);
+
+	module_put(mk->mod);
+
+	return ret;
+}
+
 static struct sysfs_ops module_sysfs_ops = {
 	.show = module_attr_show,
-	.store = NULL,
+	.store = module_attr_store,
 };
 
 #else
