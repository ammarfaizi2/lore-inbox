Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDQWvy>; Tue, 17 Apr 2001 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132709AbRDQWvp>; Tue, 17 Apr 2001 18:51:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6490 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132707AbRDQWvf>; Tue, 17 Apr 2001 18:51:35 -0400
Date: Wed, 18 Apr 2001 01:06:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, torvalds@transmeta.com
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010418010631.H31982@athlon.random>
In-Reply-To: <01041722480200.05613@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041722480200.05613@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Tue, Apr 17, 2001 at 10:48:02PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 10:48:02PM +0100, D . W . Howells wrote:
> I disagree... you want such primitives to be as efficient as possible. The 
> whole point of having asm/xxxx.h files is that you can stuff them full of 
> dirty tricks specific to certain architectures.

Of course you always have the option to override completly and you should
on x86 (providing an API for total override is the main object of my patch).

> I've had a look at your implementation... It seems to hold the spinlocks for 
> an awfully long time... specifically around the local variable initialisation 

My point for not unlocking is that unlocking and locking back another spinlock
for the waitqueue and using the wait_even interface for serializing the slow
path is expensive and generates more cacheline ping pong between cpus.  And
quite frankly I don't care about the scalability of the slow path so if the
slow path is simpler and slower I'm happy with it.

> Your rw_semaphore structure is also rather large: 46 bytes without debugging 

It is 36bytes. and on 64bit archs the difference is going to be less.

> stuff (16 bytes apiece for the waitqueues and 12 bytes for the rest). 

The real waste is the lock of the waitqueue that I don't need, so I should
probably keep two list_head in the waitqueue instead of using the
wait_queue_head_t and wake_up_process by hand.

> Admittedly, though, yours is extremely simple and easy to follow, but I don't 
> think it's going to be very fast.

The fast path has to be as fast as yours, if not then the only variable that
can make difference is the fact I'm not inlining the fast path because it's not
that small, in such a case I should simply inline the fast path, I don't care
about the scalability of the slow path and I think the slow path may even be
faster than yours because I don't run additional unlock/lock and memory
barriers and the other cpus will stop dirtifying my stuff after their first
trylock until I unlock.

If you have time to benchmark I'd be interested to see some number. But anyways
my implementation was mostly meant to be obviously right and possible to
ovverride with per-arch algorithms.

Andrea
