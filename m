Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSJUUER>; Mon, 21 Oct 2002 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSJUUEQ>; Mon, 21 Oct 2002 16:04:16 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:62172 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261606AbSJUUEO>;
	Mon, 21 Oct 2002 16:04:14 -0400
Date: Tue, 22 Oct 2002 01:44:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: mingming cao <cmm@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPC locks breaking down with RCU
Message-ID: <20021022014451.A11502@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.44.0210201809490.2106-100000@localhost.localdomain> <3DB44343.701B7EFD@us.ibm.com> <20021022004806.A10573@in.ibm.com> <3DB45886.3DDE1CC8@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB45886.3DDE1CC8@us.ibm.com>; from cmm@us.ibm.com on Mon, Oct 21, 2002 at 12:41:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 12:41:58PM -0700, mingming cao wrote:
> > I took a quick look at the original ipc code and I don't understand
> > something - it seems to me the ipc_ids structs are protected by the semaphore
> > inside for all operations, so why do we need the spinlock in the
> > first place ? Am I missing something here ?
> 
> The semaphore is used to protect the fields in ipc_ids structure, while
> the spinlock is used to protect IPC ids. For the current implementation,
> there is one spinlock for all IPC ids of the same type(i.e. for all
> messages queues).  The patch is intend to breaks down the global

Well, if the semaphore is grabbed then the critical section is serialized
including accessing of IPC ids, so there would be no need to have
a separate spinlock for the IPC ids. Hugh pointed out the right reason,
semaphore IPCs use the spinlock for serialization in many paths,
not the semaphore in ipc_ids. 

Hugh's point is right - you have two data structures to protect - ipc_id
arrays and the kern_ipc_perms attached to it. I would use a single
spinlock in ipc_ids to serialize all the updates and use RCU for both
to implement safe lockfree lookups. For the second, you would probably
want to add a rcu_head to struct kern_ipc_perms and an RCU callback
to free it.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
