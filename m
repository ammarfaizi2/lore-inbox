Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbREEOUG>; Sat, 5 May 2001 10:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbREEOT4>; Sat, 5 May 2001 10:19:56 -0400
Received: from fepF.post.tele.dk ([195.41.46.135]:34017 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S132557AbREEOTl>; Sat, 5 May 2001 10:19:41 -0400
From: "Svenning Soerensen" <svenning@post5.tele.dk>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ipsec@freeswan.org>
Subject: RE: Problem with PMTU discovery on ICMP packets
Date: Sat, 5 May 2001 16:23:18 +0200
Message-ID: <015401c0d56e$ee293250$1400a8c0@sss.intermate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <15091.59308.315685.312632@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David S. Miller [mailto:davem@redhat.com]

> I want to understand why on some boots it's on while on some
> boots it is off, that makes no sense.
> 
> Before the piece of code you patched, we call ops->create() which is
> inet_create in net/ipv4/af_inet.c, there is sets the PMTU discovery
> disposition based upon the setting in ipv4_config which should always
> have the same setting at the point during boot, every boot.
> 
> You need to figure out why it sometimes gets set and sometimes does
> not, then we can figure out how to fix it.

Yes, I see your point. I guess I made an incorrect assumption about it
being changed between reboots. It could be related to routing or something
instead. I'll have to dig a bit further to find a pattern. 

However, even if I *do* find the pattern, I still think it is reasonable
to turn off PMTU discovery for ICMP explicitly, instead of based on the
setting of ipv4_config:

1) The setting for the one global ICMP socket gets set once and for all
at initialization time and doesn't track the setting of ip_no_pmtu_disc.

2) Even if it *did* track ip_no_pmtu_disc, the missing per-protocol
granularity of ip_no_pmtu_disc means that you couldn't have PMTU discovery
enabled for TCP, while having it disabled for ICMP.

3) I don't see any reason for wanting to do automatic PMTU discovery for
ICMP packets; normally they are only sent once, and you'll risk it being
dropped somewhere along its path if the DF bit is set.

Svenning
