Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753946AbWKHDPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbWKHDPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 22:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbWKHDPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 22:15:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19138 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753946AbWKHDPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 22:15:45 -0500
Date: Tue, 7 Nov 2006 19:15:18 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107191518.c094ce1a.pj@sgi.com>
In-Reply-To: <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	<20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	<6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> One drawback to this that I can see is the following:
> 
> - suppose you mount a containerfs with controllers cpuset and cpu, and
> create some nodes, and then unmount it, what happens? do the resource
> nodes stick around still?

Sorry - I let interfaces get confused with objects and operations.

Let me back up a step.  I think I have beat on your proposal enough
to translate it into the more abstract terms that I prefer using when
detemining objects, operations and semantics.

It goes like this ... grab a cup of coffee.

We have a container mechanism (the code you extracted from cpusets)
and the potential for one or more instantiations of that mechanism
as container file systems.

This container mechanism provides a pseudo file system structure
that names not disk files, but partitions of the set of tasks
in the system.  As always, by partition I mean a set of subsets,
covering and non-intersecting.  Each element of a partition of the
set of tasks in a system is a subset of that systems tasks.

The container mechanism gives names and permissions to the elements
(subsets of tasks) of the partition, and provides a convenient place
to attach attributes to those partition elements. The directories in
such a container file system always map one-to-one with the elements of
the partition, and the regular files in each such directory represent
the per-element (per-cpuset, for example) attributes.

Each directory in a container file system has a file called 'tasks'
listing the pids of the tasks (newline separated decimal ASCII format)
in that partition element.

Each container file system needs a name.  This corresponds to the
/dev/sda1 style raw device used to name disk based file systems
independent of where or if they are mounted.

Each task should list in its /proc/<pid> directory, for each such
named container file system in the system, the container file system
relative path of whichever directory in that container (element in
the partition it defines) that task belongs to.  (An earlier proposal
I made to have an entry for each -controller- in each /proc/<pid>
directory was bogus.)

Because containers define a partition of the tasks in a system, each
task will always be in exactly one of the partition elements of a
container file system.  Tasks are moved from one partition element
to another by writing their pid (decimal ASCII) into the 'tasks'
file of the receiving directory.

For some set of events, to include at least the 'release' of a
container element, the user can request that a callout be made to
a user executable.  This carries forth a feature previously known
as 'notify_on_release.'

We have several controllers, each of which can be instantiated and
bound to a container file system.  One of these controllers provides
for NUMA processor and memory placement control, and is called cpusets.

Perhaps in the future some controllers will support multiple instances,
bound to different container file systems, at the same time.
By different here, I meant not just different mounts of the same
container file system, but different partitions that divide up the
tasks of the system in different ways.

Each controller specifies a set of attributes to be associated with
each partition element of a container.  The act of associating a
controllers attributes with partition elements I will call "binding".

We need to be able to create, destroy and list container file systems,
and for each such container file system, we need to be able to bind
and unbind controller instances thereto.

We need to be able to list what controller types exist in the system
capable of being bound to containers.  We need to be able to list
for each container file system what controllers are bound to it.

And we need to be able to mount and unmount container file systems
from specific mount point paths in the file system.

We definitely need to be able to bind more than one controller to a
given container file system at the same time.  This was my item (3)
in an earlier post today.

We might like to support multiple container file systems at one time.
This seems like a good idea to at least anticipate doing, even if it
turns out to be more work than we can deliver immediately.  This was
my item (4) in that earlier post.

We will probably have some controllers in the future that are able
to be bound to more than one container file system at the same time,
and we have now, and likely will always have, some controllers, such
as cpusets, that must be singular - at most one bound instance at a
time in the system  This relates to my (buried) item (5) from that
earlier post.  The container code may or may not be able to support
controllers that bind to more than one file system at a time; I don't
know yet either how valuable or difficult this would be.

Overloading all these operations on the mount/umount commands seems
cumbersome, obscure and confusing.  The essential thing a mount does
is bind a kernel object (such as one of our container instances) to
a mount point (path) in the filesystem.  By the way, we should allow
for the possibility that one container instance might be mounted on
multiple points at the same time.

So it seems we need additional API's to support the creation and
destruction of containers, and binding controllers to them.

All controllers define an initial default state, and all tasks
can reference, while in that tasks context in the kernel, for any
controller type built into the system (or loadable module ?!), the
per-task state of that controller, getting at least this default state
even if the controller is not bound.

If a controller is not bound to any container file system, and
immediately after such a binding, before any of its per-container
attribute files have been modified via the container file system API,
the state of a controller as seen by a task will be this default state.
When a controller is unbound, then the state it presented to each
task in the system reverts to this default state.

Container file systems can be unmounted and remounted all the
while retaining their partitioning and  any binding to controllers.
Unmounting a container file system just retracts the API mechanism
required to query and manipulate the partitioning and the state per
partition element of bound controllers.

A basic scenario exemplifying these operations might go like this
(notice I've still given no hint of the some of the API's involved):

  1) Given a system with controllers Con1, Con2 and Con3, list them.
  2) List the currently defined container file systems, finding none.
  3) Define a container file system CFS1.
  4) Bind controller Con2 to CFS1.
  5) Mount CFS1 on /dev/container.
  6) Bind controller Con3 to CFS1.
  7) List the currently defined container file systems, finding CFS1.
  8) List the controllers bound to CFS1, finding Con2 and Con3.
  9) Mount CFS1 on a second mount point, say /foo/bar/container.
     This gives us two pathnames to refer to the same thing.
 10) Refine and modify the partition defined by CFS1, by making
     subdirectories and moving tasks about.
 11) Define a second container file system - this might fail if our
     implementation doesn't support multiple container file systems
     at the same time yet.  Call this CFS2.
 12) Bind controller Con1 to CFS2.  This should work.
 13) Mount CFS2 on /baz.
 14) Bind controller Con2 to CFS2.  This may well fail if that
     controller must be singular.
 15) Unbind controller Con2 from CFS2.  After this, any task referencing
     its Con2 controller will find the minimal default state.
 16) If (14) failed, try it again.  We should be able to bind Con2 to
     CFS2 now, if not earlier.
 17) List the mount points in the system (cat /proc/mounts).  Observe
     two entries of type container. for CFS1 and CFS2.
 18) List the controllers bound to CFS2, finding Con1 and Con2.
 19) Unmount CFS2.  Its structure remains, however one lacks any API to
     observe this.
 20) List the controllers bound to CFS2 - still Con1 and Con2.
 20) Remount CFS2 on /bornagain.
 21) Observe its structure and the binding of Con1 and Con2 to it remain.
 22) Unmount CFS2 again.
 23) Ask to delete CFS2 - this fails due because it has controllers
     bound to it.
 24) Unbind controllers Con1 and Con2 from CFS2.
 25) Ask to delete CFS2 - this succeeds this time.
 26) List the currently defined container file systems, once again
     finding just CFS1.
 27) List the controllers bound to CFS1, finding just Con3.
 28) Examine the regular files in the directory /dev/container, where
     CFS1 is currently mounted.  Find the files representing the
     attributes of controller Con3.

If you indulged in enough coffee to stay awake through all that,
you noticed that I invented some rules on what would or would not
work in certain situations.  For example, I decreed in (23) that one
could not delete a container file system if it had any controllers
bound to it.  I just made these rules up ...

I find it usually works best if I turn the objects and operations
around in my head a bit, before inventing API's to realize them.

So I don't yet have any firmly jelled views on what the additional
API's to manipulate container file systems and controller binding
should look like.

Perhaps someone else will beat me to it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
