Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266297AbUFYIEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUFYIEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266335AbUFYIEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:04:42 -0400
Received: from nacho.alt.net ([207.14.113.18]:10981 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S266297AbUFYIEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:04:37 -0400
Date: Fri, 25 Jun 2004 01:04:34 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <Pine.LNX.4.44.0406231802100.13351-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0406250048190.6668-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Chris Caputo wrote:
> On Sat, 19 Jun 2004, Marcelo Tosatti wrote:
> > Can you show us this data in more detail?
> 
> In __refile_inode() before and after the list_add()/del() calls I call a
> function which checks up to the first 10 items on the inode_unused list to
> see if next and prev pointers are valid.
> (inode->next->prev == inode && inode->prev->next == inode)
> 
> So what I observed was a case here where iput() inline __refile_inode():
> 
>  1) checked inode_unused and saw that it was good
>  2) put an item on the inode_unused list
>  3) checked inode_unused and saw that it was now bad and that the item 
>     added was the culprit.
> 
> This all happened within __refile_inode() with the inode_lock spinlock
> grabbed by iput() and so I tend to think some other code is accessing the
> inode_unused list _without_ grabbing the spinlock.  I've checked the
> inode.c code over and over, plus my filesystem code, and haven't yet found
> a culprit.  I also checked the tux diffs to see if it was messing with
> inode objects in an inappropriate way.
> 
> Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> to ask.

An update on this.

Line #3 above is not entirely correct in that I have not seen the item
being added becoming immediately corrupt, but rather items beyond it.

Specifically I have now seen:

  inode_unused->next->next->prev != inode_unused->next

and:

  inode_unused->next->next->next->prev != inode_unused->next->next

My verification function doesn't check the whole inode_unused list (would
be too slow to do so), but it may be that items are only corrupted shortly
after being added to the list.  Ie., someone is still using the inode
shortly after when they shouldn't be.

> __refile_inode() was introduced in 2.4.25.  I'll try 2.4.24 to see if I
> can reproduce there.

No word yet on my 2.4.24 testing.  (test still running without failure)

I'll keep digging,
Chris

