Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUHXJad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUHXJad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 05:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHXJad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 05:30:33 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:15777 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S267209AbUHXJaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 05:30:15 -0400
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: oom-killer 2.6.8.1
Date: Tue, 24 Aug 2004 11:30:15 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, joe@unthought.net,
       Gene Heskett <gene.heskett@verizon.net>,
       Hugh Dickins <hugh@veritas.com>
References: <200408181455.42279.as@cohaesio.com> <200408181624.25131.as@cohaesio.com> <20040818211142.GH11200@holomorphy.com>
In-Reply-To: <20040818211142.GH11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408241130.15577.as@cohaesio.com>
X-OriginalArrivalTime: 24 Aug 2004 09:30:14.0598 (UTC) FILETIME=[F5EC5660:01C489BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - I now have some additional info regarding the slapinfo/oom-killer issue.

As I wrote earlier this server is a storage server providing NFS storage to a 
number of webservers - ondisk filesystem is xfs, kernel = 2.6.8.1. At 03:00 
some logrotate scripts runs throug a lot of files. It appears that this is 
what is using the slabs (see this graph, K = M, so max used slab is approx. 
700M) 

http://saaby.com/slabused.gif (values are from /proc/meminfo)

These are the values (from slabinfo, active_objs), which changed remarkably 
from 03:00 to 06:00:

03:00:        06:00:
xfs_chashlist  91297    xfs_chashlist     151994
xfs_inode     243791    xfs_inode         586780
linvfs_icache 243791    linvfs_icache     586807
dentry_cache  196033    dentry_cache      430609

The server crashed every night at approx. 03:00 to 04:00 - until last night 
where we changed:

vm.min_free_kbytes from default (approx. 900K) to vm.min_free_kbytes=32768 
(32M)

This seems to solve the problem - Does this make any sense to you? - Or just 
pure luck?

/Saaby

On Wednesday 18 August 2004 23:11, William Lee Irwin III wrote:
> On Wednesday 18 August 2004 16:05, William Lee Irwin III wrote:
> >> Index: oom-2.6.8-rc1/mm/vmscan.c
> >> ===================================================================
> >> --- oom-2.6.8-rc1.orig/mm/vmscan.c 2004-07-14 06:17:13.876343912 -0700
> >> +++ oom-2.6.8-rc1/mm/vmscan.c 2004-07-14 06:22:15.986416200 -0700
> >> @@ -417,7 +417,8 @@
> >>      goto keep_locked;
> >>     if (!may_enter_fs)
> >>      goto keep_locked;
> >> -   if (laptop_mode && !sc->may_writepage)
> >> +   if (laptop_mode && !sc->may_writepage &&
> >> +       !PageSwapCache(page))
> >>      goto keep_locked;
> >>
> >>     /* Page is dirty, try to write it out here */
>
> On Wed, Aug 18, 2004 at 04:24:24PM +0200, Anders Saaby wrote:
> > laptop_mode is not set on this server <- :-)
> > - So I guess this is not relevant for my setup?
>
> Probably not. Please try to collect /proc/slabinfo snapshots while the
> system is still functional as it degrades.
>
>
> -- wli
