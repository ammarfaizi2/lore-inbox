Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135460AbRA1FvP>; Sun, 28 Jan 2001 00:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131572AbRA1FvG>; Sun, 28 Jan 2001 00:51:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58896 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131584AbRA1Ful>; Sun, 28 Jan 2001 00:50:41 -0500
Date: Sun, 28 Jan 2001 02:01:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <Pine.LNX.4.21.0101280119360.12703-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101280155480.12703-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jan 2001, Marcelo Tosatti wrote:

> On Sat, 27 Jan 2001, Linus Torvalds wrote:
> 
> > 
> > 
> > On Sun, 28 Jan 2001, Marcelo Tosatti wrote:
> > > > 
> > > > This is the smoking gun here, I bet, but I'd like to make sure I see the
> > > > whole thing. I don't see _why_ we'd have deadlocked on __wait_on_page(),
> > > > but I think this is the thread that hangs on to the mm semaphore.
> > > 
> > > I was able to reproduce it here with dbench. 
> > > 
> > > Nothing is locked except this dbench thread (the only dbench thread):
> > > 
> > > dbench    D C1C9FE64  5200  1013      1        (L-TLB)    1370   785 
> > > Call Trace: [___wait_on_page+130/160] [truncate_list_pages+100/404] [truncate_inode_pages+93/128] [iput+162/360] [dput+262/356] [fput+121/232] [exit_mmap+218/292]  
> > > [mmput+56/80] [do_exit+208/680] [do_signal+566/656] [dput+25/356] [path_release+13/60] [sys_newstat+100/112] [sys_read+188/196] [signal_return+20/24]  
> > 
> > Ok, this definitely seems to be the pattern.
> > 
> > I don't see _what_ is going on, though.
> > 
> > I know of one "known bug" in pre10: if you run out of swap-space with
> > shared memory segments, it will do the wrong thing (return 1 without
> > unlocking the page). xmms might trigger this, but I didn't think that
> > dbench used shared memory?
> 
> It does. Bingo.
> 
> I'm not able to reproduce the problem here with your patch. 
> 
> Btw, there is another bug in shm_writepage() where it does not set the
> page dirty in case of failure...

Why dont you just put set_page_dirty() back in page_launder() in case
writepage() fails?

Otherwise you'll have to do in every specific implementation of
writepage(). 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
