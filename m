Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272247AbTHID2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272248AbTHID2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:28:40 -0400
Received: from mail.suse.de ([213.95.15.193]:24332 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272247AbTHID2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:28:38 -0400
Subject: Re: [PATCH] 2.4: Fix steal_locks race
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030809031945.GA12102@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au>
	 <20030809010736.GA10487@gondor.apana.org.au>
	 <Pine.LNX.4.53.0308090357290.18879@Chaos.suse.de>
	 <20030809025232.GA11777@gondor.apana.org.au>
	 <Pine.LNX.4.53.0308090509020.18879@Chaos.suse.de>
	 <20030809031945.GA12102@gondor.apana.org.au>
Content-Type: text/plain
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1060399816.1798.38.camel@bree.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Aug 2003 05:30:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 05:19, Herbert Xu wrote:
> On Sat, Aug 09, 2003 at 05:13:52AM +0200, Andreas Gruenbacher wrote:
> > On Sat, 9 Aug 2003, Herbert Xu wrote:
> > 
> > > On Sat, Aug 09, 2003 at 04:04:53AM +0200, Andreas Gruenbacher wrote:
> > > >
> > > > > My patch is buggy too.  If a file is closed by another clone between
> > > > > the two steal_locks calls the lock will again be lost.  Fortunately
> > > > > this much harder to trigger than the previous bug.
> > > >
> > > > I think this is not a strict bug---this scenario is not covered by POSIX
> > > > in the first place. Unless lock stealing is done atomically with
> > > > unshare_files there is a window of oportunity between unshare_files() and
> > > > steal_locks(), so locks can still get lost.
> > >
> > > It's not a standard compliance issue.  In this case the lock will never
> > > be released and it will eventually lead to a crash when someone reads
> > > /proc/locks.
> > 
> > I don't see how this would happen. Could you please elaborate?
> 
> Suppose that A and B share current->files and fd has a POSIX lock on it.
> 
> A			B
> unshare_files
> steal_locks
> 			close(fd)
> exec fails
> steal_locks
> put_files_struct
> 
> The close in B fails to release the lock as it has been stolen by the
> new files structure.  The second steal_locks sets the fl_owner back to
> the original files structure which no longer has fd in it and hence can
> never release that lock.  The put_files_struct doesn't release the lock
> either since it is now owned by the original file structure.

In the patch I've sent there is no stealing back of locks, so that case
does not exist.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>


