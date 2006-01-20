Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWATISE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWATISE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWATISE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:18:04 -0500
Received: from odin2.bull.net ([192.90.70.84]:14729 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750712AbWATISD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:18:03 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RT question : softirq and minimal user RT priority
Date: Fri, 20 Jan 2006 09:24:24 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200601131527.00828.Serge.Noiraud@bull.net> <1137167600.7241.22.camel@localhost.localdomain> <200601170858.14059.Serge.Noiraud@bull.net>
In-Reply-To: <200601170858.14059.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Message-Id: <200601200924.25135.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 01/20/2006 09:18:58 AM,
	Serialize by Router on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 01/20/2006 09:19:00 AM,
	Serialize complete at 01/20/2006 09:19:00 AM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I reproduce the problem without the script command too. I use the tee /dev/ttyS0.
It seems the problem is related to a TIMEOUT value somewhere in the buffer management or the scsi driver.
The test is 34 minutes ( 2040 sec ) long on my machine. ( HP workstation xw8200 ).
I found 1800 sec Time out in the kernel, but not for my drivers.

What kind of test or debug could I use to find out the problem ?

mardi 17 Janvier 2006 08:58, Serge Noiraud wrote/a écrit :
> Hi, 
> 	I continue my tests and found something new. I tested -rt6 : same problem
> 
> vendredi 13 Janvier 2006 16:53, Steven Rostedt wrote/a écrit :
> > On Fri, 2006-01-13 at 15:27 +0100, Serge Noiraud wrote:
> > > Hi,
> > > 
> > > 	I was testing 2.6.15-rt3. During my tests, I tried to run a program which made a loop at
> > > RT priority 10 and 30.
> > 
> > So you have two programs running, one at priority 10 and 30 right?
> I can reproduce the problem easily after each reboot at any priority with only one program.
> The problem occurs if all the IRQ's are affected to CPU 0 ( smp_affinity ) and the test run on CPU 0.
> Only one program which makes 60000000000ULL  loops.
> Before I run this program, I type the command script to keep the results.
> When the test stop, I quit the script command <ctrl>d.
> I am in the standard shell.
> The result file from the script command is empty. This is how I find the problem.
> 
> I tried with 2.6.15-rt6 :  same problem.
> 
> > 
> > > I was very happy to see that after the tests, I can't use any command except those already in memory.
> > 
> > So, are these programs still running?  Are they in busy loops?
> No they are finished.
> > 
> > > My filesystems were in read-only after the test. I was unable to shutdown the machine : 
> > 
> > How did the filesystems go into read-only?  Did the tests do that?
> No, it's a simple loop in which I get tsc to evaluate system perturbations.
> after quiting the script command, I can't type any command. That's what I mean below.
> > 
> > > top => command not found
> > > <CTRL><ALT><DEL> => INIT: cannot execute "/sbin/shutdown"
> > > /sbin/reboot   => Input/Output error
> > > I had to push the reset button.
> > 
> > I'll need more info to understand these.
> I have no more access to the file system. I can only do less and some other command.
> I get Input/Output error for all new command not in memory.
> If I try to ssh from another machine, I obtain the following messages :
> [root@dist2 root]# ssh dist1
> root@dist1's password: 
> Last login: Mon Jan 16 11:13:49 2006 from dist2.btsn.xxxxxxxxxx
> /usr/X11R6/bin/xauth:  error in locking authority file /root/.Xauthority
> I can't access .Xauthority file which exists. I could access it before the test.
> 
> At this point, If I try to reboot, I get the following messages.
> <CTRL><ALT><DEL> => INIT: cannot execute "/sbin/shutdown"
> /sbin/reboot   => Input/Output error
> 
> Before launching the script and the test, the system works correctly.
> 
> If I reboot the system and I launch the test again, I get the same problem => easily reproductible
> 
> I send you my CONFIG file and the program to reproduce the problem.
> > 
> > > 
> > > My questions are : 
> > > Did I find a bug ?
> > 
> > Don't know yet.
> > 
> > > Is the smallest usable real-time priority greater than the highest real-time softirq ?
> > 
> > Nope, you can use any rt priority you want.  It's up to you whether you
> > want to preempt the softirqs or not. Be careful, timers may be preempted
> > from delivering signals to high priority processes.  I have a patch to
> > fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
> Effectively, the problem occurs whatever the priority is : 10, 30, 60 or 99.
> 
> > 
> > > In this case could we forbid priority lesser than the highest softirq priority ?
> > 
> > No need.
> > 
> > -- Steve
> 
> Serge Noiraud
