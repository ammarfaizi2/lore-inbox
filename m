Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319350AbSHQFWM>; Sat, 17 Aug 2002 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319361AbSHQFWM>; Sat, 17 Aug 2002 01:22:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46823 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319350AbSHQFWL>; Sat, 17 Aug 2002 01:22:11 -0400
Date: Fri, 16 Aug 2002 22:24:09 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: lots of mem on 32 bit machines (was: aio-core why not using SuS?)
Message-ID: <2160605666.1029536648@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0208162156090.2539-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208162156090.2539-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, at this point I should say that that doesn't mean that I'm _against_
> a per-VM kmap table, I'm just pointing out that it's not a trivial issue.
> 
> Andrea and I talked about exactly this at OLS, because Andrea would have
> liked to use it for handling the generic_file_write() kmap case without
> having to worry about running out of kmap's and the deadlocks we used to
> have in that space (before the atomic user copy approach).

I know ;-) We talked over that one a lot ... but I think we ended
up just avoiding the problem (every solution we came up with sucked).
I wasn't so worried about avoiding kmap pool exhaustion as reducing
TLB flushing - if we put 4096 entries in the pool, and can cope with
blocking if the silly thing does happen to fill up, that seems OK.

The *really* nice thing is that you can do all sorts of smart stuff
with the TLB at this point. As we now duplicated the pool per VM,
it just got much, much larger. Chances are by the time you come to
re-use an entry you've already TLB flushed all the CPUs from context
switching. Keep track of that and you *never* tlb flush for kmap.

But in the end the two main users of kmap seem to be copy_to/from_user
stuff and highpte - using atomic for the former and the per-VM space
for the latter seems to fix the problem far enough that nobody could
see it anymore, so nobody cares ;-)

> And the thing is, you _can_ use a per-VM kmap setup, but it really only
> moves the problem from a global kmap space ("everybody shares the same
> VM") into a slightly smaller subset of it, a global thread kmap ("all
> threads share the same VM").

Well, I disagree with the "slightly" in that statement, but otherwise
yes ;-) If you're not running heavy threading, it works brilliantly.
If you are, it's better, but not necessarily brilliant.
 
> There may be other cases where this is ok. Moving to a per-VM kmap space
> may not _fix_ some fundamental scalability problem, but it might move it
> further out and make it a non-issue under normal load. Which is why I
> don't think the idea is fundamentally flawed, I just wanted to point out
> some of the traps to people since we've already almost fallen into some of
> them..

Yup, I think we ended up pushing it out by other means, but it's
still interesting. Things like this only need to be pushed out
until the timely death of 32 bit machines ;-)

If I'm not insane about the per-task stuff in the previous email,
that could be used for a per-task kmap, which would be much nicer
all round. But the chances of me being insane are pretty good ;-)

M.
