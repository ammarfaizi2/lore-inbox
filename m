Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136605AbRECK2W>; Thu, 3 May 2001 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136698AbRECK2M>; Thu, 3 May 2001 06:28:12 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61455 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S136605AbRECK16>;
	Thu, 3 May 2001 06:27:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105030615.f436FKN11735@saturn.cs.uml.edu>
Subject: Re: Unknown HZ value! (2000) Assume 1024.
To: tomh@po.crl.go.jp (Tom Holroyd)
Date: Thu, 3 May 2001 02:15:20 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (kernel mailing list)
In-Reply-To: <Pine.LNX.4.30.0105021600420.27862-100000@holly.crl.go.jp> from "Tom Holroyd" at May 02, 2001 04:47:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Holroyd writes:
> On Wed, 2 May 2001, Albert D. Cahalan wrote:

>> For 32-bit systems, we use 32-bit values to reduce overhead.
>> This causes problems at 495/smp_num_cpus days of uptime.
>
> You mean for HZ == 100.

Well, OK. No unmodified 32-bit system runs HZ == 1024.

> And I guess the overhead in question is the cost
> of a 64 bit add vs. a 32 bit add HZ times per second?  On a 64 bit
> machine, that overhead is likely to be exactly zero.  It is zero on my
> machine.  For integer math on an Alpha, changing the ints to longs can
> even make a program run faster.

Yes.

>> Proposed hack: set a very-long-duration timer (several days)
>> to check for the high bit changing. Count bit flips.
>
> What about the interval between when it flips and when you notice it?

Not a problem. Note that I count bit flips, not roll overs.
Here are the two variables, with "flips" lagging a bit:

flips  jiffies
0      0x7fffff26
0      0x80000003   (not noticed yet)
1      0x8000b01a
1      0xffffffe7
1      0x00000666   (not noticed yet)
2      0x0000ee15

Calculate 64-bit (well, 63-bit) jiffies as:

long long total;
unsigned f = flips;
unsigned j = jiffies;
f += (f ^ (j>>31)) & 1;
total = ((long long)f<<31) | j;

Now print the total.

Well, there it is. Like it? The /proc reader does 64-bit operations
and a timer goes off every few days, saving the clock tick from
doing any 64-bit operations. The fast path stays fast, while procps
can get useful data even after years of uptime.


