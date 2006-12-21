Return-Path: <linux-kernel-owner+w=401wt.eu-S965187AbWLUKLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWLUKLs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWLUKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:11:48 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:63817 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965187AbWLUKLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:11:47 -0500
Message-ID: <458A5DD9.4000304@bx.jp.nec.com>
Date: Thu, 21 Dec 2006 19:11:37 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 take2 4/5] switch function of netpoll
References: <458A5AAE.30209@bx.jp.nec.com>
In-Reply-To: <458A5AAE.30209@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains switch function of netpoll.

If "enabled" attribute of certain port is '1', this port is used
and the configurations of this port are uable to change.

If "enabled" attribute of certain port is '0', this port isn't used
and the configurations of this port are able to change.

-+- /sys/class/misc/
 |-+- netconsole/
   |-+- port1/
   | |--- id          [r--r--r--]  id
   | |--- enabled     [rw-r--r--]  0: disable 1: enable, writable
   | ...
   |--- port2/
   ...

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
[changes]
1. change active/inactive netpoll from list management to flag management.
2. change the name of switch from "enable" to "enabled".
3. return proper error value.

--- linux-2.6.19/drivers/net/netconsole.c	2006-12-21 18:39:12.627180000 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.switch	2006-12-21 18:38:58.702309750 +0900
@@ -60,6 +60,7 @@ struct netconsole_target {
 	struct list_head list;
 	struct kobject obj;
 	int id;
+	int enabled;
 	struct netpoll np;
 };
 
@@ -131,10 +132,19 @@ static ssize_t show_remote_mac(struct ne
 		       nt->np.remote_mac[4], nt->np.remote_mac[5]);
 }
 
+static ssize_t show_enabled(struct netconsole_target *nt, char *buf)
+{
+	return sprintf(buf, "%d\n", nt->enabled);
+}
+
 static ssize_t store_local_port(struct netconsole_target *nt, const char *buf,
 				size_t count)
 {
 	spin_lock(&target_list_lock);
+	if (nt->enabled) {
+		spin_unlock(&target_list_lock);
+		return -EINVAL;
+	}
 	nt->np.local_port = simple_strtol(buf, NULL, 10);
 	spin_unlock(&target_list_lock);
 
@@ -145,6 +155,10 @@ static ssize_t store_remote_port(struct 
 				size_t count)
 {
 	spin_lock(&target_list_lock);
+	if (nt->enabled) {
+		spin_unlock(&target_list_lock);
+		return -EINVAL;
+	}
 	nt->np.remote_port = simple_strtol(buf, NULL, 10);
 	spin_unlock(&target_list_lock);
 
@@ -155,6 +169,10 @@ static ssize_t store_local_ip(struct net
 			      size_t count)
 {
 	spin_lock(&target_list_lock);
+	if (nt->enabled) {
+		spin_unlock(&target_list_lock);
+		return -EINVAL;
+	}
 	nt->np.local_ip = ntohl(in_aton(buf));
 	spin_unlock(&target_list_lock);
 
@@ -165,6 +183,10 @@ static ssize_t store_remote_ip(struct ne
 			       size_t count)
 {
 	spin_lock(&target_list_lock);
+	if (nt->enabled) {
+		spin_unlock(&target_list_lock);
+		return -EINVAL;
+	}
 	nt->np.remote_ip = ntohl(in_aton(buf));
 	spin_unlock(&target_list_lock);
 
@@ -189,12 +211,39 @@ static ssize_t store_remote_mac(struct n
 		cur = delim + 1;
 	}
 	spin_lock(&target_list_lock);
+	if (nt->enabled) {
+		spin_unlock(&target_list_lock);
+		return -EINVAL;
+	}
 	memcpy(nt->np.remote_mac, input_mac, MAC_ADDR_DIGIT);
 	spin_unlock(&target_list_lock);
 
 	return count;
 }
 
+static ssize_t store_enabled(struct netconsole_target *nt, const char *buf,
+			    size_t count)
+{
+	int enabled = 0;
+
+	if (count >= 2 && (count != 2 || buf[count - 1] != '\n')) {
+		printk(KERN_ERR "netconsole: invalid argument: %s\n", buf);
+		return -EINVAL;
+	} else if (strncmp(buf, "1", 1) == 0) {
+		enabled = 1;
+	} else if(strncmp(buf, "0", 1) == 0) {
+		enabled = 0;
+	} else {
+		printk(KERN_ERR "netconsole: invalid argument: %s\n", buf);
+		return -EINVAL;
+	}
+	spin_lock(&target_list_lock);
+	nt->enabled = enabled;
+	spin_unlock(&target_list_lock);
+
+	return count;
+}
+
 static ssize_t store_remove(struct netconsole_target *nt, const char *buf,
 			    size_t count)
 {
@@ -219,6 +268,8 @@ static NETCON_CLASS_ATTR(remote_ip, S_IR
 static NETCON_CLASS_ATTR(local_mac, S_IRUGO, show_local_mac, NULL);
 static NETCON_CLASS_ATTR(remote_mac, S_IRUGO | S_IWUSR,
 			 show_remote_mac, store_remote_mac);
+static NETCON_CLASS_ATTR(enabled, S_IRUGO | S_IWUSR,
+			 show_enabled, store_enabled);
 static NETCON_CLASS_ATTR(remove, S_IWUSR, NULL, store_remove);
 
 static struct attribute *target_attrs[] = {
@@ -230,6 +281,7 @@ static struct attribute *target_attrs[] 
 	&target_attr_remote_ip.attr,
 	&target_attr_local_mac.attr,
 	&target_attr_remote_mac.attr,
+	&target_attr_enabled.attr,
 	&target_attr_remove.attr,
 	NULL
 };
@@ -245,7 +297,7 @@ static ssize_t show_target_attr(struct k
 	if (na->show)
 		return na->show(nt, buffer);
 	else
-		return -EACCES;
+		return -EINVAL;
 }
 
 static ssize_t store_target_attr(struct kobject *kobj,
@@ -259,7 +311,7 @@ static ssize_t store_target_attr(struct 
 	if (na->store)
 		return na->store(nt, buffer, count);
 	else
-		return -EACCES;
+		return -EINVAL;
 }
 
 static void release_target(struct kobject *kobj)
@@ -325,6 +377,7 @@ static int add_target(char* target_confi
 
 	atomic_inc(&target_count);
 	new_target->id = atomic_read(&target_count);
+	new_target->enabled = 1;
 
 	printk(KERN_INFO "netconsole: add target: "
 	       "remote ip_addr=%d.%d.%d.%d remote port=%d\n",
@@ -371,7 +424,8 @@ static void write_msg(struct console *co
 	for(left = len; left; ) {
 		frag = min(left, MAX_PRINT_CHUNK);
 		list_for_each_entry(target, &target_list, list) {
-			netpoll_send_udp(&target->np, msg, frag);
+			if (target->enabled)
+				netpoll_send_udp(&target->np, msg, frag);
 		}
 		msg += frag;
 		left -= frag;


-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
