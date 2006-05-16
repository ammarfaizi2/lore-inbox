Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWEPAtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWEPAtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEPAtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:49:53 -0400
Received: from loki.ee.unimelb.edu.au ([128.250.76.73]:43987 "EHLO
	loki.ee.unimelb.edu.au") by vger.kernel.org with ESMTP
	id S1750902AbWEPAtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:49:52 -0400
Date: Tue, 16 May 2006 10:48:19 +1000
From: Tom Young <tyo@ee.unimelb.edu.au>
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>, shemminger@osdl.org,
       ranjitm@google.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
Message-ID: <20060516004819.GC8386@ee.unimelb.edu.AU>
References: <20060515.142645.94689626.davem@davemloft.net> <Pine.LNX.4.56.0605151602330.29636@ranjit.corp.google.com> <20060515164101.054afa29@localhost.localdomain> <20060515.170835.126804002.davem@davemloft.net> <44691B07.6070003@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44691B07.6070003@trash.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 02:21:27AM +0200, Patrick McHardy wrote:
> David S. Miller wrote:
> > From: Stephen Hemminger <shemminger@osdl.org>
> > Date: Mon, 15 May 2006 16:41:01 -0700
> > 
> > 
> >>kfree_skb(NULL) is legal so the conditional here is unneeded.
> >>
> >>But the increased calls to kfree_skb(NULL) would probably bring the
> >>"unlikely()" hordes descending on kfree_skb, so maybe:
> > 
> > 
> > And unfortunately as Patrick McHardy states, we can't use
> > this trick here because things like tc actions can do stuff
> > like pskb_expand_head() which cannot handle shared SKBs.
> > 
> > We need another solution to this problem, because cloning an
> > extra SKB is just rediculious overhead so isn't something we
> > can seriously consider to solve this problem.
> > 
> > Another option is to say this anomaly doesn't matter enough
> > to justify the complexity we're looking at here just to fix
> > this glitch.
> > 
> > Other implementation possibility suggestions welcome :-)
> 
> 
> We could just mark the skb to make sure its only passed to taps
> on the first transmission attempt. Since we have the timestamp
> optimization there shouldn't be any visible change besides
> the desired effect.

It would be nice to have a solution that taps after its been sent to the
driver. I clearly need to investigate the tc problems, but I've been using a
similar patch now for a few weeks to allow more accurate timestamps to be
performed in the driver without cloning problems getting in the way. (the tap
skb only gets cloned after the driver has time stamped it). This is more 
accuracy than most need but is required for the clock synchronisation i'm
working on. It also seems less intrusive to let the driver have the skb first
before pushing it to the taps.

Tom
-- 
Thomas Young
http://cubinlab.ee.unimelb.edu.au/~tyo/
Research Assistant
CUBIN Research Centre - University of Melbourne
