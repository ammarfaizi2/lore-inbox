Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWBANG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWBANG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWBANG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:06:27 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:8889 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964924AbWBANG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:06:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vjkdTuhBSb1Z0aUHKeUCbUSjT5qFJwgNk02Pz7aDauNr3ZwFYxhOfWSgiZeKFia207Pk/jdXEdi+IbXB41b3V5XNf52Zqrj8a6xzNmxCZwUsNL8JVLYkQTYHZrn3YjFh9/6ZAfS5i0fntj3ZTcd6ZLdmAZQPxvfFvudq+pWDwJ0=  ;
Message-ID: <43E0B24E.8080508@yahoo.com.au>
Date: Thu, 02 Feb 2006 00:06:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain>	 <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain>
In-Reply-To: <1138797874.7088.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 2006-02-01 at 14:36 +1100, Peter Williams wrote:

>>However, a newly woken task that preempts the current task isn't the 
>>only way that needs_resched() can become true just before load balancing 
>>is started.  E.g. scheduler_tick() calls set_tsk_need_resched(p) when a 
>>task finishes a time slice and this patch would cause rebalance_tick() 
>>to be aborted after a lot of work has been done in this case.
> 
> 
> No real work is lost.  This is a loop that individually pulls tasks.  So
> the bail only stops the work of looking for more tasks to pull and we
> don't lose the tasks that have already been pulled.
> 
> 

Once we've gone to the trouble of deciding which tasks to move and how
many (and the estimate should be very conservative), and locked the source
and destination runqueues, it is a very good idea to follow up with our
threat of actually moving the tasks rather than bail out early.

It is quite likely (though perhaps less so in this braindead benchmark)
that a subsequent load balance operation will need to move the remaining
tasks anyway, so decreasing the efficiency of this routine is going to cause
more damage to your RT task even if you "fix" it to not actually show up as
a single latency blip.

>>In summary, I think that the bail out is badly placed and needs some way 
>>of knowing if the reason need_resched() has become true is because of 
>>preemption of a newly woken task and not some other reason.
> 
> 
> I need that bail in the loop, so it can stop if needed. Like I said, it
> can be a task that is pulled to cause the bail. Also, having the run
> queue locks and interrupts off for over a msec is really a bad idea.
> 

I don't think we need to change it in the mainline kernel just yet. At least
not something that will bail after moving just a single task every time in
the worst case.

> 
>>Peter
>>PS I've added Nick Piggin to the CC list as he is interested in load 
>>balancing issues.
> 
> 
> Thanks, and thanks for the comments too.  I'm up for all suggestions and
> ideas.  I just feel it is important that we don't have unbounded
> latencies of spin locks and interrupts off.
> 

That's a long way off (if ever) if you want to run crazy code that simply
increases some resource loading until something breaks. Take an rwsem for
writing and then queue up thousands of readers on the lock. Release the
writer. (this will be very similar to run queue balancing, in effect).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
