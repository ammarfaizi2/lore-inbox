Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262720AbRE0Cce>; Sat, 26 May 2001 22:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRE0CcY>; Sat, 26 May 2001 22:32:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34130 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262716AbRE0CcQ>; Sat, 26 May 2001 22:32:16 -0400
Date: Sun, 27 May 2001 04:32:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5aa1
Message-ID: <20010527043208.G1834@athlon.random>
In-Reply-To: <20010526193310.A1834@athlon.random> <15120.23023.903912.358739@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15120.23023.903912.358739@pizda.ninka.net>; from davem@redhat.com on Sat, May 26, 2001 at 06:35:43PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 06:35:43PM -0700, David S. Miller wrote:
> 
> Andrea Arcangeli writes:
>  > 00_eepro100-64bit-1
>  > 
>  > 	Fixes a 64bit bug that was generating false positives and memory
>  > 	corruption.
>  > 
>  > 	(recommended)
> 
> Good spotting, I've put this into my tree ;-)

fine, thanks!

>  > 00_eepro100-alpha-1
>  > 
>  > 	Possibly fix the eepro100 transmitter hang on alpha by doing atomic PIO
>  > 	updates to avoid the clear_suspend to be lost.
>  > 	
>  > 	(recommended)
> 
> The correct fix is to create {set,clear,change}_bit{8,16,32}()
> routines architectures may implement.  The comment there in eepro100.c

Agreed.

> indicates the those defines are simply wrong for anything other than
> x86, not just Alpha.

The defines are ok but according to Matt they're not using atomic
operations, infact they works fine until you beat them hard. Infact I
guess it may trigger even in x86 in theory, I suspect it doesn't trigger
by luck, I think we should at least declare the __u16 pointer as
volatile or gcc may be free to do whatever it does on alpha without
using the bitops. The patch is actually using an #ifdef __alpha__
because it relys on the fact alpha internally does the 32bit accesses
with the bitops (so it doesn't mess with the other registers).

>  > 00_ipv6-null-oops-1
>  > 
>  > 	Fixes null pointer oops.
>  > 
>  > 	(recommended)
> 
> Please delete this, a proper fix is in 2.4.5, and in fact your
> added NULL test will never pass now :-)

I forgotten it, Alan noticed it too. thanks for the reminder.

>  > 10_no-virtual-1
>  > 
>  > 	Avoids wasting tons of memory if highmem is not selected (like
>  > 	in all the 64bit ports).
>  > 
>  > 	(nice to have)
> 
> I experimented with computing the address every time on sparc64 and
> the performance actually went down slightly, it turned out it's
> quicker to load from an in-cache page struct member than compute the
> offset each time.

Ok, then I will add define_bool CONFIG_NO_PAGE_VIRTUAL y to sparc and
sparc64.

> It's probably not an issue on ix86, but who knows.

On modern x86 it should be faster to compute it to save dcache, memory
bandwith and ram.

Thanks for the review!

Andrea
