Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313636AbSDEViA>; Fri, 5 Apr 2002 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313637AbSDEVhk>; Fri, 5 Apr 2002 16:37:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9528 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313636AbSDEVhd>; Fri, 5 Apr 2002 16:37:33 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<a8flgc$ms2$1@cesium.transmeta.com>
	<m1lmc3qtaz.fsf@frodo.biederman.org> <3CAC9BD4.5050500@zytor.com>
	<m1hemrqo9b.fsf@frodo.biederman.org> <3CACA74A.1000004@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 14:30:56 -0700
Message-ID: <m1zo0homsv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Agreed.  Note that so far putting the real mode code *above* 0x90000 is
> completely untested.  It *should* work with boot protocol 2.02 support; it
> almost certainly *does not* work with earlier boot protocols (due to the "move
> it back to 0x90000" braindamage.)

Having misc.c move the real mode code and the command line above
0x90000 avoids this issue.  I relocate the command line so
cmd_line_ptr must be written.  This looses track of exactly which
protocol version the bootloader was using, but it doesn't matter as
all the kernel cares about is being able to find it's command line,
and the command line can still be found.  For code coming in the new
32bit entry point we are above protocol version 2.02 when the problem
was fixed.

I have now solved the space/reliability tradeoff with belt and suspenders.

I have modified misc.c to do an inplace decompression.  This means I
use approximately 78KB of memory below 1MB and 8 bytes more than the
decompressesed kernel above 1MB.  And if I have to except for the 5KB
of real mode code I can put everything above 1MB.  The 78KB is 5KB
real mode code 10KB decompressor code 61KB bss. 

The change is especially nice because now in my worst case of only
using 5KB real mode data, I do better than the best case with previous
kernels (assuming it isn't a zImage).  And if I ever get the bootmem
bootmap fixed I can put initrds down at 2.6MB and not have to worry
about them getting stomped :)

Eric


        
