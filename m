Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUDFIga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 04:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUDFIga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 04:36:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15854 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263661AbUDFIg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 04:36:28 -0400
Date: Tue, 6 Apr 2004 14:07:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406083713.GB7362@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071F9C5.2030002@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:28:53AM +1000, Nick Piggin wrote:
> I think my stuff is a bit orthogonal to what you're attempting.
> And they should probably work well together. My "lazy migrate"
> patch means the tasklist lock does not need to be held at all,
> only the dying runqueue's lock.

Hi Nick,
	I went thr' your patch and have some comments:

1. The benefit I see in your patch (over the solution present today)
   is you migrate immediately only tasks in the runqueue and don't bother abt 
   sleeping tasks. You catch up with them as and when they wake up. 

   However by doing so, are we not adding an overhead in the wake-up
   path? CPU offline should be a (very) rare event and to support that we 
   have to check a cpu's offline status _every_ wakeup call. 

   IMHO it is best if we migrate _all_ tasks in one shot during the
   rare offline event and thus avoid the necessity of cpu_is_offline check 
   during the (more) hotter wake_up path.

2. Also note that, migrate_all_tasks is being currently run with
   rest of the machine frozen. So holding/not-holding tasklist
   lock during that period does not make a difference!

My patch avoids having to migrate _immediately_ even the tasks present
in the runqueue. So the amout of time machine is frozen is greatly
reduced.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
