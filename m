Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbTFVA73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 20:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTFVA73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 20:59:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:2781 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265390AbTFVA7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 20:59:16 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: nfs@lists.sourceforge.net
Subject: [PATCH] ipconfig dhcp mtu option support
Date: Sun, 22 Jun 2003 03:13:13 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, etherboot-developers@lists.sourceforge.net
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306220313.13040.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while experimenting with jumbo frames in a diskless setup, I came
across the problem to enable them properly on the client. This is 
due to missing support for the dhcp interface-mtu option in ipconfig.

It took me this patch to make them work. Note, that I ommited the
bootp_init_ext, so this one is limited to dhcp by now... While at
it, I've cleaned up the ifreq struct usage a bit.

If you're going to test this, please let me know, if it __works__ 
for you, too, since I plan to send it to Marcelo, when 'enough' 
positives arrived here.

BTW, anybody willing to apply and test this on 2.5?

Enjoy,
Pete

P.S.: I'm using e1000 (Intel Pro/1000 MT Desktop) GB NICs here.

--- linux-2.4.20/net/ipv4/ipconfig.c.orig	2003-06-21 17:24:21.000000000 +0200
+++ linux/net/ipv4/ipconfig.c	2003-06-22 01:50:53.000000000 +0200
@@ -27,10 +27,13 @@
  *  Merged changes from 2.2.19 into 2.4.3
  *              -- Eric Biederman <ebiederman@lnxi.com>, 22 April Aug 2001
  *
  *  Multipe Nameservers in /proc/net/pnp
  *              --  Josef Siemes <jsiemes@web.de>, Aug 2002
+ *
+ *  Support for MTU selection via DHCP
+ *              -- Hans-Peter Jansen <hpj@urpla.net>, June 2003
  */
 
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -144,10 +147,13 @@
  */
 
 /* Name of user-selected boot device */
 static char user_dev_name[IFNAMSIZ] __initdata = { 0, };
 
+/* MTU of device (if requested) */
+static int ic_dev_mtu __initdata = 0;
+
 /* Protocols supported by available interfaces */
 static int ic_proto_have_if __initdata = 0;
 
 #ifdef IPCONFIG_DYNAMIC
 static spinlock_t ic_recv_lock = SPIN_LOCK_UNLOCKED;
@@ -262,21 +268,32 @@
 	sin->sin_family = AF_INET;
 	sin->sin_addr.s_addr = addr;
 	sin->sin_port = port;
 }
 
-static int __init ic_dev_ioctl(unsigned int cmd, struct ifreq *arg)
+static int __init ic_devinet_ioctl(unsigned int cmd, struct ifreq *arg)
 {
 	int res;
 
 	mm_segment_t oldfs = get_fs();
 	set_fs(get_ds());
 	res = devinet_ioctl(cmd, arg);
 	set_fs(oldfs);
 	return res;
 }
 
+static int __init ic_dev_ioctl(unsigned int cmd, struct ifreq *arg)
+{
+	int res;
+
+	mm_segment_t oldfs = get_fs();
+	set_fs(get_ds());
+	res = dev_ioctl(cmd, arg);
+	set_fs(oldfs);
+	return res;
+}
+
 static int __init ic_route_ioctl(unsigned int cmd, struct rtentry *arg)
 {
 	int res;
 
 	mm_segment_t oldfs = get_fs();
@@ -291,30 +308,38 @@
  */
 
 static int __init ic_setup_if(void)
 {
 	struct ifreq ir;
-	struct sockaddr_in *sin = (void *) &ir.ifr_ifru.ifru_addr;
+	struct sockaddr_in *sin = (void *) &ir.ifr_addr;
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name);
+	strcpy(ir.ifr_name, ic_dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
-	if ((err = ic_dev_ioctl(SIOCSIFADDR, &ir)) < 0) {
+	if ((err = ic_devinet_ioctl(SIOCSIFADDR, &ir)) < 0) {
 		printk(KERN_ERR "IP-Config: Unable to set interface address (%d).\n", err);
 		return -1;
 	}
 	set_sockaddr(sin, ic_netmask, 0);
-	if ((err = ic_dev_ioctl(SIOCSIFNETMASK, &ir)) < 0) {
+	if ((err = ic_devinet_ioctl(SIOCSIFNETMASK, &ir)) < 0) {
 		printk(KERN_ERR "IP-Config: Unable to set interface netmask (%d).\n", err);
 		return -1;
 	}
 	set_sockaddr(sin, ic_myaddr | ~ic_netmask, 0);
-	if ((err = ic_dev_ioctl(SIOCSIFBRDADDR, &ir)) < 0) {
+	if ((err = ic_devinet_ioctl(SIOCSIFBRDADDR, &ir)) < 0) {
 		printk(KERN_ERR "IP-Config: Unable to set interface broadcast address (%d).\n", err);
 		return -1;
 	}
+	if (ic_dev_mtu) {
+		strcpy(ir.ifr_name, ic_dev->name);
+		ir.ifr_mtu = ic_dev_mtu;
+		if ((err = ic_dev_ioctl(SIOCSIFMTU, &ir))  < 0)
+			printk(KERN_ERR "IP-Config: Unable to set interface mtu to %d (%d).\n", 
+				ic_dev_mtu, err);
+			/* Don't error out because set mtu failure, just notice the operator */
+	}
 	return 0;
 }
 
 static int __init ic_setup_routes(void)
 {
@@ -576,10 +601,11 @@
 			3,	/* Default gateway */
 			6,	/* DNS server */
 			12,	/* Host name */
 			15,	/* Domain name */
 			17,	/* Boot path */
+			26,	/* MTU */
 			40,	/* NIS domain name */
 		};
 
 		*e++ = 55;	/* Parameter request list */
 		*e++ = sizeof(ic_req_params);
@@ -777,10 +803,13 @@
 			break;
 		case 17:	/* Root path */
 			if (!root_server_path[0])
 				ic_bootp_string(root_server_path, ext+1, *ext, sizeof(root_server_path));
 			break;
+		case 26:
+			ic_dev_mtu = ntohs(*(u16 *)(ext+1));
+			break;
 		case 40:	/* NIS Domain name (_not_ DNS) */
 			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
 			break;
 	}
 }
@@ -1294,10 +1323,12 @@
 	printk(",\n     host=%s, domain=%s, nis-domain=%s",
 	       system_utsname.nodename, ic_domain, system_utsname.domainname);
 	printk(",\n     bootserver=%u.%u.%u.%u", NIPQUAD(ic_servaddr));
 	printk(", rootserver=%u.%u.%u.%u", NIPQUAD(root_server_addr));
 	printk(", rootpath=%s", root_server_path);
+	if (ic_dev_mtu)
+		printk(", mtu=%d", ic_dev_mtu);
 	printk("\n");
 #endif /* !SILENT */
 
 	return 0;
 }


