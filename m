Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVHRPRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHRPRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVHRPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:17:10 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:5253 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932244AbVHRPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:17:09 -0400
Subject: RE: Debugging kernel semaphore contention and priority  inversion
From: Steven Rostedt <rostedt@goodmis.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.global.avaya.com>
References: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.global.avaya.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 11:15:40 -0400
Message-Id: <1124378140.5186.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 08:50 -0600, Davda, Bhavesh P (Bhavesh) wrote:

> > >This is a headless system.
> > 
> > You could try netconsole.
> 
> Haven't heard of it before. Will look into it. But I doubt it will help
> pinpoint the semaphore holder, if all I can do is sysrq stuff.

Or does this system have a serial?  This is just as good (if not better)
than netconsole, since it is simpler, and netconsole still needs to use
the IP stack.  Although, in most cases netconsole works for me. But with
a serial, you can also send commands.  Netconsole is better if you need
to send lots of data, and need a higher speed data transfer rate.

I usually set up a minicom attached to the target computer, and on the
target run "cat /dev/ttyS0 > /dev/null &" just to open a port. This is
needed, since the reading of the serial will only be done if something
is actually reading from it.  On the kernel command line you will also
need to add, console=ttyS0,115200N8 (change the baud to whatever, since
here I use 115200).  From minicom, you can send a sysrq-t with C-a f t.
The C-a f sends a break, and the t tells the kernel this is a sysrq-t.
Read Documentation/serial-console.txt for more information.

For netconsole read: Documentation/networking/netconsole.txt


> 
> > 
> > > >
> > > > How stuck is the system?
> > > >
> > > > Keith
> > >
> > >Very. Only pingable, but can't login via 
> > telnet/ssh/anything. Reason is 
> > >the same reason the low priority mystery task is unable to run and 
> > >release the held semaphore.
> > 
> > (hmm.  I'm obviously missing some original context here)
> > 
> > Sounds like there must be another player who is RT prio + spinning.
> > 
> >          -Mike 
> 
> Very good! Yes, I left out that piece of detail in my original posting.
> There is a real low priority (4) SCHED_FIFO (hence still higher than any
> SCHED_OTHER) task spinning. But it is not the semaphore holder. I am
> trying to identify which kernel thread (because that's most likely)
> running at SCHED_OTHER real low priority (too nice) is holding the
> semaphore, locking out a priority 50 SCHED_FIFO task in its sys_write()
> as a result.

Also have a look at Ingo Molnar's RT patch. It takes care of priority
inversion (with priority inheritance) and also has lots of other nifty
features to debug semaphores and locks.

You can find it here:

http://people.redhat.com/mingo/realtime-preempt/


-- Steve

