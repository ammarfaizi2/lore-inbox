Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULHKpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULHKpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbULHKpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:45:38 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:49170 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261181AbULHKpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:45:13 -0500
Message-ID: <41B6DCE8.5030304@hist.no>
Date: Wed, 08 Dec 2004 11:52:24 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208065534.GF3035@suse.de>
In-Reply-To: <20041208065534.GF3035@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Tue, Dec 07 2004, Andrew Morton wrote:
>  
>
>>Andrea Arcangeli <andrea@suse.de> wrote:
>>    
>>
>>>The desktop is ok with "as" simply because it's
>>> normally optimal to stop writes completely
>>>      
>>>
>>AS doesn't "stop writes completely".  With the current settings it
>>apportions about 1/3 of the disk's bandwidth to writes.
>>
>>This thing Jens has found is for direct-io writes only.  It's a bug.
>>    
>>
>
>Indeed. It's a special case one, but nasty for that case.
>
>  
>
>>The other problem with AS is that it basically doesn't work at all with a
>>TCQ depth greater than four or so, and lots of people blindly look at
>>untuned SCSI benchmark results without realising that.  If a distro is
>>    
>>
>
>That's pretty easy to fix. I added something like that to cfq, and it's
>not a lot of lines of code (grep for rq_in_driver and cfq_max_depth).
>
>  
>
>>always selecting CFQ then they've probably gone and deoptimised all their
>>IDE users.  
>>    
>>
>
>Andrew, AS has other issues, it's not a case of AS always being faster
>at everything.
>
>  
>
>>AS needs another iteration of development to fix these things.  Right now
>>it's probably the case that we need CFQ or deadline for servers and AS for
>>desktops.   That's awkward.
>>    
>>
>
>Currently I think the time sliced cfq is the best all around. There's
>still a few kinks to be shaken out, but generally I think the concept is
>sounder than AS.
>  
>
I wonder, would it make sense to add some limited anticipation
to the cfq scheduler?  It seems to me that there is room to
get some of the AS benefit without getting too unfair:

AS does a wait that is short compared to a seek, getting some
more locality almost for free.  Consider if CFQ did this, with
the added limitation that it only let a few extra read requests
in this way before doing the next seek anyway.  For example,
allowing up to 3 extra anticipated read requests before
seeking could quadruple read bandwith in some cases.  This is
clearly not as fair, but the extra reads will be almost free
because those few reads take little time compared to the seek
that follows anyway.  Therefore, the latency for other requests
shouldn't change much and we get the best of both AS and CFQ.
Or have I made a broken assumption?

The max number of requests to anticipate could even be
configurable, jut set it to 0 to get pure CFQ.

Helge Hafting












