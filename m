Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVE3Tc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVE3Tc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVE3Tc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:32:56 -0400
Received: from colin.muc.de ([193.149.48.1]:50959 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261712AbVE3Tc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:32:29 -0400
Date: 30 May 2005 21:32:25 +0200
Date: Mon, 30 May 2005 21:32:25 +0200
From: Andi Kleen <ak@muc.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050530193225.GC25794@muc.de>
References: <20050530181626.GA10212@kvack.org> <Pine.LNX.4.62.0505301202380.25345@twinlark.arctic.org> <Pine.LNX.4.62.0505301209010.25345@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505301209010.25345@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 12:11:23PM -0700, dean gaudet wrote:
> On Mon, 30 May 2005, dean gaudet wrote:
> 
> > On Mon, 30 May 2005, Benjamin LaHaise wrote:
> > 
> > > Below is a patch that uses 128 bit SSE instructions for copy_page and 
> > > clear_page.  This is an improvement on P4 systems as can be seen by 
> > > running the test program at http://www.kvack.org/~bcrl/xmm64.c to get 
> > > results like:
> > 
> > it looks like the patch uses SSE2 instructions (pxor, movdqa, movntdq)... 
> > if you use xorps, movaps, movntps then it works on SSE processors as well.
> 
> oh and btw... on x86-64 you might want to look at using movnti with 64-bit 
> registers... the memory datapath on these processors is actually 64-bits 
> wide, and the 128-bit stores are broken into two 64-bit pieces internally 
> anyhow.  the advantage of using movnti over movntdq/movntps is that you 
> don't have to save/restore the xmm register set.

Any use of write combining for copy_page/clear_page is a bad idea.
The problem is that write combining always forces the destination
out of cache.  While it gives you better microbenchmarks your real workloads
suffer because they eat lot more additional cache misses when
accessing the fresh pages.

Don't go down that path please.

At least on Opteron I did quite some tests and the existing setup
with just rep ; movsq for C stepping or later or the unrolled loop 
for earlier CPUs worked best overall. On P4 I haven't do any benchmarks;
however it might be a good idea to check if rep ; movsq would be 
a win there too (if yes it could be enabled there)

-Andi
