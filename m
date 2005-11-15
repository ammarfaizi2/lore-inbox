Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKODam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKODam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVKODal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:30:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:2710 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932346AbVKODal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:30:41 -0500
Message-ID: <4379658E.1020707@watson.ibm.com>
Date: Mon, 14 Nov 2005 23:35:26 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][Patch 0/4] Per-task delay accounting
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a set of patches that adds per-task delay accounting to
Linux. In this context, delays is the time spent by a task
waiting for some resource to become available. Currently the patches
record (or make available) the following delays:

CPU delay: time spent on runqueue waiting for a CPU to run on
Block I/O delay: waiting for block I/O to complete (including any
		wait for queueing the request)
Page fault delay: waiting for page faults (major & minor) to get
		completed


Having this information allows one to adjust the priorities (cpu, io)
and rss limits of a task. e.g. if task A is spending too much time
waiting for block I/O to complete compared to task B, bumping up
A's I/O priority relative to that of B might help.This isn't particularly
useful if one always want A to get more I/O bandwidth than B. But if one
is interested in dynamically adjusting priorities, delay statistics
complete the feedback loop.

The statistics are collected by simple timestamping and recording of
intervals in the task_struct. The cpu stats are already being collected
by the schedstats so no additional code is needed in the hot path of a
context switch.

They are made available through a connector interface which allows
- stats for a given <pid> to be obtained in response to a command
which specifies the <pid>. The need for dynamically obtaining delay
stats is the reason why piggybacking delay stats onto BSD process
accounting wasn't considered.
- stats for exiting tasks to be sent to userspace listeners. This can
be useful for collecting statistics by any kind of grouping done by
the userspace agent. Such groupings (banks/process aggregates/classes)
have been proposed by different projects.

Comments on the patches are requested.

--Shailabh


Series

delayacct-init.patch
delayacct-blkio.patch
delayacct-pgflt.patch
delayacct-connector.patch


