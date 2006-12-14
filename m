Return-Path: <linux-kernel-owner+w=401wt.eu-S1752027AbWLNH2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWLNH2K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWLNH2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:28:09 -0500
Received: from web59204.mail.re1.yahoo.com ([66.196.101.30]:27043 "HELO
	web59204.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752027AbWLNH2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:28:08 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 02:28:08 EST
Message-ID: <20061214072126.12023.qmail@web59204.mail.re1.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=PkU6L2LKqy/mlibYS6jJ3Ka29/4isWLgZWBRkrR46x2coOcz7VxmUU4u81FHkD8fI66OS0/SRHF0mFkQaox3399bQJEf5qeefmhGawIDbLhRsDpSfhGkB7B1+/L+VyFTQrg3kGkZPd2yza9+i4fwBNuSozZjlxzV21unB8/uH0s=;
Date: Wed, 13 Dec 2006 23:21:26 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: Re: realtime-preempt and arm
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1166034960.1785.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
> Also, have you tried this with a nanosleep instead of a select.
> Select's timeout is just that, a timeout. It's not suppose to be
> accurate, as long as it doesn't expire early.  The reason I state
> this, is that select uses a different mechanism than nanosleep, and
> that can indeed affect the jitter.

Ok, understood; I tried this:

	t = raw_timer();
	ts.tv_nsec = 5000000;
	ts.tv_sec = 0;
	nanosleep(&ts, 0);
	t = raw_timer() - t;

It is better but I still see 8ms occasional delays when listing
nfs-mounted directories onto FB. And, what is funny, also this version
makes the average delay 20ms as if it made the jiffy 20ms.

> Although without the high res enabled, you can't get better than
jiffy
> resolution, you shouldn't get a large jitter either.  BTW, using high
> res won't help the select anyway. The select uses a normal
> schedule_timeout, which means that it's not really expected to
> timeout, but something should wake it up before hand. Which means
that
> the good old timer wheel (non-hrtimer) is going to do the waking of
> the process. This means that you need to wait for the timer softirq
to
> be scheduled before your process wakes up. If there's a process with
a
> higher priority than the timer softirq running, then you need to
wait.
> 
> Using nansleep uses the hrtimer code (available with out the high
> resolutions).  The hrtimer uses its own timer softirq
> (softirq-hrtimer), and it is special.  It inherits the priority of
the
> task that created the timer when the timer goes off.  Also, something
> like nanosleep, won't even use the softirq, and will bypass the
> softirq all together, and wake your process up from the interrupt.
> 
> So basically, don't use select for timing.

Thanks a lot for a thorough explanation. While we are at it, is it then
the only option to use threads to wait for IO and use ms-accurate
timing? Formerly I have used select with timeouts for this task but
timing requirement have not been this accurate back then, of course.

--

tike



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com


 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com
