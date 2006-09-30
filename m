Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWI3SSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWI3SSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWI3SSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:18:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65179 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751358AbWI3SSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:18:22 -0400
Date: Sat, 30 Sep 2006 23:48:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060930181804.GA28768@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159639564.4067.43.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 02:06:04PM -0400, Lee Revell wrote:
> On Wed, 2006-09-20 at 16:19 +0200, Ingo Molnar wrote:
> > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > from the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> I got this Oops with -rt3, looks RCU related.  Apologies in advance if
> it's already known.
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
>  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
> PGD 46a3067 PUD 4e27067 PMD 0 
> Oops: 0002 [1] PREEMPT SMP 
> CPU 1 

I see a very similar crash while running rcutorture on 2.6.18-mm1 and
my rcu patchset that has rcupreempt stuff rom -rt. I don't see this
while running on 2.6.18-rc3, but then rc3 had an older version
of rcutorture. I am working on narrowing it down.

The following script reproduces the problem quickly (within
a couple of minutes) in my 4-cpu x86_64 system -

#! /bin/sh
for ((i=0 ; i<200 ; i++))
do
        echo "Starting pass $i"
        modprobe rcutorture stat_interval=10 # test_no_idle_hz=1 shuffle_interval=5
        sleep 30
        rmmod rcutorture
        dmesg | sed -n -e '/^rcutorture: --- End of test:/p' | tail -1
done
exit 0

Thanks
Dipankar
