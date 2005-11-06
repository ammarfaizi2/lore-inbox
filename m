Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVKFKE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKFKE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKFKE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:04:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55459 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751190AbVKFKEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:04:25 -0500
Date: Sun, 6 Nov 2005 02:04:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 3/5] cpuset: change marker for relative numbering
Message-Id: <20051106020410.2c0c26e1.pj@sgi.com>
In-Reply-To: <20051104230827.16001781.akpm@osdl.org>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
	<20051104230827.16001781.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> >  This patch provides a minimal mechanism to support the safe
> >  cpuset-relative management of CPU and Memory placement from
> >  user library code, in the face of possible external migration
> >  to different CPU's and Memory Nodes.
> 
> I guess you mean external migration of a cpuset to different CPUs and
> memory nodes via FILE_CPULIST and FILE_MEMLIST?

Yes.

> >  However if a task is moved to a different cpuset, or if the 'cpus'
> >  or 'mems' of a cpuset are changed, then we need a way for such
> >  library code to detect that its cpuset-relative numbering has
> >  changed, when expressed using system wide numbering.
> 
> Why?  If someone calls into that library for a query, then that library can
> call into the kernel to query the current state, no?  Are you assuming that
> this library will wish to cache state which belongs to the kernel?

A single shot query is no problem.  Many of the libcpuset calls
involve a sequence of operations on cpusets.

Lets say for example the application asks to have a thread pinned on
the 3rd CPU in its cpuset.  The library code must read the current
cpuset placement, calculate what CPU is 3rd, and issue a sched_affinity
call.

Or in a little more complex operation, the app might construct an
internal specification of a cpuset, specifying certain cpus and
mems, using numbering relative to its parent cpuset, then ask for
a child cpuset to be created, in accordance with that specification.

The library will have to work overtime to have this work correctly,
in the face of possible movement of the parent cpuset at anytime.

> >  The kernel could deliver out-of-band notice of cpuset changes by
> >  such mechanisms as signals or usermodehelper callbacks, however
> >  this can't be delivered to library code linked in applications
> >  without intruding on the IPC mechanisms available to the app.
> 
> connector?

True - connector/netlink technology, or other mechanisms that
delivered asynchronous notice via a file or socket would not
intrude noticeably on the apps IPC mechanisms.

Other criteria that I didn't mention ... Registering for a
connector takes more kernel text space than the simple marker_pid.

And the connector delivers its message asynchronously, so using
it here would be racey.  If task A is performing a series of operations
on a cpuset that task B is messing with, and if task B sends off notice
of its changes via some connector or similar mechanism, it might not
arrive at task A prior to A completing its operations and returning to
the calling user code, thinking that all was well.  If task A checks
for the cpusets marker_pid being unmodified at the end of its
operations, that is sequenced on the cpuset 'manage_sem' with task B's
changes.

> >  The kernel could require user level code to do all the work,
> >  tracking the cpuset state before and during changes, to verify no
> >  unexpected change occurred, but this becomes an onerous task.
> 
> Not sure I understand this,

The library code could read in the entire state of a cpuset,
perform its operations (noting the affect of these ops on
the cpuset state) and then re-read the cpuset state to see if
it had exactly the intended state.  Not impossible, but onerous.

> Shouldn't all those files in cpusetfs be documented?

Yup.  It's on my short list of things to do, real soon now.

> c) process reads "marker_pid" and if that's still equal to getpid(), we
>    know that nobody raced with us.  If someone _did_ race with us, what? 
>    re-read everything?

If someone did race us, then yes, re-read and redo the operation.

> d) process writes zero to "marker_pid" to release the marker.

No need for that, which is an important detail.  It is good that
no one cares if we leave our stale pid in a marker_pid past our
caring about it.

> Given that you're developing a library to do all this, why not do proper
> locking in userspace and require that all cpuset updates go via the
> library?

The superficial reason why not is that I can't prevent someone from
doing "echo pid > /dev/cpuset/tasks", moving a task to another cpuset
even as that task in the middle of dorking with its cpusets.  Not all
cpuset operations will involve using my blessed library.

The actual reason why not is that I have a strong bias toward localized
"every man for himself" solutions, over globally coordinated solutions.

> hm, cpuset_common_file_write() likes to return 0 for the number of bytes
> written. 

Good catch - thanks.  I'll look into it.

On second look - I don't think so.  The following code, near the
end of kernel/cpuset.c:cpuset_common_file_write() seems to set
the return number of bytes correctly:

        if (retval == 0)
                retval = nbytes;

And a simple test doing "strace /bin/echo 0 > mems" showed that the
write system called returned 2, for the length of the string "0\n",
as desired.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
