Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWHXCUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWHXCUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 22:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWHXCUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 22:20:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3457 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030203AbWHXCUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 22:20:06 -0400
Date: Wed, 23 Aug 2006 19:19:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823191947.76a6f8ac.pj@sgi.com>
In-Reply-To: <20060823233944.GG11309@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
	<20060821221437.255808fa.pj@sgi.com>
	<20060823221114.GF11309@localdomain>
	<20060823153952.066e9a58.pj@sgi.com>
	<20060823233944.GG11309@localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> # echo 1 > /sys/devices/system/cpu/cpu3/online
> # taskset 0x8 foo
> 
> has a race condition, depending on your kernel's configuration.

Good point.  That's not a nice race to force on users.

I relent -- not udev.


> Maybe the cpuset code should just stay out of the way unless the admin
> has instantiated one?

I really don't like where such special case, modal behaviour leads us.

Let's say we have two systems, side by side.  Both have been up for
many months.  On one of these systems,  one time, a few months ago, the
sysadmin briefly made and removed a cpuset:

	mkdir /dev/cpuset
	mount -t cpuset cpuset /dev/cpuset
	mkdir /dev/cpuset/foo
	rmdir /dev/cpuset/foo
	umount /dev/cpuset
	rmdir /dev/cpuset

On the other of these systems, the sysadmin never did any such thing.
These two systems are now identical in every other aspect that might
matter to this discussion.

The sched_setaffinity call should behave the same on these two systems.

If the kernel has to impose a trivial bit of policy (such as forcing
the top cpuset to track what's online) in order to provide uniformally
consistent (not modal) and race free behaviour, then it should.

And besides, as someone else noted, it's alot easier than dealing with
udev ;).

Conclusion - the kernel should simply force the top_cpuset to track the
online maps.  See further my response to your patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
