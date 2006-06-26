Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWFZJ4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWFZJ4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWFZJ4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:56:36 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:16132 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S964949AbWFZJ4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:56:35 -0400
Message-ID: <20060626135537.D28942@castle.nmd.msu.ru>
Date: Mon, 26 Jun 2006 13:55:37 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: dlezcano@fr.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk
Subject: [patch 4/4] Network namespaces: playing and debugging
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20060626135427.C28942@castle.nmd.msu.ru>; from "Andrey Savochkin" on Mon, Jun 26, 2006 at 01:54:27PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Temporary code to play with network namespaces in the simplest way.
Do
	exec 7< /proc/net/net_ns
in your bash shell and you'll get a brand new network namespace.
There you can, for example, do
	ip link set lo up
	ip addr list
	ip addr add 1.2.3.4 dev lo
	ping -n 1.2.3.4

Signed-off-by: Andrey Savochkin <saw@swsoft.com>
---
 dev.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions, 1 deletion

--- ./net/core/dev.c.vensdbg	Fri Jun 23 11:50:16 2006
+++ ./net/core/dev.c	Fri Jun 23 11:50:40 2006
@@ -3444,6 +3444,8 @@ int net_ns_start(void)
 	if (err)
 		goto out_register;
 	put_net_ns(orig_ns);
+	printk(KERN_DEBUG "NET_NS: created new netcontext %p for %s (pid=%d)\n",
+			ns, task->comm, task->tgid);
 	return 0;
 
 out_register:
@@ -3461,6 +3463,7 @@ EXPORT_SYMBOL(net_ns_start);
 
 void net_ns_free(struct net_namespace *ns)
 {
+	printk(KERN_DEBUG "NET_NS: netcontext %p freed\n", ns);
 	kfree(ns);
 }
 EXPORT_SYMBOL(net_ns_free);
@@ -3473,8 +3476,13 @@ static void net_ns_destroy(void *data)
 	ns = data;
 	push_net_ns(ns, orig_ns);
 	unregister_netdev(ns->loopback);
+	if (!list_empty(&ns->dev_base)) {
+		printk("NET_NS: BUG: context %p has devices! ref %d\n",
+				ns, atomic_read(&ns->active_ref));
+		pop_net_ns(orig_ns);
+		return;
+	}
 	ip_fib_struct_fini();
-	BUG_ON(!list_empty(&ns->dev_base));
 	pop_net_ns(orig_ns);
 
 	/* drop (hopefully) final reference */
@@ -3483,9 +3491,23 @@ static void net_ns_destroy(void *data)
 
 void net_ns_stop(struct net_namespace *ns)
 {
+	printk(KERN_DEBUG "NET_NS: netcontext %p scheduled for stop\n", ns);
 	execute_in_process_context(net_ns_destroy, ns, &ns->destroy_work);
 }
 EXPORT_SYMBOL(net_ns_stop);
+
+static int net_ns_open(struct inode *i, struct file *f)
+{
+	return net_ns_start();
+}
+static struct file_operations net_ns_fops = {
+	.open	= net_ns_open,
+};
+static int net_ns_init(void)
+{
+	return proc_net_fops_create("net_ns", S_IRWXU, &net_ns_fops)
+			? 0 : -ENOMEM;
+}
 #endif
 
 /*
@@ -3550,6 +3572,9 @@ static int __init net_dev_init(void)
 	hotcpu_notifier(dev_cpu_callback, 0);
 	dst_init();
 	dev_mcast_init();
+#ifdef CONFIG_NET_NS
+	net_ns_init();
+#endif
 	rc = 0;
 out:
 	return rc;
