Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWC3G12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWC3G12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWC3G12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:27:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751127AbWC3G11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:27:27 -0500
Date: Wed, 29 Mar 2006 22:26:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: nagar@watson.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       tgraf@suug.ch, hadi@cyberus.ca
Subject: Re: [Patch 5/8] generic netlink interface for delay accounting
Message-Id: <20060329222629.0a730997.akpm@osdl.org>
In-Reply-To: <20060330061005.GA18387@in.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2BB6.9020309@watson.ibm.com>
	<20060329210406.08d1c929.akpm@osdl.org>
	<20060330061005.GA18387@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> > The kmem_cache_free() can happen outside the lock.
> 
> 
> kmem_cache_free() and setting to NULL outside the lock is prone to
> race conditions. Consider the following scenario
> 
> A thread group T1 has exiting processes P1 and P2
> 
> P1 is exiting, finishes the delay accounting by calling taskstats_exit_pid()
> and gives up the mutex and calls kmem_cache_free(), but before it can set
> tsk->delays to NULL, we try to get statistics for the entire thread group.
> This task will show up in the thread group with a dangling tsk->delays.

Yes, the `tsk->delays = NULL;' needs to happen inside the lock.  But the
kmem_cache_free() does not.  It pointlessly increases the lock hold time.

> > > +	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
> > > +		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> > > +		rc = fill_pid((pid_t)pid, NULL, &stats);
> > 
> > We shouldn't have a typecast here.  If it generates a warning then we need
> > to get in there and find out why.
> 
> The reason for a typecast is that pid is passed as a u32 from userspace.
> genetlink currently supports most unsigned types with little or no
> support for signed types. We exchange data as u32 and do the correct
> thing in the kernel. Would you like us to move away from this?
> 

I think it's best to avoid the cast unless it's actually needed to avoid a
warning or compile error, or to do special things with sign extension. 
Because casts clutter up the code and can hide real bugs.  In this case the
compiler should silently perform the conversion.

