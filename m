Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTGKOH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269984AbTGKOH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:07:26 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:44304 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S269981AbTGKOHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:07:02 -0400
Message-ID: <3F0EC96D.6080102@kolumbus.fi>
Date: Fri, 11 Jul 2003 17:27:57 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mika Liljeberg <mika.liljeberg@welho.com>
CC: Pekka Savola <pekkas@netcore.fi>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
References: <Pine.LNX.4.44.0307111446250.27865-100000@netcore.fi>	 <1057925366.896.24.camel@hades>  <3F0EB227.50403@kolumbus.fi> <1057930712.895.32.camel@hades>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 11.07.2003 17:23:06,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 11.07.2003 17:22:31,
	Serialize complete at 11.07.2003 17:22:31
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

afaics, ipv6_addr_type() checks just for some rfc-specified reserved 
anycast addresses, not the ones in device list. Anyway, it will surely 
also bail out from the loopback test (anycast subnet router address is 
ours).

--Mika


Mika Liljeberg wrote:

>On Fri, 2003-07-11 at 15:48, Mika Penttilä wrote:
>  
>
>>It turns out to be the (otherwise valid) check for  IFF_LOOPBACK for 
>>gateway's address in ip6_route_add() that gives EINVAL for prefix::, and 
>>has nothing to do with iid being 0, just a coinsidence....
>>    
>>
>
>Not sure. Seems to me that ipv6_addr_type() flags the gateway address as
>anycast. In ip6_route_addr() [2.5.74] we have:
>
>        if (rtmsg->rtmsg_flags & RTF_GATEWAY) {
>                struct in6_addr *gw_addr;
>                int gwa_type;
>
>                gw_addr = &rtmsg->rtmsg_gateway;
>                ipv6_addr_copy(&rt->rt6i_gateway, &rtmsg->rtmsg_gateway);
>                gwa_type = ipv6_addr_type(gw_addr);
>
>                if (gwa_type != (IPV6_ADDR_LINKLOCAL|IPV6_ADDR_UNICAST)) {
>                        struct rt6_info *grt;
>
>                        /* IPv6 strictly inhibits using not link-local
>                           addresses as nexthop address.
>                           Otherwise, router will not able to send redirects.
>                           It is very good, but in some (rare!) curcumstances
>                           (SIT, PtP, NBMA NOARP links) it is handy to allow
>                           some exceptions. --ANK
>                         */
>                        err = -EINVAL;
>                        if (!(gwa_type&IPV6_ADDR_UNICAST))
>                                goto out;
>
>Looks like it would bail out here, unless I read the code wrong. How about:
>
>                        if (!(gwa_type&(IPV6_ADDR_UNICAST|IPV6_ADDR_ANYCAST)))
>                                goto out;
>
>	MikaL
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


