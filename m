Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVBOVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVBOVsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVBOVsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:48:46 -0500
Received: from ns.suse.de ([195.135.220.2]:22675 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261902AbVBOVsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:48:42 -0500
Date: Tue, 15 Feb 2005 22:48:31 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050215214831.GC7345@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421241A2.8040407@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Making memory migration a subset of page migration is not a general
> solution.  It only works for programs that are using memory policy
> to control placement.   As I've tried to point out multiple times
> before, most programs that I am aware of use placement based on
> first-touch.  When we migrate such programs, we have to respect
> the placement decisions that the program has implicitly made in
> this way.

Sorry, but the only real difference between your API and mbind is that
yours has a pid argument. 

I think we are talking by each other, here's a more structured
overview of my thinking on the issue.

Main cases:

- Program is NUMA API aware. Fine.  It takes care of its own.
- Program is not aware, but is started with a process policy from
numactl/cpusets/batch scheduler. Already covered too in NUMA API. 
- Program is not aware and hasn't been started with a policy
(or has and you change your mind) but you want to change it later. 
That's the new case we discuss here. 

Now how to change policy of objects in an already running process.

First there are already some special cases already handled or
with existing patches:
- tmpfs/hugetlbfs/sysv shm: numactl can handle this by just mapping
the object into a different process and changing the policy there.
- shared libraries and mmaped files in general: this is a generialization of
the previous point. SteveL's patch is the beginning of handling this, although
it needs some more work (xattrs) to make the policy persistent over
memory pressure.

Only case not covered left is anonymous memory. 

You said it would need user space control, but the main reason for
wanting that seems to be to handle the non anonymous cases which
are already covered above.

My thinking is the simplest way to handle that is to have a call that just o
migrates everything. The main reasons for that is that I don't think external
processes should mess with virtual addresses of another process.
It just feels unclean and has many drawbacks (parsing /proc/*/maps
needs complicated user code, racy, locking difficult).  

In kernel space handling full VMs is much easier and safer due to better 
locking facilities.

In user space only the process itself really can handle its own virtual 
addresses well, and if it does that it can use NUMA API directly anyways.

You argued that it may be costly to walk everything, but I don't see this
as a big problem - first walking mempolicies is not very costly and then
fork() and exit() do exactly this already. 

The main missing piece for this would be a way to make policies for
files persistent. One way would be to use xattrs like selinux, but
that may be costly (not sure we want to read xattrs all the time
when reading a file). 

A hackish way to do this that already 
works would be to do a mlock on one page of the file to keep
the inode pinned. E.g. the batch manager could do this. That's 
not very clean, but would probably work. 

-Andi
