Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVAYUed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVAYUed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVAYUdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:33:51 -0500
Received: from hera.kernel.org ([209.128.68.125]:40076 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262124AbVAYUcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:32:41 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: kernel BUG at fs/sysfs/symlink.c:87
Date: Tue, 25 Jan 2005 12:32:35 -0800
Organization: Open Source Development Lab
Message-ID: <20050125123235.118108ca@dxpl.pdx.osdl.net>
References: <20050124155100.GA2583@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1106685150 25603 172.20.1.103 (25 Jan 2005 20:32:30 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 25 Jan 2005 20:32:30 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't reproduce this with 2.6.11-rc2, could you try this patch to
see if it matters.

Puzzled, because the assert is.
	BUG_ON(!kobj || !kobj->dentry || !name);
and call is
	
	err = sysfs_create_link(&p->kobj, &br->dev->class_dev.kobj, 
				SYSFS_BRIDGE_PORT_LINK);
kobj can't be NULL, because &p->kobj can't be NULL
kobj->dentry is created by kobject_add
name is SYSFS_BRIDGE_PORT_LINK ("bridge")

The kobj->dentry should have been created by kobject_add() 

	kobject_set_name(&p->kobj, SYSFS_BRIDGE_PORT_ATTR);
	p->kobj.ktype = &brport_ktype;
	p->kobj.parent = &(p->dev->class_dev.kobj);
	p->kobj.kset = NULL;

	err = kobject_add(&p->kobj);
and kobject_add does.
	err = create_dir(kobj);
create_dir calls sysfs_create_dir(kobj).
===================

Since kobject_register initializes more fields, perhaps some part of kobject_add
got confused. Try this.

diff -Nru a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
--- a/net/bridge/br_sysfs_if.c	2005-01-25 12:28:00 -08:00
+++ b/net/bridge/br_sysfs_if.c	2005-01-25 12:28:00 -08:00
@@ -229,7 +229,7 @@
 	p->kobj.parent = &(p->dev->class_dev.kobj);
 	p->kobj.kset = NULL;
 
-	err = kobject_add(&p->kobj);
+	err = kobject_register(&p->kobj);
 	if(err)
 		goto out1;
 
