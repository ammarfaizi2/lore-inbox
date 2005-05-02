Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVEBQ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVEBQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVEBQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:28:20 -0400
Received: from post.arx.com ([212.25.66.95]:36191 "EHLO post.arx.com")
	by vger.kernel.org with ESMTP id S261432AbVEBQRp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:17:45 -0400
X-Mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Re-routing packets via netfilter (ip_rt_bug)
Date: Mon, 2 May 2005 19:17:16 +0200
Message-ID: <4151C0F9B9C25C47B3328922A6297A3286CFB8@post.arx.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re-routing packets via netfilter (ip_rt_bug)
Thread-Index: AcVLKiK78AJdzKpmRxyqorAryLrbSgD3ejng
From: "Yair Itzhaki" <Yair@arx.com>
To: "Patrick McHardy" <kaber@trash.net>,
       "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu>, <netdev@oss.sgi.com>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone propose a patch that I can start checking?

I have come up with the following:

--- net/core/netfilter.c.orig   2005-04-18 21:55:30.000000000 +0300
+++ net/core/netfilter.c        2005-05-02 17:35:20.000000000 +0300
@@ -622,9 +622,10 @@
        /* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
         * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
         */
-       if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
+       if ((inet_addr_type(iph->saddr) == RTN_LOCAL) ||
+           (inet_addr_type(iph->daddr) == RTN_LOCAL)) {
                fl.nl_u.ip4_u.daddr = iph->daddr;
-               fl.nl_u.ip4_u.saddr = iph->saddr;
+               fl.nl_u.ip4_u.saddr = 0;
                fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);
                fl.oif = (*pskb)->sk ? (*pskb)->sk->sk_bound_dev_if : 0;
 #ifdef CONFIG_IP_ROUTE_FWMARK

Please advise,
Yair


> -----Original Message-----
> From: Patrick McHardy [mailto:kaber@trash.net]
> Sent: Wednesday, April 27, 2005 14:05
> To: Herbert Xu
> Cc: Jozsef Kadlecsik; netdev@oss.sgi.com; 
> netfilter-devel@lists.netfilter.org; Yair Itzhaki; 
> linux-kernel@vger.kernel.org
> Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
> 
> 
> Herbert Xu wrote:
> > Here is another reason why these packets should go through FORWARD.
> > They were generated in response to packets in INPUT/FORWARD/OUTPUT.
> > The original packet has not undergone SNAT in any of these cases.
> > 
> > However, if we feed the response packet through LOCAL_OUT it will
> > be subject to DNAT.  This creates a NAT asymmetry and we may end
> > up with the wrong destination address.
> > 
> > By pushing it through FORWARD it will only undergo SNAT which is
> > correct since the original packet would have undergone DNAT.
> 
> This is only a problem since the recent NAT changes, but I agree
> that we should fix it by moving these packets to FORWARD.
> 
> Regards
> Patrick
> 
