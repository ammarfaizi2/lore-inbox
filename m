Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSEXVaO>; Fri, 24 May 2002 17:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSEXVaN>; Fri, 24 May 2002 17:30:13 -0400
Received: from web14808.mail.yahoo.com ([216.136.224.224]:45060 "HELO
	web14808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311871AbSEXVaL>; Fri, 24 May 2002 17:30:11 -0400
Message-ID: <20020524213011.50807.qmail@web14808.mail.yahoo.com>
Date: Fri, 24 May 2002 14:30:11 -0700 (PDT)
From: Yogesh Swami <spy9599@yahoo.com>
Subject: Few comments on TCP implementation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some questions and comments about the TCP
implementation: 

a) The calculation of ssthresh is wrong, it should be
max( 1/2*packets_in_flight, 2) (see RFC 2581) and not
as shown below in net/tcp.h. Unfortunately the way
packets in flight is calculated is based on
heuristics, so the only sensible thing to do would be
to set to max( 1/2*packets_out, 2*MSS). This small
change can have a big impact in some cases.

-------- include/net/tcp.h:1098

/* Recalculate snd_ssthresh, we want to set it to:
 *
 * 	one half the current congestion window, but no
 *	less than two segments
 */
static inline __u32 tcp_recalc_ssthresh(struct tcp_opt
*tp)
{
	return max(tp->snd_cwnd >> 1U, 2U);
}
-------

b) After a retransmission timeout, all the SACK
information SHOULD be forgotten (see RFC 2018).
Implementation in the kernel does not follow this but
relies on SACK reneging. This should be changed to
what the RFC has to say--again a small change to be
made.

c) There are numerous heuristics at work with no  RFC
counterparts (rate halving etc etc). To have the best
performance its probably best to stick with RFCs, or
if there is a compelling need to have these heuristics
then they should be brought to the IETF first.
Implementing something based on someone's random
publications is not a good idea for an operating as
pervasive as Linux.

c) A few new RFCs have come recently (e.g., 3042
called limited retransmit) that boost the performance
of short lived connections ( e.g., HTTP
request-response) and probably it will be a good idea
to incorporate then in the kernel (barely takes a
couple of lines to implement). If no one else is
already working on it, maybe I can assist.

Please let me know what you think.

Thanks
BR
Yogesh

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
