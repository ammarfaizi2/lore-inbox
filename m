Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVGNM2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVGNM2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGNM2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:28:37 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:26450 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261286AbVGNM2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:28:37 -0400
Message-ID: <42D65A41.7070403@emc.com>
Date: Thu, 14 Jul 2005 08:27:45 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
CC: Yair Itzhaki <Yair@arx.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "Chitrapu, Kishore" <Chitrapu_Kishore@emc.com>,
       "Mellors, Andrew" <Mellors_Andrew@emc.com>
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <4151C0F9B9C25C47B3328922A6297A3286CFB8@post.arx.com>
In-Reply-To: <4151C0F9B9C25C47B3328922A6297A3286CFB8@post.arx.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.14.8
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patrick, Hebert,

This issues stills seems to be in the latest trees - is this patch or a 
variation on it still bumping around?

Thanks!

Yair Itzhaki wrote:

>Can anyone propose a patch that I can start checking?
>
>I have come up with the following:
>
>--- net/core/netfilter.c.orig   2005-04-18 21:55:30.000000000 +0300
>+++ net/core/netfilter.c        2005-05-02 17:35:20.000000000 +0300
>@@ -622,9 +622,10 @@
>        /* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
>         * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
>         */
>-       if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
>+       if ((inet_addr_type(iph->saddr) == RTN_LOCAL) ||
>+           (inet_addr_type(iph->daddr) == RTN_LOCAL)) {
>                fl.nl_u.ip4_u.daddr = iph->daddr;
>-               fl.nl_u.ip4_u.saddr = iph->saddr;
>+               fl.nl_u.ip4_u.saddr = 0;
>                fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);
>                fl.oif = (*pskb)->sk ? (*pskb)->sk->sk_bound_dev_if : 0;
> #ifdef CONFIG_IP_ROUTE_FWMARK
>
>Please advise,
>Yair
>
>
>  
>
>>-----Original Message-----
>>From: Patrick McHardy [mailto:kaber@trash.net]
>>Sent: Wednesday, April 27, 2005 14:05
>>To: Herbert Xu
>>Cc: Jozsef Kadlecsik; netdev@oss.sgi.com; 
>>netfilter-devel@lists.netfilter.org; Yair Itzhaki; 
>>linux-kernel@vger.kernel.org
>>Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
>>
>>
>>Herbert Xu wrote:
>>    
>>
>>>Here is another reason why these packets should go through FORWARD.
>>>They were generated in response to packets in INPUT/FORWARD/OUTPUT.
>>>The original packet has not undergone SNAT in any of these cases.
>>>
>>>However, if we feed the response packet through LOCAL_OUT it will
>>>be subject to DNAT.  This creates a NAT asymmetry and we may end
>>>up with the wrong destination address.
>>>
>>>By pushing it through FORWARD it will only undergo SNAT which is
>>>correct since the original packet would have undergone DNAT.
>>>      
>>>
>>This is only a problem since the recent NAT changes, but I agree
>>that we should fix it by moving these packets to FORWARD.
>>
>>Regards
>>Patrick
>>
>>    
>>
>
>  
>

