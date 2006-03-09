Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWCIBsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWCIBsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCIBsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:48:03 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52110 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750789AbWCIBsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:48:01 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, ak@suse.de, paulus@samba.org, bcrl@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1141861230.11221.189.camel@localhost.localdomain>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <1141853919.11221.183.camel@localhost.localdomain>
	 <1141854208.27555.1.camel@localhost.localdomain>
	 <1141861230.11221.189.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 17:48:18 -0800
Message-Id: <1141868898.6721.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 10:40 +1100, Benjamin Herrenschmidt wrote:

> What bothers me is that because of that exact same argument "it makes
> substantial difference for us", we end up with basically barriers
> tailored for architectures... that is as many kind of barriers as we
> have architectuers... like mmiowb :)

Unfortunately, it does express an untidy facet of reality, which is that
you really *do* want about as many different kinds of barrier as you
have kinds of distinct semantics, so that you have some hope of
expressing fairly portable concepts in a somewhat high-performance way.

I can see four problems at hand.  You can choose the order of their
importance yourself :-)

     1. Linux has a set of barriers that is too small to write
        performant code in a portable manner.
     2. The semantics of the existing barriers are not well understood.
     3. People don't understand when barriers are appropriate in the
        first place.  Witness the current thread on this topic.
     4. If you add more subtle barriers, they'll get misused (see #3)
        and inevitably introduce bugs that are a nightmare to find.

Regarding #2, it's not obvious to lots of people why e.g. the
atomic_*_return kinds of routines need to have memory barrier semantics,
in some cases even after reading Documentation/atomic_ops.txt.  So this
is a nasty education problem.

Regardless, in the case of the ipath driver, we squeeze every cycle out
of the hardware that we can, and this is our selling point.  I'm fine
with a driver-specific hack in this case because it suits my immediate
needs, but it would be nice to have something portable and well-defined
to rely on.

	<b

