Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSIFGyH>; Fri, 6 Sep 2002 02:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSIFGyH>; Fri, 6 Sep 2002 02:54:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318143AbSIFGyG>; Fri, 6 Sep 2002 02:54:06 -0400
Date: Thu, 5 Sep 2002 23:59:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D784F8A.CE0CF1DB@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0209052349070.15825-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Sep 2002, Helge Hafting wrote:
> 
> I can think of one case where large readahead hurts for floppy, even
> with partial completion:
> 
> 1. Grab a stack of floppies
> 2. Try mounting (or mount+ls) one after another,
>    in search of the right one.

Note that the delay for motor on/off is _much_ larger than the actual 
delay for seeking.

The seek itself is on the order of a few ms, with the head settle time 
being in the tens (possibly even a few hundred) ms per track. So assuming 
you end up reading 4 tracks or so due to readahead, that's still in the 
range of about one second.

In contrast, the motor on/off time is something like 5 seconds if I
remember correctly. Of course, you can certainly eject the floppy while
the motor is still running, but I'd suggest against it.

> So I think a smaller readahead might make sense for floppies,
> unless people don't do this sort of search anymore.  I don't.

I do agree that a 64kB readahead is likely to be excessive on a floppy, 
I'm just saying that I doubt it will be all that noticeable in most cases. 

The absolute worst case is when opening, reading a sector, and closing
again several times in succession, at which point right now we'll end up
serializing. But even at 64kB, that's going to be faster than most people
can change floppies if they actually want to even glance at what the
contents are.

The reason I want the first sectors to be returned early is that I thought 
it was quite noticeable to do just a simple "ls" on the floppy when I 
tested. Of course, that may be just me: it's literally been several years 
since I really used floppies, and maybe they really always were that slow. 
But I thought the root directory was on track zero, so it _should_ return 
it first thing. 

Oh, well. I don't seem to be the only one who doesn't use the dang things 
any more. The floppy driver has been broken in 2.5.x for half a year or 
whatever, and there weren't _that_ many people who ever even mentioned it. 

			Linus

