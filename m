Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUDFJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUDFJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:26:13 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:9149 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263670AbUDFJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:26:10 -0400
Message-ID: <407277AE.2050403@yahoo.com.au>
Date: Tue, 06 Apr 2004 19:26:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com>
In-Reply-To: <20040406083713.GB7362@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Tue, Apr 06, 2004 at 10:28:53AM +1000, Nick Piggin wrote:
> 
>>I think my stuff is a bit orthogonal to what you're attempting.
>>And they should probably work well together. My "lazy migrate"
>>patch means the tasklist lock does not need to be held at all,
>>only the dying runqueue's lock.
> 
> 
> Hi Nick,
> 	I went thr' your patch and have some comments:
> 

Hi, thanks for the comments.

> 1. The benefit I see in your patch (over the solution present today)
>    is you migrate immediately only tasks in the runqueue and don't bother abt 
>    sleeping tasks. You catch up with them as and when they wake up. 
> 

That is correct, yes.

>    However by doing so, are we not adding an overhead in the wake-up
>    path? CPU offline should be a (very) rare event and to support that we 
>    have to check a cpu's offline status _every_ wakeup call. 
> 

Note there was already that check in the wakeup path, although
I suspect it was someone being overly cautious and isn't required.

Also in my patch, the offline check should probably be done below
the check for if (cpu == this_cpu... because that should be a common
route.

>    IMHO it is best if we migrate _all_ tasks in one shot during the
>    rare offline event and thus avoid the necessity of cpu_is_offline check 
>    during the (more) hotter wake_up path.
> 

OK, whatever you like. At least you have my alternative if
you ever run into a problem here.

> 2. Also note that, migrate_all_tasks is being currently run with
>    rest of the machine frozen. So holding/not-holding tasklist
>    lock during that period does not make a difference!
> 

Yeah, so Rusty pointed out. It still potentially moves a lot fewer
tasks though, but I guess it was really waiting for a patch like
yours ;)

> My patch avoids having to migrate _immediately_ even the tasks present
> in the runqueue. So the amout of time machine is frozen is greatly
> reduced.
> 

I really don't have much interest in the code so it is up to you.
If you ever have some realtime system that does cpu hotplugging
then give me a call!

Nick
