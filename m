Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314984AbSEHTzP>; Wed, 8 May 2002 15:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314987AbSEHTzO>; Wed, 8 May 2002 15:55:14 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:37248 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S314984AbSEHTzN>; Wed, 8 May 2002 15:55:13 -0400
Date: Wed, 08 May 2002 22:00:05 +0200
Organization: ViaDomus
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: mmap() doesn't like certain value...
Message-ID: <3CD983C5.mail1K71EX1NG@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    While writing a test program I used mmap using SIZE_MAX (which is
the maximum value storeable in a size_t variable) as the length, just
to see when mmap starts failing with EINVAL or ENOMEM.

    Well, mmap() acted quite good and reasonable and gave me the
values I was searching for... except when a value of SIZE_MAX-4095 or
higher is passed to it.

    I've taken a look at the kernel sources and in the file
mm/mmap.c, in the function do_mmap_pgoff, the length supplied is page
aligned (thru the macro PAGE_ALIGN). But this macro correctly says
that when we are at address SIZE_MAX-4095 or higher the next page in
the addressable space is the page at address 0. But we are dealing
with *sizes*, not addresses.

    The matter is that mmap() doesn't fail with values of
SIZE_MAX-4095 and higher (as it should do), but succeeds returning
'0' as the address... This is due the calculus that PAGE_ALIGN does
with the enormous length passed (namely 4294963200 or higher, up to
the limit marked by SIZE_MAX: 2^32-1). This macro cannot be used with
numbers near to the limit. mmap() should return -1 and set errno to
EINVAL, as properly does when the enormous length is less than
2^32-4096.

    I know: this lengths are enormous, nobody uses them, etc... but I
think that mmap shouldn't behave as bad just because nobody will use
the entire domain of the function. If the length domain is [0, 2^32)
the function should behave correctly, returning errors as
appropriate, not succeeding falsely. So please consider correcting
the problem (should suffice with eliminating the use of PAGE_ALIGN or
adding special cases to the test prior to its use).

    If this is not a bug, but an intended behaviour please excuse me.
Moreover, I can provide a patch (I suppose) against the 2.4.18 tree.

    Thanks a lot for reading this :)
    Raúl
