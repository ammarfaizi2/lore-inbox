Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbRAaEDL>; Tue, 30 Jan 2001 23:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRAaECw>; Tue, 30 Jan 2001 23:02:52 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:13551 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129875AbRAaECp>;
	Tue, 30 Jan 2001 23:02:45 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Javier Miguel Rodríguez (GUFO) 
	<javier.miguel@futurainteractiva.com>
Cc: linux-kernel@vger.kernel.org, netfilter@us5.samba.org
Subject: Re: 2.4.0+ipchains+sparc 450= CRASH! 
In-Reply-To: Your message of "Tue, 30 Jan 2001 14:07:01 -0000."
             <01013014063301.15042@Petete> 
Date: Wed, 31 Jan 2001 15:02:31 +1100
Message-Id: <E14NoTY-0007lF-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <01013014063301.15042@Petete> you write:
>         I use kernel 2.4.0 + ipchains compatibilty. I use ipchains 1.3.9
>  
>  This code:
>  
>  ipchains -A input -p tcp --dport 80 -s 192.168.0.35 -j REDIRECT 81

Oops.  Thanks to Anton for testing and touching up this patch.

The 2.0/2.2 setsockopt code used to do the copy_from_user for you...

Rusty.
PS.  No security worries, as you need CAP_NET_ADMIN for this...
--
Premature optmztion is rt of all evl. --DK

diff -ru --exclude-from=exclude linux/net/ipv4/netfilter/ip_fw_compat.c linux_work/net/ipv4/netfilter/ip_fw_compat.c
--- linux/net/ipv4/netfilter/ip_fw_compat.c	Wed Jan 31 14:47:42 2001
+++ linux_work/net/ipv4/netfilter/ip_fw_compat.c	Wed Jan 31 14:43:23 2001
@@ -9,6 +9,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
+#include <asm/uaccess.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <linux/netfilter_ipv4/compat_firewall.h>
@@ -198,14 +199,28 @@
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
