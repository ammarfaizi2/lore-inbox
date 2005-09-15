Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbVIOQet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbVIOQet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbVIOQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:34:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030522AbVIOQes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:34:48 -0400
Date: Thu, 15 Sep 2005 09:34:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
In-Reply-To: <20050915162347.GC4122@opteron.random>
Message-ID: <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org>
References: <20050914212405.GD4966@opteron.random>
 <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random>
 <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Sep 2005, Andrea Arcangeli wrote:
> 
> I'll try again: what is the point of still getting page faults on writes
> when the first read will contain the wrong data?

What's the point of having the page AT ALL if the data is wrong?

You are _still_ arguing that the "data" and the "page fault" are somehow 
connected. They aren't.

If you think the data is wrong, then you are arguing against the COW. Yes, 
the COW will make the data "wrong", but you can't escape that. That's what 
a "write" by ptrace does.

Btw, that's true even if we didn't do the COW - the COW just makes it even 
more so. But even without the COW, the ptrace has written data that the 
process didn't expect, and the process didn't write. 

Here's a big clue. A ptrace PTRACE_POKE-induced write WRITES DATA.

Afterwards, the data is different from what if would have been if the
ptrace hadn't written. It's "wrong". Tough titties. It's what ptrace does.
Live with it. If you don't want wrong data, don't use ptrace to write 
wrong data.

However, you seem to confuse "write data" with "write data and make the
page writable".

And as long as you continue to mix the two, there's no point in talking
about it. They are different.

To recap: PTRACE_POKE _will_ write "wrong data" to the process. Part of it 
directly (the actual data written), and part of it indirectly (the fact 
that it has to break the COW connection in order to do the write). THAT IS 
INESCAPABLE, AND IT IS A DIRECT RESULT OF PTRACE_POKE.

And it has _nothing_ to do with whether we fault afterwards or not. 

		Linus
