Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSILWQv>; Thu, 12 Sep 2002 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSILWQv>; Thu, 12 Sep 2002 18:16:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:5065 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316408AbSILWQu>;
	Thu, 12 Sep 2002 18:16:50 -0400
Message-ID: <3D811363.70ABB50C@digeo.com>
Date: Thu, 12 Sep 2002 15:21:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Chuck Lever <cel@citi.umich.edu>, Daniel Phillips <phillips@arcor.de>,
       Rik van Riel <riel@conectiva.com.br>, trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209101036040.5887-100000@citi.umich.edu> <Pine.LNX.4.44.0209111044120.6219-100000@cola.enlightnet.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 22:21:26.0583 (UTC) FILETIME=[BC0EEC70:01C25AAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
> ...
> If I understood Andrew right with the inode flag that won't purge anything
> until the next userspace access. I don't think that is what smbfs wants
> since the response to the oplock break should happen fairly soon ...

Well the lazy invalidation would be OK - defer that to the next
userspace access, or just let the pages die a natural VM death,
maybe poke `ksmbinvalidated'.

But if you want to perform writeback within the local IO daemon
then hm.  That's a problem which NFS seems to not have?  I guess
you'd have to leave i_sem held and poke `ksmbwritebackd'.  Or teach
pdflush about queued work items (a tq_struct would do it).

But it's the same story: the requirements of

a) non blocking local IO daemon and

b) assured pagecache takedown

are conflicting.  You need at least one more thread, and locking
against userspace activity.
