Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbSJIRUo>; Wed, 9 Oct 2002 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261895AbSJIRUo>; Wed, 9 Oct 2002 13:20:44 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:55245 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261882AbSJIRUk>; Wed, 9 Oct 2002 13:20:40 -0400
Message-ID: <3DA4668A.5070501@drugphish.ch>
Date: Wed, 09 Oct 2002 19:25:30 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: Martin Renold <martinxyz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tcp connection tracking 2.4.19
References: <20021008205053.GA2621@old.homeip.net>	 <3DA348EF.7060709@drugphish.ch> <1034166655.30384.13.camel@lemsip>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> "When syncookies are enabled the packets are still answered  and  this
> value [tcp_max_syn_backlog] is effectively ignored." -- From tcp(7)
> manpage.

Fair enough. I thought that last time I checked with the code the SYN 
cookie functionality would only kick in _after_ the backlog queue is full.

> The whole point of syncookies is to negate the need for a backlog queue.

Well, after a successful match of the MSS encoded part or the cookie, 
you add it back to the SYN queue. But yes, the backlog queue is indeed 
omited.

> Or did I miss your point?

Well, my point should have been stated more clearly. It is simply that 
SYN cookies do not prevent you from being SYN flooded. They provide you, 
from a user perspective view, a mean to still be able to log in onto 
your server under a SYN flood because you will send legitimate ACKs and 
because your connection will not be dropped.

It doesn't prevent SYN flooding, although I just checked back with 
../Documentation/networking/ip-sysctrl.txt:

tcp_syncookies - BOOLEAN
         Only valid when the kernel was compiled with CONFIG_SYNCOOKIES
         Send out syncookies when the syn backlog queue of a socket
         overflows. This is to prevent against the common 'syn flood attack'
         Default: FALSE

         Note, that syncookies is fallback facility.
         It MUST NOT be used to help highly loaded servers to stand
         against legal connection rate. If you see synflood warnings
         in your logs, but investigation shows that they occur
         because of overload with legal connections, you should tune
         another parameters until this warning disappear.
         See: tcp_max_syn_backlog, tcp_synack_retries, 
tcp_abort_on_overflow.

         syncookies seriously violate TCP protocol, do not allow
         to use TCP extensions, can result in serious degradation
         of some services (f.e. SMTP relaying), visible not by you,
         but your clients and relays, contacting you. While you see
         synflood warnings in logs not being really flooded, your server
         is seriously misconfigured.

The best thing is to go back and check with the actual implementation. 
I'm just checking on ../net/ipv4/tcp_ipv4.c:tcp_v4_conn_request():

[...]
         if (tcp_synq_is_full(sk) && !isn) {
#ifdef CONFIG_SYN_COOKIES
                 if (sysctl_tcp_syncookies) {
                         want_cookie = 1;
                 } else
#endif
                 goto drop;
         }

         /* Accept backlog is full. If we have already queued enough
          * of warm entries in syn queue, drop request. It is better than
          * clogging syn queue with openreqs with exponentially increasing
          * timeout.
          */
         if (tcp_acceptq_is_full(sk) && tcp_synq_young(sk) > 1)
                 goto drop;
[...]

Best regards and sorry for the confusion,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

