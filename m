Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTK0WJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTK0WJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 17:09:36 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:4613 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261332AbTK0WJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 17:09:27 -0500
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Timo Kamph <timo@kamph.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, davem@redhat.com
In-Reply-To: <3FC67128.14704.30155D53@localhost>
References: <20031127142125.GG8276@jdj5.mit.edu>
	 <3FC67128.14704.30155D53@localhost>
Content-Type: multipart/mixed; boundary="=-H2KzLXVDXFWGoIKEFjkO"
Message-Id: <1069970946.2138.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 27 Nov 2003 23:09:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H2KzLXVDXFWGoIKEFjkO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-11-27 at 21:48, Timo Kamph wrote:

> > +	strlcpy(label->label, name, sizeof(label->name));
>                                                                        ^^^^^^
> I guess this shoud be label->label, or am I wrong?

Oh my god! Two consecutive mistakes with the same patch! I should have
some sleep... Here's the one with the typo corrected.

Thanks for pointing it out. Sorry for resending this patch so many
times.

--=-H2KzLXVDXFWGoIKEFjkO
Content-Disposition: attachment; filename=strlcpy-ipv4.patch
Content-Type: text/x-patch; name=strlcpy-ipv4.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.0-test11.orig/net/core/dev.c linux-2.6.0-test11/net/core/dev.c
--- linux-2.6.0-test11.orig/net/core/dev.c	2003-11-26 21:44:11.000000000 +0100
+++ linux-2.6.0-test11/net/core/dev.c	2003-11-27 13:21:12.791315993 +0100
@@ -335,7 +335,7 @@
 	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
 		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
 			memset(s[i].name, 0, sizeof(s[i].name));
-			strcpy(s[i].name, name);
+			strlcpy(s[i].name, name, sizeof(s[i].name));
 			memcpy(&s[i].map, map, sizeof(s[i].map));
 			break;
 		}
@@ -653,7 +653,7 @@
 	for (i = 0; i < 100; i++) {
 		snprintf(buf, sizeof(buf), name, i);
 		if (!__dev_get_by_name(buf)) {
-			strcpy(dev->name, buf);
+			strlcpy(dev->name, buf, sizeof(dev->name));
 			return i;
 		}
 	}
@@ -1773,7 +1773,7 @@
 		return -ENODEV;
 	}
 
-	strcpy(ifr.ifr_name, dev->name);
+	strlcpy(ifr.ifr_name, dev->name, sizeof(ifr.ifr_name));
 	read_unlock(&dev_base_lock);
 
 	if (copy_to_user(arg, &ifr, sizeof(struct ifreq)))
