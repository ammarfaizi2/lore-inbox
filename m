Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUELBtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUELBtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 21:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUELBtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 21:49:16 -0400
Received: from waste.org ([209.173.204.2]:50839 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264890AbUELBsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 21:48:15 -0400
Date: Tue, 11 May 2004 20:47:30 -0500
From: Matt Mackall <mpm@selenic.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       randy.dunlap@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k
Message-ID: <20040512014730.GP5414@waste.org>
References: <1084252135.31802.312.camel@bach> <20040511080843.GB8751@colin2.muc.de> <1084317416.17692.29.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084317416.17692.29.camel@bach>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 09:16:56AM +1000, Rusty Russell wrote:
> On Tue, 2004-05-11 at 18:08, Andi Kleen wrote:
> > On Tue, May 11, 2004 at 03:08:55PM +1000, Rusty Russell wrote:
> > > Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
> > > it's a fairly trivial change.
> > 
> > As long as nobody does binary search it's good. Wonder why I did not
> > have this idea already with the original stem compression change ;-)
> 
> ISTR that someone (I thought you) mentioned doing this before.
> 
> In general this code was considered non-speed-critical, but Keith points
> out its use in wchan.  A simple cache might make more sense there,
> however.
> 
> A binary search as stands doesn't help much because we still need to
> iterate through the names.  We could do "address, nameindex" pairs, but
> with stem compression we need to at least wade back some way to decode
> the name.

I'd like to delta compress the addresses as well. I think the way to
do this is to change the address table to be sparsed by a factor of 16
or 32 or so, with pointers into the stem table. The pointers are
chosen to land us on stems of length 0 so we don't have to do any
backtracking. Then in addition to stem length, we keep a 16-bit
address delta. 

So we do a binary (or linear) search on the reduced address table, hop
into the stem table, and iterate along as before until we find our
symbol. Even if we stick with linear search on the address table,
we've sped up the search by 32x. So now we have nearly random access
into the stem table and for 15000 symbols, we'll save on the order of
30k (and 90k on 64-bit!).

We can also drop the nulls from the end of the ascii strings and look
for termination by finding the next stem code (hopefully always in the
control character range). This should be worth another 15k.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
