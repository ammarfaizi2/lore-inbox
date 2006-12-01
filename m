Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031756AbWLAUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031756AbWLAUda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031759AbWLAUda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:33:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65202 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1031748AbWLAUd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:33:28 -0500
Date: Fri, 1 Dec 2006 12:31:34 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, akpm@osdl.org, sekharan@us.ibm.com, dev@sw.ru,
       xemul@sw.ru, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com, devel@openvz.org, mingo@elte.hu,
       nickpiggin@yahoo.com.au, dipankar@in.ibm.com, balbir@in.ibm.com
Subject: Re: [Patch 1/3] Miscellaneous container fixes
Message-Id: <20061201123134.106da1c2.pj@sgi.com>
In-Reply-To: <6599ad830612010925w17f56643n8c92f179ea28b828@mail.gmail.com>
References: <20061123120848.051048000@menage.corp.google.com>
	<20061123123414.641150000@menage.corp.google.com>
	<20061201164632.GA26550@in.ibm.com>
	<6599ad830612010925w17f56643n8c92f179ea28b828@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Ah - this may be the lockup that PaulJ hit.

Yes - looks like this fixes it.  Thanks, Srivatsa.

And with that fix, it becomes obvious how to reproduce this problem:

	mount -t cpuset cpuset /dev/cpuset	# if not already mounted
	cd /dev/cpuset
	mkdir foo
	echo 1 > foo/cpu_exclusive
	rmdir foo				# hangs ...

However ...

Read the comment in kernel/cpuset.c for the routine cpuset_destroy().
It explains that update_flag() is called where it is (turning off
the cpu_exclusive flag, if it was set), to avoid the calling sequence:

  cpuset_destroy->update_flag->update_cpu_domains->lock_cpu_hotplug

while holding the callback_mutex, as that could ABBA deadlock with the
CPU hotplug code.

But with this container based rewrite of cpusets, it now seems that
cpuset_destroy -is- called holding the callback_mutex (though I don't
see any mention of that in the cpuset_destroy comment ;), so it would
seem that we once again are at risk for this ABBA deadlock.

I also notice that the comment for container_lock() in the file
kernel/container.c only mentions its use in the oom code.  That is
no longer the only, or even primary, user of this lock routine.
The kernel/cpuset.c code uses it frequently (without comment ;),
and I wouldn't be surprised to see other future controllers calling
container_lock() as well.

Looks like its time to update those comments, and think about what
was written there before, as that might catch a bug or two, such as
the one Srivatsa just fixed for us.

Most of those long locking comments in kernel/cpuset.c are there
for a reason - recording the results of a lesson learned in the
school of hard knocks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
