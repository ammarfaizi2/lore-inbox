Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131572AbRA1GLJ>; Sun, 28 Jan 2001 01:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRA1GK7>; Sun, 28 Jan 2001 01:10:59 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:58786 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131572AbRA1GKr>; Sun, 28 Jan 2001 01:10:47 -0500
Message-ID: <3A73B7CF.E3FA84CF@Home.net>
Date: Sun, 28 Jan 2001 01:10:24 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10a i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <Pine.LNX.4.21.0101280119360.12703-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch appears to work,
for i in [0-9]*; do echo $i; cat $i/stat > /dev/null; done
completes successfully with xmms running in "real-time" priority.

Shawn.

Marcelo Tosatti wrote:

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
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
