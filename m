Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTJQRqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTJQRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:46:12 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41320 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263572AbTJQRor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:44:47 -0400
Date: Fri, 17 Oct 2003 10:44:30 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix for register_cpu()
Message-ID: <20031017174430.GA6699@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

register_cpu() needs to honor the root argument that gets passed in if
it's valid.

Jesse

diff -Nru a/drivers/base/cpu.c b/drivers/base/cpu.c
--- a/drivers/base/cpu.c	Fri Oct 17 10:41:16 2003
+++ b/drivers/base/cpu.c	Fri Oct 17 10:41:16 2003
@@ -23,10 +23,18 @@
  */
 int __init register_cpu(struct cpu *cpu, int num, struct node *root)
 {
+	int error;
+
 	cpu->node_id = cpu_to_node(num);
 	cpu->sysdev.id = num;
 	cpu->sysdev.cls = &cpu_sysdev_class;
-	return sys_device_register(&cpu->sysdev);
+
+	error = sys_device_register(&cpu->sysdev);
+	if (!error && root) 
+		error = sysfs_create_link(&root->sysdev.kobj,
+					  &cpu->sysdev.kobj,
+					  kobject_name(&cpu->sysdev.kobj));
+	return error;
 }
 
 
