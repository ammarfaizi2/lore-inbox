Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTEYXDR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 19:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTEYXDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 19:03:17 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:54964 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263800AbTEYXDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 19:03:15 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Mon, 26 May 2003 09:16:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16081.20154.686639.275401@notabene.cse.unsw.edu.au>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
   linux-kernel@vger.kernel.org, linux-mm@kvack.org,
   Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.5.69-mm9
In-Reply-To: message from Andrew Morton on Sunday May 25
References: <20030525042759.6edacd62.akpm@digeo.com>
	<1053899811.750.1.camel@teapot.felipe-alfaro.com>
	<20030525154840.3ba7609b.akpm@digeo.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday May 25, akpm@digeo.com wrote:
> >  EIP is at svc_udp_recvfrom+0x52b/0x560 [sunrpc]

> 
> OK, you have CONFIG_DEBUG_PAGEALLOC set.  That's the patch which unmaps
> pages from kernel virtual address space when they are freed.
> 
> That patch seems quite stable on uniprocessor at least - there are question
> marks over its honesty on SMP.
> 
> I would be inclined to say that this is a hitherto undiscovered
> use-after-free bug.

Good inclination.  See patch.

As far as I can tell, sock->stamp is only ever used for
SIOCGSTAMP, which probably doesn't need to be support for
these rpc sockets, but I guess it doesn't hurt..

NeilBrown

--------------------------------------------
Extract ->stamp from skb *before* freeing it in svcsock.c

As we sometime copy and free an skb, and sometime us it
in-place, we must be careful to extract information from
it *before* it might be freed, not after.

 ----------- Diffstat output ------------
 ./net/sunrpc/svcsock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff ./net/sunrpc/svcsock.c~current~ ./net/sunrpc/svcsock.c
--- ./net/sunrpc/svcsock.c~current~	2003-05-21 13:17:52.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2003-05-26 09:11:32.000000000 +1000
@@ -589,6 +589,8 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_addr.sin_port = skb->h.uh->source;
 	rqstp->rq_addr.sin_addr.s_addr = skb->nh.iph->saddr;
 
+	svsk->sk_sk->stamp = skb->stamp;
+
 	if (skb_is_nonlinear(skb)) {
 		/* we have to copy */
 		local_bh_disable();
@@ -629,7 +631,6 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 		serv->sv_stats->netudpcnt++;
 
 	/* One down, maybe more to go... */
-	svsk->sk_sk->stamp = skb->stamp;
 	svc_sock_received(svsk);
 
 	return len;
