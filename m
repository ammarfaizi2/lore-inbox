Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVCNWlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVCNWlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVCNWij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:38:39 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17326
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262026AbVCNWes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:34:48 -0500
Date: Mon, 14 Mar 2005 14:33:23 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-Id: <20050314143323.6c66dfc3.davem@davemloft.net>
In-Reply-To: <1110838711.19340.58.camel@localhost>
References: <1110834883.19340.47.camel@localhost>
	<20050314135021.639d1533.davem@davemloft.net>
	<1110838711.19340.58.camel@localhost>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 14:18:31 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> Those bits are used today for page_zone() and page_to_nid().  I assume
> that you don't support NUMA, but how do you get around the page_zone()
> definition?  (a quick grep in asm-sparc64 didn't show anything obvious)
> 
>         static inline struct zone *page_zone(struct page *page)
>         {
>                 return zone_table[page->flags >> NODEZONE_SHIFT];
>         }

NODEZONE_SHIFT is (64 /* sizeof(page_flags_t)*8 */ -
                   1 /* MAX_NODES_SHIFT */ -
                   2 /* MAX_ZONES_SHIFT */)

Which means the table is indexed by the top 3 bits of page->flags.
Sparc64 only uses a couple bits (specifically, enough to hold
(NR_CPUS - 1)) starting at bit 24, so this should not intersect
the page_zone() usage.

I don't even accidently modify those bits when setting and clearing
this cpu field.

However, I do notice that I assume NR_CPUS is a power of two.  I should
certainly cure that.  (Basically, I use ~(NR_CPUS - 1) as a mask).

> BTW, in theory, the new patch should allow page->flags to be better
> managed by a variety of users, including special arch users.  An
> architecture should be able to relatively easily add the necessary
> pieces to reserve them.  We could even have a ARCH_RESERVED_BITS macro
> or something.  

That sounds like a great idea.  We have several issues like this, perhaps
it's time to create some abstraction accessors via include/asm-*/page-flags.h
The platform can specify the type and size or whatever of page_flags_t, how
to stick node and zone numbers into the field, and whatever else.  Furthermore,
we can have an asm-generic/page-flags.h that most folks can just use and
replicates what occurs right now.

That may be overkill, however.
