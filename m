Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVHSAXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVHSAXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHSAXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:23:38 -0400
Received: from web54405.mail.yahoo.com ([206.190.49.135]:43677 "HELO
	web54405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932354AbVHSAXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:23:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iVjSxVvBFfhDq5ndhYLAuTSOh/n9fRP4iYz3x4O3QoTFTGgT2QtmQpSKPL6UNOtKXUSBj35UMP4oD6zTWFX+F6r6izdeieoJ34XrrFjokf1Q2n0Gmu+XV/7eOtGjso98sXcZ5wpEbexKUn7mNslCK9PLxpfOjJ7t/KPRQUzY11c=  ;
Message-ID: <20050819002336.74150.qmail@web54405.mail.yahoo.com>
Date: Thu, 18 Aug 2005 17:23:35 -0700 (PDT)
From: Sundar Narayanaswamy <sundar007@yahoo.com>
Subject: Re: Latency with Real-Time Preemption with 2.6.12
To: Steven Rostedt <rostedt@goodmis.org>, george@mvista.com
Cc: Sundar Narayanaswamy <sundar007@yahoo.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <43050BBB.2020609@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,
Thanks very much for your input. I applied the latest realtime-preempt 
patch today (patch-2.6.13-rc6-rt9) on top of 2.6.13-rc6 kernel and I set
the high res timer to using TSC. 

Anyways, I am not too concerned about the nanosleep test itself. I just
thought that would be a way to demonstrate the original problem I am trying
to solve (which is a bit more complicated). The original problem is
setup like this: 

The SBC has two serial ports, ttyS0 and ttyS1 that are connected by the
serial port cable. A program writes characters on ttyS0 while another
program (with RealTime priority thread) reads the char from ttyS1 and
echoes it back immediately). The first program then measures the time it
takes for it to get back the written char. Without any system load, 
I noticed that this time is about 4ms, which I think is fine. However,
as the system load (primarly disk I/O) increases, the time increases to about 
30-40 ms and this increase (with moderate system load) surprises me. With
realtime preemption patch, I was hoping this time would remain about 4ms.

My initial guess was that the driver (IDE controller, due to disk I/O load) 
has non-preemptible sections that is causing the additional delay, and 
that was why I tried the nanosleep test program. 

Now, I am not sure if  I am not setting up something right, or if I 
am missing something. I appreciate your time and feedback. Please let me know 
if there is something obvious that I should look into, or a setup (config) 
I might be missing. I'll look into George's suggestion to try timers 
tomorrow.

Thanks very much,
sundar.



--- George Anzinger <george@mvista.com> wrote:

> Steven Rostedt wrote:
> > On Wed, 2005-08-17 at 19:38 -0700, Sundar Narayanaswamy wrote:
> > 
> >>Hi,
> >>I am trying to experiment using 2.6.12 kernel with the realtime-preempt 
> >>V0.7.51-38 patch to determine the kernel preemption latencies with the 
> >>CONFIG_PREEMPT_RT mode. The test program I wrote does the following on
> >>a thread with highest priority (99) and SCHED_FIFO policy to simulate
> >>a real time thread.
> >>
> >>t1 = gettimeofday
> >>nanosleep(for 3 ms)
> >>t2 = gettimeofday
> >>
> >>I was expecting to see the difference t2-t1 to be close to 3 ms. However, 
> >>the smallest difference I see is 4 milliseconds under no system load, 
> >>and the difference is as high as 25 milliseconds under moderate to 
> >>heavy system load (mostly performing disk I/O).
> > 
> > 
> > That version of Ingo's patch does not implement High-Resolution Timers.
> > Thomas worked on merging this into the latest RT patch.  Without
> > high-res timers, the best you may ever get is 4ms. This is because
> > nanosleep is to guarantee _at_least_ 3 ms.  So you have the following
> > situation:
> > 
> > 0               1               2                3               4 (ms)
> > +---------------+---------------+----------------+---------------+--->
> >            ^                                        ^
> >            |                                        |
> >          Start here 0+3 = 3                      here we have the response
> > 
> > If we look at this in smaller units than ms, we started on 0.8ms and
> > responded at 3.2ms where we have 3.2 - 0.8 = 2.4 which is less than 3ms.
> > So since Ingo's patch doesn't increase the resolution of the timers from
> > a jiffy (which is currently 1ms) Linux is forced to add one more than
> > you need.
> > 
> > 
> >>Based on the articles and the mails I read on this list, I understand that 
> >>worst case latencies of 1 ms (or less) should be possible using the RT 
> >>Preemption patch, but I am unable to get anything less than 4 millseconds 
> >>even with sleep times smaller than 3 ms. I am running the tests on a SBC 
> >>with a 1.4G Pentium M, 512M RAM, 1GB compact flash (using IDE). 
> >>
> >>I believe I have the high resolution timer working correctly, because if I 
> >>comment out the sleep line above t2-t1 is consistenly 0 or 1 microsecond.
> > 
> > 
> > I don't think you have the high res timer working, since there is no
> > high res timer in that kernel.
> > 
> > 
> >>Following earlier discussions (in July) in this list, I tried to set kernel
> 
> >>configuration parameters like CONFIG_LATENCY_TRACE to get tracing/debug 
> >>information, but I didn't find these parameters in my .config file.
> >>
> >>I appreciate your suggestions/insights into the situation and steps that I 
> >>should try to get more debug/tracing information that might help to
> understand 
> >>the cause of high latency.
> > 
> > 
> > It's not a high latency.  It's doing exactly as it is suppose to, since
> > the nanosleep doesn't have high-res support (in that kernel).  If you
> > really want to measure latency, you need to add a device or something
> > and see what the response time of an interrupt going off to the time a
> > thread is woken to respond to it.  Now with Ingo's that is really fast.
> 
> Another way to do it is to set up a repeating timer.  You _must_ read 
> back the timer to get the repeat time it is really using, and then 
> measure how well it does giving signals at these repeat times.  FAR FAR 
> more than three lines of code...
> > 



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
