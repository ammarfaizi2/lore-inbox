Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135187AbRDMBeo>; Thu, 12 Apr 2001 21:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135207AbRDMBef>; Thu, 12 Apr 2001 21:34:35 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:5047 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135187AbRDMBe3>; Thu, 12 Apr 2001 21:34:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alexander Viro <viro@math.psu.edu>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
Date: Thu, 12 Apr 2001 21:34:24 -0400
X-Mailer: KMail [version 1.2]
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104121107570.19944-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0104121107570.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01041221342400.27841@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 April 2001 11:12, Alexander Viro wrote:
> On Thu, 12 Apr 2001, Rik van Riel wrote:
> > On Thu, 12 Apr 2001, Ed Tomlinson wrote:
> > > I have been playing around with patches that fix this problem.  What
> > > seems to happen is that the VM code is pretty efficent at avoiding the
> > > calls to shrink the caches.  When they do get called its a case of to
> > > little to late.  This is espically bad in lightly loaded systems.
> > > The following patch helps here.  I also have a more complex version
> > > that uses autotuning, but would rather push the simple code, _if_ it
> > > does the job.
> >
> > I like this patch. The thing I like most is that it tries to free
> > from this cache if there is little activity, not when we are low
> > on memory and it is physically impossible to get rid of the cache.
> >
> > Remember that evicting early from the inode and dentry cache doesn't
> > matter since we can easily rebuild this data from the buffer and page
> > cache.
>
> Ahem. Yes, for local block-based filesystems, provided that directories are
> small and that indirect blocks will not flush the inode table buffers out
> of buffer cache, etc., etc.
>
> Keeping inodes clean when pressure is low is a nice idea. That way you can
> easily evict when needed. Evicting early... Not really.

What prompted my patch was observing situations where the icache (and dcache 
too) got so big that they were applying artifical pressure to the page and 
buffer caches. I say artifical since checking the stats these caches showed 
over 95% of the entries unused.  At this point there is usually another 10% 
or so of objects allocated by the slab caches but not accounted for in the 
stats (not a problem they are accounted if the cache starts using them).

Suspect your change to the prune logic is not going to help the above situation 
much - if the shrink functions are not called often enough we end up with over 
size caches. 

Comments?
Ed Tomlinson <tomlins@cam.org>
