Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311119AbSCHU6X>; Fri, 8 Mar 2002 15:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311120AbSCHU6P>; Fri, 8 Mar 2002 15:58:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15117 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311119AbSCHU6I>; Fri, 8 Mar 2002 15:58:08 -0500
Date: Fri, 8 Mar 2002 12:57:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16jRAU-0007QU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203081252450.1412-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Mar 2002, Alan Cox wrote:
> 
> Can we go to cache line alignment - for an array of locks thats clearly
> advantageous

I disagree about the "clearly". Firstly, the cacheline alignment is CPU 
dependent, so on some CPU's it's 32 bytes (or even 16), on others it is 
128 bytes. 

Secondly, a lot of locking is actually done inside a single thread, and
false sharing doesn't happen much - so keeping the locks dense can be
quite advantageous.

The cases where false sharing _does_ happen and are a problem should be 
for the application writer to worry about, not for the kernel to force.

So I think 8 bytes is plenty fine enough - with 16 bytes a remote 
possibility (I don't think it is needed, but it gives you som epadding for 
future expansion). And people who have arrays and find false sharing to be 
a problem can fix it themselves.

I personally don't find arrays of locks very common. It's much more common
to have arrays of data structures that _contain_ locks (eg things like
having hash tables etc with a per-hashchain lock) and then those container 
structures may want to be cacheline aligned, but the locks themselves 
should not need to be.

		Linus

