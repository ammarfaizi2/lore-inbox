Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUCHM3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbUCHM3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:29:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:52177 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262482AbUCHM3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:29:20 -0500
Date: Mon, 8 Mar 2004 18:00:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: mingo@redhat.com
Cc: rusty@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: more efficient current_is_keventd macro? [was Re: [lhcs-devel] Re: Kthread_create() never returns when called from worker_thread]
Message-ID: <20040308123030.GA7428@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
	current_is_keventd() macro checks "current" with the per-cpu
thread of _all_ possible cpus attached to keventd_wq. Can't it just check 
against the per-cpu thread of _current_ cpu alone (since the per-cpu workqueue
threads are anyway bound only to their cpus)?  

int current_is_keventd(void)
{
        struct cpu_workqueue_struct *cwq;
-       int cpu;
+       int cpu = smp_processor_id();

        BUG_ON(!keventd_wq);

-       for_each_cpu(cpu) {
-               cwq = keventd_wq->cpu_wq + cpu;
-               if (current == cwq->thread)
-                       return 1;
-       }

-       return 0;

+	cwq = keventd_wq->cpu_wq + cpu;
+	if (current == cwq->thread)
+		return 1;
+	else
+		return 0;
}


----- Forwarded message from Rusty Russell <rusty@rustcorp.com.au> -----

Subject: Re: [lhcs-devel] Re: Kthread_create() never returns when called
	from worker_thread
From: Rusty Russell <rusty@rustcorp.com.au>
To: vatsa@in.ibm.com
Cc: rusty@au1.ibm.com,
	"Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
	lhcs-devel@lists.sourceforge.net, "Raj, Ashok" <ashok.raj@intel.com>,
	"Shah, Rajesh" <rajesh.shah@intel.com>
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 11:29:27 +1100

On Wed, 2004-03-03 at 20:08, Srivatsa Vaddagiri wrote: 
> On Tue, Mar 02, 2004 at 12:10:08PM +1100, Rusty Russell wrote:
> >  	/* If we're being called to start the first workqueue, we
> >  	 * can't use keventd. */
> > -	if (!keventd_up())
> > +	if (!keventd_up() || current_is_keventd())
> >  		work.func(work.data);
> >  	else {
> >  		schedule_work(&work);
> 
> I noticed that current_is_keventd() check actually goes and compares
> "current" with all the per-cpu threads attached to keventd() workqueue ..
> Is that really necessary? Can't it compare with the per-cpu thread
> attached to _current_ cpu only? 

You'd think so, but it's not my code.  I believe you are correct though.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
lhcs-devel mailing list
lhcs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lhcs-devel

----- End forwarded message -----

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
