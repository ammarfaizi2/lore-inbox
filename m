Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVL3CD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVL3CD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVL3CD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:03:27 -0500
Received: from [139.30.44.16] ([139.30.44.16]:33394 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750765AbVL3CD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:03:26 -0500
Date: Fri, 30 Dec 2005 03:03:22 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <1135897092.2935.81.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
References: <1135798495.2935.29.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>  <20051228212313.GA4388@elte.hu>
 <20051228214845.GA7859@elte.hu>  <20051228201150.b6cfca14.akpm@osdl.org>
 <20051229073259.GA20177@elte.hu>  <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
  <20051229202852.GE12056@redhat.com>  <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
  <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>  <20051229224839.GA12247@elte.hu>
 <1135897092.2935.81.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Arjan van de Ven wrote:

> Some data from an x86-64 allyesconfig build.

Thanks for the table. This certainly is a good starting point to find 
valid candidates for uninlining.

> Below is a *rough* estimate of savings that could be achieved by
> uninlining specific functions. The estimate is rough in the sense that 
> it assumes
> that no "trick" allows the uninlined version to be significantly smaller
> than the inlined version, which for certain functions is not a valid
> assumption (kmalloc comes to mind as an obvious one).

What about the (probably more common) case that the inlined version is 
smaller because of optimizations that are not possible in the general 
case?

> The saving is estimated at (count-1) * (size-6), eg the estimate for a
> function call is 6 bytes as well and the estimate for the size something 
> takes as inlined is the same as the uninline size. 

Maybe the estimate is a little bit too rough. All savings add up to 
1780743 bytes, which seems a bit too large to me (can't compare to the
total size of an allyesconfig kernel since that gives me a 'File size 
limit exceeded' when linking).


What about the previous suggestion to remove inline from *all* static 
inline functions in .c files?
I just tried that for the fun of it. It got rid of 8806 'inline' 
annotations and produced the ~2 MB (uncompressed) patch at
   http://www.physik3.uni-rostock.de/tim/kernel/2.6/deinline.patch.gz
The resulting kernel actually booted (am running it right now). However, 
catching just these low-hanging fruits doesn't get me anywhere near 
Arjan's numbers. For my non-representative personal config I get (on 
i386 with -unit-at-a-time):

   > size vmlinux*
      text    data     bss     dec     hex filename
   2197105  386568  316840 2900513  2c4221 vmlinux
   2144453  392100  316840 2853393  2b8a11 vmlinux.deinline

I just started an allyesconfig build to get some real numbers.

Tim
