Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUEHT2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUEHT2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 15:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUEHT2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 15:28:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:2277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264102AbUEHT2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 15:28:01 -0400
Date: Sat, 8 May 2004 12:27:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
In-Reply-To: <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org>
 <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org>
 <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org>
 <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org>
 <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 May 2004, Linus Torvalds wrote:
> 
> 
> On Sat, 8 May 2004, Andrew Morton wrote:
> > 
> > I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
> > serialise against d_move(), fixing the problem which you mention, and also
> > makes d_movecount go away.
> 
> If you do that, RCU basically loses most of it's meaning.

Hmm.. Maybe I'm wrong.

In particular, it should be safe to at least do the name hash and parent
comparison without holding any lock (since even if they are invalidated by
a concurrent "move()" operation, doing the comparison is safe). By the
time those have matched, we are probably pretty safe in taking the lock,
since the likelihood of the other checks matching should be pretty high.

And yes, removing d_movecount would be ok by then, as long as we re-test
the parent inside d_lock (we don't need to re-test "hash", since if we
tested the full name inside the lock, the hash had better match too ;)

Comments?

		Linus
