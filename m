Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVANPfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVANPfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVANPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:35:32 -0500
Received: from fsmlabs.com ([168.103.115.128]:24746 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262010AbVANPfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:35:25 -0500
Date: Fri, 14 Jan 2005 08:35:08 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Karim Yaghmour <karim@opersys.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501140819521.4941@montezuma.fsmlabs.com>
References: <20050114002352.5a038710.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Andrew Morton wrote:

> - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>   haven't yet taken as close a look at LTT as I should have.  Probably neither
>   have you.

Just a few things from a quick look;

- What's with all the ltt_*_bit? Please use the ones provided by the 
kernel.

- i see cpu_has_tsc, can't you use sched_clock?

- ltt_log_event isn't preempt safe

- num_cpus isn't hotplug cpu safe, and you should be using the 
for_each_online_cpu iterators

- code style, you have large hunks of code with blocks of the following 
form, you can save processor cycles by placing an if (incoming_process) 
branch earlier. This code is in _ltt_log_event, which i presume executes 
frequently.

if (event_id == LTT_EV_SCHEDCHANGE)
	incoming_process = (struct task_struct *) ((ltt_schedchange *) event_struct)->in);

if ((trace->tracing_gid == 1) && (current->egid != trace->traced_gid)) {
	if (incoming_process == NULL)
		return 0;
	else if (incoming_process->egid != trace->traced_gid)
		return 0;
}
... [ more of the same ]
if ((trace->tracing_uid == 1) && (current->euid != trace->traced_uid)) {
	if (incoming_process == NULL)
		return 0;
	else if (incoming_process->euid != trace->traced_uid)
		return 0;
}
