Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVK2UmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVK2UmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVK2UmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:42:06 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:37699 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932388AbVK2UmE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:42:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hae+XKSoKSacw3IpU5KRzLIrcEkrGPjpOfsVY/6Wb3n2C5ggwIdgzfwI3vTnPUFJRKX1VeOi4u4dYaUPCs1oUkTZz3xPL2qqB9BsHXtqLR4DjeJVdrVP8m5HY4hVJm2+uNEhxfRQlBczN+ynmeovdUAEKAiXLuNJ25GjWIewURw=
Message-ID: <9fda5f510511291242u3b313bddi538f724a2c35926f@mail.gmail.com>
Date: Tue, 29 Nov 2005 12:42:02 -0800
From: Pradeep Vincent <pradeep.vincent@gmail.com>
To: Roberto Nibali <ratz@drugphish.ch>, netdev@vger.kernel.org
Subject: Re: [Patch] 2.4.32 - Neighbour Cache (ARP) State machine bug Fixed
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the source,
/*
   Transitions NUD_STALE <-> NUD_REACHABLE do not occur
   when fast path is built: we have no timers associated with
   these states, we do not have time to check state when sending.
   neigh_periodic_timer check periodically neigh->confirmed
   time and moves NUD_REACHABLE -> NUD_STALE.

   If a routine wants to know TRUE entry state, it calls
   neigh_sync before checking state.

   Called with write_locked neigh.
 */

I got the impression that neigh_periodic_timer is supposed to check
for stale entries although it doesn't. Which tasklet are you referring
to ? Or are you saying I should be calling neigh_sync instead of
checking for stale entries myself.

VMACS are used outside the linux system - for e.g. certain routers
present different VMACS for a default gateway ip for active-active
load-balancing and when one dies off, the failed VMAC is removed
eventually causing linux system using the failed VMAC to balk as it
doesn't stale out the arp cache entries even when traffic isn't able
to flow (confirmed doesn't move ahead).

netdev folks, can you CC me on your reply.

Thanks,

Pradeep Vincent


On 11/28/05, Roberto Nibali <ratz@drugphish.ch> wrote:
> > In 2.4.21, arp code uses gc_timer to check for stale arp cache
> > entries. In 2.6, each entry has its own timer to check for stale arp
> > cache. 2.4.29 to 2.4.32 kernels (atleast) use neither of these timers.
>
> Regarding NUD_REACHABLE <-> NUD_STALE transition it has a timer check.
> Due to the fast path it's not enabled per default. Use neigh_sync() to
> check, although I believe the installed tasklet does this for you already.
>
> The knowledgeable netdev people will know better.
>
> > This causes problems in environments where IPs or MACs are reassigned
> > - saw this problem on load balancing router based networks that use
> > VMACs. Tested this code on load balancing router based networks as
> > well as peer-linux systems.
>
> How do you use VMACs in 2.4.x?
>
> > diff -Naur old/net/core/neighbour.c new/net/core/neighbour.c
> > --- old/net/core/neighbour.c    Wed Nov 23 17:15:30 2005
> > +++ new/net/core/neighbour.c    Wed Nov 23 17:26:01 2005
> > @@ -14,6 +14,7 @@
> > *     Vitaly E. Lavrov        releasing NULL neighbor in neigh_add.
> > *     Harald Welte            Add neighbour cache statistics like rtstat
> > *     Harald Welte            port neighbour cache rework from 2.6.9-rcX
> > + *      Pradeep Vincent         Move neighbour cache entry to stale state
> > */
> >
> > #include <linux/config.h>
> > @@ -705,6 +706,14 @@
> >                        neigh_release(n);
> >                        continue;
> >                }
> > +
> > +               /* Mark it stale - To be reconfirmed later when used */
> > +               if (n->nud_state&NUD_REACHABLE &&
> > +                   now - n->confirmed > n->parms->reachable_time) {
> > +                       n->nud_state = NUD_STALE;
> > +                       neigh_suspect(n);
> > +               }
> > +
>
> If this is really a problem, why not simply call neigh_sync()? Your
> patch also seems to be whitespace damaged.
>
> >                write_unlock(&n->lock);
> >
> > next_elt:
>
> I've cc'd netdev since this is where such patches should go for
> discussion; left Linus in the loop (netiquette) although he's nothing to
> do with this ;).
>
> Cheers,
> Roberto Nibali, ratz
> --
> echo
> '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
>
