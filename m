Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVBVNzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVBVNzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVBVNzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:55:52 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:7296 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S262314AbVBVNzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:55:40 -0500
Subject: Re: Needed faster implementation of do_gettimeofday()
From: Puneet Kaushik <puneet_kaushik@persistent.co.in>
To: george@mvista.com, kernel-stuff@comcast.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <421AA1BD.7020706@mvista.com>
References: <34373.203.199.147.2.1108897097.squirrel@webmail.persistent.co.in>
	 <200502201048.01424.kernel-stuff@comcast.net> <421AA1BD.7020706@mvista.com>
Content-Type: text/plain
Message-Id: <1109080575.21544.264.camel@ps2335.persistent.co.in>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 22 Feb 2005 19:26:15 +0530
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Parag and George,

Thanks for immediate reply.
The main problem is I am working on a SMP system. I have written a small
program that just calls the gettimeofday(), one billion times. I have
run it with time utility and it takes almost double time on SMP then a
UP.



with kernel 2.6.10 on UP

real    4m5.495s
user    1m17.088s
sys     2m48.046s


With Kernel 2.6.10 on SMP

real    6m24.485s
user    1m43.723s
sys     4m30.749s


And the fact is this SMP machine is faster and with more memory than the
UP one. In SMP systems it make a spinlock every time it got called,
synchronizes both the processors, and unlock them. Thats all I know
about it.

George I am just working on your suggestion, let me know if it will work
for SMPs.

If there is some good implementation for SMP, please let me know.

Thanks,

- Puneet




On Tue, 2005-02-22 at 08:36, George Anzinger wrote:
> Parag Warudkar wrote:
> > On Sunday 20 February 2005 05:58 am, puneet_kaushik@persistent.co.in wrote:
> > 
> >>985913    8.6083  vmlinux                  mark_offset_tsc
> >>584473    5.1032  libc-2.3.2.so            getc
> > 
> > 
> > What makes you think mark_offset_tsc is slow? Do you have any comparative 
> > numbers?  It might just be that the workload you are throwing at it justifies 
> > it. (For e.g. if your workload does a zillion system calls, system_call will 
> > show up as a hot spot in oprofile - doesn't necessarily mean it is slow - 
> > it's just overused.) Can you post the relevant code?
> 
> He really is right.  Mark offset is reading the PIT counter and that is not only 
> rather dumb but dog slow.
> 
> A suggestion, try the high res timers patch.  Even if you don't use the timers 
> the mark offset there is MUCH faster.  It does not read the PIT.
> 
> The difference is where we assume the jiffie bump is in time.  If we assume it 
> is at the point that the PIT interrupts, well then the only way to get to that 
> is to read the PIT.  If, on the other hand, we assume it is at the time after 
> the interrrupt where we mark offset, we can observe the "best" time for this 
> event based on the TSC and avoid reading the PIT.
> 
> Try the HRT patch (see signature below) and see if if doesn't do better.
> 

