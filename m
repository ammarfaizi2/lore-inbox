Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268457AbRGXUfK>; Tue, 24 Jul 2001 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268456AbRGXUfA>; Tue, 24 Jul 2001 16:35:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:1029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268449AbRGXUeo>; Tue, 24 Jul 2001 16:34:44 -0400
Date: Tue, 24 Jul 2001 13:33:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Dreker <patrick@dreker.de>
cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <E15P8jB-0000Au-00@wintermute>
Message-ID: <Pine.LNX.4.33.0107241328020.29611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Patrick Dreker wrote:
>
> I just decided to give this patch a try, as I have written a little
> application which does some statistics over traces dumped by another program
> by mmap()ing a large file and reading it sequentially. The trace file to be
> analyzed is about 240 megs in size and consists of records each 249 bytes
> long. The analysis program opens and the mmap()s the trace file doing some
> small calculations on the data (basically it adds up fields from the records
> to get overall values).

Note that the patch won't do much anything for the mmap() case - the VM
doesn't consider that "use once" anyway, and trying to make it do so would
be hard, I suspect. It's just very nasty to try to figure out whether the
user has touched the page a single time or millions of times...

We do have the "accessed" bit, but in order to get any access patterns
we'd have to scan the page tables a _lot_ more than we do now. Right now
we do it only under memory pressure, and only about once per memory cycle,
which is not really even remotely enough to get anything more than "yes,
the user did touch the page"..

In order for mmap() to make a difference with the new code, we could do
something like look at the adjacent VM pages on page-in. That, together
with VM hints, might well be able to do similar things for mmap. But at a
noticeably higher cost than what the current code has.

		Linus

