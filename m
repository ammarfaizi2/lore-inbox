Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVJQE3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJQE3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJQE3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 00:29:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32716
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932113AbVJQE3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 00:29:43 -0400
Date: Sun, 16 Oct 2005 21:29:17 -0700 (PDT)
Message-Id: <20051016.212917.34746449.davem@davemloft.net>
To: ink@jurassic.park.msu.ru
Cc: andrea@suse.de, herbert@gondor.apana.org.au, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051016233600.A13487@jurassic.park.msu.ru>
References: <20051015200701.GP18159@opteron.random>
	<20051015.160702.128767261.davem@davemloft.net>
	<20051016233600.A13487@jurassic.park.msu.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Sun, 16 Oct 2005 23:36:00 +0400

> My opinion is that we don't need a barrier even _after_ ll/sc sequences
> on Alpha - it's redundant; perhaps it's just a historical baggage.
> I strongly believe that ll/sc _does_ imply an SMP memory barrier, as can
> be seen from instructions timing: a standalone mb takes tens of cycles,
> the mb before/after ll/sc takes 0 to 1 cycle on ev6 (a bit more on ev56)
> depending on instruction slotting.
> Note that superfluous mb's around atomic stuff still can hurt -
> Alpha mb instruction also flushes IO write buffers, so it can
> be _extremely_ expensive under heavy IO...

Even a quick google tells me that on Alpha, LL/SC have implicit
barriers only with respect to the locations being acted upon
by the LL/SC, but don't have more general barrier properties.

This is in line with how PPC is defined as well.

I truly believe that you would be removing those Alpha memory barriers
only at your own peril. :-)  And since the PPC and Alpha defined
semantics aparently match, I think it would be wise to add the missing
memory barriers from the front of the LL/SC sequences which need them,
just as PPC does.

I just spent 6 months tracking down a bug that turned out to be a
couple of missing memory barriers on sparc64.  So, this has taught me
to be extra careful in this area :-)  I really think this is an area
in which it's better to be safe than sorry.
