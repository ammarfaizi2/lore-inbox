Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUEHUpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUEHUpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUEHUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 16:45:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:28560 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264155AbUEHUph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 16:45:37 -0400
Date: Sun, 9 May 2004 02:12:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
Message-ID: <20040508204239.GB6383@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 12:27:50PM -0700, Linus Torvalds wrote:
> 
> On Sat, 8 May 2004, Linus Torvalds wrote:
> > On Sat, 8 May 2004, Andrew Morton wrote:
> > > 
> > > I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
> > > serialise against d_move(), fixing the problem which you mention, and also
> > > makes d_movecount go away.
> > 
> > If you do that, RCU basically loses most of it's meaning.
> 
> In particular, it should be safe to at least do the name hash and parent
> comparison without holding any lock (since even if they are invalidated by
> a concurrent "move()" operation, doing the comparison is safe). By the
> time those have matched, we are probably pretty safe in taking the lock,
> since the likelihood of the other checks matching should be pretty high.
> 
> And yes, removing d_movecount would be ok by then, as long as we re-test
> the parent inside d_lock (we don't need to re-test "hash", since if we
> tested the full name inside the lock, the hash had better match too ;)

There are couple of issues that need to be checked -

1. Re-doing the parent comparison and full name under ->d_lock
need to be benchmarked using dcachebench. That part of code
is extrememly performance sensitive and I remember that the
current d_movecount based solution was done after a lot of
benchmarking of various alternatives.

2. We need to check if doing ->d_compare() under ->d_lock will
result in locking hierarchy problems.

Thanks
Dipankar
