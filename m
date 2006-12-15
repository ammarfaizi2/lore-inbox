Return-Path: <linux-kernel-owner+w=401wt.eu-S964869AbWLOUz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWLOUz3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWLOUz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:55:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:50989 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964866AbWLOUz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:55:27 -0500
Message-ID: <45830BBC.2030608@us.ibm.com>
Date: Fri, 15 Dec 2006 12:55:24 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>, Malahal Naineni <malahal@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: [PATCHSET] Various libsas/aic94xx stability and EH fixes
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It has been a while since I posted the last batch of patches against
libsas and aic94xx.  In that time, we've been working with Adaptec
engineers to stabilize the driver under disk stress workloads and reboot
tests, and these patches represent the results of this work and a few
other cleanups that have been made along the way.  Each patch has its
own preamble description, but I'd like to call attention to two of the
larger shifts.

Adaptec's sequencer engineers pointed out that a few of the assumptions
that I made about SCB return were invalid, which forced me to rewrite
much of the REQ_TASK_ABORT and REQ_DEVICE RESET code to move all of the
ABORT TASK code into the SAS EH.  By concentrating all error handling in
the EH, the REQ_TASK_ABORT case is less efficient, but the race
conditions and other strange nits that I'd been seeing went away.  In
particular, libsas now handles the case where a sas_task causes the
controller to send both a REQ_TASK_ABORT ESCB and a CHECK CONDITION SCB
response.

The second major set of changes (15-17) fix the insmod/rmmod and pounder
stability problems by performing correct device memory initialization
and locking device descriptor updates to avoid corrupting the controller
memory.

These patches should apply in number order cleanly against 2.6.19 +
scsi_misc.  At the moment 2.6.20-rc isn't stable enough to boot cleanly
on any of our machines, but we've been running insmod/rmmod and pounder
tests on x260, x206m and x366 machines for several days without problems.

One can pick up the patches at the URL below.

http://sweaglesw.net/~djwong/docs/libsas-patches/

A rough breakdown of the patches follows.

EH improvements:
09-aic94xx-dont-eat-query-task-results_1.patch
10-libsas-remove-initiator-aborted_1.patch
11-libsas-add-dev-reset-to-eh_1.patch
12-libsas-abort-sas-task-deferral_1.patch
13-aic94xx-defer-task-abort_1.patch
21-alexisb-aic94xx-abort-task-failed-fallthrough.patch

Stability/leak/locking fixes:
15-aic94xx-fix-fw-leak_1.patch
16-aic94xx-fix-ddb-scb-init_2.patch
17-aic94xx-lock-ddb-access_2.patch
19-andmike-lockdep-fix.patch
20-malahal-discovery-race.patch

Stuff from last time:
01-libsas-discovery-failure_6.patch
02-libsas-discovery-failure-expander_6.patch
03-aic94xx-abort-task-race_2.patch
04-libsas-enable-phy_2.patch
05-libsas-taskless-cmnd-reset-timer_2.patch

Enable the SAS task collector code (it's not that useful):
06-libsas-kill-task-collector-after-ports_1.patch
07-aic94xx-set-max-execute-num_1.patch

Re-enable the SMP portal interface as a stopgap until something better
replaces it (Doug Gilbert may be the only person who cares to have this?):
14-libsas-smp-portal_1.patch

Code cleanups:
08-libsas-use-scan-wildcard_1.patch
18-libsas-phy-sysfs-ctrl-not-iwugo_1.patch

The SAS ATA patches will follow in a separate email.  I appreciate any
feedback/comments/flames people have about this patch set.  Thanks!

--D
