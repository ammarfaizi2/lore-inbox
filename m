Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317771AbSFLTfZ>; Wed, 12 Jun 2002 15:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSFLTfY>; Wed, 12 Jun 2002 15:35:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317771AbSFLTfY>; Wed, 12 Jun 2002 15:35:24 -0400
Date: Wed, 12 Jun 2002 12:32:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <k-suganuma@mvj.biglobe.ne.jp>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: <5.1.0.14.2.20020612090736.04192860@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0206121226550.1533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Since the cpu_online_map thing can be used to fix this, this doesn't 
seem to be a big issue, BUT

On Wed, 12 Jun 2002, Anton Altaparmakov wrote:
> 
> 1) Use a single buffer and lock it so once one file is under decompression 
> no other files can be and if multiple compressed files are being accessed 
> simultaneously on different CPUs only one CPU would be decompressing. The 
> others would be waiting for the lock. (Obviously scheduling and doing other 
> stuff.)
> 
> 2) Use multiple buffers and allocate a buffer every time the decompression 
> engine is used. Note this means a vmalloc()+vfree() in EVERY ->readpage() 
> for a compressed file!
> 
> 3) Use one buffer for each CPU and use a critical section during 
> decompression (disable preemption, don't sleep). Allocated at mount time of 
> first partition supporting compression. Freed at umount time of last 
> partition supporting compression.
> 
> I think it is obvious why I went for 3)...

I don't see that as being all that obvious. The _obvious_ choice is just 
(1), protected by a simple spinlock. 128kB/CPU seems rather wasteful, 
especially as the only thing it buys you is scalability on multiple CPU's 
for the case where you have multiple readers all at the same time touching 
a new compressed block.

That scalability operation seems dubious, especially since this will only 
happen when you just had to do IO anyway, so in order to actually take 
advantage of the scalability that IO would have had to happen on multiple 
separate controllers.

Ehh?

		Linus

