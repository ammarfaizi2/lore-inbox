Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbVKBJl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbVKBJl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVKBJl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:41:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27144 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932693AbVKBJl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:41:26 -0500
Date: Wed, 2 Nov 2005 10:29:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Yan Zheng <yzcorp@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Message-ID: <20051102092959.GA15515@alpha.home.local>
References: <20051102054702.GB11266@alpha.home.local> <OF0C913512.B3EB99A5-ON882570AD.0025FB9D-882570AD.00276427@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0C913512.B3EB99A5-ON882570AD.0025FB9D-882570AD.00276427@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 11:10:29PM -0800, David Stevens wrote:
> Willy Tarreau <willy@w.ods.org> wrote on 11/01/2005 09:47:02 PM:
> 
> > Hi,
> > 
> > On Tue, Nov 01, 2005 at 06:37:43PM +0800, Yan Zheng wrote:
> > > You can reproduce this bug by follow codes. This program will cause a
> > > change to include report even though the first socket's filter mode is
> > > exclude.
> > 
> > I've not clearly understood the nature of the bug, does it also
> > affect 2.4 ? Marcelo will be releasing 2.4.32 in a few days, so
> > it would be wise to merge the fix soon.
> > 
> > Regards,
> > Willy
> > 
> 
>         Yes.
>  
>         Multicast source filters aren't widely used yet, and that's
> really the only feature that's affected if an application actually
> exercises this bug, as far as I can tell. An ordinary filter-less
> multicast join should still work, and only forwarded multicast
> traffic making use of filters and doing empty-source filters with
> the MSFILTER ioctl would be at risk of not getting multicast
> traffic forwarded to them because the reports generated would not
> be based on the correct counts.
>         But having the fix in is better than having it broken, even
> for that case. :-)


OK, thanks for the clarification, I understand better now :-)

Marcelo, David, does this backport seem appropriate for 2.4.32 ? I verified
that it compiles, nothing more. If it's OK, I've noticed another patch that
Yan posted today and which might be of interest before a very solid release.

Regards,
Willy

diff -urN linux-2.4.32-rc2/net/ipv4/igmp.c linux-2.4.32-rc2-mcast/net/ipv4/igmp.c
--- linux-2.4.32-rc2/net/ipv4/igmp.c	2005-11-02 10:16:03.000000000 +0100
+++ linux-2.4.32-rc2-mcast/net/ipv4/igmp.c	2005-11-02 10:20:33.000000000 +0100
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
diff -urN linux-2.4.32-rc2/net/ipv6/mcast.c linux-2.4.32-rc2-mcast/net/ipv6/mcast.c
--- linux-2.4.32-rc2/net/ipv6/mcast.c	2005-11-02 10:16:03.000000000 +0100
+++ linux-2.4.32-rc2-mcast/net/ipv6/mcast.c	2005-11-02 10:21:49.000000000 +0100
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

