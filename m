Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCTIlq>; Tue, 20 Mar 2001 03:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRCTIlg>; Tue, 20 Mar 2001 03:41:36 -0500
Received: from [32.97.166.34] ([32.97.166.34]:61855 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S129164AbRCTIlW>;
	Tue, 20 Mar 2001 03:41:22 -0500
Message-Id: <m14fHjL-001PKjC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1 
In-Reply-To: Your message of "Thu, 15 Mar 2001 18:24:51 -0800."
             <200103160224.SAA03920@csl.Stanford.EDU> 
Date: Tue, 20 Mar 2001 19:42:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200103160224.SAA03920@csl.Stanford.EDU> you write:
> Hi,
> 
> I wrote an extension to gcc that does global analysis to determine
> which pointers in 2.4.1 are ever treated as user space pointers (i.e,
> passed to copy_*_user, verify_area, etc) and then makes sure they are
> always treated that way.

Hi Dawson,

	FYI, you missed one, which was fixed in 2.4.2.  This is tricky
since ip_fw_ctl is defined in TWO (mutually exclusive) places:
ipfwadm_core.c and ipchains_core.c.

	Oh, I see in a later message that you do CONFIG=y.  Hmm, you
won't even get asked about these if you've said CONFIG=y to
CONFIG_IPTABLES.  You're best off trying CONFIG=m, which allows a
compile of everything, but that may be outside your framework, in
which case a series of different configurations might be in order...

diff -u --recursive --new-file v2.4.1/linux/net/ipv4/netfilter/ip_fw_compat.c linux/net/ipv4/netfilter/ip_fw_compat.c
--- v2.4.1/linux/net/ipv4/netfilter/ip_fw_compat.c	Mon Sep 18 15:09:55 2000
+++ linux/net/ipv4/netfilter/ip_fw_compat.c	Fri Feb  9 11:34:13 2001
@@ -9,6 +9,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
+#include <asm/uaccess.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <linux/netfilter_ipv4/compat_firewall.h>
@@ -197,14 +198,28 @@
 	return NF_ACCEPT;
 }
 
-extern int ip_fw_ctl(int optval, void *user, unsigned int len);
+extern int ip_fw_ctl(int optval, void *m, unsigned int len);
 
 static int sock_fn(struct sock *sk, int optval, void *user, unsigned int len)
 {
+	/* MAX of:
+	   2.2: sizeof(struct ip_fwtest) (~14x4 + 3x4 = 17x4)
+	   2.2: sizeof(struct ip_fwnew) (~1x4 + 15x4 + 3x4 + 3x4 = 22x4)
+	   2.0: sizeof(struct ip_fw) (~25x4)
+
+	   We can't include both 2.0 and 2.2 headers, they conflict.
+	   Hence, 200 is a good number. --RR */
+	char tmp_fw[200];
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	return -ip_fw_ctl(optval, user, len);
+	if (len > sizeof(tmp_fw) || len < 1)
+		return -EINVAL;
+
+	if (copy_from_user(&tmp_fw, user, len))
+		return -EFAULT;
+
+	return -ip_fw_ctl(optval, &tmp_fw, len);
 }
 
 static struct nf_hook_ops preroute_ops

Hope that helps, and keep up the great work!
Rusty.
--
Premature optmztion is rt of all evl. --DK

