Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316176AbSEKBxH>; Fri, 10 May 2002 21:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316191AbSEKBxG>; Fri, 10 May 2002 21:53:06 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:30638 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S316176AbSEKBxD>; Fri, 10 May 2002 21:53:03 -0400
Message-Id: <5.1.0.14.2.20020511114358.03cd6ab0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 11 May 2002 11:53:33 +1000
To: "David S. Miller" <davem@redhat.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Tcp/ip offload card driver
Cc: jgarzik@mandrakesoft.com, chen_xiangping@emc.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020510.080725.94585622.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:07 AM 10/05/2002 -0700, David S. Miller wrote:
>if there was some real life
>demonstrable performance gain with current systems.
>
>For example, do a SpecWEB run with TUX both using on-chip-TCP and
>without, same networking card.  Show a demonstrable gain from the
>on-chip-TCP implementation.  I bet you can't.  If you can make such a
>claim using a setup that other people could reproduce themselves by
>buying your card and running the test, I'll eat all of my words.

i think its conceivable that TOE could be advantagous in some situations.

for example, if TOE was supported in a driver (eg. /dev/toeN) which allowed 
user-space to mmap() into RAM (either on the card or main memory which the 
TOE card DMAs into/out-of).
in that way, a read()-equvalent system-call on a TOE socket could 
potentially just use 1 or 2 memory-accesses versus the 3 that currently occur.
translation: 33% or 50% less traffic across the front-side-bus, no 
pollution of the processor L1/L2 cache as a side-effect of copy_to_user().

in terms of a write()-like system-call, the equivalent holds true also.
right now, a write() means 3 memory-accesses:
  - 2 memory-accesses (memory-read and memory-write) on copy_from_user() 
from userspace to kernel
  - memory-read on NIC DMAing from kernel buffer
its forseeable that something that this could be 1 or 2 memory-accesses in 
a kernel-memory-mmap()ed-to-userspace scenario.

the biggest advantage is the scenario where userspace doesn't care about 
the actual payload of the data.
ie. its reading from-disk and sending to-network, or read-from-socket, 
write-to-another-socket.

of course, if TOE adapters don't work this way and don't have some API of 
their own exposed to allow this, then i'd agree that the benefit is negligible.
and of course, if we did get around to some kind of async i/o scheme in 
linux that allowed the above, then TOE would be of limited value also.
of course, such a scheme would probably be too hard to play fair with the 
page-cache, so it'd only be a "win" for data that is touched once and/or 
the application needs to do its own page-cache-like function.

i guess this is some of the points i'm trying to show with high-speed Fibre 
Channel HBAs -- the overhead of copy_to_user(), copy_from_user() means that 
the front-side-bus/memory-bandwidth ultimately becomes the main bottleneck, 
at least in IA32-architecture machines.


cheers,

lincoln.

