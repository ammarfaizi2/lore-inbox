Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSIBQtL>; Mon, 2 Sep 2002 12:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSIBQtL>; Mon, 2 Sep 2002 12:49:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318326AbSIBQtJ>; Mon, 2 Sep 2002 12:49:09 -0400
Date: Mon, 2 Sep 2002 10:01:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: neilb@cse.unsw.edu.au, <linux-kernel@vger.kernel.org>,
       <linux-raid@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <UTC200209020853.g828rtj03830.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0209020950500.2452-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002 Andries.Brouwer@cwi.nl wrote:
> > HOWEVER, that disk change checking really should be done by
> > the generic layers, and it should be done after the open() anyway
> > (and not by the open)
> 
> Are you sure?
> I am inclined to think that this would be an undesirable change of
> open() semantics. Traditionally, and according to all standards,
> open() will return ENXIO when the device does not exist.

Well, one reason I don't want the low-level drivers doing the media change 
checking is that there's more to media change than just checking the 
media.

For example, the higher levels want to do a partition table re-read if the
media really has changed. We do have this strange "bd_invalidated" thing
for passing that information back, and maybe that is acceptable. It's a
bit subtle, though.

Another reason why it would be good to factor out media change from open() 
is that I can well imagine that somebody would want to do a "door open" 
ioctl on a device without a media, and we actually do kind of have that 
interface: opening with O_NDELAY historically means to not do the media 
change checks.

And guess what? Because that test is done inside the low-level driver
right now, it means that these O_NDELAY semantics aren't actually known or
followed by most drivers, _and_ it means that the higher levels don't even
realize that sometimes the media check hasn't gotten done at all (ie
because the low-level "open()" is called only for the _first_ open, the
higher levels right now won't even call "open()" at _all_ later on and so
the media checks aren't done later when they should be).

However, your ENXIO point is a good one, and implies that we really should 
have a more expressive "media_change()" function, so that if we'd factor 
out open()/media_check(), then we'd still get the right ENXIO thing.

		Linus

