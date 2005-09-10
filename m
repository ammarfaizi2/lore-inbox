Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVIJIwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIJIwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVIJIwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:52:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750710AbVIJIwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:52:21 -0400
Date: Sat, 10 Sep 2005 01:52:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: magnus.damm@gmail.com, kurosawa@valinux.co.jp, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050910015209.4f581b8a.pj@sgi.com>
In-Reply-To: <20050910.161145.74742186.taka@valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I suspect I don't understand yet.

Nice picture though - that gives me some idea what you mean.

Do notice that the basic rule of cpu_exclusive cpusets is that their
CPUs don't overlap their siblings.  Your Cpusets 1, 2, and 3 seem to be
marked cpu_exclusive in your picture, but all contain the same CPUs 2
and 3, overlapping each other.

I'm guessing what you are trying to draw is:

  Tasks on CPUs 0 and 1 have no resource control limits.

  Tasks on CPUs 2 and 3 have resource control limits specifying
	what percentage of the CPUs 2 and 3 is available to them.

I might draw my solution to that as:

     +-----------------------------------+
     |                                   |
  CPUSET 0                            CPUSET 1         
  sched domain A                      sched domain B   
  cpus: 0, 1                          cpus: 2, 3       
  cpu_exclusive=1                     cpu_exclusive=1
  meter_cpu=0                         meter_cpu=0
                                         |
                        +----------------+----------------+
                        |                |                |
                     CPUSET 1a        CPUSET 1b        CPUSET 1c
                     cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
		     cpu_exclusive=0  cpu_exclusive=0  cpu_exclusive=0
                     meter_cpu=1      meter_cpu=1      meter_cpu=1
                     meter_cpu_*      meter_cpu_*      meter_cpu_*

The meter_cpu_* files in each of Cpusets 1a, 1b, and 1c control what
proportion of the CPU resources in that Cpuset can be used by the tasks
in that Cpuset.

If meter_cpu is false (0) then the meter_cpu_* files do not appear,
which is equivalent to allowing 100% of the CPUs in that Cpuset to
be used by the tasks in that Cpuset (and descendents, of course.)

Don't forget - this all seems like it has significant mission overlap
with CKRM.  I hate to repeat this, but the relation of your work to
CKRM needs to be understood before I am likely to agree to accepting
your work into the kernel (not that my acceptance is required; you
really just need Linus to agree, though he of course considers the
positions of others to some inscrutable degree.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
