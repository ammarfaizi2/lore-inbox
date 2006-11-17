Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755816AbWKQTOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbWKQTOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbWKQTOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:14:10 -0500
Received: from smtp-out.google.com ([216.239.45.12]:26918 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1755816AbWKQTOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:14:09 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:user-agent:date:from:to:cc:subject;
	b=MKTHHiiiaddJ8sOWo/U6QlkhCRvXR+jGoewf1fjj/DuoII5cjWhRsVKELRUSo74pU
	MTeU+aig/GlS20VY092/Q==
Message-Id: <20061117191159.151894000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Fri, 17 Nov 2006 11:11:59 -0800
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com
Cc: ckrm-tech@lists.sourceforge.net, jlan@sgi.com, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
Subject: [PATCH 0/6]  Multi-hierarchy Process Containers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to my generic containers patch. The major change is
support for multiple hierarchies of containers (up to a limit
specified at build time).

- The mount options passed when mounting a container filesystem
  indicate the set of controllers/subsystems that are wanted in the
  hierarchy - e.g. "mount -t container -o cpuset,numtasks container /foo"

- Default is to try to mount all subsystems

- if a hierarchy with the requested set of subsystems already exists
  then its superblock is reused

- otherwise (as long as all the requested subsystems are currently not
  in use in any hierarchy) a new hierarchy is created.

- hierarchies with more than one container (i.e. with any children of
  the root container) persist even when unmounted;

- /proc/containers shows current hierarchy/subsystem details

- /proc/<pid>/container shows one line for each active hierarchy

Other changes include:

- ported to 2.6.19-rc5 

- per-subsystem/per-container state is no longer just a void * - it
  has some state maintained by the container framework (to handle
  moving subsystems in and out of hierarchies when they are created/released)

Note that this hasn't yet undergone intensive testing following the
multi-hierarchy introduction, but I wanted to get the basic idea out
for comments.

TODOs include:

- figuring out a nice way to handle release notifications now that
  there are multiple hierarchies

-------------------------------------

There have recently been various proposals floating around for
resource management/accounting subsystems in the kernel, including
Res Groups, User BeanCounters and others.  These all need the basic
abstraction of being able to group together multiple processes in an
aggregate, in order to track/limit the resources permitted to those
processes, and all implement this grouping in different ways.

Already existing in the kernel is the cpuset subsystem; this has a
process grouping mechanism that is mature, tested, and well documented
(particularly with regards to synchronization rules).

This patchset extracts the process grouping code from cpusets into a
generic container system, and makes the cpusets code a client of
the container system.

It also provides a very simple additional container subsystem to do
per-container CPU usage accounting; this is primarily to demonstrate
use of the container subsystem API, but is useful in its own right.

The change is implemented in five stages plus an additional example patch:

1) extract the process grouping code from cpusets into a standalone system

2) remove the process grouping code from cpusets and hook into the
   container system

3) convert the container system to present a generic multi-hierarchy
   API, and make cpusets a client of that API

4) add a simple CPU accounting container subsystem as an example

5) add support for fork/exit callbacks iff some subsystem is interested in them

6) example of implementing ResGroups and its numtasks controller over
   generic containers - not intended to be applied with this patch set

The intention is that the various resource management efforts can also
become container clients, with the result that:

- the userspace APIs are (somewhat) normalised

- it's easier to test out e.g. the ResGroups CPU controller in
 conjunction with the UBC memory controller

- the additional kernel footprint of any of the competing resource
 management systems is substantially reduced, since it doesn't need
 to provide process grouping/containment, hence improving their
 chances of getting into the kernel


Signed-off-by: Paul Menage <menage@google.com>
--