diff -uNr linux-2.6.0-test11.orig/net/core/sock.c linux-2.6.0-test11/net/core/sock.c
--- linux-2.6.0-test11.orig/net/core/sock.c	2003-11-26 21:44:57.000000000 +0100
+++ linux-2.6.0-test11/net/core/sock.c	2003-11-27 13:22:22.150223793 +0100
@@ -157,7 +157,7 @@
 	static int warned;
 	static char warncomm[16];
 	if (strcmp(warncomm, current->comm) && warned < 5) { 
-		strcpy(warncomm,  current->comm); 
+		strlcpy(warncomm,  current->comm, sizeof(warncomm)); 
 		printk(KERN_WARNING "process `%s' is using obsolete "
 		       "%s SO_BSDCOMPAT\n", warncomm, name);
 		warned++;
diff -uNr linux-2.6.0-test11.orig/net/ipv4/devinet.c linux-2.6.0-test11/net/ipv4/devinet.c
--- linux-2.6.0-test11.orig/net/ipv4/devinet.c	2003-11-26 21:43:25.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/devinet.c	2003-11-27 13:31:43.971262502 +0100
@@ -731,9 +731,9 @@
 			break;
 		memset(&ifr, 0, sizeof(struct ifreq));
 		if (ifa->ifa_label)
-			strcpy(ifr.ifr_name, ifa->ifa_label);
+			strlcpy(ifr.ifr_name, ifa->ifa_label, sizeof(ifr.ifr_name));
 		else
-			strcpy(ifr.ifr_name, dev->name);
+			strlcpy(ifr.ifr_name, dev->name, sizeof(ifr.ifr_name));
 
 		(*(struct sockaddr_in *)&ifr.ifr_addr).sin_family = AF_INET;
 		(*(struct sockaddr_in *)&ifr.ifr_addr).sin_addr.s_addr =
diff -uNr linux-2.6.0-test11.orig/net/ipv4/ipconfig.c linux-2.6.0-test11/net/ipv4/ipconfig.c
--- linux-2.6.0-test11.orig/net/ipv4/ipconfig.c	2003-11-26 21:42:55.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/ipconfig.c	2003-11-27 13:32:06.904650818 +0100
@@ -299,7 +299,7 @@
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name);
+	strlcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name, sizeof(ir.ifr_ifrn.ifrn_name));
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = ic_dev_ioctl(SIOCSIFADDR, &ir)) < 0) {
 		printk(KERN_ERR "IP-Config: Unable to set interface address (%d).\n", err);
diff -uNr linux-2.6.0-test11.orig/net/ipv4/ip_gre.c linux-2.6.0-test11/net/ipv4/ip_gre.c
--- linux-2.6.0-test11.orig/net/ipv4/ip_gre.c	2003-11-26 21:44:59.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/ip_gre.c	2003-11-27 13:30:13.342198122 +0100
@@ -1163,7 +1163,7 @@
 	iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	memcpy(dev->dev_addr, &tunnel->parms.iph.saddr, 4);
 	memcpy(dev->broadcast, &tunnel->parms.iph.daddr, 4);
@@ -1227,7 +1227,7 @@
 	struct iphdr *iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	iph->version		= 4;
 	iph->protocol		= IPPROTO_GRE;
diff -uNr linux-2.6.0-test11.orig/net/ipv4/ipip.c linux-2.6.0-test11/net/ipv4/ipip.c
--- linux-2.6.0-test11.orig/net/ipv4/ipip.c	2003-11-26 21:46:10.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/ipip.c	2003-11-27 13:30:42.476717090 +0100
@@ -815,7 +815,7 @@
 	iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	memcpy(dev->dev_addr, &tunnel->parms.iph.saddr, 4);
 	memcpy(dev->broadcast, &tunnel->parms.iph.daddr, 4);
@@ -853,7 +853,7 @@
 	struct iphdr *iph = &tunnel->parms.iph;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strlcpy(tunnel->parms.name, dev->name, sizeof(tunnel->parms.name));
 
 	iph->version		= 4;
 	iph->protocol		= IPPROTO_IPIP;
diff -uNr linux-2.6.0-test11.orig/net/ipv4/ipvs/ip_vs_ctl.c linux-2.6.0-test11/net/ipv4/ipvs/ip_vs_ctl.c
--- linux-2.6.0-test11.orig/net/ipv4/ipvs/ip_vs_ctl.c	2003-11-26 21:45:33.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/ipvs/ip_vs_ctl.c	2003-11-27 13:36:43.776537082 +0100
@@ -1918,7 +1918,7 @@
 	dst->addr = src->addr;
 	dst->port = src->port;
 	dst->fwmark = src->fwmark;
-	strcpy(dst->sched_name, src->scheduler->name);
+	strlcpy(dst->sched_name, src->scheduler->name, sizeof(dst->sched_name));
 	dst->flags = src->flags;
 	dst->timeout = src->timeout / HZ;
 	dst->netmask = src->netmask;
@@ -2163,12 +2163,12 @@
 		memset(&d, 0, sizeof(d));
 		if (ip_vs_sync_state & IP_VS_STATE_MASTER) {
 			d[0].state = IP_VS_STATE_MASTER;
-			strcpy(d[0].mcast_ifn, ip_vs_master_mcast_ifn);
+			strlcpy(d[0].mcast_ifn, ip_vs_master_mcast_ifn, sizeof(d[0].mcast_ifn));
 			d[0].syncid = ip_vs_master_syncid;
 		}
 		if (ip_vs_sync_state & IP_VS_STATE_BACKUP) {
 			d[1].state = IP_VS_STATE_BACKUP;
-			strcpy(d[1].mcast_ifn, ip_vs_backup_mcast_ifn);
+			strlcpy(d[1].mcast_ifn, ip_vs_backup_mcast_ifn, sizeof(d[1].mcast_ifn));
 			d[1].syncid = ip_vs_backup_syncid;
 		}
 		if (copy_to_user(user, &d, sizeof(d)) != 0)
diff -uNr linux-2.6.0-test11.orig/net/ipv4/ipvs/ip_vs_sync.c linux-2.6.0-test11/net/ipv4/ipvs/ip_vs_sync.c
--- linux-2.6.0-test11.orig/net/ipv4/ipvs/ip_vs_sync.c	2003-11-26 21:42:47.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/ipvs/ip_vs_sync.c	2003-11-27 13:34:51.218619748 +0100
@@ -854,10 +854,10 @@
 
 	ip_vs_sync_state |= state;
 	if (state == IP_VS_STATE_MASTER) {
-		strcpy(ip_vs_master_mcast_ifn, mcast_ifn);
+		strlcpy(ip_vs_master_mcast_ifn, mcast_ifn, sizeof(ip_vs_master_mcast_ifn));
 		ip_vs_master_syncid = syncid;
 	} else {
-		strcpy(ip_vs_backup_mcast_ifn, mcast_ifn);
+		strlcpy(ip_vs_backup_mcast_ifn, mcast_ifn, sizeof(ip_vs_backup_mcast_ifn));
 		ip_vs_backup_syncid = syncid;
 	}
 
diff -uNr linux-2.6.0-test11.orig/net/ipv4/netfilter/arp_tables.c linux-2.6.0-test11/net/ipv4/netfilter/arp_tables.c
--- linux-2.6.0-test11.orig/net/ipv4/netfilter/arp_tables.c	2003-11-26 21:45:10.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/netfilter/arp_tables.c	2003-11-27 13:23:24.284474101 +0100
@@ -1086,7 +1086,7 @@
 			       sizeof(info.underflow));
 			info.num_entries = t->private->number;
 			info.size = t->private->size;
