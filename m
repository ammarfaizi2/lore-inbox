Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280996AbRKCRjT>; Sat, 3 Nov 2001 12:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKCRjJ>; Sat, 3 Nov 2001 12:39:09 -0500
Received: from colorfullife.com ([216.156.138.34]:25612 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S280996AbRKCRiz>;
	Sat, 3 Nov 2001 12:38:55 -0500
Message-ID: <3BE42BB5.7AF5F56F@colorfullife.com>
Date: Sat, 03 Nov 2001 18:39:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Patch and Performance of larger pipes
In-Reply-To: <OF2428DABF.B9AD95A4-ON86256AEA.005A4949@raleigh.ibm.com> <20011024153930.A12944@watson.ibm.com> <20011030133124.A16257@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
>  32k        512      500           0         1.09       -78.3

I understand the slowdown, but 78% are too large.
With my patch applied, the read syscall probably returns after 4608
bytes instead of all 32 kB. Could you check that you don't delay after
every syscall, but only after 32 kB are read?

> 
> Whereas Manfred's patch is doing 12% degradation on 2-way and 78%
> degradation on UP.
>
I found the problem:
The current code does syscall coalescing.

On UP, I get
<<<<<<<<
$dd if=/dev/zero bs=4096 count=20000 | dd bs=1M of=/dev/null
20000+0 records in
20000+0 records out
78+1 records in
78+1 records out
$dd if=/dev/zero bs=4096 count=20000 | dd bs=1M of=/dev/null
20000+0 records in
20000+0 records out
77+2 records in
77+2 records out
<<<<<<<< [ok, it it SMP, but the 2nd cpu executes 'for(;;);']
Only 80 read syscalls are needed. With my patch applied, I'd get around
10000 syscalls.

I haven't found a simple way to fix it yet, probably I must wait until
the cache flushing functions are cleaned up.
--
	Manfred
