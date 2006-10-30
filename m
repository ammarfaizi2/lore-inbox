Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWJ3PI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWJ3PI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWJ3PI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:08:28 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:27023 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030375AbWJ3PI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:08:28 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vasily Averin <vvs@sw.ru>
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
Date: Mon, 30 Oct 2006 16:08:25 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
References: <4541F2A3.8050004@sw.ru> <20061027110645.b906839f.akpm@osdl.org> <45460B16.7050201@sw.ru>
In-Reply-To: <45460B16.7050201@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301608.25861.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 October 2006 15:24, Vasily Averin wrote:
> Andrew Morton wrote:
> > On Fri, 27 Oct 2006 18:05:50 +0400
> >
> > Vasily Averin <vvs@sw.ru> wrote:
> >> Virtuozzo/OpenVZ linux kernel team has discovered that umount/remount
> >> can last for hours looping in shrink_dcache_sb() without much successes.
> >> Since during shrinking s_umount semaphore is taken lots of other
> >> unrelated operations like sync can stop working until shrink finished.
> >
> > Did you consider altering shrink_dcache_sb() so that it holds onto
> > dcache_lock and moves all the to-be-pruned dentries onto a private list
> > in a single pass, then prunes them all outside the lock?
>
> At the first glance it is wrong because of 2 reasons:
> 1) it continues to check the whole global LRU list (we propose to use
> per-sb LRU, it will provide very quick search)

Quick search maybe, but your patch adds 2 pointers to each dentry in the 
system... That's pretty expensive, as dentries are already using a *lot* of 
ram.

Maybe an alternative would be to not have anymore a global dentry_unused, but 
only per-sb unused dentries lists ?


> 2) we have not any guarantee that someone will add new unused dentries to
> the list when we prune it outside the lock. And to the contrary, some of
> unused dentries can be used again. As far as I understand we should hold
> dcache_lock beginning at the removing dentry from unused_list until
> dentry_iput() call.
>
> David did it inside shrink_dcache_for_umount() just because it have
> guarantee that all the filesystem operations are finished and new ones
> cannot be started.

