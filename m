Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJUSxR>; Mon, 21 Oct 2002 14:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJUSxQ>; Mon, 21 Oct 2002 14:53:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12386 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261518AbSJUSxN>; Mon, 21 Oct 2002 14:53:13 -0400
Date: Mon, 21 Oct 2002 20:00:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: mingming cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>
Subject: Re: [PATCH]IPC locks breaking down with RCU
In-Reply-To: <3DB44343.701B7EFD@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, mingming cao wrote:
> Hugh Dickins wrote:
> > A much more serious point: we could certainly bring the ipc_rmid
> > and ipc_unlock much closer together; but however close we bring them
> > (unlock implicit within rmid), there will still be a race with one
> > cpu in ipc_lock spinning on out->lock, while we in ipc_rmid null
> > entries[lid].p and unlock and free the structure containing that lock.
> 
> A simple solution I could think of for this problem, moving the per_id
> lock out of the kern_ipc_perm structure, and put it in the ipc_id
> structure. Actually I did this way at the first time,  then I agreed
> with you that moving the per_id lock into there kern_ipc_perm structure
> will help reduce cacheline bouncing.  
> 
> I think that having the per_id lock stay out of the structure it
> protects will easy the job of ipc_rmid(), also will avoid the wrong
> preempt count problem caused by the additional check "if (out)" in
> ipc_unlock() as you mentioned above.
> 
> Is this solution looks good to you? If so, I will update the patch for
> 2.5.44 soon.

Sorry, no, doesn't look good to me.  I do agree that it's an easy
solution to this problem, but there's no point in having gone the RCU
route to avoid cacheline bouncing, if you now reintroduce it all here.

I believe, as I said, that you'll have to go further, applying RCU
to freeing the entries themselves.  I had toyed with the idea of never
freeing entries once allocated, which is a similarly simple solution;
rejected that as in general too wasteful; and concluded that RCU is a
reasonable compromise - it amounts to lazy freeing, I think.

I'm happy to be overruled by someone who understands these cacheline
bounce issues better than we do, but nobody else has spoken up yet.

Hugh

