Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWCAS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCAS2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWCAS2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:28:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37592 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751402AbWCAS2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:28:11 -0500
Date: Wed, 1 Mar 2006 10:27:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060301102757.f2eec70e.pj@sgi.com>
In-Reply-To: <200602281813.47234.ak@suse.de>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0602271510320.12637@schroedinger.engr.sgi.com>
	<20060227175603.e858eade.pj@sgi.com>
	<200602281813.47234.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  1) Are you content to have such a interleave of these particular file
> >     i/o slabs triggered by a mm/mempolicy.c option?  Or do you think
> >     we need some sort of task external API to invoke this policy?
> 
> Task external. mempolicy.c has no good way to handle multiple policies
> like this. I was thinking of a simple sysctl

No need to implement a sysctl for this.  The current cpuset facility
should provide just what you want, if I am understanding correctly.

It would be really easy.  Run with a kernel that has cpusets configured
in.  One time at boot, enable memory spreading for these slabs:
    test -d /dev/cpuset || mkdir /dev/cpuset
    mount -t cpuset cpuset /dev/cpuset
    echo 1 > /dev/cpuset/memory_spread_slab	# enable system wide

That's all you need to do to enable this system wide.

With this, tasks will be spreading these selected slab caches,
independently of whatever mempolicy they have.

To disable this memory spreading system wide:
    echo 0 > /dev/cpuset/memory_spread_slab	# disable system wide

If you want to control which tasks have these slab spread, then
it is just a few more lines once at boottime.  The following
lines make a second cpuset 'spread_tasks'.  Tasks in this second
cpuset will be spread; the other tasks in the root cpuset won't be
spread.

One time at boot:
    test -d /dev/cpuset || mkdir /dev/cpuset
    mount -t cpuset cpuset /dev/cpuset
    mkdir /dev/cpuset/spread_tasks
    cat /dev/cpuset/cpus > /dev/cpuset/spread_tasks/cpus
    cat /dev/cpuset/mems > /dev/cpuset/spread_tasks/mems
    echo 1 > /dev/cpuset/spread_tasks/memory_spread_slab

Then during operation, for each task $pid that is to be spread:
    echo $pid > /dev/cpuset/spread_tasks/tasks	# enable for $pid

or to disable that spreading for a pid:
    echo $pid > /dev/cpuset/tasks		# disable for $pid

These echo's can be done with open/write/close system calls if you
prefer.

The first two echos above would correspond to a sysctl that applied
system wide, enabling or disabling memory spreading on these slabs for
all tasks.  The last two echo's correspond directly to a sysctl that
applies to a single specified pid.

Why do a new sysctl, when the existing open/write/close system calls
can do the same thing?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
