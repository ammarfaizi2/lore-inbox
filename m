Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269952AbTGKNYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269953AbTGKNYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:24:00 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:39808 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269952AbTGKNX7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:23:59 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Pekka Savola <pekkas@netcore.fi>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3F0EB227.50403@kolumbus.fi>
References: <Pine.LNX.4.44.0307111446250.27865-100000@netcore.fi>
	 <1057925366.896.24.camel@hades>  <3F0EB227.50403@kolumbus.fi>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1057930712.895.32.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 16:38:32 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 15:48, Mika Penttilä wrote:
> It turns out to be the (otherwise valid) check for  IFF_LOOPBACK for 
> gateway's address in ip6_route_add() that gives EINVAL for prefix::, and 
> has nothing to do with iid being 0, just a coinsidence....

Not sure. Seems to me that ipv6_addr_type() flags the gateway address as
anycast. In ip6_route_addr() [2.5.74] we have:

        if (rtmsg->rtmsg_flags & RTF_GATEWAY) {
                struct in6_addr *gw_addr;
                int gwa_type;

                gw_addr = &rtmsg->rtmsg_gateway;
                ipv6_addr_copy(&rt->rt6i_gateway, &rtmsg->rtmsg_gateway);
                gwa_type = ipv6_addr_type(gw_addr);

                if (gwa_type != (IPV6_ADDR_LINKLOCAL|IPV6_ADDR_UNICAST)) {
                        struct rt6_info *grt;

                        /* IPv6 strictly inhibits using not link-local
                           addresses as nexthop address.
                           Otherwise, router will not able to send redirects.
                           It is very good, but in some (rare!) curcumstances
                           (SIT, PtP, NBMA NOARP links) it is handy to allow
                           some exceptions. --ANK
                         */
                        err = -EINVAL;
                        if (!(gwa_type&IPV6_ADDR_UNICAST))
                                goto out;

Looks like it would bail out here, unless I read the code wrong. How about:

                        if (!(gwa_type&(IPV6_ADDR_UNICAST|IPV6_ADDR_ANYCAST)))
                                goto out;

	MikaL

