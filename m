Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTIXPzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 11:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbTIXPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 11:55:48 -0400
Received: from CPE0010e000064f-CM014270111571.cpe.net.cable.rogers.com ([65.49.101.54]:33035
	"EHLO belle.augustahouse.net") by vger.kernel.org with ESMTP
	id S261368AbTIXPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 11:55:46 -0400
Message-ID: <3F71BE3D.6030501@sun.com>
Date: Wed, 24 Sep 2003 11:54:37 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
References: <1064408962.5074.2.camel@laptop.fenrus.com> <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
In-Reply-To: <Pine.LNX.4.44.0309242136080.6713-100000@raven.themaw.net>
Content-Type: multipart/mixed;
 boundary="------------050604060400060505010602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604060400060505010602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> On Wed, 24 Sep 2003, Arjan van de Ven wrote:
> 
> 
>>On Wed, 2003-09-24 at 15:01, Ian Kent wrote:
>>
>>>This is a corrected patch for the autofs4 daedlock problem I posted about 
>>>@@ -206,6 +207,11 @@
>>> 
>>> 		interruptible_sleep_on(&wq->queue);
>>> 
>>>+		if (waitqueue_active(&wq->queue) && current != wq->owner) {
>>>+			set_current_state(TASK_INTERRUPTIBLE);
>>>+			schedule_timeout(wq->wait_ctr * (HZ/10));
>>>+		}
>>>+
>>
>>this really really looks like you're trying to pamper over a bug by
>>changing the timing somewhere instead of fixing it...
> 
> 
> Agreed.
> 
> 
>>also are you sure the deadlock isn't because of the racey use of
>>interruptible_sleep_on ?
>>

I think the deadlock itself needs to be properly identified.

Could you explain where the deadlock is actually occuring?  I briefed 
over the automount 4 code as well as autofs4 and I don't see the 
deadlock.  The 'owner' in the case of an expiry will be a child process 
of the daemon, within a call to ioctl(EXPIRE_MULTI), correct?  Having it 
be released from the waitqueue first should not affect flow of execution 
and released from deadlock.

I don't see how having it wake up before before any other racing 
processes solves anything.

I think Arjan is right in that the race is do to the nautilus process 
entering the sleep_on after the a call to wake_up(&wq->queue).  I don't 
know if a change to using a workqueue is best..   how about refactoring 
that chunk of code to use wait_event_interruptible on the queue, which 
should be clear of any waitqueue/sleep_on races.

> 
> 
> OK so maybe I should have suggestions instead of comments.
> 
> Please elaborate.
> 

How about you try out this quick patch I threw together.

Mike Waychison

--------------050604060400060505010602
Content-Type: text/plain;
 name="autofs4_wait_event.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs4_wait_event.patch"

===== waitq.c 1.6 vs edited =====
--- 1.6/fs/autofs4/waitq.c	Fri Feb  7 12:25:20 2003
+++ edited/waitq.c	Wed Sep 24 15:48:30 2003
@@ -204,7 +204,7 @@
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 
-		interruptible_sleep_on(&wq->queue);
+		wait_event_interruptible(wq->queue, wq->name == NULL);
 
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;

--------------050604060400060505010602--

