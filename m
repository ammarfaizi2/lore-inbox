Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbRGXDtd>; Mon, 23 Jul 2001 23:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbRGXDtX>; Mon, 23 Jul 2001 23:49:23 -0400
Received: from mplspop4.mpls.uswest.net ([204.147.80.14]:6406 "HELO
	mplspop4.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S266853AbRGXDtT>; Mon, 23 Jul 2001 23:49:19 -0400
Date: Mon, 23 Jul 2001 20:45:54 -0700
Message-Id: <p05100306b7829ca20739@[10.0.0.49]>
From: "Jonathan Lundell" <jlundell@pobox.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Andrea Arcangeli" <andrea@suse.de>, "Jeff Dike" <jdike@karaya.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Jan Hubicka" <jh@suse.cz>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0107231546430.7916-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107231546430.7916-100000@penguin.transmeta.com>
Subject: Re: user-mode port 0.44-2.4.7
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 3:51 PM -0700 2001-07-23, Linus Torvalds wrote:
>On Mon, 23 Jul 2001, Jonathan Lundell wrote:
>>
>>  If jiffies were not volatile, this initializing assignment and the
>>  test at the end could be optimized away, leaving an unconditional
>>  "return 0". A lock is of no help.
>
>Right.
>
>We want optimization barriers, and there's an explicit "barrier()"  thing
>for Linux exactly for this reason.
>
>For historical reasons "jiffies" is actually marked volatile, but at least
>it has reasonably good semantics with a single-data item. Which is not to
>say I like it. But grep for "barrier()" to see how many times we make this
>explicit in the algorithms.
>
>And really, THAT is my whole point. Notice in the previous mail how I used
>"volatile" when it was part of the _algorithm_. You should not hide
>algorithmic choices in your data structures. You should make them
>explicit, so that when you read the code you _see_ what assumptions people
>make.

OK, sure, that's fine. Better than barrier() in some respects, too. 
Namely, 1) volatile is portable C; barrier() isn't (not that that's 
much of an issue for compiling Linux), and 2) volatile can be 
specific to a variable, unlike the indiscriminate barrier(), which 
forces a reload of everything that might be cached (OK, not a big 
deal for IA32, but nontrivial for many-register architectures). One 
could imagine a more specific barrier(jiffies) syntax, I suppose, but 
the volatile cast is nice, restricting the effect not only to the 
single variable but to the single reference to a single variable.

>For example, if you fix the code by adding an explicit barrier(), people
>see that (a) you're aware of the fact that you expect the values to change
>and (b) they see that it is taken care of.
>
>In contrast, if your data structure is marked volatile, how is anybody
>reading the code every going to be sure that the code is correct? You have
>to look at the header file defining all the data structures. That kind of
>thing is NOT GOOD.

-- 
/Jonathan Lundell.
