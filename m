Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKERce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTKERce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:32:34 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:33292 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263015AbTKERca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:32:30 -0500
Date: Thu, 06 Nov 2003 02:32:37 +0900 (JST)
Message-Id: <20031106.023237.110009516.yoshfuji@linux-ipv6.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       yoshfuji@linux-ipv6.org, davem@redhat.com
Subject: Re: 2.6.0-test9: Kernel OOPS in /sbin/nameif
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu>
References: <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu> (at Wed, 05 Nov 2003 12:03:08 -0500), Valdis.Kletnieks@vt.edu says:

> Basic summary - when /sbin/nameif goes to rename an interface, things
> go totally pear-shaped.  nameif itself croaks, and apparently leaves
> data structures corrupted - on a subsequent 'ifup lo' or 'shutdown -r'
> the system locks up solid.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000000d8
>  printing eip:
> c033eb32
:
> EIP is at addrconf_sysctl_unregister+0x7/0x3a
:
> Call Trace:
>  [<c033cdda>] addrconf_notify+0xc4/0xfb
>  [<c012673d>] notifier_call_chain+0x1c/0x37
:

Please try this.

===== net/ipv6/addrconf.c 1.74 vs edited =====
--- 1.74/net/ipv6/addrconf.c	Tue Oct 28 20:10:47 2003
+++ edited/net/ipv6/addrconf.c	Thu Nov  6 02:30:03 2003
@@ -1877,10 +1877,12 @@
 		break;
 	case NETDEV_CHANGENAME:
 #ifdef CONFIG_SYSCTL
-		addrconf_sysctl_unregister(&idev->cnf);
-		neigh_sysctl_unregister(idev->nd_parms);
-		neigh_sysctl_register(dev, idev->nd_parms, NET_IPV6, NET_IPV6_NEIGH, "ipv6");
-		addrconf_sysctl_register(idev, &idev->cnf);
+		if (idev) {
+			addrconf_sysctl_unregister(&idev->cnf);
+			neigh_sysctl_unregister(idev->nd_parms);
+			neigh_sysctl_register(dev, idev->nd_parms, NET_IPV6, NET_IPV6_NEIGH, "ipv6");
+			addrconf_sysctl_register(idev, &idev->cnf);
+		}
 #endif
 		break;
 	};

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
