Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTEVLKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEVLKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:10:25 -0400
Received: from n13.sp.op.dlr.de ([129.247.25.4]:3474 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id S261678AbTEVLKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:10:24 -0400
Message-ID: <3ECCB319.4060706@dlr.de>
Date: Thu, 22 May 2003 13:23:05 +0200
From: Martin Wirth <martin.wirth@dlr.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: de-de, de
MIME-Version: 1.0
To: mingo <mingo@elte.hu>, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

 >all that is needed now is some actual review of the new APIs from the
 >conceptual angle (i've done that and i think they are okay, but more 
 >eyes see more), so that we make sure these are good and we wont need to
 >discard any aspect of them anytime soon.

What about adding an u32 flags field to each one of the new futex 
sys_calls. This gives you more freedom for future extensions without
changing the API again. Possible uses may be:

- Specify the futexes to be mm-local: By using the pair mm* and vaddr as
   key it is possible to have process local futexes living on the same
   hash with the following advantages:
   1. no page_table lock contention (I implemented mm-local futexes
      for my application after I noticed long latencies on SMP where a
      high prio tasks spun in futex_wake while another task was doing 		
      mmap/munmap on a second processor).
   2. no vcache pollution (I guess 99% of all futexes will not be in 		 
     shared memory)
   3. Slightly faster, since no page pinning is needed

- Specify queueing or unqueueing in priority order


Martin


P.S.

By the way, your latest futex patch still contains the bogus
if (!list_empty(&q.list)) conditional, that's always true since
you hold the locks at this point and no one can have removed us
from the list:

 > 	add_wait_queue(&q.waiters, &wait);
 > 	set_current_state(TASK_INTERRUPTIBLE);
 >-	if (!list_empty(&q.list))
 >+	if (!list_empty(&q.list)) {
 >+		unlock_futex_mm();
 > 		time = schedule_timeout(time);
 >+	}

Of course the test would be (and was) pretty necessary if you drop the
locks before the get_user(...) call. And I must admit that I still
can't see why you need to hold the locks across get_user. Even if it's
save to do so at least every automatic code checker will bark at this point.



	

