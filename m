Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVKOJG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVKOJG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVKOJGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:06:55 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57063 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751407AbVKOJGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:06:54 -0500
Date: Tue, 15 Nov 2005 01:06:24 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115010624.2ca9237d.pj@sgi.com>
In-Reply-To: <20051115081100.GA2488@IBM-BWN8ZTBWAO1>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	<20051114223513.3145db39.pj@sgi.com>
	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But in the end isn't that more complicated than our approach?  The
> kernel still needs to be modified to let processes request their pids,

No - getpid() works, as always.  Perhaps I don't understand your
comment.


> and now processes have to worry *always* about the value or range of
> their pids, both at startup and restart. 

No - tasks get the pid the kernel gives them at fork, as always.
The task keeps that exact same pid, across all checkpoints, restarts
and migrations.  Nothing that the application process has to worry
about, either inside the kernel code or in userspace, beyond the fork
code honoring the assigned pid range when allocating a new pid.

No wide spread kernel code change, compared to yours.  As now, tasks
have a pid field, and that pid is the same value, system-wide.

An additional per-task attribute, set by a batch manager typically
when it starts a job on a checkpointable, restartable, movable
"virtual server" connects the job parent task, and hence all its
descendents in that job, with a named kernel object that has among its
attributes a pid range.  When fork is handing out new pids, it honors
that pid range.  User level code, in the batch manager or system
administration layer manages a set of these named virtual servers,
including assigning pid ranges to them, and puts what is usually the
same such configuration on each server in the farm.

There will likely be other system-wide or job-wide name spaces and
associated resources that will need to be preserved across these
operations, such as shared memory, ipc, sockets, tmp files, signals,
locking, shared file descriptors, process tree, permissions, ulimits,
accounting, ...  For each system-wide namespace, give each virtual
server a dedicated portion of that space, the same across all servers
in the farm.  Where those names are kernel assigned, such as pids,
teach the kernel to assign within the specified portion, such as the
assigned pid range.

The real complexity comes, I claim, from changing the pid from a
system-wide name space to a partially per-job namespace.  You can
never do that conversion entirely and will always have confusions
around the edges, as pids relative to one virtual server are used,
incorrectly, in the environment of another virtual server or system
wide.

The difficulty of things is best not measured by the effort to
do the first 90%, but by the effort to do the last 10%.  And when
trying to reconcile two irreconcilable concepts, that last 10% can
never be completed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
