Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUEHVDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUEHVDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUEHVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:03:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31158 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264153AbUEHVDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:03:16 -0400
Date: Sun, 9 May 2004 02:30:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, manfred@colorfullife.com,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
Message-ID: <20040508210021.GC6383@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508120148.1be96d66.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 12:01:48PM -0700, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> > Also, in your previous patch (which I'm not as convinced might be wrong), 
> > the d_qstr pointer removal makes me worry:
> > 
> > -       struct qstr * d_qstr;           /* quick str ptr used in lockless lookup and concurrent d_move */
> > 
> > I thought the point of d_qstr was that when we do the lockless lookup,
> > we're guaranteed to always see "stable storage" in the sense that when we
> > follow the d_qstr, we will always get a "char *" + "len" that match, and
> > we could never see a partial update (ie len points to the old one, and
> > "char *" points to the new one).
> 
> It looks that way.

Yes, that is exactly why d_qstr was introduced. The "len" and the
storage for the name is then a single update through d_qstr.

> 
> > In particular, think about the "d_compare(parent, qstr, name)" / 
> > "memcmp(qstr->name, str, len)" part - what if "len" doesn't match str, 
> > because a concurrent d_move() is updating them, and maybe we will compare 
> > past the end of kernel mapped memory or something?
> > 
> > (In other words, the "move_count" check should protect us from returning a 
> > wrong dentry, but I'd worry that we'd do something that could cause 
> > serious problems before we even get to the "move_count" check).
> > 
> > Hmm?

Yes, that is indeed why we had to have d_qstr.


> I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
> serialise against d_move(), fixing the problem which you mention, and also
> makes d_movecount go away.

Repeating some of the tests under ->d_lock is worth looking at, but
we have to be carefull about performance. ISTR, there was another
issue related to calling ->d_compare() under ->d_lock. I will dig
a little bit on this, or Maneesh may remember.

Thanks
Dipankar
