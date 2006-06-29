Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWF2O1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWF2O1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWF2O1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:27:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57748 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750736AbWF2O1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:27:03 -0400
Date: Thu, 29 Jun 2006 07:27:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dipkanar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Samuel Ortiz <samuel@sortiz.org>
Subject: Re: [PATCH] irda: Fix RCU lock pairing on error path
Message-ID: <20060629142741.GA1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151542602.18723.19.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 05:56:41PM -0700, Josh Triplett wrote:
> irlan_client_discovery_indication calls rcu_read_lock and rcu_read_unlock, but
> returns without unlocking in an error case.  Fix that by replacing the return
> with a goto so that the rcu_read_unlock always gets executed.

Good catch!!!  Looks good from an RCU viewpoint, in fact, looks absolutely
necessary to permit IRDA to work in debug mode, particularly in either
a CONFIG_PREEMPT or a -rt kernel.

One question below, but up to the maintainer.  ;-)

							Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> 
> ---
> 
>  net/irda/irlan/irlan_client.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> e20ab96944814489277c3bfd4e69133854ab01e9
> diff --git a/net/irda/irlan/irlan_client.c b/net/irda/irlan/irlan_client.c
> index f8e6cb0..5ce7d2e 100644
> --- a/net/irda/irlan/irlan_client.c
> +++ b/net/irda/irlan/irlan_client.c
> @@ -173,13 +173,14 @@ void irlan_client_discovery_indication(d
>  	rcu_read_lock();
>  	self = irlan_get_any();
>  	if (self) {
> -		IRDA_ASSERT(self->magic == IRLAN_MAGIC, return;);
> +		IRDA_ASSERT(self->magic == IRLAN_MAGIC, goto out;);
>  
>  		IRDA_DEBUG(1, "%s(), Found instance (%08x)!\n", __FUNCTION__ ,
>  		      daddr);
>  		
>  		irlan_client_wakeup(self, saddr, daddr);
>  	}
> +out:

Should the above label instead be as follows?

	IRDA_ASSERT_LABEL(out:)

Just in case some variant of gcc, sparse, or whatever complains about
labels that don't have a corresponding goto (in CONFIG_IRDA_DEBUG=n
builds).

>  	rcu_read_unlock();
>  }
>  	
> 
> 
