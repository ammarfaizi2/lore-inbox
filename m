Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbRAILp6>; Tue, 9 Jan 2001 06:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAILps>; Tue, 9 Jan 2001 06:45:48 -0500
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:63177 "EHLO
	mailout2.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129875AbRAILpc>; Tue, 9 Jan 2001 06:45:32 -0500
Message-ID: <01da01c07a32$03995db0$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: <whitney@math.berkeley.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.e9ik37v.1lg8urj@ifi.uio.no> <fa.hifgbev.s1ana8@ifi.uio.no>
Subject: Re: Subtle MM bug (really 830MB barrier question)
Date: Tue, 9 Jan 2001 06:47:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 08048000-08b5c000 r-xp 00000000 03:05 1130923
/tmp/newmagma/magma.exe.dyn
> 08b5c000-08cc9000 rw-p 00b13000 03:05 1130923
/tmp/newmagma/magma.exe.dyn
> 08cc9000-0bd00000 rwxp 00000000 00:00 0

> Now, subsequent to each memory allocation, only the second number in the
> third line changes.  It becomes 23a78000, then 3b7f0000, and finally
> 3b808000 (after the failed allocation).

OK it's fairly obvious what's happening here. Your program is using its own
allocator, which relies solely on brk() to obtain more memory. On x86 Linux,
brk()-allocated memory (the heap) begins right above the executable and
grows upward - the increasing number you noted above is the top of the heap,
which grows with every brk(). Problem is, the heap can't keep growing
forever - as you discovered, on x86 Linux the upper bound is just below
0x40000000. That boundary is where shared libraries and other memory-mapped
files start to appear.

Note that there is still plenty (~2GB) of address space left, in the region
between the shared libraries and the top of user address space (just under
0xBFFFFFFF). How do you use that space? You need an allocation scheme based
on mmap'ing /dev/zero. As others pointed out, glibc's allocator does just
that.

Here's your short answer: ask the authors of your program to either 1)
replace their custom allocator with regular malloc() or 2) enhance their
custom allocator to use mmap. (or, buy some 64-bit hardware =)...)

Dan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
