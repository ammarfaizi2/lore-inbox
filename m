Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVFCVlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVFCVlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFCVlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:41:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:54983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261485AbVFCVkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:40:20 -0400
Date: Fri, 3 Jun 2005 14:37:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>, Baruch Even <baruch@ev-en.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.12-rc5-mm2: "bic unavailable using TCP reno" messages
Message-ID: <20050603143702.0422101d@dxpl.pdx.osdl.net>
In-Reply-To: <20050602203823.GI4992@stusta.de>
References: <20050601022824.33c8206e.akpm@osdl.org>
	<20050602121511.GE4992@stusta.de>
	<429F1079.5070701@ev-en.org>
	<20050602103805.6beb4f4e@dxpl.pdx.osdl.net>
	<20050602203823.GI4992@stusta.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is what I am working on as better way to make the sysctl selection.
I am not totally happy with the way the default congestion control value is determined
by the load order. But it does seem good that if you load "tcp_xxx" module and it
registers it becomes the default.

Index: 2.6.12-rc5-tcp3/include/net/tcp.h
===================================================================
--- 2.6.12-rc5-tcp3.orig/include/net/tcp.h
+++ 2.6.12-rc5-tcp3/include/net/tcp.h
@@ -1242,6 +1242,8 @@ extern int tcp_register_congestion_contr
 extern void tcp_unregister_congestion_control(struct tcp_congestion_ops *type);
 extern void tcp_init_congestion_control(struct tcp_sock *tp);
 extern void tcp_release_congestion_control(struct tcp_sock *tp);
+extern int tcp_set_congestion_control(const char *name);
+extern void tcp_get_congestion_control(char *name);
 
 extern struct tcp_congestion_ops tcp_reno;
 extern u32 tcp_reno_ssthresh(struct tcp_sock *tp);
Index: 2.6.12-rc5-tcp3/net/ipv4/tcp_cong.c
===================================================================
--- 2.6.12-rc5-tcp3.orig/net/ipv4/tcp_cong.c
+++ 2.6.12-rc5-tcp3/net/ipv4/tcp_cong.c
@@ -13,8 +13,6 @@
 #include <linux/list.h>
 #include <net/tcp.h>
 
-char sysctl_tcp_congestion_control[TCP_CA_NAME_MAX] = "bic";
-
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
 static LIST_HEAD(tcp_cong_list);
 
