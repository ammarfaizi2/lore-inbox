Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136405AbRA1Bzv>; Sat, 27 Jan 2001 20:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbRA1Bzl>; Sat, 27 Jan 2001 20:55:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35596 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136405AbRA1Bzc>; Sat, 27 Jan 2001 20:55:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ps hang in 241-pre10
Date: 27 Jan 2001 17:55:04 -0800
Organization: Transmeta Corporation
Message-ID: <94vu5o$1c6$1@penguin.transmeta.com>
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com> <3A737061.F1B914A3@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A737061.F1B914A3@linux.com>, David Ford  <david@linux.com> wrote:
>Unfortunately klogd reads /proc....erg.
>
>So the following is a painstakingly slow hand translation, I'll only print
>the D state entries unless someone asks otherwise.

You seem to be pretty much able to reproduce this at will, right?

I'd really like to see the raw System.map and dmesg output if your
syslogd doesn't do a proper job of getting the symbols interpreted: just
send the things by email, and I'll put something together.  It's too
hard to interpret your half-way decoded thing, and I really want to see
what this xmms thing is doing.. 

>xmms      D CACC5EA8  4116   713    155   715  (NOTLB)    1493   674
>Call Trace: [<c0124966>] [<c012412f>] [<c01242b8>] [<c0144138>] [<c014238e>]
>[<c0131cd0>] [<c01236b2>]
>       [<c01239f2>] [<c01ac5ca>] [<c010d1f6>] [<c0108e7c>] [<c0108d5f>]
>
>c01248e4 T ___wait_on_page
>c0124984 t __lock_page
>
>c01240dc t truncate_list_pages
>c0124268 T truncate_inode_pages
>c01242d4 t writeout_one_page

This is the smoking gun here, I bet, but I'd like to make sure I see the
whole thing. I don't see _why_ we'd have deadlocked on __wait_on_page(),
but I think this is the thread that hangs on to the mm semaphore.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
