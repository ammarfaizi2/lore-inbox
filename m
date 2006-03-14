Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWCNAkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWCNAkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWCNAkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:40:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17330 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751772AbWCNAkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:40:42 -0500
Subject: [Patch 0/9] Per-task delay accounting
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142296834.5858.3.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:40:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next iteration of the delay accounting patches
last posted at
	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html

The major changes to the patches (and names of commenters whose concerns
have been addressed) are:

- considerable revision of the synchronous block I/O delay collection (Arjan)
Now most delays seen in I/O submission are not being collected.
- removal of dependency on schedstats by using common code (Nick) 
- removal of sysctl or dynamic configurability of delay accounting (Arjan)
Now it it can be set on/off at boot time only.
- providing I/O delays through /proc/<tgid>/stats (Andi)
- revisions to the generic netlink interface (Jamal)

Unaddressed comments are suggestions from Jamal on 
further improving the generic netlink interface which is ongoing.

Series 

nstimestamp-diff.patch
delayacct-setup.patch
delayacct-blkio-init.patch
delayacct-blkio-collect.patch
delayacct-swapin.patch
delayacct-procfs.patch
delayacct-schedstats.patch
genetlink-utils.patch
delayacct-genetlink.patch


A short note on expected usage of this functionality follows which
addresses a comment from Nick in the previous iteration.
Basically, the patches measures a subset of the delays encountered 
by a task waiting for a resource such as cpu, disk I/O and page 
frames. Which subset is chosen depends on whether a task's delay 
is something that can be controlled by playing with its priority 
or rss limit etc.
e.g. cpu delays can directly be affected by its static CPU priority.
Similarly I/O delay can be affected by its I/O priority (assuming 
one uses the right iosched). In page frame delay, we only count 
the page faults due to swapin since that is directly affected by 
the rss limits for a task (well, ok, process). 

Delays can be used as feedback to decide whether something can/should
be done about a task (or group of tasks) which is not performing 
as one expects. 

http://www.research.ibm.com/journal/sj/362/amanaut.html
lists a fairly complicated way of using such data in 
workload management.

At a simpler level, one can think of utilities that can use this data
to control individual apps using a simple feedback loop.
At this point we do not have such a utility. 

Of course, its useful to visually inspect such data. Some of it is 
being exported through /proc as suggested by Andi, but the primary 
interface is through a netlink socket so that userspace can get 
data for exiting tasks too. 

The netlink socket also allows userspace apps to efficiently 
collect  delay data and group it in arbitrary ways 
(as envisaged by CKRM, CSA or ELSA) for reporting or 
control purposes. 


--Shailabh

