Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUFKNxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUFKNxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUFKNxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:53:52 -0400
Received: from [213.91.247.3] ([213.91.247.3]:3338 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S263937AbUFKNxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:53:48 -0400
Date: Fri, 11 Jun 2004 16:53:35 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@l
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Herbert Xu <herbert@gondor.apana.org.au>, <yoshfuji@linux-ipv6.org>,
       <netdev@oss.sgi.com>, <linux-net@vger.kernel.org>, <davem@redhat.com>,
       <pekkas@netcore.fi>, <jmorris@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
In-Reply-To: <200406111527.45955.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0406111651370.2763-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Fri, 11 Jun 2004, Denis Vlasenko wrote:

> Hmmm... do I have to set a *routing dest address* field
> to set src ip address of my UDP packet?

	Try such function:

static int my_send(int fd, unsigned srcip, (struct sockaddr *) remote,
			char *data, int len)
{
	struct iovec iov = { data, len };
	struct {
		struct cmsghdr cm;
		struct in_pktinfo ipi;
	} cmsg = {
		.cm = {
			.cmsg_len	= sizeof(struct cmsghdr) +
						sizeof(struct in_pktinfo),
			.cmsg_level	= SOL_IP,
			.cmsg_type	= IP_PKTINFO,
		},
		.ipi = {
			.ipi_ifindex	= 0,
			.ipi_spec_dst	= srcip,
		},
	};
	struct msghdr m = {
		.msg_name	= remote,
		.msg_namelen	= sizeof(struct sockaddr_in),
		.msg_iov	= &iov,
		.msg_iovlen	= 1,
		.msg_control	= &cmsg,
		.msg_controllen	= sizeof(cmsg),
		.msg_flags	= 0,
	};

	return sendmsg(fd, &m, MSG_NOSIGNAL|MSG_DONTWAIT);
}

Regards

--
Julian Anastasov <ja@ssi.bg>

