Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWIVRjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWIVRjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWIVRjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:39:32 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S964806AbWIVRjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:39:32 -0400
Received: from osiris.atheme.org ([69.60.119.211]:50834 "EHLO
	osiris.atheme.org") by vger.kernel.org with ESMTP id S932081AbWIVIWY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:22:24 -0400
In-Reply-To: <20060922.164109.112537486.yoshfuji@linux-ipv6.org>
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org> <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org> <20060922.164109.112537486.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <410AB903-2500-4CDF-B777-0367A7C0AEDF@atheme.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 03:22:47 -0500
To: =?UTF-8?Q?YOSHIFUJI_Hideaki_/_=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 22, 2006, at 2:41 AM, YOSHIFUJI Hideaki / 吉藤英明 wrote:

> In article <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org> (at  
> Fri, 22 Sep 2006 02:31:59 -0500), William Pitcock  
> <nenolod@atheme.org> says:
>
>> This patch allows for a user to disable the requirement to meet the
>> CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by
>> the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.
>
> Why?  I don't think this is a good idea.
>

There are several reasons. To summarize, in some setups, such as  
mine, it is undesirable to force applications to run as root to gain  
access to 'service' ports. A more defined listing of reasons why this  
patch is a good idea are below:

* People wanting to run restricted services such as jabber, ircd, etc  
on low ports to allow people to bypass ISP firewalls, but the  
software doesn't have mechanisms for dropping privileges (most ircds,  
for example do not have such an option)

* The software is untrusted by the end user, in the event that the  
software is not trustworthy, the amount of damage it can do running  
as a normal user is less than as a superuser. As it is, the bind()  
may have failed before the CAP_NET_BIND_SERVICE capability was  
granted to the process.

* Building on that, capabilities are still linux-specific. Other  
systems, such as FreeBSD allow you to disable this restriction via  
sysctl as well. It is very likely that daemons are not capability  
aware, and thus would require some sort of wrapper script (which is  
likely beyond the ability of most endusers). Wrapping the daemon  
would still require superuser privileges as well to make sure it  
worked properly, and even if it did work properly, it still opens a  
race condition where the bind() may have failed before the capability  
bit was granted to the process.

* Many services do not run on 'service' ports, and instead run out in  
userspace. For instance, MySQL listens on TCP/3306 by default, and  
PostgreSQL listens in userspace as well (although, I cannot recall  
the exact port number it listens on at present). In many cases, squid  
runs on port 8080, which is also userspace. For this reason, it is  
arguable that the entire CAP_NET_BIND_SERVICE restriction isn't very  
useful.

* Embedded devices (consumer routers, etc) may want to have some  
level of privilege seperation internally to reduce the amount of  
exploitation possibility in their firmware, this patch makes that  
easier to accomplish (just set the sysctl in the initialization and  
go from there)

* Other TCP stacks (Winsock2, for instance) do not impose the <= 1023  
limit.

>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index e4b1a4d..c3f7c3c 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -411,6 +411,7 @@ enum
>> 	NET_IPV4_TCP_WORKAROUND_SIGNED_WINDOWS=115,
>> 	NET_TCP_DMA_COPYBREAK=116,
>> 	NET_TCP_SLOW_START_AFTER_IDLE=117,
>> +	NET_IPV4_ALLOW_LOWPORT_BIND_NONSUPERUSER=118,
>>    };
>>
>>    enum {
>
> This implies all IPv4 protocols including other protocols
> such as UDP, SCTP, ...

Yes, I'll change the sysctl name to better infer that it is for TCP.  
That is not an issue. If you have a suggestion for what it should be,  
I'd love to hear it.

>
>> @@ -1412,3 +1418,4 @@ EXPORT_SYMBOL(inet_stream_ops);
>>    EXPORT_SYMBOL(inet_unregister_protosw);
>>    EXPORT_SYMBOL(net_statistics);
>>    EXPORT_SYMBOL(sysctl_ip_nonlocal_bind);
>> +EXPORT_SYMBOL(sysctl_ip_allow_lowport_bind_nonsuperuser);
>
> Please be aware about indent.

I'll be sure to fix that, thank you.

(resent due to mailer glitch)

- nenolod

