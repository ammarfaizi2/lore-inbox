Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVBDCMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVBDCMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbVBDCMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:12:17 -0500
Received: from main.gmane.org ([80.91.229.2]:4809 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263270AbVBDBvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:51:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tristan Wibberley <maihem@maihem.org>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Date: Fri, 04 Feb 2005 00:36:00 +0000
Message-ID: <pan.2005.02.04.00.22.41.102231@maihem.org>
References: <200502031420.j13EKwFx005545@localhost.localdomain> <4202876F.3010302@kolivas.org> <20050203204711.GB25018@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-156-197-142.range81-156.btcentralplus.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Gmane-MailScanner: Found to be clean
Cc: ck@vds.kolivas.org
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 21:47:11 +0100, Ingo Molnar wrote:

> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
>> >	* real inter-process handoff. i am thinking of something like
>> >	    sched_yield(), but it would take a TID as the target
>> >	    of the yield. this would avoid all the crap we have to 
>> >	    go through to drive the graph of clients with FIFO's and
>> >	    write(2) and poll(2). Futexes might be a usable
>> >	    approximation in 2.6 (we are supporting 2.4, so we can't
>> >	    use them all the time)
>> 
>> yield_to(tid) should not be too hard to implement. Ingo? What do you
>> think?
> 
> i dont really like it - it's really the wrong interface to use.

Would it be nice to create scheduling domains, so the processes in a
domain have priority relative to each other. The second highest priority
FIFO task could actually be a scheduling sub-domain (which appears to be a
child process of task A). In that scheduling sub-domain would be all the
real-time tasks that A manages the scheduling of. It gets to set their
relative priorities and sched class.

Task A could then make the first FIFO client be at the top of that domain,
with the second task to run being at the next priority, etc. Then Task A
blocks waiting for a watchdog timer so it can keep an eye on things. This
way yield_to would actually be almost a special case of a pre-configurable
sequence of operations which can have FIFO parts, RR parts, and OTHER
parts. Task A could also put one of its own threads in the sub-domain to
be able to change its state at a certain point in the sequence rather than
a certain time.

This could be extended to allow init to own a sub-domain for each user
that it could manage to allow users to each have real-time operations, and
daemons with high priorities relative to that user's other tasks, but
without interfering with other users (or giving root an automatic
advantage). It could make accounting easier, and allow users to get total
priority equal to the amount of money they pay.

I know this could be a lot of work, but is it sound in principle?

How would you do better than RR between users with domains at the same
priority though... That I'm not sure of. IE, it might be good to switch
back to any domain that has a recently woken task more frequently but for
less time then extend the time and decrease the frequency as the time
since waking increases. That way users tasks could respond quickly to
events without ever being able to cause or suffer from starvation.

Unfortunately, O(1) behaviour would be a must, and that scheme could be
particularly hard to implement in O(1) :)

Is it useful, too much work, over-engineered, logically impossible?

-- 
Tristan Wibberley

