Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTIMMYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 08:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbTIMMYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 08:24:06 -0400
Received: from bdpp-p-144-138-18-50.prem.tmns.net.au ([144.138.18.50]:59264
	"EHLO portal.frood.au") by vger.kernel.org with ESMTP
	id S262115AbTIMMYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 08:24:03 -0400
Message-ID: <3F630C59.5090004@bigpond.com>
Date: Sat, 13 Sep 2003 22:23:53 +1000
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: yoshfuji@linux-ipv6.org
Subject: Re: oops in inet_bind/tcp_v4_get_port
References: <3F62EA61.1000804@bigpond.com> <20030913.192535.114458752.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't disabled preemption, but I have pinned down where i'm getting 
the crash... it appears to be related to ipv6, and from what I can 
determine the following is happening:

When I stop slapd... netstat -an | grep 389 looks like this:

tcp 1 0 127.0.0.1:32973 127.0.0.1:389 CLOSE_WAIT
tcp 0 0 127.0.0.1:32974 127.0.0.1:389 TIME_WAIT
tcp6 0 0 ::ffff:127.0.0.1:389 ::ffff:127.0.0.1:32973 FIN_WAIT2
tcp6 0 0 ::ffff:127.0.0.1:389 ::ffff:127.0.0.1:32958 FIN_WAIT2

If I restart it immediately, I get the oops (it's always a null pointer 
dereference, it's more often the one where you access memory that's out 
of bounds). If I wait until the tcp6 connections time out, and then 
restart, I don't get the oops.

The crash is happening in net/ipv4/tcp_ipv4.c - tcp_bind_conflict (it's 
inline, which i guess is why it isn't in the oops trace, but it's called 
from tcp_v4_get_port), specifically in the call to the macro 
ipv6_only_sock. My guess is that while the sock says it's PF_INET6, it 
doesn't have the extra ipv6 stuff (specifically the pointer to 
ipv6_pinfo) so it's reading past the end of the structure, or that the 
stuff past the main sock struct is getting corrupted. I think the former 
is more likely but either possibility explains why I got a null pointer 
dereference one time, and the other oops the other time.

This is the first time i've ever really looked at the networking code in 
the kernel so I can't easily see how the above situation could arise, 
but if anyone wants me to test anything i'm more than happy to!

thanks

James


YOSHIFUJI Hideaki / ???? wrote:

>In article <3F62EA61.1000804@bigpond.com> (at Sat, 13 Sep 2003 19:58:57 +1000), James Harper <james.harper@bigpond.com> says:
>
>  
>
>>I get a null pointer exception in the same routine when restarting slapd 
>>in 2.6.0-test5, and it hangs my system hard. I'm investigating now. If 
>>anyone has a patch already please send me a copy too!
>>    
>>
>
>Have you tried to disable kernek preemption?
>
>--yoshfuji
>
>  
>



