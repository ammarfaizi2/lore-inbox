Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269353AbRGaQeW>; Tue, 31 Jul 2001 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRGaQeD>; Tue, 31 Jul 2001 12:34:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:10759 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269353AbRGaQeA>; Tue, 31 Jul 2001 12:34:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Boszormenyi Zoltan <zboszor@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: used-once really works?
Date: Tue, 31 Jul 2001 18:39:11 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <freemail.20010631154204.52946@fm5.freemail.hu>
In-Reply-To: <freemail.20010631154204.52946@fm5.freemail.hu>
MIME-Version: 1.0
Message-Id: <01073118391103.00303@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 31 July 2001 15:42, Boszormenyi Zoltan wrote:
> Hi!
>
> I freshly compiled 2.4.8-pre3 and I thought
> I give it a try.
>
> The machine is a dual P3 with 384MB memory and one
> 15 GB IDE disk, distro is RedHat 6.2 with official
> upgrades and e2fsprogs-1.22 and GNOME-1.4.
>
> In X, I had mozilla, and 3 gnome-terminals running.
> In one terminal, I run 'top', in one other
> 'dd if=/dev/hda of=/dev/null bs=4096'.
>
> 'top' showed that the system buffer cache filled up
> and soon the machine started swapping. It seemed to swap
> out mozilla and parts of the X server. Otherwise the
> system remained responsive.

There is no specific use-once handling for buffers so what happens is

  touch_buffer->SetPageReferenced

causes all referenced buffer pages to be moved lazilly from the 
inactive to active queue and unused readahead buffers to be dropped 
quickly.  It would be better if there were use-once handling for 
buffers too, so that your dd doesn't fill up memory and cause a (still 
mysterious to me) chain of events that ends up in swapping.

> I tried other more experimental patches, too:
> o_direct-10 and blkdev-pagecache-5. There was a one-liner
> reject in mm/vmscan.c after applying blkdev-pagecache-5.
>
> I fixed this and booted this new kernel, I tried the same.
> This time the page cache started to fill up but
> no swapping occured. Hm...
>
> During 'dd' starting new (I mean: not yet in the page cache)
> programs were slow as hell. Starting them second time was
> fast as expected.

The blkdev-pagecache patch is highly relevant to the discussion because 
it moves the dd resource load from buffers to the page cache, changing 
the behaviour of the system a great deal as you saw.  I think what is 
happening is, use-once makes a lot more inactive pages available from 
the dd so the system sees no need to go into swap (good).  But we also 
lose the scanning behaviour that used to throttle the dd process.  It 
now picks up new IO pages so quickly that it usually wins the 
competition for IO bandwidth.  (N.B., this is a *theory*, measurements 
needed.  If it's correct then we have to look at ways to be fairer 
about IO, something that's been needed for a long time anyway.)

> I tried glade with a large project file,
> loading it / looking into directories was slow at first,
> was fast second time. Since ext2 directories are in the
> page cache, this is perfectly understandable.

Yes, there is also no use-once handling for ext2 directories so the 
default behaviour is to lazily activate them.  Since directory pages 
are never treated as use-once, and they get a default boost in priority 
vs file IO.  It's probably ok to just leave it that way.

> So it seems that the used-once patch works.
> The only comments is that I didn't expect it
> to start swapping with the stock pre3.
> I supposed it frees the "used-once" pages more quickly.
> Anyway I am not a VM expert and don't flame me about
> my non relevant comments. 2.4.8 seems promising :-)

A little bit of digging should answer the swapping question.  Adding 
use-once handling to buffers should be a one-liner, after moving the 
check_used_once into a header.  I'll try it first before making any 
claims ;-)

--
Daniel
