Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVCRT2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVCRT2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCRT2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:28:34 -0500
Received: from colin2.muc.de ([193.149.48.15]:32265 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261977AbVCRT2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:28:12 -0500
Date: 18 Mar 2005 20:28:08 +0100
Date: Fri, 18 Mar 2005 20:28:08 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Message-ID: <20050318192808.GB38053@muc.de>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com> <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 07:00:06AM -0800, Christoph Lameter wrote:
> On Fri, 18 Mar 2005, Denis Vlasenko wrote:
> 
> > NT stores are not about 5% increase. 200%-300%. Provided you are ok with
> > the fact that zeroed page ends up evicted from cache. Luckily, this is exactly
> > what you want with prezeroing.
> 
> These are pretty significant results. Maybe its best to use non-temporal

The differences are actually less. I do not know what Denis benchmarked,
but in my tests the difference was never more than ~10%.  He got a zero
too much? 

It does not make any sense if you think of it - the memory bus
of the CPU cannot be that much faster than the cache.

And the drawback of eating the cache misses later is really very
significant.

> stores in general for clearing pages? I checked and Itanium has always
> used non-temporal stores. So there will be no benefit for us from this

That is weird. I would actually try to switch to temporal stores, maybe
it will improve some benchmarks. 

> approach (we have 16k and 64k page sizes which may make the situation a
> bit different). Try to update the i386 architectures to do the same?

Definitely not. 

You can experiment with using it for the cleaner daemon, but even
there I would use some heuristic to make sure you only use it 
on a page that are at the end of a pretty long queue.

e.g. if you can guarantee that the page allocator will go through
500k-1MB before going to the NT page that is cache cold it may
be a good idea. But that might be pretty complicated and I am not
sure it will be worth it.

But for the clear running in the page fault handler context it is 
definitely a bad idea.

-Andi
