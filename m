Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUENOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUENOpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUENOpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:45:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:52396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261321AbUENOpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:45:06 -0400
Date: Fri, 14 May 2004 07:44:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Raghavan <raghav@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       maneesh@in.ibm.com, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
In-Reply-To: <20040514111759.GL4002@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0405140735480.25771@ppc970.osdl.org>
References: <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org>
 <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
 <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
 <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com>
 <20040511132205.4b55292a.akpm@osdl.org> <20040514103322.GA6474@in.ibm.com>
 <20040514111759.GL4002@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 May 2004, Dipankar Sarma wrote:
> > 
> > 2.6.6                       10280             110
> > 
> > 2.6.6-bk                    10862             30
> 
> > To find out if the huge performance dip between the 2.6.6
> > and 2.6.6-bk is because of the hash changes, I removed the hash patch
> > from 2.6.6-bk and applied it to 2.6.6.
> > 
> > 2.6.6-bk with old hash      10685             34
> > 
> > 2.6.6 with new hash         10496             125
> > 
> > Looks like the new hashing function has brought down the performance.
> > Also some code outside dcache.c and inode.c seems to have pushed down
> > the performance in 2.6.6-bk.
> 
> OK, I am confused. These numbers show that the new hash function
> is better.

No, look again.

			old hash		new hash
	
	2.6.6:		10280			10496
	2.6.6-bk:	10685			10862

in both cases, the new hash makes each iteration about ~200us (or whatever 
the metric is) slower.

There's something _else_ going on too, since plain 2.6.6 is so clearly 
better than the others. I don't know why - the only thing -bk does is the 
hash change and some changes to GFP_NOFS behaviour (different return value 
from shrink_dentries or whatever). Which shouldn't even trigger, I'd have 
assumed this is all cached.

NOTE! Just "simple" things like variations in I$ layout of the kernel code 
can make a pretty big difference if you're unlucky. And the new dentry 
code doesn't align the things on a D$ cache line boundary, so there could 
easily be "consistent" differences from that - just from the order of 
dentries allocated etc.

But it's interesting to note that the hash does make a difference. The old 
hash was very much optimized for simplicity (those hash-calculation 
routines are some of the hottest in the kernel). But I don't see that a 
few extra instructions should make that big of a difference.

		Linus
