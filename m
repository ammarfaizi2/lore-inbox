Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269765AbSISDAG>; Wed, 18 Sep 2002 23:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269862AbSISDAG>; Wed, 18 Sep 2002 23:00:06 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:65179 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269765AbSISDAF>;
	Wed, 18 Sep 2002 23:00:05 -0400
Message-ID: <3D893ECC.4020906@candelatech.com>
Date: Wed, 18 Sep 2002 20:04:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch this
 time]
References: <3D890A51.7000103@candelatech.com>	<20020918.182855.47438220.davem@redhat.com>	<3D893165.10106@candelatech.com> <20020918.190117.53168129.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Wed, 18 Sep 2002 19:07:33 -0700
> 
>    David S. Miller wrote:
>    
>    > I mean put the ifdefs in a header file such as tcp.h, not in the *.c
>    > code.
>    
>    Would you object to me just removing all of them and having the patch
>    unconditionally compiled in?
> 
> Your comments say that SIOCBINDTODEVICE behavior is changed, how can
> we legitimately do that all the time without breaking apps?

The old way is broken, it sets the bound-device to 0 when sending
the syn-ack.  I am not sure exactly how this worked before, or
if it even worked at all.  I changed it to use the bound_dev_if of the
parent socket, which I believe is more correct.

--- linux-2.4.19/net/ipv4/ip_output.c	Tue Sep 17 23:55:48 2002
+++ linux-2.4.19.dev/net/ipv4/ip_output.c	Sun Sep 15 21:19:45 2002
@@ -975,7 +975,11 @@
  			daddr = replyopts.opt.faddr;
  	}

+#ifdef CONFIG_NET_SENDTOSELF
+	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), sk->bound_dev_if))
+#else
  	if (ip_route_output(&rt, daddr, rt->rt_spec_dst, RT_TOS(skb->nh.iph->tos), 0))
+#endif
  		return;

  	/* And let IP do all the hard work.


It also failed due to the hashing issue, but with the current code,
packets to self from self will be dropped before reaching the IP
code, so that is not really a bug in the current code.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