-			strcpy(info.name, name);
+			strlcpy(info.name, name, sizeof(info.name));
 
 			if (copy_to_user(user, &info, *len) != 0)
 				ret = -EFAULT;
diff -uNr linux-2.6.0-test11.orig/net/ipv4/netfilter/ipchains_core.c linux-2.6.0-test11/net/ipv4/netfilter/ipchains_core.c
--- linux-2.6.0-test11.orig/net/ipv4/netfilter/ipchains_core.c	2003-11-26 21:45:26.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/netfilter/ipchains_core.c	2003-11-27 13:28:39.884442527 +0100
@@ -1173,7 +1173,7 @@
 		= kmalloc(SIZEOF_STRUCT_IP_CHAIN, GFP_KERNEL);
 	if (label == NULL)
 		panic("Can't kmalloc for firewall chains.\n");
-	strcpy(label->label,name);
+	strlcpy(label->label, name, sizeof(label->label));
 	label->next = NULL;
 	label->chain = NULL;
 	label->refcount = ref;
diff -uNr linux-2.6.0-test11.orig/net/ipv4/netfilter/ip_queue.c linux-2.6.0-test11/net/ipv4/netfilter/ip_queue.c
--- linux-2.6.0-test11.orig/net/ipv4/netfilter/ip_queue.c	2003-11-26 21:46:12.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/netfilter/ip_queue.c	2003-11-27 13:29:19.651041898 +0100
@@ -235,12 +235,12 @@
 	pmsg->hw_protocol     = entry->skb->protocol;
 	
 	if (entry->info->indev)
-		strcpy(pmsg->indev_name, entry->info->indev->name);
+		strlcpy(pmsg->indev_name, entry->info->indev->name, sizeof(pmsg->indev_name));
 	else
 		pmsg->indev_name[0] = '\0';
 	
 	if (entry->info->outdev)
-		strcpy(pmsg->outdev_name, entry->info->outdev->name);
+		strlcpy(pmsg->outdev_name, entry->info->outdev->name, sizeof(pmsg->outdev_name));
 	else
 		pmsg->outdev_name[0] = '\0';
 	
diff -uNr linux-2.6.0-test11.orig/net/ipv4/netfilter/ip_tables.c linux-2.6.0-test11/net/ipv4/netfilter/ip_tables.c
--- linux-2.6.0-test11.orig/net/ipv4/netfilter/ip_tables.c	2003-11-26 21:43:25.000000000 +0100
+++ linux-2.6.0-test11/net/ipv4/netfilter/ip_tables.c	2003-11-27 13:23:11.366451326 +0100
@@ -1277,7 +1277,7 @@
 			       sizeof(info.underflow));
 			info.num_entries = t->private->number;
 			info.size = t->private->size;
-			strcpy(info.name, name);
+			strlcpy(info.name, name, sizeof(info.name));
 
 			if (copy_to_user(user, &info, *len) != 0)
 				ret = -EFAULT;

--=-H2KzLXVDXFWGoIKEFjkO--

