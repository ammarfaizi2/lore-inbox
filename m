Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319728AbSIMRXI>; Fri, 13 Sep 2002 13:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319729AbSIMRXI>; Fri, 13 Sep 2002 13:23:08 -0400
Received: from packet.digeo.com ([12.110.80.53]:29151 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319728AbSIMRXG>;
	Fri, 13 Sep 2002 13:23:06 -0400
Message-ID: <3D8223BE.31C564F2@digeo.com>
Date: Fri, 13 Sep 2002 10:43:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
References: <3D81A200.C1B6A293@digeo.com> <20020913.182350.43012479.taka@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 17:27:52.0152 (UTC) FILETIME=[E373CD80:01C25B4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> Hello,
> 
> I fixed the patch.

Thanks again.

> But I have one more question.
> 
> Please consider...
> while a process sleep in copy_*_user() another one may call kmap_atomic
> and kunmap_atomic. And the process will restart and might access the
> wrong page as kunmap_atomic do nothing without CONFIG_DEBUG_HIGHMEM flag.
> I mean it wouldn't any faults as another page is still kmapped.

Yes; this is why it is illegal to sleep, or to switch CPUs by any means
while holding an atomic kmap:


	kmap_atomic(...);
	__copy_*_user(...);
	kunmap_atomic(...);

the kmap_atomic() will increment the preempt count (even on CONFIG_PREEMPT=n).

- The incremented preempt count pins this code path onto this CPU
  while the kmap is held. (This is only relevant to CONFIG_PREEMPT=y)

- The incremented preempt count tells do_page_fault() that we cannot
  handle a pagefault; if a fault is encountered during the copy_*_user(),
  do_page_fault() will arrange for the __copy_*_user() to return a short
  copy.

So.  The code path is atomic, and is pinned to a single CPU.  The atomic
kmap pool uses a different batch of virtual addresses for each CPU (it's
a per-CPU pool of addresses).
