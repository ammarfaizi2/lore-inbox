Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWHKIss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWHKIss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWHKIss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:48:48 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:24500 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750885AbWHKIsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:48:47 -0400
Subject: Re: What's the NFS OOM problem?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: Willy Tarreau <w@1wt.eu>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <17627.53340.43470.60811@cse.unsw.edu.au>
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
	 <20060810045711.GI8776@1wt.eu>  <17627.53340.43470.60811@cse.unsw.edu.au>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 10:48:30 +0200
Message-Id: <1155286110.5696.64.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 10:33 +1000, Neil Brown wrote:
> On Thursday August 10, w@1wt.eu wrote:
> > 
> > > Can someone help me and give me a brief description on OOM issue?
> > 
> > I don't know about any OOM issue related to NFS. At most it might happen
> > on the client (eg: stating firefox from an NFS root) which might not have
> > enough memory for new network buffers, but I don't even know if it's
> > possible at all.
> 
> We've had reports of OOM problems with NFS at SuSE.
> The common factors seem to be lots of memory (6G+) and very large
> files. 
> Tuning down  /proc/sys/vm/dirty_*ratio seems to avoid the problem,
> but I'm not very close to understanding what the real problem is.

Would it not be related to mmap'ed files, where the client will not
properly
track the dirty pages? This will make the reclaim code go crap itself
because
suddenly not a single page is easily freeable anymore, all pages are
then
found to be dirty and require writeback, which takes more memory - ie.
allocate
network packets, and wait for proper answer.

Andrew is currently carrying some patches that will avoid this problem
by
virtue of tracking dirtying of mmap'ed pages. With these patches
nr_dirty is
properly incremented and the pdflush logic should kick in and do its
thing.

This would explain why lowering dirty_*ratio would sometimes help, that
would
kick off the pdflush thread earlier, which would then detect the
previously
unknown dirty pages.


