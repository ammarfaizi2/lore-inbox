Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUEHUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUEHUQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUEHUQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 16:16:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30157 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264138AbUEHUQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 16:16:02 -0400
Date: Sun, 9 May 2004 01:43:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040508201259.GA6383@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 12:13:09PM -0700, Linus Torvalds wrote:
> On Sat, 8 May 2004, Andrew Morton wrote:
> > 
> > I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
> > serialise against d_move(), fixing the problem which you mention, and also
> > makes d_movecount go away.
> 
> If you do that, RCU basically loses most of it's meaning.
> 
> You'll be taking a lock for - and dirtying in the cache - every single
> dentry on the hash chain, which is pretty much guaranteed to be slower
> than just taking the dcache_lock _once_, even if that one jumps across 
> CPU's a lot.
> 
> In other words, no, I don't think that's a good idea. We really want to
> take the dentry lock only after we're pretty sure we have the right
> dentry. Otherwise the dentry chains will be bouncing from CPU to CPU all
> the time.

Exactly. Taking ->d_lock for every dentry while traversing the hash
chain should be avoided. As such, atomic operations on that path
are getting costly.

Thanks
Dipankar
