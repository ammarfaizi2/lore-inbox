Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSILThm>; Thu, 12 Sep 2002 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSILThm>; Thu, 12 Sep 2002 15:37:42 -0400
Received: from packet.digeo.com ([12.110.80.53]:44995 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317189AbSILThl>;
	Thu, 12 Sep 2002 15:37:41 -0400
Message-ID: <3D80EE1D.34AF4FF2@digeo.com>
Date: Thu, 12 Sep 2002 12:42:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
References: Your message of "Thu, 12 Sep 2002 00:20:22 PDT."
	             <3D804036.4C000672@digeo.com> <200209120918.g8C9IND03853@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 19:42:23.0816 (UTC) FILETIME=[84203C80:01C25A94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> 
>     OK, that's a start.  I think there was some work done on making
>     kernel_stat percpu as well.
> 
> Yes there's work on a couple of different fronts there.  There is work
> to specifically make disk stats per cpu (actually, I have some 2.4
> patches already I could port), and there is a more general interface
> (statctr_t) which Dipankar Sarma (dipankar@in.ibm.com) is working on
> for 2.5 for stat counters in general which generalizes the per-cpu
> concept.
> 
> Regardless of which route we go, can you suggest a good exercise to
> demonstrate the advantage of per-cpu counters?  It seems intuitive to
> me, but I'm much more comfortable when I have numbers to back me up.

I don't think this is enough to justify a new subsystem like
statctr_t (struct statctr, please).

Looks like we can take the disk stats out of kernel_stat, move all
the vm-related things out of kernel_stat into struct page_state and
what's left of kernel_stat?

        unsigned int per_cpu_user[NR_CPUS],
                     per_cpu_nice[NR_CPUS],
                     per_cpu_system[NR_CPUS];
        unsigned int irqs[NR_CPUS][NR_IRQS];

And that's good, because "kernel statistics" was clearly too
broad a concept.  The above is just one concept: interrupts and
scheduler things.

I'll pull the VM accounting out of there; when you have a
close-to-final patch for the disk stats we can give it a whizz
in the -mm patches and then get all the userspace tools working
nicely against that, OK?

I'm not sure that I want to add 14 more fields to /proc/meminfo.
So a new /proc/vmstat may appear.  We would then have:

/proc/stat		scheduler things
/proc/diskstat		disk things
/proc/vmstat		vm things
