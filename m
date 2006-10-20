Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992870AbWJTTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992870AbWJTTIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992868AbWJTTIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:08:31 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64016 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S2992864AbWJTTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:08:23 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:user-agent:date:from:to:cc:subject;
	b=teM5jx2Tnrg7nfyef9+ka+Ii2z2NZ8Jw1RKs2uH2jJ6mxr+VzoyOuLR4lWl/wRAZq
	dAVqPpNuEZiMr6rczZy2A==
Message-Id: <20061020183819.656586000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Fri, 20 Oct 2006 11:38:19 -0700
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       jlan@sgi.com, mbligh@google.com, rohitseth@google.com,
       winget@google.com, Simon.Derr@bull.net
Subject: [PATCH 0/6] Generic Process Containers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

This is an update to my generic containers patch, with the following changes:

- ported to 2.6.19-rc2
- CONFIG_CPUSETS_LEGACY_API option maintains the existing cpusets userspace API
- support for fork/exit callbacks

Patch 6 contains a port of the interesting bits of ResGroups to run
over generic containers, along with the example ResGroups numtasks
patch. It's not intended to be actually applied with this patch set,
but is an example of how other in-kernel systems might use generic
containers.

(This time built with multiple compilers and architectures)

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

The change is implemented in five stages:

1) extract the process grouping code from cpusets into a standalone system

2) remove the process grouping code from cpusets and hook into the
 container system

3) convert the container system to present a generic API, and make
 cpusets a client of that API

4) add a simple CPU accounting container subsystem as an example

5) add support for fork/exit callbacks iff some subsystem is interested in them

The intention is that the various resource management efforts can also
become container clients, with the result that:

- the userspace APIs are (somewhat) normalised

- it's easier to test out e.g. the ResGroups CPU controller in
 conjunction with the UBC memory controller

- the additional kernel footprint of any of the competing resource
 management systems is substantially reduced, since it doesn't need
 to provide process grouping/containment, hence improving their
 chances of getting into the kernel

Possible TODOs include:

- define a convention for populating the per-container directories so
 that different subsystems don't clash with one another

- provide higher-level primitives (e.g. an easy interface to seq_file)
 for files registered by subsystems, or potentially convert to use configfs

Signed-off-by: Paul Menage <menage@google.com>

--
