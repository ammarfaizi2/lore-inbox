Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284337AbRLMQYA>; Thu, 13 Dec 2001 11:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbRLMQXy>; Thu, 13 Dec 2001 11:23:54 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:62868 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S284337AbRLMQXb>; Thu, 13 Dec 2001 11:23:31 -0500
Date: Thu, 13 Dec 2001 08:22:51 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
In-Reply-To: <BDD02BB0D67@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0112130803260.19406-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Petr Vandrovec wrote:

> If you have legacy app, how it comes that it uses mmap?

Very good question.  The app per se does not call mmap(), but mmap() is
called once when I execute it.  So it must be something from libc:

[whitney@mf1 whitney]$ ldd `which magma`
	not a dynamic executable
[whitney@mf1 whitney]$ magma
[ . . .]
[2]+  Stopped                 magma
[whitney@mf1 whitney]$ cat /proc/`pidof magma`/maps
08048000-08afb000 r-xp 00000000 21:07 64318 magma
08afb000-08c3e000 rw-p 00ab2000 21:07 64318 magma     
08c3e000-0bc54000 rwxp 00000000 00:00 0
40000000-40001000 rw-p 00000000 00:00 0
bfffd000-c0000000 rwxp ffffe000 00:00 0

> So maybe MAGMA uses some API which it should not use under any
> circumstances... Such as that you linked it with libc6 stdio.

Indeed.  How can I avoid the map at 0x40000000?  Must I avoid using
certain glibc2 functions, and then link the executable carefully to leave
out their initialization routines?  Or can I set some magic environment
variable to tell glibc2 to mmap() the single map with MAP_FIXED at a
higher addresss?  Of course I could modify glibc2 so that it does all (or
most) of its mmap()'s with MAP_FIXED at a higher address.  Is there an
alternative libc that might work out of the box or require less
modification?

So it seems like for MAGMA I should be able to work around the fact that
mmap()'s start at 0x40000000.  But as difficulties with other programs
come up here fairly regularly, I still think it makes sense to fully
understand the downside of modifying the kernel to allocate mmap() VMAs
going downward.  If the downside is small, I think it is a good tradeoff.

Cheers, Wayne


