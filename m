Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGUNaC>; Sun, 21 Jul 2002 09:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGUNaB>; Sun, 21 Jul 2002 09:30:01 -0400
Received: from tomts19.bellnexxia.net ([209.226.175.73]:35279 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S315413AbSGUNaB>; Sun, 21 Jul 2002 09:30:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Date: Sun, 21 Jul 2002 09:33:01 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-mm@kvack.org
References: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu>
In-Reply-To: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207210933.01211.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On July 21, 2002 07:24 am, Craig Kulesa wrote:

> This patch is intermediate between where we were (freeing slab caches
> blindly and not in tune with the rest of the VM), and where we want to be
> (cache pruning by page as we scan the active list looking for cold pages
> to deactivate).  Uhhh, well, I *think* that's where we want to be.  :)
>
> How do we get there?
>
> Given a slab page, I can find out what cachep and slab I'm dealing with
> (via GET_PAGE_SLAB and friends).  If the cache is prunable one,
> cachep->pruner tells me what kind of callback (dcache/inode/dquot) I
> should invoke to prune the page.  No problem.
>
> The trouble comes when we try to replace shrink_dcache_memory() and
> friends with slab-aware pruners.  Namely, how to teach those
> inode/dcache/dquot callbacks to free objects belonging to a *specified*
> page or slab?  If I have a dentry slab, I'd like to try to liberate
> *those* dentries, not some random ones like shrink_dcache_memory does now.

Well not quite random.  It prunes the oldest entries.  The idea behind the prunable
callback is that some caches have specific aging methods.   What I tried to do here
was keep the rate of aging in sync with the VM.  

> I'm still trying to figure out how to make that work.  Or is that
> totally the wrong approach?  Thoughts?  ;)

Thats a question I have asked myself too.  What could be done is,  scan the 
entries in the slab encountered, using a call back, free them if they are purgeable.
If this ends up producing an empty slab, release it.

>Intermezzo has a funky dentry cache that may need a pruner method (??), 
>but I didn't touch it.  If there was a better way to do this, I was too 
>blind to see it.  

Looking at the Intermezzo dcache code, I think you made the right choise.
I do not think this needs a pruner method.

Ed Tomlinson



