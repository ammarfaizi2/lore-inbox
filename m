Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWJUUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWJUUzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWJUUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:55:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35305 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161052AbWJUUzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:55:40 -0400
Date: Sat, 21 Oct 2006 13:55:16 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: mbligh@google.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061021135516.5deaa3e4.pj@sgi.com>
In-Reply-To: <6599ad830610211123i35d2e132y8ef1e0f612b94877@mail.gmail.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<6599ad830610211123i35d2e132y8ef1e0f612b94877@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not very familiar
> with the sched domains code but I guess it doesn't handle overlapping
> cpu masks very well?

As best as I can tell, the two motivations for explicity setting
sched domain partitions are:
 1) isolating cpus for real time uses very sensitive to any interference,
 2) handling load balancing on huge CPU counts, where the worse than linear
    algorithms start to hurt.

The load balancing algorithms apparently should be close to linear, but
in the presence of many disallowed cpus (0 bits in tasks cpus_allowed),
I guess they have to work harder.

I still have little confidence that I understand this.  Maybe if I say
enough stupid things about the scheduler domains and load balancing,
someone will get annoyed and try to educate me ;).  Best of luck to
them.

It doesn't sound to me like your situation is a real time, very low
latency or jigger, sensitive application.

How many CPUs are you juggling?  My utterly naive expectation would be
that dozens of CPUs should not need explicit sched domain partitioning,
but that hundreds of them would benefit from reduced time spent in
kernel/sched.c code if the sched domains were able to be partitioned
down to a significantly smaller size.

The only problem I can see that overlapping cpus_allowed masks presents
to this is that it inhibits partitioning down to smaller sched domains.
Apparently these partitions are system-wide hard partitions, such that
no load balancing occurs across partitions, so we should avoid creating
a partition that cuts across some tasks cpus_allowed mask.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
