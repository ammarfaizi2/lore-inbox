Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317727AbSFLPmQ>; Wed, 12 Jun 2002 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317731AbSFLPmP>; Wed, 12 Jun 2002 11:42:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26643 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317727AbSFLPmP> convert rfc822-to-8bit; Wed, 12 Jun 2002 11:42:15 -0400
Date: Wed, 12 Jun 2002 08:39:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D071153.9020607@loewe-komp.de>
Message-ID: <Pine.LNX.4.33.0206120833470.23029-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g5CFfrj29151
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jun 2002, Peter Wächtler wrote:
> 
> What are the plans on how to deal with a waiter when the lock holder
> dies abnormally?

That's why they are called FUTEX'es - they're fast. They're NOT SysV 
semaphores, and they are done 99% in user space. The kernel doesn't even 
_know_ about them until contention happens, and even then only in a rather 
dim "somebody wants me to do this, but I don't know _what_ he is doing" 
way.

> What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
> setting errno to a reasonable value (EIO?)

There's just nothing the kernel _can_ do. The common case (by far) is that
the kernel has never seen the futex at all, since many uses are likely to
not have much contention. So when a user program dies holding such a 
uncontended lock, the kernel simply _cannot_ do anything.

(The kernel also cannot do anything even for the contended locks, because 
the whole interface is designed for speed and with the knowledge that the 
kernel won't be able to fix stuff up, so the kernel doesn't actually have 
enough information even in the contention case. See the "dim notion" 
above).

Besides, if you have a threads package that uses some lock for mutual 
exclusion, and a thread dies while holding the lock, there's nothign sane 
anybody can do about it anyway. The data structures are likely to be in an 
invalid state, and just making every other thread block on the lock until 
you can attach a debugger is probably the closest to a _right_ thing you 
can do.

In short: it's not a bug, it's a design feature, and it's very much 
designed for efficiency.

		Linus

