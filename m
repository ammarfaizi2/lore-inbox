Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUEURrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUEURrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUEURrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:47:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29605 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265916AbUEURrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:47:17 -0400
Date: Fri, 21 May 2004 10:46:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: brettspamacct@fastclick.com
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       jbarnes@engr.sgi.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <74030000.1085161614@flay>
In-Reply-To: <40AE3BF5.5080804@fastclick.com>
References: <40AD52A4.3060607@fastclick.com> <273180000.1085121453@[10.10.2.4]> <40AE3BF5.5080804@fastclick.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Say you have a bunch of single-threaded processes on a NUMA machine. 
>>> Does the kernel make sure to prefer allocations using a certain CPU's 
>>> memory, preferring to run a given process on the CPU which contains 
>>> its memory?  Or should I use the NUMA API(libnuma) to spell this out 
>>> to the kernel? Does the kernel do the right thing in this case?
>> 
>> 
>> The kernel will generally do the right thing (process local alloc) by
>> default. In 99% of cases, you don't want to muck with it - unless you're
>> running one single app dominating the whole system, and nothing else is
>> going on, you probably don't want to specify anything explicitly.
>> 
>> M.
>> 
> Let's say I have a 2 way opteron and want to run 4 long-lived processes.   I fork and exec to create 1 of the processes, it chooses to run on processor 0 since processor 1 is overloaded at that time, so its homenode is processor 0. 

There is no such thing as a homenode. What you describe is more or less why
we ditched that concept.

> I fork and exec another, it chooses processor 0 since processors 1 is overloaded at that time. .. Let's say an uneven distribution is chosen for all 4 processes, with all processes mapped to processor 0. So they allocate on node 0 yet the scheduler will map these to both processors since CPU should be balanced. In this case, you will have a situation where the second processor will have to fetch memory from the other processor's memory.

Each process will allocate local to the CPU it is running on when it does the
allocate, so it's difficult to get as off-kilter as you describe (though it
is still possible).

> So a better solution would be to use numactl to set the homenodes explicitly, choosing processor 0 for 2 processes, processor 1 for the 2 other processes.

In theory, it may be. If you ever had complete control of the system, and
started no other processes whatsoever. In practice, that's very unlikely,
so unless you're running a dedicated Oracle server or something, don't muck 
with it - just let the OS sort it out ;-)

M.

