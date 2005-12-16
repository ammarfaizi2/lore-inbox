Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLPC3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLPC3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLPC3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:29:03 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:1997 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932084AbVLPC3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:29:01 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Matt Helsley <matthltc@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net,
       vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, pagg@oss.sgi.com
In-Reply-To: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
References: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 18:20:52 -0800
Message-Id: <1134699652.10396.161.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> On Thu, 15 Dec 2005 09:35:57 EST, Hubertus Franke wrote:
> > This patchset is a followup to the posting by Serge.
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113200410620972&w=2
> > 
> > In this patchset here, we are providing the pid virtualization mentioned
> > in serge's posting.
> > 
> > > I'm part of a project implementing checkpoint/restart processes.
> > > After a process or group of processes is checkpointed, killed, and
> > > restarted, the changing of pids could confuse them.  There are many
> > > other such issues, but we wanted to start with pids.
> > >
> > > This patchset introduces functions to access task->pid and ->tgid,
> > > and updates ->pid accessors to use the functions.  This is in
> > > preparation for a subsequent patchset which will separate the kernel
> > > and virtualized pidspaces.  This will allow us to virtualize pids
> > > from users' pov, so that, for instance, a checkpointed set of
> > > processes could be restarted with particular pids.  Even though their
> > > kernel pids may already be in use by new processes, the checkpointed
> > > processes can be started in a new user pidspace with their old
> > > virtual pid.  This also gives vserver a simpler way to fake vserver
> > > init processes as pid 1.  Note that this does not change the kernel's
> > > internal idea of pids, only what users see.
> > >
> > > The first 12 patches change all locations which access ->pid and
> > > ->tgid to use the inlined functions.  The last patch actually
> > > introduces task_pid() and task_tgid(), and renames ->pid and ->tgid
> > > to __pid and __tgid to make sure any uncaught users error out.
> > >
> > > Does something like this, presumably after much working over, seem
> > > mergeable?
> > 
> > These patches build on top of serge's posted patches (if necessary
> > we can repost them here).
> > 
> > PID Virtualization is based on the concept of a container.
> > The ultimate goal is to checkpoint/restart containers. 
> > 
> > The mechanism to start a container 
> > is to 'echo "container_name" > /proc/container'  which creates a new
> > container and associates the calling process with it. All subsequently
> > forked tasks then belong to that container.
> > There is a separate pid space associated with each container.
> > Only processes/task belonging to the same container "see" each other.
> > The exception is an implied default system container that has 
> > a global view.

<snip>

> I think perhaps this could also be the basis for a CKRM "class"
> grouping as well.  Rather than maintaining an independent class
> affiliation for tasks, why not have a class devolve (evolve?) into
> a "container" as described here.  The container provides much of
> the same grouping capabilities as a class as far as I can see.  The
> right information would be availble for scheduling and IO resource
> management.  The memory component of CKRM is perhaps a bit tricky
> still, but an overall strategy (can I use that word here? ;-) might
> be to use these "containers" as the single intrinsic grouping mechanism
> for vserver, openvz, application checkpoint/restart, resource
> management, and possibly others?
> 
> Opinions, especially from the CKRM folks?  This might even be useful
> to the PAGG folks as a grouping mechanism, similar to their jobs or
> containers.
> 
> "This patchset solves multiple problems".
> 
> gerrit

CKRM classes seem too different from containers to merge the two
concepts:

- Classes don't assign class-unique pids to tasks.

- Tasks can move between classes.

- Tasks move between classes without any need for checkpoint/restart.

- Classes show up in a filesystem interface rather that using a file
in /proc to create them. (trivial interface difference)

- There are no "visibility boundaries" to enforce between tasks in
different classes.

- Classes are hierarchial.

- Unless I am mistaken, a container groups processes (Can one thread run
in container A and another in container B?) while a class groups tasks.
Since a task represents a thread or a process one thread could be in
class A and another in class B.

Cheers,
	-Matt Helsley

