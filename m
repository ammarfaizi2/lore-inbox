Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWB1TI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWB1TI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWB1TI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:08:59 -0500
Received: from kanga.kvack.org ([66.96.29.28]:62119 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932416AbWB1TI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:08:58 -0500
Date: Tue, 28 Feb 2006 14:03:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Message-ID: <20060228190354.GE24306@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <20060225142814.GB17844@kvack.org> <1140887517.9852.4.camel@localhost.localdomain> <20060225174134.GA18291@kvack.org> <1141149009.24103.8.camel@camp4.serpentine.com> <20060228175838.GD24306@kvack.org> <1141150814.24103.37.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141150814.24103.37.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 10:20:14AM -0800, Bryan O'Sullivan wrote:
> No.  We're writing to a region that we've marked as write combining, so
> the processor or north bridge will not write in program order.  It's
> free to write out the write combining store buffers in whatever order it
> feels like, unless forced to do otherwise.

The rules are a bit more complex than that -- write are weakly ordered, 
but still ordered.  They maybe be delayed with respect to other stores, 
but will never occur before other stores are visible to the cache 
heirarchy.  In terms of how writes to the write combining region are 
delayed, you'll have to look at the addresses of the registers you are 
writing to.  If they map to the same write combining buffer (that is each 
one can combine with the previous write) and are increasing in address, 
then you don't need the explicite barrier.  Most hardware is laid out so 
that this is possible.

The case the write combining buffers affect memory ordering in an 'unexpected' 
way is if your writes combine and you write to registers in an order that 
is opposite from that in which they combine.  Ie, a write to address 8 
followed by a write to address 0 that combines will show up on the bus 
as 0, 8 (assuming an 8 byte writes at 0).  Besides that, the write combining 
buffers can introduce a delay of a few clocks while the cpu defers the write 
in the hope that it will combine with another write, but that delay applies 
to all writes that go through the write combining buffers and thus do not 
change the memory ordering (except as previously noted).

Memory barriers are not cheap.  At least for the example you provided, 
it looks like things are overdone and performance is going to suck, so 
it needs to be avoided if at all possible.  I really think that you 
should be using wmb().

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
