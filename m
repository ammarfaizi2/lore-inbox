Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUKOVGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUKOVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbUKOVGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:06:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22924 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261714AbUKOVDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:03:54 -0500
Date: Mon, 15 Nov 2004 15:03:43 -0600
From: Dean Nelson <dcn@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041115210343.GA32520@sgi.com>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <Pine.LNX.4.53.0411152139580.19849@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411152139580.19849@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 09:41:00PM +0100, Jan Engelhardt wrote:
> >> * Dean Nelson (dcn@sgi.com) wrote:
> >> > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> >>
> >> this should be static.
> >
> >You're right. I made another change in that one now passes the task_struct
> >pointer to sched_setscheduler() instead of the pid. This requires that
> >the caller of sched_setscheduler() hold the tasklist_lock. The new patch
> >for people's feedback follows.
> 
> Hi,
> 
> can you elaborate a little why passing the task struct/pid is better/worse,
> respectively?

The idea of passing the task_struct was to avoid the potential cost
of having to search for the task again if one was working with the
task_struct already. We saw in a particular benchmark that had thousands
of processes and a kernel module that called find_process_by_pid() for
each of them as it performed its services on their behalf, that the
cost was quite high. I believe the benchmark was sped up some 16x by
eliminating the need to map a pid to a task structure (i.e., a
task_struct pointers were saved with the pid in this module's
internal tables).

In my particular case (XPC module) this is not an issue because I'm
dealing with the current task, so if I were to pass 0 for the pid,
find_process_by_pid() would return immediately with the current
task_struct pointer.

With passing the task_struct pointer the caller has to be holding
the tasklist_lock, which may be it's main detraction. If one only
has the pid, they can call find_task_by_pid_type() themselves,
since it is an exported symbol.

I'm quite open to go with whatever the community prefers on this
issue.

Thanks,
Dean
