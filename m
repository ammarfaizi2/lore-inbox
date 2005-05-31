Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVEaIh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVEaIh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 04:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEaIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 04:37:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1769 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261262AbVEaIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 04:37:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andi Kleen <ak@muc.de>, dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Date: Tue, 31 May 2005 11:37:00 +0300
User-Agent: KMail/1.5.4
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
References: <20050530181626.GA10212@kvack.org> <Pine.LNX.4.62.0505301209010.25345@twinlark.arctic.org> <20050530193225.GC25794@muc.de>
In-Reply-To: <20050530193225.GC25794@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311137.00011.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 May 2005 22:32, Andi Kleen wrote:
> On Mon, May 30, 2005 at 12:11:23PM -0700, dean gaudet wrote:
> > On Mon, 30 May 2005, dean gaudet wrote:
> > 
> > > On Mon, 30 May 2005, Benjamin LaHaise wrote:
> > > 
> > > > Below is a patch that uses 128 bit SSE instructions for copy_page and 
> > > > clear_page.  This is an improvement on P4 systems as can be seen by 
> > > > running the test program at http://www.kvack.org/~bcrl/xmm64.c to get 
> > > > results like:
> > > 
> > > it looks like the patch uses SSE2 instructions (pxor, movdqa, movntdq)... 
> > > if you use xorps, movaps, movntps then it works on SSE processors as well.
> > 
> > oh and btw... on x86-64 you might want to look at using movnti with 64-bit 
> > registers... the memory datapath on these processors is actually 64-bits 
> > wide, and the 128-bit stores are broken into two 64-bit pieces internally 
> > anyhow.  the advantage of using movnti over movntdq/movntps is that you 
> > don't have to save/restore the xmm register set.

And if (more like 'when', actually) next AMD CPU will have 2x128bit bus
instead of 2x64bit? Revert back to XMM?
 
> Any use of write combining for copy_page/clear_page is a bad idea.
> The problem is that write combining always forces the destination
> out of cache.  While it gives you better microbenchmarks your real workloads
> suffer because they eat lot more additional cache misses when
> accessing the fresh pages.
> 
> Don't go down that path please.

I doubt it unless real-world data will back your claim up.

I did microbenchmarking. You said it looks good in microbench but
hurts real-world.

Sometime after that I made a patch which allows for switching
clear/copy routines on the fly, and played a bit with real-world tests.

See http://www.thisishull.net/showthread.php?t=36562

In short, I ran forking test programs which excercise clearing and copying
routines in kernel. I wasn't able to find a usage pattern where page copying
using SSE non-temporal stores is a loss. Page clear was demonstrably worse,
no argument about that.

If you know such usage pattern, I'd like to test it.
--
vda

