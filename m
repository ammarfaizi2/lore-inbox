Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278386AbRJMT7C>; Sat, 13 Oct 2001 15:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278387AbRJMT6x>; Sat, 13 Oct 2001 15:58:53 -0400
Received: from [193.252.19.44] ([193.252.19.44]:59360 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278386AbRJMT6n>; Sat, 13 Oct 2001 15:58:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Linus Torvalds <torvalds@transmeta.com>, duncan.sands@math.u-psud.fr,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Al Viro <viro@redhat.com>
Subject: Re: xine pauses with recent (not -ac) kernels
Date: Sat, 13 Oct 2001 21:58:45 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01101208552800.00838@baldrick> <20011012161052.R714@athlon.random> <200110130351.f9D3pRp08271@penguin.transmeta.com>
In-Reply-To: <200110130351.f9D3pRp08271@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01101321584500.00779@baldrick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 October 2001  5:51 am, Linus Torvalds wrote:
> In article <01101300085600.00832@baldrick> you write:
> >> can you reproduce also on 2.4.12aa1?
> >>
> >> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4
> >>.12 aa1.bz2
> >>
> >> Andrea
> >
> >Yes, it seems to have the same problem.  It even seems a bit worse
> >(just my impression, I didn't do any statistics).
>
> Let me guess: xine opens the raw device, and does all the DVD parsing
> from there.
>
> Furthermore, maybe it closes and re-opens the device for each VOB file.
>
> Which in turn will invalidate the buffer and page cache, and force a
> re-read of all the metadata..  Oh, and wait for all the prefetching to
> have finished.
>
> If this is it, it should be "fixed" by doing a
>
> 	sleep 100000 < /dev/dvd-device &
>
> in the background before starting xine?
>
> Does that make any difference?
>
> If it does, then I suspect we should really look into making the raw
> device close just leave the device descriptor around at least for a
> while. Al?
>
> 		Linus

Good try, but no banana: I wasn't using raw IO!  (I use devfs
which didn't support raw devices last time I looked).  I experimented
a bit with raw io, your sleep idea and other things though:

devfs vs no devfs : no difference (problem present)

no raw io (devfs) + sleep : problem present
raw io (no devfs) : problem present, but less frequent (one time in three)
raw io (no devfs) + sleep : problem not present (tried three times)

I'm not sure whether the fact that xine didn't get stuck with raw io + sleep
means that it will never get stuck, or that I didn't try long enough.  I
rebooted the machine after every test since if I run xine several times
without rebooting, I get a pattern like this:
  problem
  problem
  ...
  problem
  correct
  correct
  correct...

So rebooting seemed like the best way to reset everything to the
same state for each test.  But it means that it takes time to run
each test, which is why there are not so many...

Thanks for looking into this,

Duncan.




