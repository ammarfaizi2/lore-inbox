Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbRFLOEw>; Tue, 12 Jun 2001 10:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262614AbRFLOEm>; Tue, 12 Jun 2001 10:04:42 -0400
Received: from foobar.isg.de ([62.96.243.63]:27152 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S262611AbRFLOE2>;
	Tue, 12 Jun 2001 10:04:28 -0400
Message-ID: <3B262158.29EFC01A@isg.de>
Date: Tue, 12 Jun 2001 16:04:08 +0200
From: Peter Niemayer <niemayer.viag@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unused shared memory is written into core dump - bug or feature?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I just noticed that when I attach some SYSV shared memory segments
to my process and then that process dies from a SIGSEGV that _all_
the shared memory is dumped into the core file, even if it was never
used and therefore didn't show up in any of the memory statistics.

One may say: "Oh, that's just a feature". But for some reason, this
is a small catastrophy:

I try to share some memory between the child processes of an application.
At the time when the child processes are fork()ed, it is not known how
much shared memory will be needed later. No other processes should see
that memory.

I searched through the literature how this could be done, but alas,
the recommended methods such as mmap()ing "/dev/zero" with MAP_SHARED
or using MAP_ANON are not implemented in Linux as they are within
other Unices, and so using "ftruncate" to expand the shared memory
region doesn't work either.

So the only work-around I found was to attach the very maximum of
what is to be used as shared memory using the SYSV shared memory
functions, and allocating/using subsets of this memory later on
the "logical" level.

This of course means that any "parent" process starts by attaching
~512MB of shared memory, but since they are not mapped at that time,
there's no undue performance or memory/swap consumption.

But if one of the programs crashes (and you know, this is nothing
you can be sure to never happen :-), it stymies the whole system,
as the kernel first seems to map all the 512MB, then dumps them
into the core file.

Please tell me there is either a way to keep the kernel from dumping
these unused pages (but generate the much appreciated core-dump anyway)
or there is some better method to share memory with one's child processes
(not with the whole universe)  in a way that allows either the child or
the parent to extend the amount of shared memory... 

Thanks for any hints in advance,

Peter Niemayer

PS: Please CC me if you reply - thanks!
