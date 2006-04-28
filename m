Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWD1FeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWD1FeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWD1FeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:34:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030213AbWD1FeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:34:11 -0400
Date: Thu, 27 Apr 2006 22:34:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
In-Reply-To: <4451A00A.2030606@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0604272230230.3701@g5.osdl.org>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org>
 <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
 <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <44505B59.1060308@yahoo.com.au>
 <Pine.LNX.4.64.0604270804420.3701@g5.osdl.org> <4451A00A.2030606@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Nick Piggin wrote:
> > 
> > See __d_lookup() for details.
> 
> Yes I see. Perhaps a seqlock could do the trick (hmm, there already is one),
> however we still have to increment the refcount, so there'll always be a
> shared cacheline.

Actually, the thing I'd really _like_ to see is not even incrementing the 
refcount for intermediate directories (and those are actually the most 
common case).

It should be possible in theory to do a lookup of a long path all using 
the rcu_read_lock, and only do the refcount increment (and then you might 
as well do the d_lock thing) for the final component of the path.

Of course, it's not possible right now. We do each component separately, 
and we very much depend on the d_lock. For some things, we _have_ to do it 
that way (revalidation etc), so the "possible in theory" isn't always even 
true.

And every time I look at it, I decide that it's too damn complex, and the 
end result would look horrible, and that I'd probably get it wrong anyway.

Still, I've _looked_ at it several times.

		Linus
