Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVF0LrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVF0LrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVF0LrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:47:18 -0400
Received: from [62.206.217.67] ([62.206.217.67]:27009 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261992AbVF0LrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:47:08 -0400
Message-ID: <42BFE726.20305@trash.net>
Date: Mon, 27 Jun 2005 13:46:46 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: Bart De Schuymer <bdschuym@pandora.be>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de> <1119249575.3387.3.camel@localhost.localdomain> <42B6B373.20507@trash.net> <1119293193.3381.9.camel@localhost.localdomain> <42B74FC5.3070404@trash.net> <1119338382.3390.24.camel@localhost.localdomain> <42B82F35.3040909@trash.net> <20050622214920.GA13519@gondor.apana.org.au> <1119507800.3387.18.camel@localhost.localdomain> <20050627083219.GZ19928@sunbeam.de.gnumonks.org>
In-Reply-To: <20050627083219.GZ19928@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> I have to agree with Bart.  I don't know any bridging-packetfilter setup
> that doesn't use ipt_physdev in FORWARD :(

It shouldn't be a problem to MARK in ebtables and use the marks instead.
So far I think we can only remove the support for locally generated
packets, but the way bridge-netfilter and ip-netfilter interact causes
some more problems and inconsistencies which I would like to look into
first. One thing I've noticed is that NF_IP_LOCAL_OUT, NF_IP_FORWARD and
NF_IP_POST_ROUTING get called for every clone when packets are delivered
to multiple ports, which causes unexpected results with REJECT (many
packets sent in response to a single one) and probably others. This
could be avoided by only passing packets to the NF_IP_* hooks once, but
that would make the physdev match useless.

Another problem is defragmentation, we've added the user argument to
ip_defrag to avoid packets from jumping through the stack between
different callers. With bridge-netfilter defragmentation in
NF_IP_PRE_ROUTING can be reached from both the IP layer and the bridge
layer, so packets can still jump (see netfilter bugzilla #339).

I expect there are more problems, I hope I can find some time to look
into it this week.

Regards
Patrick
