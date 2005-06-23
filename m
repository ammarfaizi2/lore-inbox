Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVFWD06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVFWD06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVFWD06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:26:58 -0400
Received: from [62.206.217.67] ([62.206.217.67]:57835 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262038AbVFWD0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:26:53 -0400
Date: Thu, 23 Jun 2005 05:26:30 +0200 (CEST)
From: Patrick McHardy <kaber@trash.net>
X-X-Sender: kaber@kaber.coreworks.de
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Bart De Schuymer <bdschuym@pandora.be>,
       Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
In-Reply-To: <20050622214920.GA13519@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.62.0506230502070.12228@kaber.coreworks.de>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
 <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net>
 <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net>
 <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net>
 <20050622214920.GA13519@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005, Herbert Xu wrote:
> Longer term though we should obsolete the ipt_physdev module.  The
> rationale there is that this creates a precedence that we can't
> possibly maintain in a consistent way.  For example, we don't have
> a target that matches by hardware MAC address.  If you wanted to
> do that, you'd hook into the arptables interface rather than deferring
> iptables after the creation of the hardware header.

Agreed.

> This can be done in two stages to minimise pain for people already
> using it:
>
> 1) We rewrite ipt_physdev to do the lookups necessary to get the output
> physical devices through the bridge layer.  Of course this may not be
> the real output device due to changes in the environment.  So this should
> be accompanied with a warning that users should switch to ebt.

IMO without defering the hooks the physdev match becomes pretty useless
for locally generated packets. The bridge layer clones packets that are
delivered to multiple ports and calls the NF_IP_* hooks for each clone, so
each clone can be treated seperately. In the IP layer there is only a
single packet, so clones for different ports couldn't be treated
seperately anymore and the semantic of the physdev match would need to be
changed to match on any bridge port in this case, which would probably
break existing rulesets.

> 2) We remove the iptables deferring since ipt_physdev will no longer need
> it.
>
> 3) After a set period (say a year or so) we remove ipt_physdev altogether.

How about we schedule it for removal in a year, keep the workaround
until then and then remove the hook defering?

Regards
Patrick
