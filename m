Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSHFOYM>; Tue, 6 Aug 2002 10:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSHFOYM>; Tue, 6 Aug 2002 10:24:12 -0400
Received: from daimi.au.dk ([130.225.16.1]:56209 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S312973AbSHFOYL>;
	Tue, 6 Aug 2002 10:24:11 -0400
Message-ID: <3D4FDCDB.744EE7C9@daimi.au.dk>
Date: Tue, 06 Aug 2002 16:27:39 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
References: <3D4FD736.DA443B4B@daimi.au.dk>
		<20020806.065652.12285252.davem@redhat.com>
		<3D4FDA23.90CAB62F@daimi.au.dk> <20020806.070535.24871584.davem@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Kasper Dupont <kasperd@daimi.au.dk>
>    Date: Tue, 06 Aug 2002 16:16:03 +0200
> 
>    "David S. Miller" wrote:
>    > What if we have to sleep and page in some memory from disk?
>    >
>    > Your idea could lead to deadlock in a multi-threaded app.
> 
>    Why? The page should eventually get into memory from the disk,
>    at this point the process doing the copy can continue, and
>    when it finishes the other processes gets waked up. While the
>    copy_to_user is in progress all the processes witht this mm
>    should be in noninterruptible sleep. The sleeping procces
>    doesn't need to do anything to get the page into memory, so I
>    cannot see the problem.
> 
> What if the other thread we freeze is holding a lock we
> need in order to get the page from disk?

If the other thread is in user mode, that should not be possible.
If the other thread is in kernel mode, things starts getting
complicated. Maybe we could delay the freezing until the other
thread leaves kernel. I don't right away see if the current
thread has to wait for the other process to leave kernel and
get frozen.

I just get another idea, that might be easier to get right. If
the only problem is one process changing the mm while another
process is doing a copy_to_user, we should be able to fix it by
placing a readlock on the mm while the copy_to_user is in progress.

I don't remember if the mm is protected by a spinlock or
semaphore, if it is a spinlock maybe it could be replaced by a
semaphore? Otherwise we could prevent the copy_to_user from
completing if it has to sleep, and just release the lock if it
does go to sleep. In that case when the process gets waked up, it
has to get a special return value, that forces it to repeat the
verification of the area. (Isn't there a way to ensure the pages
are in memory before starting the actual copy, that would make
things simpler?)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
