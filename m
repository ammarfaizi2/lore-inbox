Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbRGKANc>; Tue, 10 Jul 2001 20:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbRGKANW>; Tue, 10 Jul 2001 20:13:22 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:12531
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S267118AbRGKAND>; Tue, 10 Jul 2001 20:13:03 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: root@chaos.analogic.com, "Richard B. Johnson" <root@chaos.analogic.com>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Date: Tue, 10 Jul 2001 18:56:24 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010710142459.19170A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010710142459.19170A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <01071019124201.20649@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Richard B. Johnson wrote:
>On Tue, 10 Jul 2001, Jonathan Lundell wrote:
>
>> At 1:35 PM -0400 2001-07-10, Richard B. Johnson wrote:
>> >Unlike some OS (like VMS), a context-switch does not occur
>> >when the kernel provides services for the calling task.
>> >Therefore, it was most reasonable to have the kernel exist within
>> >each tasks address space. With modern processors, it doesn't make
>> >very much difference, you could have user space start at virtual
>> >address 0 and extend to virtual address 0xffffffff. However, this would
>> >not be Unix. It would also force the kernel to use additional
>> >CPU cycles when addressing a tasks virtual address space,
>> >i.e., when data are copied to/from user to kernel space.
>> 
>> Certainly the shared space is convenient, but in what sense would a 
>> separate kernel space "not be Unix"? I'm quite sure that back in the 
>
>I explained why it would not be Unix.
>
>
>> AT&T days that there were Unix ports with separate kernel (vs user) 
>> address spaces, as well as processors with special instructions for 
>
>No. The difference between kernel and user address space is protection.
>Let's say that you decided to revamp all the user space to go from
>0 to 2^32-1. You call the kernel with a pointer to a buffer into
>which you need to write kernel data:
>
>You will need to set a selector that will access both user and
>kernel data at the same time. Since the user address space is
>paged, this will not be possible, you get one or the other, but
>not both. Therefore, you need to use two selectors. In the case
>of ix86 stuff, you could set DS = KERNEL_DS and ES = a separately
>calculated selector that represents the base address of the caller's
>virtual address space. Note that you can't just use the caller's
>DS or ES because they can be changed by the caller.

Sure you can - But you do have to modify the page tables for the
kernel access. You also have to verity that the page is valid
to the user, that the offset to the location to modify is
valid from both the users context and the kernel context.

>Then you can move data from DS:OFFSET to ES:OFFSET, but not the
>other way. If you need to move data the other way, you need DS: = a
>separately calculated selector that represents the base address of the
>caller's virtual address space, and ES = KERNEL_DS. Then you can copy from
>ES:OFFSET to ES:OFFSET (as before), but the data goes the other way.

See, it can be done, but the changing page tables are a PITA. It's slow.

>With the same virtual address space for kernel and user, you
>don't need any of this stuff. The only reason we have special
>functions (macros) for copy to/from, is to protect the kernel
>from crashing when the user-mode caller gives it a bad address.

wrong - In either case, the parameters to the system call (and the
return values) have to be evaluated for proper usage and security.
That is NOT unique and can be done in many ways.

They provide the same protection as that provided by
other hardware. Even using page remapping will work, if implemented
properly. it just isn't as fast as using a single virtual mapping.

Been there, done that.

Multi-tasking real time systems do this a LOT - and because the
amount of data passed may be quite small it is frequently
more efficient. (largest I ever did was about 256 bytes - ocean going
autopilot/seismic surveys). The determining factor is:
1. correctness, 2. speed, 3. ease of implementation, 4. hardware
support.

>It all tasks were cooperative, you could use memcpy() perfectly
>fine (or rep movsl ; rep movsw ; rep movsb).

You still must verify that the source/destination are reasonably valid.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
