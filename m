Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAKAAI>; Wed, 10 Jan 2001 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRAJX7s>; Wed, 10 Jan 2001 18:59:48 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:61969 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S129641AbRAJX70>;
	Wed, 10 Jan 2001 18:59:26 -0500
Date: Wed, 10 Jan 2001 16:03:39 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        "William A. Stein" <was@math.harvard.edu>, Dan Maas <dmaas@dcine.com>
Subject: Re: Subtle MM bug (really 830MB barrier question)
In-Reply-To: <Pine.LNX.4.30.0101092109580.1092-100000@fs129-124.f-secure.com>
Message-ID: <Pine.LNX.4.30.0101101454040.27513-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Szabolcs Szakacsits wrote:

> 3) ask kernel developers to get rid of this "brk hits the fixed start
> address of mmapped areas" or the other way around complaints "mmapped
> area should start at lower address" limitation. E.g. Solaris does
> growing up heap, growing down mmap and fixed size stack at the top.

OK, despite knowing nothing of the kernel internals, I looked at doing
this myself :-)

I notice that TASK_UNMAPPED_BASE is only used in get_unmapped_area() in
mm/mmap.c, which is encouraging.  Moreover, get_unmapped_area() is only
called once in mm/mmap.c and once in mm/mremap.c.  So I think I would only
have to change get_unmapped_area() to get the desired effect, and this
change should not affect anything else.

If no address is specified, get_unmapped_area() currently chooses the
first (large enough, unused) region above TASK_UNMAPPED_BASE.  I guess I
would just have to define something like TASK_UNMAPPED_CEILING and arrange
for get_unmapped_area() to allocate the first region below
TASK_UNMAPPED_CEILING.  And I guess TASK_UNMAPPED_CEILING should equal
TASK_SIZE - maximum stack size.  What is the maximum stack size?  I
couldn't quite figure this out myself.

Am I missing something, or should choosing an appropriate value for
TASK_UNMAPPED_CEILING and changing get_unmapped_area() be sufficient?

Cheers,
Wayne






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
