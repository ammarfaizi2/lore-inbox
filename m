Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTF0J13 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 05:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTF0J13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 05:27:29 -0400
Received: from pop.gmx.net ([213.165.64.20]:13459 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264087AbTF0J12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 05:27:28 -0400
Message-Id: <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 27 Jun 2003 11:46:02 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler & interactivity improvements
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3EFBFDD1.4000603@aitel.hist.no>
References: <3EFAC408.4020106@aitel.hist.no>
 <5.2.0.9.2.20030627071904.00c890e0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:18 AM 6/27/2003 +0200, Helge Hafting wrote:
>Mike Galbraith wrote:
>
>>The thought of building/passing "connection" information around in the 
>>scheduler gives me a bad case of the willies.  I can imagine a process 
>>struct containing a list of components and their cpu usage information as 
>>a means to defeat fairness/starvation issues, but I can't imagine how to 
>>do that and retain high speed low drag O(1) scheduling.
>The idea isn't that complicated.  When a process wakes up, make
>a simple check to see what it woke up from.  Ordinary
>io is handled as today, with a io boost.

(simple?  decode stack, find out where he was sleeping, and then have to 
decide what to do based upon that after _every sleep_?  sprinkle scheduling 
decisions around every place that does wakeups?... i can just imagine Al's 
reaction to someone suggesting that for the VFS... someone better run fast 
and hide well:)

>A pipe wakeup can be handled by taking a look at the other end.
>If the other process has interactivity bonus, grab half of
>it.  (And halve the bonus belonging to that process.)
>No bonus is created in this case, so no risk of DOS.
>It is merely redistributed.
>
>And it is simple - there is one thing that woke the
>process up - so only one thing to check.

How?

>Hard corner cases can be avoided.  Perhaps bunch of pipes,
>files, devices, sockets and page-ins becomes ready
>simultaneosly.  A detailed priority calculation is clearly
>pointless, so just use one of the things - or none.
>
>>Until someone demonstrates that the DoS/abuse scenarios I might be 
>>imagining are real, in C, I think I'll do the smart thing: try to stop 
>>worrying about it and stick to very very simple stuff.
>
>I thought the Irman thing was what killed the previous attempt
>at redistributing priorities?

What I think kills the priority redistribution idea is _massive_ 
complexity.  I don't see anything simple.  You would have to build the 
logical connections between tasks, which currently doesn't exist.  Wakeups 
and task switches are extremely light weight operations, and no decision 
you make at wakeup time has a ghost of a chance of not hurting like 
hell.  Just using the monotonic_clock() in the wakeup/schedule paths is 
fairly painful.  There is just no way you can run around looking for and 
processing "who shot JR" information in those paths (no way _I_ can imagine 
anyway) without absolutely destroying performance.

         -Mike 

