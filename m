Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135972AbRA1EKf>; Sat, 27 Jan 2001 23:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136763AbRA1EKZ>; Sat, 27 Jan 2001 23:10:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:54032 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135972AbRA1EKG>; Sat, 27 Jan 2001 23:10:06 -0500
Date: Sun, 28 Jan 2001 00:20:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <94vu5o$1c6$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101280010320.12703-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(ugh, sorry about last mail)

On 27 Jan 2001, Linus Torvalds wrote:

> In article <3A737061.F1B914A3@linux.com>, David Ford  <david@linux.com> wrote:
> >Unfortunately klogd reads /proc....erg.
> >
> >So the following is a painstakingly slow hand translation, I'll only print
> >the D state entries unless someone asks otherwise.
> 
> You seem to be pretty much able to reproduce this at will, right?
> 
> I'd really like to see the raw System.map and dmesg output if your
> syslogd doesn't do a proper job of getting the symbols interpreted: just
> send the things by email, and I'll put something together.  It's too
> hard to interpret your half-way decoded thing, and I really want to see
> what this xmms thing is doing.. 
> 
> >xmms      D CACC5EA8  4116   713    155   715  (NOTLB)    1493   674
> >Call Trace: [<c0124966>] [<c012412f>] [<c01242b8>] [<c0144138>] [<c014238e>]
> >[<c0131cd0>] [<c01236b2>]
> >       [<c01239f2>] [<c01ac5ca>] [<c010d1f6>] [<c0108e7c>] [<c0108d5f>]
> >
> >c01248e4 T ___wait_on_page
> >c0124984 t __lock_page
> >
> >c01240dc t truncate_list_pages
> >c0124268 T truncate_inode_pages
> >c01242d4 t writeout_one_page
> 
> This is the smoking gun here, I bet, but I'd like to make sure I see the
> whole thing. I don't see _why_ we'd have deadlocked on __wait_on_page(),
> but I think this is the thread that hangs on to the mm semaphore.

I was able to reproduce it here with dbench. 

Nothing is locked except this dbench thread (the only dbench thread):

dbench    D C1C9FE64  5200  1013      1        (L-TLB)    1370   785 
Call Trace: [___wait_on_page+130/160] [truncate_list_pages+100/404] [truncate_inode_pages+93/128] [iput+162/360] [dput+262/356] [fput+121/232] [exit_mmap+218/292]  
[mmput+56/80] [do_exit+208/680] [do_signal+566/656] [dput+25/356] [path_release+13/60] [sys_newstat+100/112] [sys_read+188/196] [signal_return+20/24]  


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
