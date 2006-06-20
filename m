Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbWFTK7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWFTK7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWFTK7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:59:19 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:11600 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932591AbWFTK7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:59:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YgDvy5XK+4OhhlnE6jnnpASvEinoV757wUVJYIQP5r7sT4XMHfbNMx1L4aCoSKMfmDUBB3usXvNrHBvt7GDx5F5NbMcmqTGbmnx0U2gDM+C6RF5mhoeSyETR9QhW+eGwfRvaIgQ29Cr+9VNV4rRr9EjEC1BoLz0JCYvWj4a45Hs=  ;
Message-ID: <4497D4FF.6000706@yahoo.com.au>
Date: Tue, 20 Jun 2006 20:59:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       ccb@acm.org, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock
 and NMI)
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no> <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com> <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au> <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au> <20060620095135.GC11037@elte.hu>
In-Reply-To: <20060620095135.GC11037@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Corrected Arjan's address I messed up earlier.]

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>curious, do you have any (relatively-) simple to run testcase that 
>>>clearly shows the "scalability issues" you mention above, when going 
>>
>>>from rwlocks to spinlocks? I'd like to give it a try on an 8-way box.
>>
>>Arjan van de Ven wrote:
>>
>>>I'm curious what scalability advantage you see for rw spinlocks vs real
>>>spinlocks ... since for any kind of moderate hold time the opposite is
>>>expected ;)
>>
>>It actually surprised me too, but Peter Chubb (who IIRC provided the 
>>motivation to merge the patch) showed some fairly significant 
>>improvement at 12-way.
>>
>>https://www.gelato.unsw.edu.au/archives/scalability/2005-March/000069.html
> 
> 
> i think that workload wasnt analyzed well enough (by us, not by Peter, 
> who sent a reasonable analysis and suggested a reasonable change), and 
> we went with whatever magic change appeared to make a difference, 
> without fully understanding the underlying reasons. Quote:
> 
>   "I'm not sure what's happening in the 4-processor case."
> 
> Now history appears to be repeating itself, just in the other direction 
> ;) And we didnt get one inch closer to understanding the situation for 
> real. I'd vote for putting a change-moratorium on tree-lock and only 
> allow a patch that tweaks it that fully analyzes the workload :-)
> 
> one thing off the top of my mind: doesnt lockstat introduce significant 
> overhead? Is this reproducable with lockstat turned off too? Is the same 
> scalability problem visible if all read_lock()s are changed to 
> write_lock()? [like i did in my patch] I.e. can other explanations (like 
> unlucky alignment of certain rwlock data structures / functions) be 
> excluded.

Yes, it would need re-testing.

> 
> another thing: average hold times in the spinlock case on that workload 
> are below 1 microsecond - probably on the range of cachemiss bounce 
> costs on such a system. 

It's the wait time that I'd be more worried about. As I said, my wild
guess is that the wait times are creeping up.

> I.e. it's the worst possible case for a 
> spinlock->rwlock conversion! The only reason i can believe this to make 
> a difference are cycle level races and small random micro-differences 
> that cause heavier bouncing in the spinlock workload but happen to avoid 
> it in the read-lock case. Not due to any fundamental advantage of 
> rwlocks.

I'd say the 12 way results show that there is a fundamental advantage
(although that's pending whether or not lockstat is wrecking the results).
I'd even go out on a limb ;) and say that it will only become more
pronounced at higher cpu counts.

Correct me if I'm wrong, but... a read-lock requires at most a single
cacheline transfer per lock acq and a single per release, no matter the
concurrency on the lock (so long as it is read only).

A spinlock is going to take more. If the hardware perfectly round-robins
the cacheline, it will take lockers+1 transfers per lock+unlock. Of
course, hardware might be pretty unfair for efficiency, but there will
still be some probability of the cacheline bouncing to other lockers
while it is locked. And that probability will increase proportionally to
the number of lockers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
