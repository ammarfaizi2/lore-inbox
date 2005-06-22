Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVFVV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVFVV4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVFVVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:53:44 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:39433 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262441AbVFVVuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:50:02 -0400
Date: Thu, 23 Jun 2005 07:49:20 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Bart De Schuymer <bdschuym@pandora.be>,
       Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050622214920.GA13519@gondor.apana.org.au>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net> <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B82F35.3040909@trash.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 05:16:05PM +0200, Patrick McHardy wrote:
> Bart De Schuymer wrote:
> > Deferring the hooks makes the bridge-nf code alot more complicated, so I
> > would be glad to get rid of it if it is the right thing to do. But
> > backwards compatibility can't be maintained and I'd be surprised if
> > every ruleset that now works will still be possible using an
> > iptables/ebtables scheme.
> 
> I unfortunately don't see a way to remove it, but we should keep
> thinking about it. Can you please check if the attached patch is
> correct? It should exclude all packets handled by bridge-netfilter
> from having their conntrack reference dropped. I didn't add nf_reset()'s
> to the bridging code because with tc actions the packets can end up
> anywhere else anyway, and this will hopefully get fixed right sometime.

I think this patch will be fine for 2.6.12.*.

Longer term though we should obsolete the ipt_physdev module.  The
rationale there is that this creates a precedence that we can't
possibly maintain in a consistent way.  For example, we don't have
a target that matches by hardware MAC address.  If you wanted to
do that, you'd hook into the arptables interface rather than deferring
iptables after the creation of the hardware header.

This can be done in two stages to minimise pain for people already
using it:

1) We rewrite ipt_physdev to do the lookups necessary to get the output
physical devices through the bridge layer.  Of course this may not be
the real output device due to changes in the environment.  So this should
be accompanied with a warning that users should switch to ebt.

2) We remove the iptables deferring since ipt_physdev will no longer need
it.

3) After a set period (say a year or so) we remove ipt_physdev altogether.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
