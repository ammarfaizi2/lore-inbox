Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSJUSHx>; Mon, 21 Oct 2002 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJUSHx>; Mon, 21 Oct 2002 14:07:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33246 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261446AbSJUSHw>; Mon, 21 Oct 2002 14:07:52 -0400
Message-ID: <3DB44343.701B7EFD@us.ibm.com>
Date: Mon, 21 Oct 2002 11:11:15 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [PATCH]IPC locks breaking down with RCU
References: <Pine.LNX.4.44.0210201809490.2106-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> The "if(lid >= ids->size) return;" still looks unnecessary,
> but I think I see why you have "if (out)" in ipc_unlock: because
> of ipc_rmid, which has already nulled out entries[lid].p, yes?
>

Thanks a lot for your comments.  Yes.  That's the consideration.

> A minor point is, wouldn't that skipping of spin_unlock leave you
> with the wrong preempt count, on a CONFIG_PREEMPT y configuration?
> But that's easily dealt with.
> 
> A much more serious point: we could certainly bring the ipc_rmid
> and ipc_unlock much closer together; but however close we bring them
> (unlock implicit within rmid), there will still be a race with one
> cpu in ipc_lock spinning on out->lock, while we in ipc_rmid null
> entries[lid].p and unlock and free the structure containing that lock.
>

Thanks for pointing this out.  This is a issue that has to be addressed. 

A simple solution I could think of for this problem, moving the per_id
lock out of the kern_ipc_perm structure, and put it in the ipc_id
structure. Actually I did this way at the first time,  then I agreed
with you that moving the per_id lock into there kern_ipc_perm structure
will help reduce cacheline bouncing.  

I think that having the per_id lock stay out of the structure it
protects will easy the job of ipc_rmid(), also will avoid the wrong
preempt count problem caused by the additional check "if (out)" in
ipc_unlock() as you mentioned above.

Is this solution looks good to you? If so, I will update the patch for
2.5.44 soon.


Mingming
