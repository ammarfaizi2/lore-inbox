Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWI1LP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWI1LP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWI1LP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:15:57 -0400
Received: from smtp-out.google.com ([216.239.45.12]:28122 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161071AbWI1LP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:15:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:user-agent:date:from:to:cc:subject:sender;
	b=L8aWsJjAisOLakA//zTB84ZW6ypjEEeH52Ta7ZCsu20czg79koSpQwGqMIW9rnLkI
	PiRjjfGdxQnJBfu37nqhQ==
Message-Id: <20060928104035.840699000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 03:40:35 -0700
From: menage@google.com
To: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       mbligh@google.com, rohitseth@google.com, winget@google.com, dev@sw.ru,
       sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/4] Generic container system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

4) add a simple CPU accounting container subsystem

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
