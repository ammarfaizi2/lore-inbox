Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUCEXzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUCEXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:55:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:26827 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261503AbUCEXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:55:00 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <4048B720.4010403@nortelnetworks.com>
References: <40479A50.9090605@nortelnetworks.com>
	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com>
	 <1078452637.5700.45.camel@gaston>  <404812A2.70207@nortelnetworks.com>
	 <1078465612.5704.52.camel@gaston>  <4048B720.4010403@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1078530835.5704.125.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 10:53:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This OS allows runtime patching of code.  After changing the 
> instruction(s), it then has to make sure that the icache doesn't contain 
> stale instructions.
> 
> The original code was written for ppc hardware that had the ability to 
> flush the whole dcache and invalidate the whole icache, all at once, so 
> that's what they used. 

That's very inefficient.

> The code doesn't track the address/size of what 
> was changed.  For our existing products, we are using the 74xx series, 
> and they've got hardware cache flush/invalidate as well, so we just kept 
> using that.

Ouch... that _VERY_ inefficient... and the HW flush on the 74xx may
be broken on some models afaik =P 

>   For the 970 however, that hardware mechanisms seem to be 
> absent, which started me on this whole path.
> 
> After doing some digging in the 970fx specs, it seems that we may not 
> need to explicitly force a store of the L1 dcache at all.  According to 
> the docs, the L1 dcache is unconditionally store-through. Thus, for a 
> brute-force implementation we should be able to just invalidate the 
> whole icache, do the appropriate sync/isync, and it should pick up the 
> changed instructions from the L2 cache.  Do you see any problems with 
> this?  Do I actually still need the store?

It's unclear if stores will get straight to the coherency domain or not,
they may still be stuffed in a store queue... Though a sync would
probably flush it. Still, you should really try to get your code fixes
to just dcb{f,st}/icbi on the right instruction.

> Of course, the proper fix is to change the code in the OS running on the 
> emulator to track the addresses that got changed and just do the minimal 
> work required.
> 
> Chris
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

