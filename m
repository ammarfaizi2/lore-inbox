Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUJLBGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUJLBGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUJLBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:05:16 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46560 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266892AbUJLBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:03:34 -0400
Subject: Re: Difference in priority
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org, ankitjain1580@yahoo.com, mingo@elte.hu, rml@tech9.net
Content-Type: text/plain
Organization: 
Message-Id: <1097542651.2666.7860.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Oct 2004 20:57:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas writes:
> Ankit Jain wrote:

>> if somebody knows the difference b/w /PRI of both
>> these commands because both give different results
>>
>> ps -Al
>> & top
>>
>> as per priority rule we can set priority upto 0-99
>> but top never shows this high priority
>
> Priority values 0-99 are real time ones and 100-139 are normal 
> scheduling ones. RT scheduling does not change dynamic priority while 
> running wheras normal scheduling does (between 100-139). top shows the 
> value of the current dynamic priority in the PRI column as the current 
> dynamic priority-100. If you have a real time task in top it shows as a 
> -ve value. ps -Al seems to show the current dynamic priority+60.

What would you like to see? There are numerous
competing ideas of reality. There's also the matter
of history and standards. I'd gladly "fix" ps, if
people could agree on what "fix" would mean.

Various desirable but conflicting traits include:

a. for normal idle processes, PRI matches NI
b. for RT processes, PRI matches RT priority
c. for RT processes, PRI is negative of RT priority
d. PRI is the unmodified value seen in /proc
e. PRI is never negative
f. low PRI is low priority (SysV "pri" keyword)
g. low PRI is high priority (UNIX "PRI", SysV "opri")
h. PRI matches some kernel-internal value
i. PRI is in the range -99 to 999 (not too wide)

I had originally tried to match up with Solaris and
a few other systems, but that's looking hopeless.
I intend to change to something sane, perhaps even
making the PRI of "-o pri" be the same as that of "-l".
Currently I don't even try to document PRI.

It is good to keep the value narrow. I really wish
we didn't have so many RT levels; POSIX only requires
that there be 32. A simple 0..99 value would be great.

Here is what I have in my current code, with the
headers edited so they won't be confusing. Note
that the left two versions ("aaa" and "bbb") are
similar to the traditional SysV "pri", but the new
POSIX and UNIX standard makes them unsuitable for use
as the "PRI" displayed by "ps -l". It is common to
generate the "PRI" of "ps -l" via an "opri" keyword.

$ LD_LIBRARY_PATH=../../proc ../../ps/ps -t pts/8 --sort=-priority -o stat,pri,pri_api,rtprio,pri_bar,priority,pri_baz,opri,pri_foo,ni,cls,sched,comm
STAT aaa bbb RTPRIO ccc ddd eee fff ggg  NI CLS SCH COMMAND
SN     0 -40      -  40  39 139  99  19  19  TS   0 setpriority19
Ss+   23 -17      -  17  16 116  76  -4   0  TS   0 bash
S<    39  -1      -   1   0 100  60 -20 -20  TS   0 setpriority-20
S     41   1      1  -1  -2  98  58 -22   -  RR   2 min_rr
S    139  99     99 -99 -100  0 -40 -120  -  FF   1 max_fifo


