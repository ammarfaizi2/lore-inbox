Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVKDXat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVKDXat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKDXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:30:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5385 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751082AbVKDXat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:30:49 -0500
Date: Sat, 5 Nov 2005 00:18:15 +0100
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, Roberto Nibali <ratz@drugphish.ch>
Subject: Linux-2.4.31-hf8
Message-ID: <20051104231815.GA26093@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the eighth hotfix for 2.4.31. OK, I know there was one not long ago,
but a recent fix in IPVS which got merged into -hf7 left a refcnt problem in
ip_vs_conn_expire_now, which can cause mid-term/long-term stability problems.
I took this opportunity to merge a backport from 2.6 of another fix from Yan
Zheng affecting multicast source filters.

There's no other fix, people not using IPVS nor IPv6 have no reason to upgrade.

I'd like to specially thank Roberto Nibali, Yan Zheng and David Stevens for
their determination in tracking those bugs, and getting them fixed early
(and most of all, taking some time to explain me what the fixes do !).

Changelog and incremental patch appended. Kernel has been rebuilt on x86.
As usual, 2.4.29-hf18, 2.4.30-hf11 and 2.4.31-hf8 have been released.
You can get them from the usual places :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)

I hope I did not forget anything, otherwise please bug me.

Regards,
Willy

Changelog from 2.4.31-hf7 to 2.4.31-hf8
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-rc2-ip_vs_conn_expire_now-fix_refcnt-dec-1       (Julian Anastasov)

Quoting Roberto Nibali: It is absolutely needed. Without it, people will
really experience a long term problem with hanging templates in IPVS,
manifesting itself depending on time and hardware configuration.
It seems we forgot to fix one place where ip_vs_conn_expire_now is used.
Callers should hold write lock or cp->refcnt (and not forget it). This
results in hanging template entries when expire_nodest_conn is kicking
in and trying to remove all connection entries for a specific
destination. Julian Anastasov created a patch to fix this and asked me
to forward it for inclusion, after test and verification, which have
happened the last 24 hours.

+ 2.4.32-rc2-mcast-filter-1                                  (Willy Tarreau)

[PATCH-2.4][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Multicast source filters aren't widely used yet, and that's really
the only feature that's affected if an application actually exercises
this bug, as far as I can tell. An ordinary filter-less multicast join
should still work, and only forwarded multicast traffic making use of
filters and doing empty-source filters with the MSFILTER ioctl would
be at risk of not getting multicast traffic forwarded to them because
the reports generated would not be based on the correct counts.
Initial 2.6 patch by Yan Zheng, bug explanation by David Stevens,
patch ACKed by David.

--

Incremental diff from 2.4.31-hf7
--- linux-2.4.31-hf7/Makefile	Tue Nov  1 11:08:11 2005
+++ linux-2.4.31-hf8/Makefile	Fri Nov  4 23:50:30 2005
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 31
-EXTRAVERSION = -hf7
+EXTRAVERSION = -hf8
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
--- linux-2.4.31-hf7/net/ipv4/igmp.c	Tue Nov  1 11:08:11 2005
+++ linux-2.4.31-hf8/net/ipv4/igmp.c	Fri Nov  4 23:50:30 2005
@@ -1876,8 +1876,11 @@
 			sock_kfree_s(sk, newpsl, IP_SFLSIZE(newpsl->sl_max));
 			goto done;
 		}
-	} else
-		newpsl = 0;
+	} else {
+		newpsl = NULL;
+		(void) ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
+		       msf->imsf_fmode, 0, NULL, 0);
+	}
 	psl = pmc->sflist;
 	if (psl) {
 		(void) ip_mc_del_src(in_dev, &msf->imsf_multiaddr, pmc->sfmode,
--- linux-2.4.31-hf7/net/ipv4/ipvs/ip_vs_core.c	Tue Nov  1 11:08:11 2005
+++ linux-2.4.31-hf8/net/ipv4/ipvs/ip_vs_core.c	Fri Nov  4 23:50:29 2005
@@ -1111,11 +1111,10 @@
 		if (sysctl_ip_vs_expire_nodest_conn) {
 			/* try to expire the connection immediately */
 			ip_vs_conn_expire_now(cp);
-		} else {
-			/* don't restart its timer, and silently
-			   drop the packet. */
-			__ip_vs_conn_put(cp);
 		}
+		/* don't restart its timer, and silently
+		   drop the packet. */
+		__ip_vs_conn_put(cp);
 		return NF_DROP;
 	}
 
--- linux-2.4.31-hf7/net/ipv6/mcast.c	Tue Nov  1 11:08:11 2005
+++ linux-2.4.31-hf8/net/ipv6/mcast.c	Fri Nov  4 23:50:30 2005
@@ -505,8 +505,11 @@
 			sock_kfree_s(sk, newpsl, IP6_SFLSIZE(newpsl->sl_max));
 			goto done;
 		}
-	} else
-		newpsl = 0;
+	} else {
+		newpsl = NULL;
+		(void) ip6_mc_add_src(idev, group, gsf->gf_fmode, 0, NULL, 0);
+	}
+
 	psl = pmc->sflist;
 	if (psl) {
 		(void) ip6_mc_del_src(idev, group, pmc->sfmode,


