Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSKQA>; Tue, 19 Dec 2000 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLSKPu>; Tue, 19 Dec 2000 05:15:50 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:57358 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S129183AbQLSKPn>;
	Tue, 19 Dec 2000 05:15:43 -0500
Date: Tue, 19 Dec 2000 10:45:12 +0100
From: Stelian Pop <stelian.pop@alcove.fr>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for emulating a tape device on top of a cd writer...
Message-ID: <20001219104512.A10971@wiliam.alcove-int>
Reply-To: Stelian Pop <stelian.pop@alcove.fr>
In-Reply-To: <20001218112529.B6315@wiliam.alcove-int> <20001218190442.B473@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001218190442.B473@suse.de>; from axboe@suse.de on Mon, Dec 18, 2000 at 07:04:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 07:04:42PM +0100, Jens Axboe wrote:

> > Basically, I would like to be able to use a cdwriter as a tape
> > device, with software like dump(8) or tar(1). With /dev/tcdw
> > as name (for example), I'd like to be able to do:
> > [...]

> What you describe is actually one of the goals of the packet writing
> driver. To do this reliably you need packet writing, I won't even
> start to think about the headaches wihtout it...

Yes, I saw your patch for packet writing but:
- the CD written with packet writing software may not be readable
  on standard CD-ROM drives (and I want that, because almost 
  everybody has one).

- using packet writing you basically write _files_ on top of an
  UDF filesystem. Tar and dump (or afio, cpio etc) does not
  support that kind of access, they expect to be given a character
  device they can stream data to. (Of course, it is possible to
  add some additionnal level of indirection on top of the packet
  device and provide character based access to the UDF files, but
  IMHO _this_ would be overkill).

- data backups are expected to be fast. Writing data in DAO/TAO
  mode is much quicker than in packet mode.

- reliability is a question of implementation. cdrecord can
  be very reliable. If a user space application can provide this
  level of reliability, it should be even simpler to achieve it
  in kernel space (and I plan to use the BurnProof/etc extensions
  which will be present on all future cdwriters).

> > I'll start to work on this, probably by looking at the cdrecord 
> > low level code and porting it into kernel space.
> 
> Oh god no! You can do all this from user space.

Please pay attention to the fact that I was refering to the 'low level
code'. I don't intend to write a driver who can replace cdrecord. 
_This_ would be madness.

What I indend to do is just a 'small' driver, which supports only the
mmc drives. I expect the driver to be only some hundreds lines long.

Doing that from user space would mean propagating the data from
the user space application (dump or tar) to a character mode
driver, and back to a user space application (something like a hacked 
cdrecord), which will return in kernel space using sg interface...
It could be easier to write (even if I don't exactly feel confident
about hacking the cdrecord source :) ), but the reliability and
the performance would be far far away...

-- 
Stelian Pop <stelian.pop@alcove.fr>
| Alcôve - http://www.alcove.fr
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
