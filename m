Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSDECw7>; Thu, 4 Apr 2002 21:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDECwk>; Thu, 4 Apr 2002 21:52:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29702 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311403AbSDECwe>;
	Thu, 4 Apr 2002 21:52:34 -0500
Message-ID: <3CAD1142.82527917@zip.com.au>
Date: Thu, 04 Apr 2002 18:51:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CACEF18.CE742314@zip.com.au> <200204050218.g352ILY32221@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> >       http://www.atnf.csiro.au/people/rgooch/linux/boot-scripts/
> 
> Around 20 seconds or less from when the kernel starts init(8) to when
> my XDM splash screen is up, last time I checked.

eww.  You need a doctored filesystem.

> ...
> > The theory was lovely.  And I tried all sorts of stuff.  But
> > the bottom line benefit was only about 10%.  The whole thing
> > was constrained by buffercache seek time - filesytem metadata.
> 
> The problem is that you're not listing the metadata blocks when
> building the database, right? And that's because Linus didn't want
> such hackery in the kernel. So instead we got the not-very-useful
> readahead system call.

No, everything was listed.  pagecache, buffercache.  This
was pre buffercache-in-pagecache.  I tried lots of stuff,
including intermingling pagecache and buffercache reads
in strict LBA order, buffercache first, no buffercache at
all.  Nothing really helped.  Fact is, all those files are
sprinkled all over the disk and a short seek is pretty much
as expensive as a long one.

The code's at http://www.zip.com.au/~akpm/linux/fboot.tar.gz -
it includes a demonstration of the ancient art of reading files
in a kernel module via insmod's standard input :)

> > Oh well.  The best benefit was in fact from launching all
> > the initscripts in parallel.  Lots of stuff broke because
> > of the lack of any sort of dependency system, but it was
> > appreciably quicker.
> 
> Of course, my boot scripts do the dependency stuff right (actually,
> it's the changes I made to simpleinit(8) that make it possible).

Yes, I've looked.  It's nice stuff.  The dependencies are critial.

> > I guess the greatest benefit would come from reorganising the
> > layout of the root filesystem's data and metadata so the
> > pagecache prepopulation doesn't have to seek all over the place.
> 
> Or being able to preload *everything* in ascending order...

I was preloading everything.  I certainly avoided the thought of
taking a *copy* of everything and placing it elsewhere on disk.
Scary coherency problems there.

One thing I did do a while back was to set up a new root filesystem
on a new disk via `tar cf - | (cd /newplace ; tar xf -)'.  But before
doing this I nobbled ext2's directory placement algorithm so
subdirectories in the new fs go in the same blockgroup as the parent.
This sped boots up quite a bit.  Probably the pagecache preload
code would work better with that setup.

Still.  Joe tells me (offlist) that his machine is taking
ages just to get to the "starting init" stage.

-
