Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315747AbSEJAtT>; Thu, 9 May 2002 20:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSEJAtS>; Thu, 9 May 2002 20:49:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315747AbSEJAtR>;
	Thu, 9 May 2002 20:49:17 -0400
Message-ID: <3CDB18CF.82DD6D6B@zip.com.au>
Date: Thu, 09 May 2002 17:48:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <m31yck9700.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > For bulk read() and write() I/O the best sized buffer is 8 kbytes.  4k is
> > pretty good, too.  Anything larger blows the user-side buffer out of L1.
> > This is for x86.
> 
> Modern x86 support prefetch hints for the CPU to tell it to not
> pollute the caches with "streaming data". I bet using them would
> be a big win.

Maybe.  For your basic:

	for (many) {
		read(fd1, buf, 8192);
		write(fd2, buf, 8192);
	}

you want `buf' cached, but not the pagecache for fd1 and fd2.
If the prefetch hints can express that then yes, nice.

> The rep ; movsl loop used in copy*user isn't
> very good on modern x86 anyways (it is ok on PPro, but loses on Athlon
> and P4)

On PII and PIII, rep;movsl is slower than an open-coded
duff-device copy for all src/dest alignments except for
the case where both are eight-byte-aligned.  By up to
20%, iirc.  four-byte-aligned to four-byte-aligned isn't
too bad.

Of course, a lot of copy_*_users are well-aligned.  But
a lot are not.  I ended up deciding that switching to
the duff-device copy would be a very small overall win, when
you weight it by the alignment patterns of normal kernel
usage.

But making a runtime slection of which copy function to
use (based on src/dest alignment) could speed up the
kernel's most expensive function by maybe 10-15% overall.

The test proggy is in http://www.zip.com.au/~akpm/linux/cptimer.tar.gz


-
