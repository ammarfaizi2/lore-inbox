Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUECMt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUECMt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUECMt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:49:29 -0400
Received: from [129.183.4.3] ([129.183.4.3]:25996 "EHLO ecbull20.frec.bull.fr")
	by vger.kernel.org with ESMTP id S261416AbUECMso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:48:44 -0400
Message-ID: <40963FAB.DF49BC3E@nospam.org>
Date: Mon, 03 May 2004 14:48:44 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: NUMA API - wish list
References: <409201BE.9000909@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you remember back the "old golden days" when there were no open(),
read(), lseek(), write(), mmap(), etc., and one had to tell explicitly
(job control punched cards) that s/he needed the sectors 123... 145 on
the disk on channel 6 unit 7 ?
Or somewhat more recently, one had to manage by hand the memory and the
overlays.
Now we are going to manage (from applications) the topology, CPU or
memory binding. Moreover, to have the applications resolve resources
management / dependency problems / conflicts among them...

The operating systems should provide for abstractions of the actual
HW platform: file system, virtual memory, shared CPUs, etc.

Why should an application care for the actual physical characteristics ?
Including counting nanoseconds of some HW resource access time ? We'll
end up with some completely un-portable applications.

I think an application should describe what it needs for its optimal run,
e.g.:
	- I need 3 * N (where N = 1, 2, 3,...) CPUs "very close"
	  together and 2.5 Gbytes / N real memory (working set size) for
	  each CPUs "very very close to" their respective CPUs
	- Should not it fit into a "domain", the CPUs have to be
	  "very very close" to each other 3 by 3
	- If no resources for even N == 1, do not start it at all
	- Use "gang scheduling" for them, otherwise I'll busy wait :-)
	- In addition, I need M CPUs + X Gbytes of memory
	  "where my previous group is" and I need a disk I/O path of
	  the capacity of 200 Mbytes / sec "more or less close to" my
	  memory
	- I need "some more" CPUs "somewhere" with some 100 Mbytes of
	  memory "preferably close to" the CPUs and 10 Mbytes / sec
	  TCP/IP bandwidth "close to" my memory 

	- I need 70 % of the CPU time on my CPUs (the scheduler can
	  select others for the 30 % of the time left)

	- O.K. should my request be too much, here is my minimal,
	  "degraded" configuration:...

The OS reserves the resources for the application (exec time assignment)
and reports the applications what of its needs have been granted.

When the application allocates some memory, it'll say: you know, this
is for the memory pool I've described in the 5th criteria.
When it creates threads, it'll say they are in the 2nd group of threads
mentioned at the 1st line

The work load manager / load balancer can negotiate other resource
assignment at any time with the application.
The work load manager / load balancer is free to move a collection of
resources from some NUMA domains to others, provided the application's
requirements are still met. (No hard binding.)

Billing is done accordingly :-)

As you do not need to know anything about SCSI LUNs, sector IDs, phy-
sical memory maps or the other applications when you compile your kernel,  
why should an application care for HW NUMA details ?

Thanks,

Zoltán Menyhárt
