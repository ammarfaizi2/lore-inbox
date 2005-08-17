Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVHQWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVHQWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVHQWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:24:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22246 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751302AbVHQWY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:24:26 -0400
Date: Wed, 17 Aug 2005 15:24:15 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: George Anzinger <george@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050817222415.GA4398@us.ibm.com>
References: <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com> <42F24643.7080702@mvista.com> <20050816230512.GD2806@us.ibm.com> <4302872F.2050303@mvista.com> <20050817055622.GB4143@us.ibm.com> <43039535.2010600@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43039535.2010600@mvista.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2005 [12:51:17 -0700], George Anzinger wrote:
> Nishanth Aravamudan wrote:
> ~
> >>IMNSHO we should not get too parental with kernel only interfaces. 
> >>Adding 1 is easy enough for the caller and even easier to explain in the 
> >>instructions (i.e. this call sleeps for X jiffies edges).  This allows 
> >>the caller to do more if needed and, should he ever just want to sync to 
> >>the next jiffie he does not have to deal with backing out that +1.
> >
> >
> >I don't want to be too parental either, but I also am trying to avoid
> >code duplication. Lots of drivers basically do something like
> >poll_event() does (or could do with some changes), i.e. looping a
> >constant amount multiple times, checking something every so often. The
> >patch was just a thought, though. I will keep evaluating drivers and see
> >if it's a useful interface to have eventually.
> >
> >I guess I'm just concerned with making an unintuitive interface. As was
> >brought up at OLS, drivers are a major source of bugs/buggy code. The
> >simpler, more useful we can make interfaces, the better, I think. I'm
> >not claiming you disagree, I just want to make my own motives clear.
> >While fixing up the schedule_timeout() comment would make it clear what
> >schedule_timeout() achieves, I'm not sure how useful such an interface
> >is, if every caller adds 1 :) I need to mull it over, though... Lots to
> >consider. I also, of course, want to stay flexible for the reasons you
> >mention (letting the driver adjust the timeout as they expect to).
> 
> I would leave the +1 alone and put in the correct documentation.  This 
> way _more_ folks will be made aware of the mid jiffie issue.  Far to 
> often we see (and let get in) patches that mess up user interfaces 
> around this issue.  The recent changes to itimer come to mind...

Ok, makes sense to me; does the following patch work for everybody? The
wording is a bit awkward, but so is the issue :)

Description: Fix schedule_timeout()'s comment, indicated the inter-tick
rounding issue. Since the kernel does not keep track of an inter-tick
position in jiffies, a caller which wishes to sleep for at least a
certain number of jiffies should add its request to the *next* jiffies
value (meaning add 1 to its relative request). Make that clear in the
comment.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

diff -urpN 2.6.13-rc6/kernel/timer.c 2.6.13-rc6-dev/kernel/timer.c
--- 2.6.13-rc6/kernel/timer.c	2005-08-09 15:22:57.000000000 -0700
+++ 2.6.13-rc6-dev/kernel/timer.c	2005-08-17 15:21:35.000000000 -0700
@@ -1077,9 +1077,15 @@ static void process_timeout(unsigned lon
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
  *
- * Make the current task sleep until @timeout jiffies have
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
+ * Make the current task sleep until @timeout timer interrupts have
+ * occurred, meaning jiffies has incremented @timeout times and not
+ * necessarily that @timeout jiffies have elapsed. If the task wishes to
+ * sleep until (at least) @timeout jiffies have elapsed, then it should
+ * add 1 to its request. This is necessary, as the kernel does not keep
+ * track of an inter-jiffy position, so the caller must "round up" its
+ * request so that it begins at the next jiffy. The routine will return
+ * immediately unless the current task state has been set (see
+ * set_current_state()).
  *
  * You can set the task state as follows -
  *
