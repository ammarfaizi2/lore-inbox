Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTHIDUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272252AbTHIDUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:20:54 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:12563 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272251AbTHIDUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:20:50 -0400
Date: Sat, 9 Aug 2003 13:19:45 +1000
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
Message-ID: <20030809031945.GA12102@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <20030809010736.GA10487@gondor.apana.org.au> <Pine.LNX.4.53.0308090357290.18879@Chaos.suse.de> <20030809025232.GA11777@gondor.apana.org.au> <Pine.LNX.4.53.0308090509020.18879@Chaos.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308090509020.18879@Chaos.suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 05:13:52AM +0200, Andreas Gruenbacher wrote:
> On Sat, 9 Aug 2003, Herbert Xu wrote:
> 
> > On Sat, Aug 09, 2003 at 04:04:53AM +0200, Andreas Gruenbacher wrote:
> > >
> > > > My patch is buggy too.  If a file is closed by another clone between
> > > > the two steal_locks calls the lock will again be lost.  Fortunately
> > > > this much harder to trigger than the previous bug.
> > >
> > > I think this is not a strict bug---this scenario is not covered by POSIX
> > > in the first place. Unless lock stealing is done atomically with
> > > unshare_files there is a window of oportunity between unshare_files() and
> > > steal_locks(), so locks can still get lost.
> >
> > It's not a standard compliance issue.  In this case the lock will never
> > be released and it will eventually lead to a crash when someone reads
> > /proc/locks.
> 
> I don't see how this would happen. Could you please elaborate?

Suppose that A and B share current->files and fd has a POSIX lock on it.

A			B
unshare_files
steal_locks
			close(fd)
exec fails
steal_locks
put_files_struct

The close in B fails to release the lock as it has been stolen by the
new files structure.  The second steal_locks sets the fl_owner back to
the original files structure which no longer has fd in it and hence can
never release that lock.  The put_files_struct doesn't release the lock
either since it is now owned by the original file structure.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
