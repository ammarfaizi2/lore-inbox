Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933635AbWKWMfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635AbWKWMfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933634AbWKWMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:35:37 -0500
Received: from smtp-out.google.com ([216.239.45.12]:19242 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S933633AbWKWMff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:35:35 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:user-agent:date:from:to:cc:subject;
	b=cjAclPPtR0pV+t096w3L0t5v182qFkhljorqt8WZmnRdvZryA9wjI9fXSNNgR092P
	pPICt/WumUokWhInyaaZg==
Message-Id: <20061123120848.051048000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Thu, 23 Nov 2006 04:08:48 -0800
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
Subject: [PATCH 0/7] Generic Process Containers (+ ResGroups/BeanCounters)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update to my multi-hierarchy generic containers patch (against
2.6.19-rc6). Changes include:

- an example patch implementing the BeanCounters core and numfiles
  counters over generic containers. The addition of the
  BeanCounters code unifies the three main process grouping
  abstractions (Cpusets, ResGroups and BeanCounters).

- a patch splitting Cpusets into two independently groupable
  subsystems, Cpusets and Memsets.

- support for a subsystem to keep a container alive via refcounts
  (e.g. the BeanCounters numfiles counter has a reference to the
  beancounter object from each file charged to that beancounter, so
  needs to be able to keep the beancounter alive until the file is
  destroyed)

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

It also provides several example clients of the container system,
including ResGroups and BeanCounters

The change is implemented in five stages plus two additional example patches:

1) extract the process grouping code from cpusets into a standalone system

2) remove the process grouping code from cpusets and hook into the
   container system

3) convert the container system to present a generic multi-hierarchy
   API, and make cpusets a client of that API

4) add a simple CPU accounting container subsystem as an example

5) example of implementing ResGroups and its numtasks controller over
   generic containers - not intended to be applied with this patch set

6) split cpusets into two subsystems, cpusets and memsets

7) example of implementing BeanCounters and its numfiles counter over
   generic containers - not intended to be applied with this patch set


The intention is that the various resource management efforts can also
become container clients, with the result that:

- the userspace APIs are (somewhat) normalised

- it's easier to test out e.g. the ResGroups CPU controller in
 conjunction with the BeanCounters memory controller

- the additional kernel footprint of any of the competing resource
 management systems is substantially reduced, since it doesn't need
 to provide process grouping/containment, hence improving their
 chances of getting into the kernel

Signed-off-by: Paul Menage <menage@google.com>

--
