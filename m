Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVBCEoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVBCEoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 23:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVBCEoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 23:44:07 -0500
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:62967 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S262838AbVBCEnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 23:43:47 -0500
From: Shane Hathaway <shane@hathawaymix.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Configure MTU via kernel DHCP
Date: Wed, 2 Feb 2005 21:47:59 -0700
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A0aACW4YfLlU66g"
Message-Id: <200502022148.00045.shane@hathawaymix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_A0aACW4YfLlU66g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch enhances the kernel's DHCP client support (in 
net/ipv4/ipconfig.c) to set the interface MTU if provided by the DHCP server.  
Without this patch, it's difficult to netboot on a network that uses jumbo 
frames.  The patch is based on 2.6.10, but I'll update it to the latest 
testing kernel if that would expedite its inclusion in the kernel.

More background: it's currently difficult to netboot on a jumbo frame network 
because when clients try to mount the root partition, they are still 
configured with a small MTU and therefore reject packets sent by the 
jumbo-frame-enabled NFS server.  Linux needs to set the client MTU before 
mounting any NFS shares.  Fortunately, the DHCP protocol already supports 
setting the MTU; this patch just integrates that feature into the kernel.

Incidentally, ipconfig.c doesn't appear to do enough bounds checking on byte 1 
of DHCP/BOOTP extension fields (the length field).  It looks like a malicious 
DHCP server could mess with kernel memory that way.  I could try to fix the 
hole, but maybe someone more experienced with this code would like to verify 
there's a problem first.

Shane

--Boundary-00=_A0aACW4YfLlU66g
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ipconfig-mtu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipconfig-mtu.patch"

--- ipconfig.c.orig	2005-02-02 17:23:35.175853560 -0700
+++ ipconfig.c	2005-02-02 19:10:39.843155672 -0700
@@ -126,6 +126,7 @@
 
 int ic_host_name_set __initdata = 0;		/* Host name set by us? */
 
+u16 ic_mtu = 0;			/* Interface MTU */
 u32 ic_myaddr = INADDR_NONE;		/* My IP address */
 u32 ic_netmask = INADDR_NONE;	/* Netmask for local subnet */
 u32 ic_gateway = INADDR_NONE;	/* Gateway IP address */
@@ -322,6 +323,13 @@
 		printk(KERN_ERR "IP-Config: Unable to set interface broadcast address (%d).\n", err);
 		return -1;
 	}
+	rtnl_shlock();
+	err = dev_set_mtu(ic_dev, ic_mtu);
+	rtnl_shunlock();
+	if (err < 0) {
+		printk(KERN_ERR "IP-Config: Unable to set interface MTU (%d).\n", err);
+		return -1;
+	}
 	return 0;
 }
 
@@ -609,6 +617,7 @@
 			12,	/* Host name */
 			15,	/* Domain name */
 			17,	/* Boot path */
+			26,	/* MTU */
 			40,	/* NIS domain name */
 		};
 
@@ -812,6 +821,9 @@
 			if (!root_server_path[0])
 				ic_bootp_string(root_server_path, ext+1, *ext, sizeof(root_server_path));
 			break;
+		case 26:	/* Interface MTU */
+			ic_mtu = (((u16) ext[1]) << 8) | ext[2];
+			break;
 		case 40:	/* NIS Domain name (_not_ DNS) */
 			ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
 			break;
@@ -1362,8 +1374,9 @@
 	 * Clue in the operator.
 	 */
 	printk("IP-Config: Complete:");
-	printk("\n      device=%s", ic_dev->name);
-	printk(", addr=%u.%u.%u.%u", NIPQUAD(ic_myaddr));
+	printk("\n     device=%s", ic_dev->name);
+	printk(", mtu=%u", (unsigned int)ic_mtu);
+	printk(",\n     addr=%u.%u.%u.%u", NIPQUAD(ic_myaddr));
 	printk(", mask=%u.%u.%u.%u", NIPQUAD(ic_netmask));
 	printk(", gw=%u.%u.%u.%u", NIPQUAD(ic_gateway));
 	printk(",\n     host=%s, domain=%s, nis-domain=%s",

--Boundary-00=_A0aACW4YfLlU66g--
