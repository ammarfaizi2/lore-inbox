Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUKOLCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUKOLCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUKOLCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:02:12 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:54666 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261495AbUKOLCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:02:01 -0500
Message-ID: <41988CA2.8050407@yahoo.com.au>
Date: Mon, 15 Nov 2004 22:01:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalize prio_tree (1/3)
References: <20041114235646.K28802@almesberger.net> <419830FD.7000007@yahoo.com.au> <20041115030750.L28802@almesberger.net>
In-Reply-To: <20041115030750.L28802@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Nick Piggin wrote:
> 
>>I'm curious, how do you plan to use them for healthier barrier handling?
> 
> 
> Ah, you missed the great discussion on fsdevel and the BOF
> at OLS :-)
> 
> http://marc.theaimsgroup.com/?t=108787649700005&r=1&w=2&n=34
> http://marc.theaimsgroup.com/?t=108809650200006&r=1&w=2&n=11
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109107082406140&w=2
> 

Ah OK. Interesting reading.

> This comes from prioritization of requests at the elevator.
> In order to honor priorities as much as possible, we need to
> keep barriers from affecting all requests in the queue.
> 
> The idea is to ignore barriers unless requests separated by a
> barrier overlap, and at least one of them is a write. prio_tree
> is used to find those overlaps.
> 

Hmm OK. I won't quiz you on the impelementation as I'm sure you've
thought it through, and I haven't :)

... but humor me, you _are_ ensuring the following doesn't get
reordered, say:

(write, sect 100), (barrier), (write, sect 200)

Right? It isn't clear from your description what you are intending
(and I'm too lazy to read the code at the moment!).

> That way, priorities are only affected by barriers if using
> some form of direct IO, with overlaps and writes. While this
> isn't perfect (i.e. someone else scribbling over our files can
> still spoil all the fun), it allows a much larger class of
> applications to enjoy the full benefits of priorities.
> 
> Besides that, it also helps the elevator to do a better job for
> requests even without priorities, because it doesn't have to go
> FIFO whenever it sees a barrier.
> 

Well it goes FIFO to the extent that the barrier definition requires:
all requests before the barrier are issued before any requests
after the barrier.

> See also section 3.6 of
> http://abiss.sourceforge.net/doc/abiss-lk.ps.gz
> 
> The CPU overhead is actually quite marginal: in tests, the ABISS
> elevator would actually outperform AS in terms of CPU time
> spent (measured by sending a lot of random requests with AIO
> into a large queue). While such tests compare apples and oranges,
> they at least indicate that minimalizing the effect of barriers
> doesn't have a horrible performance impact.
> 

Well it sounds interesting. Good luck with it...

No comment on your prio tree generalization, sorry. Other than: it
seems to be unfortunately quite ugly. Obviously better than duplicating
the code, but... it may just be worth holding onto it until it has
another user about to be merged as well (eg. add the patch to the front
of your ABISS elevator if you submit it to 2.6 or -mm).

But I don't have strong feelings on the matter. If Rajesh says its OK
to go ahead as is, that would be fine by me :)

Good luck!
Nick
