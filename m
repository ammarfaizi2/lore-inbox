Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUANJEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUANJEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:04:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:5134 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265594AbUANJD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:03:56 -0500
Date: 14 Jan 2004 10:04:53 +0100
Date: Wed, 14 Jan 2004 10:04:53 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation on gcc 3.4
Message-ID: <20040114090453.GB10916@colin2.muc.de>
References: <20040114083700.GA1820@averell> <20040114004944.5ba6b4a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114004944.5ba6b4a5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 12:49:44AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > 
> > The upcomming gcc 3.4 has a new inlining algorithm which sometimes
> > fails to inline some "dumb" inlines in the kernel. This sometimes leads
> > to undefined symbols while linking.
> 
> That's a compiler bug, surely.

See my mail to Jakub.

> 
> > To make the kernel compile again this patch drops the always inline
> > for gcc 3.4.  The new algorithm should be good enough to do the right
> > thing on its own. 
> 
> Are you sure?  Without the always_inline stuff we were seeing 100 different
> copies of __constant_c_and_count_memset and friends in the vmlinux symbol
> table.  It was really silly.
> 

That was with the old inliner. The new one is completely different
and should do better, especially with -funit-at-a-time. In fact there were
 still a few no inlines for __builtin_constant_p stuff, but Jan fixed them
 now (it was one small left over buglet in the inlining
heuristics). Should be fixed soon in gcc mainline.

I have another patch to compile with -Winline (submitted shortly)
which catches all these issues easily.

> After applying this patch and building with gcc-3.4, how does `size
> vmlinux' compare with the same kernel built with gcc-3.3, minus the patch?

I can only compare to a 3.3-hammer branch compiler, which is a kind
of mixture between 3.3 and 3.4 and already has an older version of the
inliner. 

Better is to use -Winline. You get a warning then
There was only one warning for copy_*_user stuff somewhere in XFS because
it bloated an ioctl function considerably.  There are many other
inlining warnings too, but these seemed to be mostly kernel bugs
(stuff declared inline in headers without bodies etc.)
I think fixing copy_*_user with extern inline would be better so that a 
out of line copy_from_user is used in this case (I can prepare a patch for 
that if you're interested) 

-Andi
