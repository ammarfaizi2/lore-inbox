Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUFKMuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUFKMuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 08:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUFKMuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 08:50:16 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28937 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263875AbUFKMuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 08:50:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
Date: Fri, 11 Jun 2004 15:27:45 +0300
X-Mailer: KMail [version 1.4]
Cc: yoshfuji@linux-ipv6.org, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       davem@redhat.com, pekkas@netcore.fi, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
References: <E1BYjMY-0002CE-00@gondolin.me.apana.org.au>
In-Reply-To: <E1BYjMY-0002CE-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406111527.45955.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 June 2004 13:34, Herbert Xu wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> > I looked into sendmsg(). Looks like ther is no way to
> > indicate source ip.
> >
> > Shall I use some other technique?
>
> IP_PKTINFO works just as well there.  Look at the ip_cmsg_send call
> in udp_sendmsg.

int udp_sendmsg(...)
{
...
        ipc.addr = inet->saddr;

        ipc.oif = sk->sk_bound_dev_if;
        if (msg->msg_controllen) {
                err = ip_cmsg_send(msg, &ipc);
                if (err)
                        return err;
                if (ipc.opt)
                        free = 1;
                connected = 0;
        }
        if (!ipc.opt)
                ipc.opt = inet->opt;

        saddr = ipc.addr;
...

int ip_cmsg_send(struct msghdr *msg, struct ipcm_cookie *ipc)
{
...
                case IP_PKTINFO:
                {
                        struct in_pktinfo *info;
                        if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct in_pktinfo)))
                                return -EINVAL;
                        info = (struct in_pktinfo *)CMSG_DATA(cmsg);
                        ipc->oif = info->ipi_ifindex;
                        ipc->addr = info->ipi_spec_dst.s_addr;

manpage:
IP_PKTINFO
Pass an IP_PKTINFO ancillary message that contains a pktinfo structure that supplies some information  about  the
incoming packet. This only works for datagram oriented sockets.

struct in_pktinfo
{
    unsigned int   ipi_ifindex;  /* Interface index */
    struct in_addr ipi_spec_dst; /* Routing destination address */
    struct in_addr ipi_addr;     /* Header Destination address */
};

Hmmm... do I have to set a *routing dest address* field
to set src ip address of my UDP packet?
-- 
vda
