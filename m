Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUGCFru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUGCFru (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUGCFrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 01:47:49 -0400
Received: from mail.enyo.de ([212.9.189.167]:15367 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264914AbUGCFrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 01:47:45 -0400
To: bugtraq@securityfocus.com
Cc: full-disclosure@lists.netsys.com, linux-kernel@vger.kernel.org
Subject: Re: SUSE Security Announcement: kernel (SUSE-SA:2004:020)
References: <Pine.LNX.4.58.0407021848160.30205@qrag.fhfr.qr>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sat, 03 Jul 2004 07:47:40 +0200
In-Reply-To: <Pine.LNX.4.58.0407021848160.30205@qrag.fhfr.qr> (Roman
 Drahtmueller's message of "Fri, 2 Jul 2004 18:48:27 +0200 (MEST)")
Message-ID: <873c49fxqb.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roman Drahtmueller:

>     Multiple security vulnerabilities are being addressed with this security
>     update of the Linux kernel.

Do you plan to release generic advisories (not SuSE-specific ones) for
some of the issues?

>     Kernel memory access vulnerabilities are fixed in the e1000, decnet, 
>     acpi_asus, alsa, airo/WLAN, pss and mpu401 drivers. These 
>     vulnerabilities can lead to kernel memory read access, write access 
>     and local denial of service conditions, resulting in access to the 
>     root account for an attacker with a local account on the affected 
>     system.

These are too many changes to reproduce here.

>     Missing Discretionary Access Control (DAC) checks in the chown(2) system
>     call allow an attacker with a local account to change the group
>     ownership of arbitrary files, which leads to root privileges on affected
>     systems.

This patch also applies to 2.6.7 (in the sense of patch(3), not
necessarily semantically).

The problem is the missing check against the fsuid, a Linux-specific
user ID used by NFS servers and the like.  (It's been added so that
processes can assume the UID of different users without exposing
themselves to signals from those users.)

diff -urNp linux-2.6.5/fs/attr.c linux-2.6.5.SUSE/fs/attr.c
--- linux-2.6.5/fs/attr.c	2004-04-04 05:36:24.000000000 +0200
+++ linux-2.6.5.SUSE/fs/attr.c	2004-06-28 14:25:28.137185522 +0200
@@ -35,7 +35,8 @@ int inode_change_ok(struct inode *inode,
 
 	/* Make sure caller can chgrp. */
 	if ((ia_valid & ATTR_GID) &&
-	    (!in_group_p(attr->ia_gid) && attr->ia_gid != inode->i_gid) &&
+	    (current->fsuid != inode->i_uid ||
+	    (!in_group_p(attr->ia_gid) && attr->ia_gid != inode->i_gid)) &&
 	    !capable(CAP_CHOWN))
 		goto error;
 
diff -urNp linux-2.6.5/fs/proc/generic.c linux-2.6.5.SUSE/fs/proc/generic.c
--- linux-2.6.5/fs/proc/generic.c	2004-06-28 14:20:33.462438777 +0200
+++ linux-2.6.5.SUSE/fs/proc/generic.c	2004-06-28 14:25:40.232339376 +0200
@@ -230,14 +230,21 @@ out:
 static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = dentry->d_inode;
-	int error = inode_setattr(inode, iattr);
-	if (!error) {
-		struct proc_dir_entry *de = PDE(inode);
-		de->uid = inode->i_uid;
-		de->gid = inode->i_gid;
-		de->mode = inode->i_mode;
-	}
+	struct proc_dir_entry *de = PDE(inode);
+	int error;
+
+	error = inode_change_ok(inode, iattr);
+	if (error)
+		goto out;
 
+	error = inode_setattr(inode, iattr);
+	if (error)
+		goto out;
+	
+	de->uid = inode->i_uid;
+	de->gid = inode->i_gid;
+	de->mode = inode->i_mode;
+out:
 	return error;
 }
 
>     The only network-related vulnerability fixed with the kernel updates
>     that are subject to this announcement affect the SUSE Linux 9.1 
>     distribution only, as it is based on a 2.6 kernel. Found and reported 
>     to bugtraq by Adam Osuchowski and Tomasz Dubinski, the vulnerability 
>     allows a remote attacker to send a specially crafted TCP packet to a 
>     vulnerable system, causing that system to stall if it makes use of 
>     TCP option matching netfilter rules.

This patch is essentially the same that was presented by the
discoverers, but it also fixes the same code for IPv6.  The IPv6 fix
appears to be SuSE-specific, the official 2.6.7 code is different (it
doesn't use skb_copy_bits()), and apparently doesn't have this
particular bug.

diff -urNp linux-2.6.5/net/ipv4/netfilter/ip_tables.c linux-2.6.5.SUSE/net/ipv4/netfilter/ip_tables.c
--- linux-2.6.5/net/ipv4/netfilter/ip_tables.c	2004-04-04 05:36:47.000000000 +0200
+++ linux-2.6.5.SUSE/net/ipv4/netfilter/ip_tables.c	2004-07-01 14:11:14.670389325 +0200
@@ -1461,7 +1461,7 @@ tcp_find_option(u_int8_t option,
 		int *hotdrop)
 {
 	/* tcp.doff is only 4 bits, ie. max 15 * 4 bytes */
-	char opt[60 - sizeof(struct tcphdr)];
+	u_int8_t opt[60 - sizeof(struct tcphdr)];
 	unsigned int i;
 
 	duprintf("tcp_match: finding option\n");
diff -urNp linux-2.6.5/net/ipv6/netfilter/ip6_tables.c linux-2.6.5.SUSE/net/ipv6/netfilter/ip6_tables.c
--- linux-2.6.5/net/ipv6/netfilter/ip6_tables.c	2004-07-01 14:09:24.481930748 +0200
+++ linux-2.6.5.SUSE/net/ipv6/netfilter/ip6_tables.c	2004-07-01 14:13:30.228181645 +0200
@@ -1543,7 +1543,7 @@ tcp_find_option(u_int8_t option,
 		int *hotdrop)
 {
 	/* tcp.doff is only 4 bits, ie. max 15 * 4 bytes */
-	char opt[60 - sizeof(struct tcphdr)];
+	u_int8_t opt[60 - sizeof(struct tcphdr)];
 	unsigned int i;
 
 	duprintf("tcp_match: finding option\n");

