Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHPB13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHPB13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHPB13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:27:29 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:10480 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S267311AbUHPB1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:27:23 -0400
Subject: [PATCH] Read cpumasks every time when exporting through sysfs
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, pj@sgi.com
Content-Type: text/plain
Message-Id: <1092619602.29608.47.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 11:26:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Read cpumasks every time when exporting through sysfs
Status: Booted on 2.6.7-rc2-bk7
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Paul Jackson points out that the sysfs code saves a node's cpumask in
the sysfs node, although it can change with CPU hotplug.  Don't do
this.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4860-linux-2.6.7-rc2-bk7/drivers/base/node.c .4860-linux-2.6.7-rc2-bk7.updated/drivers/base/node.c
--- .4860-linux-2.6.7-rc2-bk7/drivers/base/node.c	2004-06-07 07:47:33.000000000 +1000
+++ .4860-linux-2.6.7-rc2-bk7.updated/drivers/base/node.c	2004-06-07 12:26:16.000000000 +1000
@@ -18,7 +18,7 @@ static struct sysdev_class node_class = 
 static ssize_t node_read_cpumap(struct sys_device * dev, char * buf)
 {
 	struct node *node_dev = to_node(dev);
-	cpumask_t mask = node_dev->cpumap;
+	cpumask_t mask = node_to_cpumask(node_dev->sysdev.id);
 	int len;
 
 	/* 2004/06/03: buf currently PAGE_SIZE, need > 1 char per 4 bits. */
@@ -116,7 +116,6 @@ int __init register_node(struct node *no
 {
 	int error;
 
-	node->cpumap = node_to_cpumask(num);
 	node->sysdev.id = num;
 	node->sysdev.cls = &node_class;
 	error = sysdev_register(&node->sysdev);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .4860-linux-2.6.7-rc2-bk7/include/linux/node.h .4860-linux-2.6.7-rc2-bk7.updated/include/linux/node.h
--- .4860-linux-2.6.7-rc2-bk7/include/linux/node.h	2003-09-22 10:27:37.000000000 +1000
+++ .4860-linux-2.6.7-rc2-bk7.updated/include/linux/node.h	2004-06-07 12:24:47.000000000 +1000
@@ -23,7 +23,6 @@
 #include <linux/cpumask.h>
 
 struct node {
-	cpumask_t cpumap;	/* Bitmap of CPUs on the Node */
 	struct sys_device	sysdev;
 };
 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

