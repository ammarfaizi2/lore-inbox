Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbTCIGE0>; Sun, 9 Mar 2003 01:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTCIGE0>; Sun, 9 Mar 2003 01:04:26 -0500
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:42507 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S262426AbTCIGEZ>;
	Sun, 9 Mar 2003 01:04:25 -0500
Date: Sun, 9 Mar 2003 01:12:13 -0500
Message-Id: <200303090612.h296CDV02987@moisil.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: uweigand@de.ibm.com, schwidefsky@de.ibm.com, bk@suse.de,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Race in rpc_delete_timer causes crash
In-Reply-To: <200303082303.AAA22598@faui11.informatik.uni-erlangen.de>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003 00:03:45 +0100 (MET), Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de> wrote:
> Hello,
> 
> we're seeing a rare and hard to trigger crash on s390 where rpc_run_timer 
> calls via an invalid callback pointer.

Myself and Jakob Oestergaard have seen the same race, and the tentative 
fix from Trond was similar to yours. I haven't been able to reproduce 
the problem after applying that fix.

Perhaps it's time to propagate the patch upstream? Most recent 2.4.x 
kernels are affected...

> What appears to happen is that rpc_call_sync allocates a struct rpc_task 
> (with its embedded tk_timer) on the stack, and the timer gets set up 
> sometime during rpc_execute.  However, the timer actually triggers at
> a point in time where the original call to rpc_call_sync has already 
> returned, and the stack space overwritten by other data.  That data is 
> now interpreted as an rpc_task struct holding a tk_timeout_fn pointer by
> rpc_run_timer, which causes the Oops (actually, Aieee).

Yup, that's the race all right.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
