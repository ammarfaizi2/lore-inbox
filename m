Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946610AbWKAGRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946610AbWKAGRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946619AbWKAGRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:17:42 -0500
Received: from 1wt.eu ([62.212.114.60]:62468 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1946610AbWKAGRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:17:40 -0500
Date: Wed, 1 Nov 2006 08:17:22 +0100
From: Willy Tarreau <w@1wt.eu>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
       David S Miller <davem@davemloft.net>
Subject: Re: [PATCH 40/61] SCTP: Always linearise packet on input
Message-ID: <20061101071722.GC543@1wt.eu>
References: <20061101053340.305569000@sous-sol.org> <20061101054231.472027000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101054231.472027000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:20PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> I was looking at a RHEL5 bug report involving Xen and SCTP
> (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=212550).
> It turns out that SCTP wasn't written to handle skb fragments at
> all.  The absence of any calls to skb_may_pull is testament to
> that.
> 
> It just so happens that Xen creates fragmented packets more often
> than other scenarios (header & data split when going from domU to
> dom0).  That's what caused this bug to show up.
> 
> Until someone has the time sits down and audits the entire net/sctp
> directory, here is a conservative and safe solution that simply
> linearises all packets on input.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  net/sctp/input.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-2.6.18.1.orig/net/sctp/input.c
> +++ linux-2.6.18.1/net/sctp/input.c
> @@ -135,6 +135,9 @@ int sctp_rcv(struct sk_buff *skb)
>  
>  	SCTP_INC_STATS_BH(SCTP_MIB_INSCTPPACKS);
>  
> +	if (skb_linearize(skb))
> +		goto discard_it;
> +
>  	sh = (struct sctphdr *) skb->h.raw;
>  
>  	/* Pull up the IP and SCTP headers. */


Herbert, David,

This one seems to be valid for 2.4 too. Should I merge it or is it
unneeded ?

Willy

