Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVKEHJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVKEHJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVKEHJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:09:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751279AbVKEHJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:09:16 -0500
Date: Fri, 4 Nov 2005 23:08:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, pj@sgi.com, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 3/5] cpuset: change marker for relative numbering
Message-Id: <20051104230827.16001781.akpm@osdl.org>
In-Reply-To: <20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  This patch provides a minimal mechanism to support the safe
>  cpuset-relative management of CPU and Memory placement from
>  user library code, in the face of possible external migration
>  to different CPU's and Memory Nodes.

I guess you mean external migration of a cpuset to different CPUs and
memory nodes via FILE_CPULIST and FILE_MEMLIST?

>  The interface presented to user space for cpusets uses system wide
>  numbering of CPUs and Memory Nodes.   It is the responsibility of
>  user level code, presumably in a library, to present cpuset-relative
>  numbering to applications when that would be more useful to them.
> 
>  However if a task is moved to a different cpuset, or if the 'cpus'
>  or 'mems' of a cpuset are changed, then we need a way for such
>  library code to detect that its cpuset-relative numbering has
>  changed, when expressed using system wide numbering.

Why?  If someone calls into that library for a query, then that library can
call into the kernel to query the current state, no?  Are you assuming that
this library will wish to cache state which belongs to the kernel?

>  The kernel cannot safely allow user code to lock kernel resources.

Well yes - in the presence of other processes dinking with a cpuset's
settings, such a library is always racy.  Unless it provides
kernel-triggered callbacks when something changes.  Or unless it does
locking.

>  The kernel could deliver out-of-band notice of cpuset changes by
>  such mechanisms as signals or usermodehelper callbacks, however
>  this can't be delivered to library code linked in applications
>  without intruding on the IPC mechanisms available to the app.

connector?

>  The kernel could require user level code to do all the work,
>  tracking the cpuset state before and during changes, to verify no
>  unexpected change occurred, but this becomes an onerous task.

Not sure I understand this, but if you're saying that maintaining state in
a single pace is good then yup.

>  The "marker_pid" cpuset field provides a simple way to make this
>  task less onerous on user library code.  The code writes its pid
>  to a cpusets "marker_pid" at the start of a sequence of queries
>  and updates, and check as it goes that the cpsuets marker_pid
>  doesn't change.  The pread(2) system call does a seek and read in
>  a single call.  If the marker_pid changes, the library code should
>  retry the required sequence of operations.

<looks for API documentation in cpusets.txt, gives up>

Shouldn't all those files in cpusetfs be documented?

So what is the <undocumented> programming interface which you are proposing
here?

a) process writes a non-zero number to file "marker_pid" in cpusetfs. 
   Kernel remembers that the calling task "owns" the cpuset for updates.

b) cpuset updates proceed.  If a different task does an update, marker_pid
   gets cleared.

c) process reads "marker_pid" and if that's still equal to getpid(), we
   know that nobody raced with us.  If someone _did_ race with us, what? 
   re-read everything?

d) process writes zero to "marker_pid" to release the marker.


Given that you're developing a library to do all this, why not do proper
locking in userspace and require that all cpuset updates go via the
library?

Does this code work correctly if different threads stomp on each others'
toes?  I think so.


hm, cpuset_common_file_write() likes to return 0 for the number of bytes
written.  This could cause some userspace tools to hang, repeating the
write all the time, or to report a write error.  It should return nbytes on
success.

>  Anytime that a task modifies the "cpus" or "mems" of a cpuset,
>  unless it's pid is in the cpusets marker_pid field, the kernel
>  zeros this field.
