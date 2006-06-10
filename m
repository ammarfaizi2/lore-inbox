Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWFJIKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWFJIKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWFJIKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:10:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35270 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030369AbWFJIKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:10:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605144328.GA12904@sergelap.austin.ibm.com>
	<m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
	<20060609232551.GA11240@sergelap.austin.ibm.com>
	<m1k67p6dz7.fsf@ebiederm.dsl.xmission.com>
	<20060610012314.GA2378@sergelap.austin.ibm.com>
Date: Sat, 10 Jun 2006 02:09:53 -0600
In-Reply-To: <20060610012314.GA2378@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 9 Jun 2006 20:23:14 -0500")
Message-ID: <m1u06t4ejy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Oh, you mean instead of doing kill_proc(struct pid->nr), which
> I guess was pretty braindead?  :)

For a single process we should be able to do:
struct pid *pid = ( some value ... )
struct task_struct *task;
rcu_read_lock();
task = pid_task(pid);
if (task)
	group_send_sig_info(sig, info, task);
rcu_read_unlock();

If it comes up very often that looks like an idiom
that would appreciate a helper function.

For process groups we must get a read_lock on the task_list_lock
because otherwise the atomicity guarantees of sending a signal
to a process group are broken.

Eric
