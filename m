Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbULNRv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbULNRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbULNRuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:50:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:13194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261572AbULNRsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:48:03 -0500
Date: Tue, 14 Dec 2004 09:48:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities (fwd)
Message-ID: <20041214094801.P469@build.pdx.osdl.net>
References: <Pine.LNX.4.61.0412141659270.25679@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0412141659270.25679@student.dei.uc.pt>; from marado@student.dei.uc.pt on Tue, Dec 14, 2004 at 04:59:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcos D. Marado Torres (marado@student.dei.uc.pt) wrote:
> Synopsis:  Linux kernel IGMP vulnerabilities
> Product:   Linux kernel
> Version:   2.4 up to and including 2.4.28, 2.6 up to and including 2.6.9

Here's a patch for the ip_mc_source trouble.  I don't believe the remote
one is valid because nrsrcs is checked against payload, so you won't
ever touch random memory.


===== net/ipv4/igmp.c 1.58 vs edited =====
--- 1.58/net/ipv4/igmp.c	2004-11-09 16:44:25 -08:00
+++ edited/net/ipv4/igmp.c	2004-12-10 15:16:17 -08:00
@@ -1778,12 +1778,12 @@ int ip_mc_source(int add, int omode, str
 			goto done;
 		rv = !0;
 		for (i=0; i<psl->sl_count; i++) {
-			rv = memcmp(&psl->sl_addr, &mreqs->imr_multiaddr,
+			rv = memcmp(&psl->sl_addr[i], &mreqs->imr_sourceaddr,
 				sizeof(__u32));
-			if (rv >= 0)
+			if (rv == 0)
 				break;
 		}
-		if (!rv)	/* source not found */
+		if (rv)		/* source not found */
 			goto done;
 
 		/* update the interface filter */
@@ -1825,9 +1825,9 @@ int ip_mc_source(int add, int omode, str
 	}
 	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
 	for (i=0; i<psl->sl_count; i++) {
-		rv = memcmp(&psl->sl_addr, &mreqs->imr_multiaddr,
+		rv = memcmp(&psl->sl_addr[i], &mreqs->imr_sourceaddr,
 			sizeof(__u32));
-		if (rv >= 0)
+		if (rv == 0)
 			break;
 	}
 	if (rv == 0)		/* address already there is an error */
===== net/ipv6/mcast.c 1.71 vs edited =====
--- 1.71/net/ipv6/mcast.c	2004-11-11 15:07:25 -08:00
+++ edited/net/ipv6/mcast.c	2004-12-10 17:20:46 -08:00
@@ -391,12 +391,12 @@ int ip6_mc_source(int add, int omode, st
 			goto done;
 		rv = !0;
 		for (i=0; i<psl->sl_count; i++) {
-			rv = memcmp(&psl->sl_addr, group,
+			rv = memcmp(&psl->sl_addr[i], source,
 				sizeof(struct in6_addr));
-			if (rv >= 0)
+			if (rv == 0)
 				break;
 		}
-		if (!rv)	/* source not found */
+		if (rv)		/* source not found */
 			goto done;
 
 		/* update the interface filter */
@@ -437,8 +437,8 @@ int ip6_mc_source(int add, int omode, st
 	}
 	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
 	for (i=0; i<psl->sl_count; i++) {
-		rv = memcmp(&psl->sl_addr, group, sizeof(struct in6_addr));
-		if (rv >= 0)
+		rv = memcmp(&psl->sl_addr[i], source, sizeof(struct in6_addr));
+		if (rv == 0)
 			break;
 	}
 	if (rv == 0)		/* address already there is an error */
