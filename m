Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRAJAWP>; Tue, 9 Jan 2001 19:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRAJAWG>; Tue, 9 Jan 2001 19:22:06 -0500
Received: from chiara.elte.hu ([157.181.150.200]:43788 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131888AbRAJAVu>;
	Tue, 9 Jan 2001 19:21:50 -0500
Date: Wed, 10 Jan 2001 01:20:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Kaiser <rob@sysgo.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01011001040704.03050@rob>
Message-ID: <Pine.LNX.4.30.0101100109270.11542-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2001, Robert Kaiser wrote:

> Sorry, no ext2fs in this kernel (it is for a diskless embedded
> system). I seem to recall though that the problem at one point
> magically went away when I disabled the FPU emulation, but I have not
> been able to reproduce this recently, so I'm not sure. Making minor
> changes to the kernel code (such as adding/removing some test-prints)
> certainly does not affect the behavior.

math-FPU emulation takes up quite some space in the kernel image, so this
could indeed be the case. Could you disable any non-boot-essential
subsystem (networking, or the serial driver, or anything else), to
significantly reduce the image size?

> > Or if that part is not mapped
> > correctly (which does happen sometimes as well).
>
> What could I do to check/fix this ?

i had this a couple of times while doing the 3-level pagetables and
related highmem stuff (and i might even have added this bug ...), and
typically i just printed out the pagetables to a serial console and
analyzed them manually :-|

> > and are you sure it crashes there? [are you putting delays between your
> > printouts?]
>
> I have put a "halting statement" (i.e. "while(1);") after my printouts to make
> sure execution does not go any further than that point. I moved this halting
> statement ahead in the code line by line until the crash would occur again.
> So, yes, I am pretty sure.

(okay, that certainly is a proof. I had to ask.)

> > it accesses mem_map variable, which is near to the end of the kernel
> > image, so it could indeed something of that sort. An uncompressed kernel
> > image (including the data area) must not be bigger than 4MB (IIRC).
>
> According to my System.map file, mem_map is at 0xc0244f78. Does that help ?

not really. Could you write a small function that just reads the kernel
image from the first symbol to the last one, and see whether it crashes?
(read it into a volatile variable to make sure GCC reads it.) Kernel image
goes from _stext to _end - you can access it with something like this:

void test_image (void)
{
	extern char _stext;
	extern char _end;

	volatile char data;
	char *ptr = &_stext;

	while (ptr < _end)
		data = *ptr++;
}

another problem could be if the kernel image is in a place that is somehow
invalid physical RAM. We uncompress it into address 1MB physical (and
assume there is enough space from that point on to uncompress
successfully, without actually checking it), which should work on all 'PC
architecture compatible' systems. (other bootloaders use this method
frequently as well.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
