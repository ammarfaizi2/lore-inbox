Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWJBKir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWJBKir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWJBKir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:38:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:24784 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWJBKiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:38:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:user-agent:date:from:to:cc:subject:sender;
	b=LmTuHUf8pqZhWoQ57kSByiDRShuQb/7/L1aM4tTlP4LIa68oa8zGEZcXG2XAETVSQ
	7Wj5r86u/WG9+cFzHT6gw==
Message-Id: <20061002095319.865614000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Mon, 02 Oct 2006 02:53:19 -0700
From: Paul Menage <menage@google.com>
To: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, sekharan@us.ibm.com, jlan@sgi.com
Subject: [RFC][PATCH 0/4] Generic container system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is essentially the same as the patch set that I posted last week,
with the following fixes/changes:

- CONFIG_CONTAINERS is no longer a user-selectable option - subsystems
  such as cpusets that require it should select it in Kconfig.

- Each container subsystem type now has a name, and a <name>_enabled
  file in the top container directory. This file contains 0 or 1 to
  indicate whether the container subsystem is enabled, and can only be
  modified when there are no subcontainers; disabled container subsystems
  don't get new instances created when a subcontainer is created; the
  subsystem-specific state is simply inherited from the parent
  container.

- include a config option to default to enabled, for backwards
  compatibility

- Documentation tweaks

- builds properly without CONFIG_CONTAINER_CPUACCT configured on

- should build properly with newer gccs. (I've not actually had a
  chance to try building it with anything newer than gcc 3.2.2, but I've
  fixed all the potential warnings/errors that PaulJ pointed out when
  compiling with some unspecified newer gcc).

I've also looked at converting ResGroups to be a client of the
container system. This isn't yet complete; my thoughts so far include:

- each resource controller can be implemented as an independent
  container subsystem; rather than a single "shares" and "stats" file
  in each directory there will be e.g. "numtasks_shares",
  "cpurc_shares", etc

- the ResGroups core will basically end up as a library that provides
  the common parsing/displaying for the shares and stats file for each
  controller, and the logic for propagating resources up and down the
  parent/child tree.

- for some of the resource controllers we will probably require a few
  extra callbacks from the container system, e.g. at fork/exit time.
  I might make these a config option that the controller must "select"
  in Kconfig, to avoid extra locking/overhead for subsystems such as
  cpusets that don't require such callbacks.

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

The change is implemented in four stages:

1) extract the process grouping code from cpusets into a standalone system

2) remove the process grouping code from cpusets and hook into the
  container system

3) convert the container system to present a generic API, and make
  cpusets a client of that API

4) add a simple CPU accounting container subsystem as an example

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
 for files registered by subsystems.

- support subsystem deregistering

Signed-off-by: Paul Menage <menage@google.com>

---