@@ -23,7 +21,7 @@ static struct tcp_congestion_ops *tcp_ca
 {
 	struct tcp_congestion_ops *e;
 
-	list_for_each_entry_rcu(e, &tcp_cong_list, list) {
+	list_for_each_entry(e, &tcp_cong_list, list) {
 		if (strcmp(e->name, name) == 0) 
 			return e;
 	}
@@ -46,7 +44,7 @@ int tcp_register_congestion_control(stru
 		return -EINVAL;
 	}
 
-	spin_lock_irq(&tcp_cong_list_lock);
+	spin_lock(&tcp_cong_list_lock);
 	if (tcp_ca_find(ca->name)) {
 		printk(KERN_NOTICE "TCP %s already registered\n", ca->name);
 		ret = -EEXIST;
@@ -54,7 +52,7 @@ int tcp_register_congestion_control(stru
 		list_add_rcu(&ca->list, &tcp_cong_list);
 		printk(KERN_INFO "TCP %s registered\n", ca->name);
 	}
-	spin_unlock_irq(&tcp_cong_list_lock);
+	spin_unlock(&tcp_cong_list_lock);
 	
 	return ret;
 }
@@ -69,7 +67,6 @@ EXPORT_SYMBOL_GPL(tcp_register_congestio
 void tcp_unregister_congestion_control(struct tcp_congestion_ops *ca)
 {
 	spin_lock(&tcp_cong_list_lock);
-	BUG_ON(!tcp_ca_find(ca->name));
 	list_del_rcu(&ca->list);
 	spin_unlock(&tcp_cong_list_lock);
 }
@@ -78,34 +75,22 @@ EXPORT_SYMBOL_GPL(tcp_unregister_congest
 /* Assign choice of congestion control. */
 void tcp_init_congestion_control(struct tcp_sock *tp)
 {
-	const char *cong_proto = sysctl_tcp_congestion_control;
 	struct tcp_congestion_ops *ca;
 
 	rcu_read_lock();
-	ca = tcp_ca_find(cong_proto);
-#ifdef CONFIG_KMOD
-	if (!ca) {
-		/* autoload and try again */
-		rcu_read_unlock();
-		request_module("tcp_%s",  cong_proto);
-		rcu_read_lock();
-
-		ca = tcp_ca_find(cong_proto);
-	}
-#endif
-
-	/* If selection doesn't exist or is being removed use Reno */
-	if (!ca || !try_module_get(ca->owner)) {
-		if (net_ratelimit())
-			printk(KERN_WARNING "%s unavailable using TCP reno\n",
-			       cong_proto);
-		ca = &tcp_reno;
-	} 
-	tp->ca_ops = ca;
-	rcu_read_unlock();
+	tp->ca_ops = NULL;
+	list_for_each_entry_rcu(ca, &tcp_cong_list, list) {
+		if (try_module_get(ca->owner)) {
+			tp->ca_ops = ca;
+			break;
+		}
 
-	if (ca->init)
-		ca->init(tp);
+	}
+
+	/* We will always have reno to fallback on. */
+	if (tp->ca_ops->init)
+		tp->ca_ops->init(tp);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(tcp_init_congestion_control);
 
@@ -122,6 +107,36 @@ void tcp_release_congestion_control(stru
 	}
 }
 
+/* Used by sysctl to change default congestion control */
+int tcp_set_congestion_control(const char *name)
+{
+	struct tcp_congestion_ops *ca;
+	int ret = -ENOENT;
+
+	spin_lock(&tcp_cong_list_lock);
+	ca = tcp_ca_find(name);
+	if (ca) {
+		list_move(&ca->list, &tcp_cong_list);
+		ret = 0;
+	}
+	spin_unlock(&tcp_cong_list_lock);
+
+	return ret;
+}
+
+/* Get current default congestion control */
+void tcp_get_congestion_control(char *name)
+{
+	struct tcp_congestion_ops *ca;
+	/* We will always have reno... */
+	BUG_ON(list_empty(&tcp_cong_list));
+
+	rcu_read_lock();
+	ca = list_entry(tcp_cong_list.next, struct tcp_congestion_ops, list);
+	strncpy(name, ca->name, TCP_CA_NAME_MAX);
+	rcu_read_lock();
+}
+
 /*
  * TCP Reno congestion control
  * This is special case used for fallback as well.
Index: 2.6.12-rc5-tcp3/net/ipv4/sysctl_net_ipv4.c
===================================================================
--- 2.6.12-rc5-tcp3.orig/net/ipv4/sysctl_net_ipv4.c
+++ 2.6.12-rc5-tcp3/net/ipv4/sysctl_net_ipv4.c
@@ -48,9 +48,6 @@ extern int inet_peer_maxttl;
 extern int inet_peer_gc_mintime;
 extern int inet_peer_gc_maxtime;
 
-/* From tcp_input.c */
-extern char sysctl_tcp_congestion_control[TCP_CA_NAME_MAX];
-
 #ifdef CONFIG_SYSCTL
 static int tcp_retr1_max = 255; 
 static int ip_local_port_range_min[] = { 1, 1 };
@@ -120,6 +117,52 @@ static int ipv4_sysctl_forward_strategy(
 	return 1;
 }
 
+static int proc_tcp_congestion_control(ctl_table *ctl, int write, struct file * filp,
+				       void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	char val[TCP_CA_NAME_MAX];
+	ctl_table tbl = {
+		.data = val,
+		.maxlen = TCP_CA_NAME_MAX,
+	};
+	int ret;
+
+	tcp_get_congestion_control(val);
+	
+	ret = proc_dostring(&tbl, write, filp, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		ret = tcp_set_congestion_control(val);
+#ifdef CONFIG_KMOD
+		if (ret == -ENOENT) {
+			request_module("tcp_%s", val);
+			ret = tcp_set_congestion_control(val);
+		}
+#endif
+	}
+	return ret;
+}
+
+int sysctl_tcp_congestion_control(ctl_table *table, int __user *name, int nlen,
+				  void __user *oldval, size_t __user *oldlenp,
+				  void __user *newval, size_t newlen, 
+				  void **context)
+{
+	char val[TCP_CA_NAME_MAX];
+	ctl_table tbl = {
+		.data = val,
+		.maxlen = TCP_CA_NAME_MAX,
+	};
+	int ret;
+
+	tcp_get_congestion_control(val);
+	ret = sysctl_string(&tbl, name, nlen, oldval, oldlenp, newval, newlen,
+			    context);
+	if (ret == 0 && newval && newlen)
+		ret = tcp_set_congestion_control(val);
+	return ret;
+}
+
+
 ctl_table ipv4_table[] = {
         {
 		.ctl_name	= NET_IPV4_TCP_TIMESTAMPS,
@@ -624,11 +667,10 @@ ctl_table ipv4_table[] = {
 	{
 		.ctl_name	= NET_TCP_CONG_CONTROL,
 		.procname	= "tcp_congestion_control",
-		.data		= &sysctl_tcp_congestion_control,
-		.maxlen		= TCP_CA_NAME_MAX,
 		.mode		= 0644,
-		.proc_handler	= &proc_dostring,
-		.strategy	= &sysctl_string,
+		.maxlen		= TCP_CA_NAME_MAX,
+		.proc_handler	= &proc_tcp_congestion_control,
+		.strategy	= &sysctl_tcp_congestion_control,
 	},
 
 	{ .ctl_name = 0 }
