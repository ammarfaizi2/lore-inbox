Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWD1QUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWD1QUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWD1QUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:20:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35555 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030480AbWD1QUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:20:00 -0400
Date: Fri, 28 Apr 2006 21:47:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Fix file lookup without ref
Message-ID: <20060428161755.GA2309@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200604232315.k3NNFIC4017623@murzim.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604232315.k3NNFIC4017623@murzim.cs.pdx.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzanne,

Sorry about the late reply, I have been offline for a while.

On Sun, Apr 23, 2006 at 04:15:18PM -0700, Suzanne Wood wrote:
> Do you mind explaining what you mean by "don't hold a reference"
> in the places you replace rcu_read_lock() with spin_lock() in
> settings with nested fcheck_files() or files_fdtable() which 
> in turn call rcu_dereference()?  How, for example, are the 

Well, we use different methods of reference counting with
RCU based objects and fd table is one of those. With the
fd table, when you look up a file without holding
the fd table spinlock, the file structure you get may
be getting torn down on another CPU. We can safely
do this only if we *successfully* increment the reference
count of the file structure using atomic_inc_not_zero()
primitive which is based on cmpxchg. If atomic_inc_not_zero()
fails, we assume that the reference count of the file
structure had become zero and is getting destroyed.
If atomic_inc_not_zero() was successful, then we
"hold" a reference to the file structure and it is
safe to access it.

> occurences in proc_readfd() and tid_fd_revalidate() in 
> fs/proc/base.c different?  tid_fid_revalidate() doesn't make
> a local assignment and has the FASTCALL put_files_struct, but
> is there reasoning that proc_readfd() isn't similar to steal_locks()
> in fs/locks.c?

In both proc_readfd() and tid_fd_revalidate(), we don't access
the file structure itself in the lock-free section. We just
check if the file exists or not in the fd table. Worst case,
we may see state data in /proc.

Thanks
Dipankar
