Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVKYWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVKYWaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVKYWaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:30:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39305 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751491AbVKYWaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:30:06 -0500
Date: Fri, 25 Nov 2005 14:29:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: guillaume.thouvenin@bull.net, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com
Subject: Re: [BUG linux-2.6.15-rc] process events connector - soft lockup
 detected
Message-Id: <20051125142952.02d63801.pj@sgi.com>
In-Reply-To: <20051125115725.3ff23590.akpm@osdl.org>
References: <20051125144226.37778246@frecb000711.frec.bull.fr>
	<20051125114741.6549ef3a.akpm@osdl.org>
	<20051125115725.3ff23590.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I note that copy_process() also calls cpuset_fork() under
> write_lock_irq(&tasklist_lock) which is a) inefficient and b) forbidden
> according to the nice comment over task_lock().

Nice catch - thanks.  It was (perhaps) only inefficient until recently, because
cpuset_fork() didn't do any locking - just an atomic cpuset counter increment.

But with the locking overhaul that went into Linus's tree Oct 31, 2005,
cpuset_fork() now takes task_lock(), to guard against cpuset.c attach_task()
invalidating the task->cpuset pointer as cpuset_fork is dereferencing it.

I will look into preparing a patch that moves cpuset_fork() outside the
write_lock_irq().

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
