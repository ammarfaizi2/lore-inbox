Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUGAE5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUGAE5q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUGAE5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:57:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:55781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262730AbUGAE5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:57:45 -0400
Date: Wed, 30 Jun 2004 21:57:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <200407010322.i613MPDr016785@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406302147350.11212@ppc970.osdl.org>
References: <200407010322.i613MPDr016785@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jun 2004, Roland McGrath wrote:
>
> The following patch fixes that for me.  I am not 100% confident that the
> locking dance required here doesn't create some weird issue (and it
> certainly seems inefficient how many times the lock is released and
> retaken in this sequence), but maybe 92% sure.

I do think the locking is broken in your patch.

Since you release the tasklist lock, the children on our list of children 
might go away while you released the lock, making the

	list_for_each_safe(..)

thing unsafe - the next entry in the list (that we have cached in "next") 
may have gone away, resulting in us using a stale pointer when we re-start 
the loop after re-aquiring the lock.

HOWEVER, I think you can fix it with something like

	_n = father->children.next;

after you've re-aquired the lock (that will re-start the loop, but since 
we should have gotten rid of all the previous entries, the "restart" is 
actually going to just continue at the point where we were going to 
continue anyway, so it shouldn't cause any extra iterations).

Does that still work for you, or have I totally messed up?

I do agree with Andrea that it's ugly, and my patch just makes it uglier 
still. I wonder if there is some cleaner way to do the same thing.

		Linus
