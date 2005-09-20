Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbVITOX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbVITOX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbVITOX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:23:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27011 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932758AbVITOX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:23:27 -0400
Date: Tue, 20 Sep 2005 07:22:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050920072255.0096f1bb.pj@sgi.com>
In-Reply-To: <20050920120523.GC21435@lnx-holt.americas.sgi.com>
References: <20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
	<20050914124642.1b19dd73.pj@sgi.com>
	<Pine.LNX.4.61.0509150116150.3728@scrub.home>
	<20050915104535.6058bbda.pj@sgi.com>
	<20050920005743.4ea5f224.pj@sgi.com>
	<20050920120523.GC21435@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin asked:
> Can you give a _short_ explanation of why notify_on_release is
> essential? 

short - me - hah !

Ok - I'll try ;).

It's not the children, it's the parents.

Only leaf nodes in the /dev/cpuset tree can get removed,
when they have no children and no tasks.  This might
trigger walking up the parent chain, if in turn the parent
now has no children and no tasks.

Removing one or more vfs file system directories, working
from the bottom up, while in the task exit code, would have
required far more vfs locking voodoo than I can even imagine
possible.

With the usermodehelper, running rmdir(2) from a separate
thread asynchonously from userland, the only way these
directories ever get removed is via an ordinary rmdir(2)
system call, one empty directory at a time.  I trust that
the vfs file system can handle that locking; I don't even
need to know how it does it.

Let's say we have the following notify_on_release cpusets,
each with exactly one task in them:

	/dev/cpuset/A		task1
	/dev/cpuset/A/B		task2
	/dev/cpuset/A/B/C	task3

Lets further say that tasks 1, 2 and 3, exit, in that
order, task1 first.

When task1 exits, no cpusets are removed.

When task2 exits, no cpusets are removed.

When task3 exits, cpuset A/B/C needs to be removed. That in
turn triggers removing A/B.  That in turn triggers removing A.

I was confident that I could do these three removals safely
by doing three rmdir(2) system calls, one at a time, in order,
working from the bottom up.

I had no clue how to do these three removals safely, working
from the bottom up, while in the kernel exit code for task3.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
