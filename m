Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132904AbRDJCmD>; Mon, 9 Apr 2001 22:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132906AbRDJClx>; Mon, 9 Apr 2001 22:41:53 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49310 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S132904AbRDJClp>; Mon, 9 Apr 2001 22:41:45 -0400
Date: Tue, 10 Apr 2001 11:41:28 +0900
Message-ID: <y9t9easn.wl@frostrubin.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <Pine.LNX.4.31.0104081841440.7671-100000@penguin.transmeta.com>
In-Reply-To: <3AD0FD0F.9B0C47FD@uow.edu.au>
	<Pine.LNX.4.31.0104081841440.7671-100000@penguin.transmeta.com>
User-Agent: Wanderlust/2.4.0 (Rio) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.3 () APEL/10.2 MULE XEmacs/21.2 (beta46) (Urania) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Sun, 8 Apr 2001 20:08:13 -0700 (PDT),
Linus Torvalds wrote:
> 
> Can anybody shoot any holes in this? I haven't actually tested it, but
> race conditions in locking primitives are slippery things, and I'd much
> rather have an algorithm we can _think_ about and prove to be working. And
> I think the above one is provably correct.

  I am not familiar with semaphore or x86, so this may not be correct,
but if the following sequence is possible, the writer can call wake_up()
before the reader calls add_wait_queue() and reader may sleep forever.
Is it possible?


Reader							Writer

    down_read:
	lock incl (%sem)
	js __down_read_failed
						    up_write:
							lock andl $0x3fffffff,(%sem)
							jne __up_write_wakeup

						    __up_write_wakeup:
							spin_lock(&sem->lock);
							wake_up(&sem->waiters);
							spin_unlock(&sem->lock);
    __down_read_failed:
	spin_lock(%sem->lock)
	add_wait_queue(&sem->waiters, &wait);
	.
	.
