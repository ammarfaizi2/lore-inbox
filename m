Return-Path: <linux-kernel-owner+w=401wt.eu-S932926AbWL0GMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWL0GMw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 01:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWL0GMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 01:12:52 -0500
Received: from web27312.mail.ukl.yahoo.com ([217.146.177.173]:26661 "HELO
	web27312.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932926AbWL0GMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 01:12:51 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 01:12:51 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xsfuSh84154dAEuQqaU+gPOVeoSuip44jtsLX5hxjk9qkaxhv4a+KS1ovISG+nGtQH5unNRcyvxYuKn43Ha7EQaCbiOLXxkt3iA8LVAbTMXK1KzqL/2i9PfdPDvWrh84grwEe3a9yoBHqeOIIy+hS/N3dvn+p8D9kPZWWJNtMM0=  ;
Message-ID: <20061227060609.95588.qmail@web27312.mail.ukl.yahoo.com>
X-YMail-OSG: nn1vOc8VM1k_O7xv2eYC2x.GITcUbR2bUQCl2gg_s2wb7pbifB5pdMPWsVBjLc2z2tfWJnX2exDShagmKRYC6gumNZ8ih4yZVNcbqcllgHl3wS6lClmQinCYRXge728i6gh49g--
Date: Wed, 27 Dec 2006 06:06:09 +0000 (GMT)
From: Z <commander_uk@yahoo.com>
Subject: ip_recv_error (ip_sockglue.c) - why zero the port on ICMP errors?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am developing a UDP application and wish to receive
the ICMP unreachable messages that some hosts send in
response to a UDP datagram that hits a closed port. I
use the IP_RECVERR on my socket, recvmsg (fd, &msg,
MSG_ERRQUEUE) and all that, however the returned port
in the sock_extended_err SO_EE_OFFENDER data always 0.

The following code in net/ipv4/ip_sockglue.c
illustrates this:
...
	sin = &errhdr.offender;
	sin->sin_family = AF_UNSPEC;
	if (serr->ee.ee_origin == SO_EE_ORIGIN_ICMP) {
		struct inet_sock *inet = inet_sk(sk);

		sin->sin_family = AF_INET;
		sin->sin_addr.s_addr = skb->nh.iph->saddr;
		sin->sin_port = 0;
		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
		if (inet->cmsg_flags)
			ip_cmsg_recv(msg, skb);
	}
...
For some reason, even though the full IP header is
available here (and the port preserved in
ip_icmp_error), sin->sin_port is set to zero in the
ip_recv_error function, which really hurts the
potential use of this in some applications which need
the port to uniquely identify multiple clients using
the same IP address.

I realise there's more than one way to do this - as a
workaround, I am using the msg.msg_name field, however
on earlier kernel versions (or maybe an earlier libc -
I didn't track down the reason), the msg.msg_name
field is not set correctly and the data fetched by
SO_EE_OFFENDER is the only way to find out the full
source of the error.

I'm just curious as to the reasoning behind zeroing
out the port in this piece of code, it doesn't seem to
make much sense as usermode applications will just see
a zero port instead of the real port. I noticed in
earlier kernel versions that sin_port and sin_zero
were unspecified which led to uninitialized kernel
stack memory being returned, maybe this was a hasty
bug fix for that problem?

I hope someone can quell my curiosity behind this :). Thanks.

Send instant messages to your online friends http://uk.messenger.yahoo.com 
