Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269454AbUJSPQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269454AbUJSPQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUJSPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:16:34 -0400
Received: from mail.tmr.com ([216.238.38.203]:62212 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269454AbUJSPQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:16:24 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: per-process shared information
Date: Tue, 19 Oct 2004 11:18:39 -0400
Organization: TMR Associates, Inc
Message-ID: <cl3al8$poi$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain><Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <20041015160424.GA17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098198505 26386 192.168.12.100 (19 Oct 2004 15:08:25 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20041015160424.GA17849@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Oct 15, 2004 at 12:56:22PM +0100, Hugh Dickins wrote:
> 
>>Well, it didn't quite mean that in 2.4: since any pagecache (including
>>swapcache) page mapped into a single task would have page_count 2 and
>>so be counted as shared.
> 
> 
> Well, doing page_mapcount + !PageAnon should do the trick. My point is
> that the confusion of an anon page going in swapcache (the one you
> mentioned) is easily fixable.
> 
> 
>>I think 2.4 was already trying to come up with a plausible simulacrum
>>of numbers that made sense to gather in 2.2, but the numbers had lost
>>their point, and it only had page_count to play with.  Or maybe 2.2
>>was already trying to make up numbers to fit with 2.0...
> 
> 
> ;)
> 
> 
>>[..] and I don't want to
>>give the cpu unnecessary work, [..]
> 
> 
> this doesn't make much sense to me, then you should as well forbid
> the user to run main () { for(;;) }.
> 
> Of course doing a sort of for(;;) in each pid of ps xav is overkill, but
> on demand easily killable and reschedule friendly would be no different
> than allowing an user to execute main () { for(;;) }. All you can do is
> to renice it or use CKRM to lower its cpu availability from the
> scheduler, or kill -9.
> 
> 
>>remove even the vma walk; but I accept you're being careful to propose
>>that we keep the overhead out of existing /proc/pid uses - right if
>>we have to go that way, but I just prefer to avoid the work myself.
> 
> 
> correct. I'd also prefer to avoid this work myself.
> 
> 
>>I hope that's what my patch would be sufficient to achieve.
> 
> 
> I hope too.
> 
> 
>>It would be unfair to say 2.4's numbers were actually a bug, but
>>certainly peculiar: I'm about as interested in exactly reproducing
>>their oddities as in building a replica of some antique furniture.
> 
> 
> sure the swapcache bit would need fixing ;)
> 
> 
>>Oh, if that's all we need, I can do a simpler patch ;)
> 
> 
> yep ;) though such simpler patch would return no-sensical results, it
> would provide no-information at all in some case.
> 
> 
>>Interesting idea, and now (well, 2.6.9-mm heading to 2.6.10) we have
>>atomic_inc_return and atomic_dec_return supported on all architectures,
>>it should be possible to adjust an mm->shared_rss each time mapcount
>>goes up from 1 or down to 1, as well as adjusting nr_mapped count
>>as we do when it goes up from 0 or down to 0.
> 
> 
> I believe your approach will work fine, and it's much closer to the 2.4
> physical-driven semantics. It looks like "shared" really means
> not-anonymous memory, but accounted on a physical basis.
> 
> However I wouldn't mind if you want to add a new field and to provide
> both the "virtual" shared like 2.6 right now, along the "physical"
> shared miming the semantics of 2.4 (they could be both in statm since
> they're O(1) to collect).

If it's cheap I'd like to see that. I don't know until I see the numbers 
if it will be useful information for system tuning, but many servers 
(web, news, mail) offer fork vs. thread operation and sometimes 
non-intuitive performance results, so I'd like to have more data.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
