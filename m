Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVHYSyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVHYSyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVHYSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:54:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38134 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932419AbVHYSyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:54:32 -0400
Message-ID: <430E13D8.8070005@mvista.com>
Date: Thu, 25 Aug 2005 11:54:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: John McCutchan <ttb@tentacle.dhs.org>, jim.houston@ccur.com,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       johannes@sipsolutions.net, linux-kernel@vger.kernel.org
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex> <1124983117.6810.198.camel@betsy>
In-Reply-To: <1124983117.6810.198.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Thu, 2005-08-25 at 09:33 -0400, John McCutchan wrote:
> 
>>On Thu, 2005-08-25 at 22:07 +1200, Reuben Farrelly wrote:
>>
~
>>>dovecot: Aug 25 19:31:26 Warning: IMAP(gilly): removing wd 1022 from inotify fd 4
>>>dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1023
>>>dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): inotify_add_watch returned 1024
>>>dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1024 from inotify fd 4
>>>dovecot: Aug 25 19:31:27 Error: IMAP(gilly): inotify_rm_watch() failed: 
>>>Invalid argument
>>>dovecot: Aug 25 19:31:27 Warning: IMAP(gilly): removing wd 1023 from inotify fd 4
>>>dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024
>>>dovecot: Aug 25 19:31:28 Warning: IMAP(gilly): inotify_add_watch returned 1024
>>>
>>>Note the incrementing wd value even though we are removing them as we go..
>>>
>>
>>What kernel are you running? The wd's should ALWAYS be incrementing, you
>>should never get the same wd as you did before. From your log, you are
>>getting the same wd (after you inotify_rm_watch it). I can reproduce
>>this bug on 2.6.13-rc7.
>>
>>idr_get_new_above 
>>
>>isn't returning something above.
>>
>>Also, the idr layer seems to be breaking when we pass in 1024. I can
>>reproduce that on my 2.6.13-rc7 system as well.
>>
>>
>>>This is using latest CVS of dovecot code and with 2.6.12-rc6-mm(1|2) kernel.
>>>
>>>Robert, John, what do you think?   Is this possibly related to the oops seen 
>>>in the log that I reported earlier?  (Which is still showing up 2-3 times per 
>>>day, btw)
>>
>>There is definitely something broken here.
> 
> 
> Jim, George-
> 
> We are seeing a problem in the idr layer.  If we do idr_find(1024) when,
> say, a low valued idr, like, zero, is unallocated, NULL is returned.

I think the best thing is to take idr into user space and emulate the 
problem usage.  To this end, from the log it appears that you _might_ be 
moving between 0, 1 and 2 entries increasing the number each time.  It 
also appears that the failure happens here:
add 1023
add 1024
find 1024  or is it the remove that fails?  It also looks like 1024 got 
allocated twice.  Am I reading the log correctly?

So, is it correct to assume that the tree is empty save these two at 
this time?  I am just trying to figure out what the test program needs 
to do.



-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
