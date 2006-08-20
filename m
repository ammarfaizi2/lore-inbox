Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWHTRkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWHTRkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWHTRkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:40:55 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46979 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751024AbWHTRky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:40:54 -0400
Date: Sun, 20 Aug 2006 23:10:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH 0/7] CPU controller - V1
Message-ID: <20060820174015.GA13917@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an attempt to provide some minimal CPU controller for resource
management purpose. Although we have seen several proposals for one before, 
none has gained acceptance yet.  For ex: http://lkml.org/lkml/2006/8/4/137 
summarizes the feedback received against the last CPU controller posted by 
Fujitsu folks.

This is V1 of the patch posted at http://lkml.org/lkml/2006/8/4/6
and has been tested against 2.6.18-rc3.

Change since last version:

	- Basic task-group aware SMP load balancing, based on SMP nice
	  mechanism

Still on my todo list:

	- Cleanup so that !CONFIG_CPUMETER has zero impact
	- Better timeslice management, so that bursty workloads
	  can be handled well. I have some ideas (for ex: don't
	  switch active/expired arrays as soon as active 
	  array becomes empty) which I would like to experiment
	  with a bit before sending a patch for this
	- Better SMP load balancing. I feel that some feedback
	  about how much bandwidth a task-group is actually 
	  getting (compared to its quota) can be included in
	  runqueue pressure calculations.

Salient design points of this patch:

	- Each task-group gets its own runqueue on every cpu.

	- In addition, there is an active and expired array of
	  task-groups themselves. Task-groups who have expired their
	  quota are put into expired array.

	- Task-groups have priorities. Priority of a task-group is the
	  same as the priority of the highest-priority runnable task it
	  has. This I feel will retain interactiveness of the system
	  as it is today.

	- Scheduling the next task involves picking highest priority task-group 
	  from active array first and then picking highest-priority task 
	  within it. Both steps are O(1).

	- Token are assigned to task-groups based on their assigned
	  quota. Once they run out of tokens, the task-group is put
	  in an expired array. Array switch happens when active array
	  is empty.

	- SMP load-balancing is accomplished on the lines of smpnice.

	- Although the algorithm is very simple, it perhaps needs more 
	  refinement to handle different cases. Especially I
	  feel task-groups which are idle most of the time and 
	  experience bursts once in a while will need to be handled 
	  better than this simple scheme.

Ingo/Nick,
	Would request your inputs as before.


-- 
Regards,
vatsa
