Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSJ1WKx>; Mon, 28 Oct 2002 17:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJ1WJ0>; Mon, 28 Oct 2002 17:09:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:37010 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261573AbSJ1WJH>;
	Mon, 28 Oct 2002 17:09:07 -0500
Message-ID: <3DBDB51B.84F97EC1@us.ibm.com>
Date: Mon, 28 Oct 2002 14:07:23 -0800
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@gamebox.net, Rusty Russell <rusty@rustcorp.com.au>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210270748560.1704-100000@localhost.localdomain> <20021028010711.E659A2C085@lists.samba.org> <20021029013059.A13287@dikhow>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> On Mon, Oct 28, 2002 at 02:20:04AM +0100, Rusty Russell wrote:
> > Yes, nonsensical.  Firstly, it's in violation of the standard to fail
> > IPC_RMID under random circumstances.  Secondly, failing to clean up is
> > an unhandlable error, since you're quite possible in the failure path
> > of the code already.  This is a well known issue.
> 
> I am not sure how Ming/Hugh's current IPC changes affect IPC_RMID.
> It affects only when you are trying to add a new ipc. In fact,
> since it is a *add* operation (grow_ary()), it seems ok to fail it if rcu_head
> allocation fails. Feel free to correct me if I missed something here.
> AFAICS, the rcu stuff doesn't affect any freeing other than the IPC
> id array.
>

We extended the usage of RCU to IPC_RMID, to prevent ipc_lock()
returning an invalid IPC ID which has been removed by ioc_rmid.
 
> > It's a hacky, fragile and incorrect solution.  It's completely
> > tasteless.
> 
> Yes, the mempool code is broken, but only because rcu_backup_pool
> is created three times, one by each IPC mechanism init :-)
>

That's my bad, thanks for pointing this out. It's easy to fix if we
decide to go with mempool way.
 
> > Patch below is against Mingming's mm4 release.  Compiles, untested.
> > Rusty.
> 
> Yes, this is the typical RCU model, except that in this case (IPC),
> I am not quite sure if it is in effect that different from what Ming/Hugh
> have done.

Rusty's patch looks good to me. I would like to replace the mempool in
IPC with this typical RCU model. Rusty, if you like, I will make a patch
against mm6.  There need some cleanups. One thing is that ipc_alloc()
are called by other places(besides grow_ary()), and they don't need to
the RCU header structure. 

Mingming
