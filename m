Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUH0Ken@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUH0Ken (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUH0Ken
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:34:43 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:29959 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261375AbUH0Keg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:34:36 -0400
Message-ID: <2ff2162804082703342bca4594@mail.gmail.com>
Date: Fri, 27 Aug 2004 16:04:33 +0530
From: BAIN <bainonline@gmail.com>
Reply-To: BAIN <bainonline@gmail.com>
To: Lei Yang <leiyang@nec-labs.com>
Subject: Re: Compression filter for Loopback device
Cc: pmarques@grupopie.com, Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <951A499AA688EF47A898B45F25BD8EE80126D4DB@mailer.nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <951A499AA688EF47A898B45F25BD8EE80126D4DB@mailer.nec-labs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I missed this mail for almost a month, but neway 
i was also looking at something similar but failed to find nething,
(donno why zloop didn't show up on sf search)

My main reason to search something like this was triggered due to the
discussion on lkml about the necessity of the swap.

The idea i had was to mount a swap partition over a compressed block
device implemented in the ram, this way few of my biggest problems in
current projects would be solved,

1. The project is embedded project and is running out of ram quite
frequently, i have bunch of monitor stuff in userspace which is
triggered only at moderate intervals and does not need to be in memory
all the time. swap is what is required here but unfortunately i have
no backing store for swap. (not all the tasks kick in at one time
neway so swap will be just fine).

2. This also does seem to be good idea on top of IMHO otherwise silly
stuff like this
http://kerneltrap.org/node/view/3660 [ using ram as swap : kerneltrap.org ]

3. And according to discussion on lkml few months back , kernel is
suppose to work better if swap is enabled ?

NE progress neone of you have made so far

i was kinda alone doing this so this is going very slow, but will
speed up the things if i am backed up :).

BAIN
On Mon, 26 Jul 2004 08:48:21 -0400, Lei Yang <leiyang@nec-labs.com> wrote:
> Hmm, I am a bit surprised to see this...
> Since I am the one who posted the question, could anyone pls give me
> some clue of what is going on? Or something like a summary. Many many
> thanks!!
> 
> Lei
> 
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paulo Marques
> Sent: Monday, July 26, 2004 8:38 AM
> To: Phillip Lougher
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Compression filter for Loopback device
> 
> On Fri, 2004-07-23 at 19:20, Phillip Lougher wrote:
> > On Thu, 2004-07-23 Paulo Marques wrote:
> >  >
> >  >I did start working on something like that a while ago. I even
> >  >registered for a project on sourceforge:
> >  >
> >  >http://sourceforge.net/projects/zloop/
> >  >
> >  >    - The block device doesn't understand anything about files. This
> is
> >  >an advantage because it will compress the filesystem metadata
> >  >transparently, but it is bad because it compresses "unused" blocks
> of
> >  >data. This could probably be avoided with a patch I saw floating
> around
> >  >a while ago that zero'ed delete ext2 files. Zero'ed blocks didn't
> accupy
> >  >any space at all in my compressed scheme, only metadata (only 2
> bytes
> >  >per block).
> >  >
> >
> > The fact the block device doesn't understand anything about the
> > filesystem is a *major* disadvantage.  Cloop has a I/O and seeking
> > performance hit because it doesn't understand the filesystem, and this
> 
> > will be far worse for write compression.  Every time a block update is
> 
> > seen by your block layer you'll have to recompress the block, it is
> > going to be difficult to cache the block because you're below the
> block
> > cache (any writes you see shouldn't be cached).  If you use a larger
> > compressed block size than the block size, you'll also have to
> > decompress each compressed block to obtain the missing data to
> > recompress.  Obviously Linux I/O scheduling has a large part to play,
> > and you better hope to see bursts of writes to consecutive disk
> blocks.
> 
> Yes, I agree it is a major disadvantage. That is way I listed this as
> one of the reasons to drop the project altogether :)
> 
> Anyway, my main concern was compression ratio, not performance.
> 
> Seek times are very bad for live CD distros, but are not so bad for
> flash or ram media.
> 
> >  >I did a proof of concept using a nbd server. This way I could test
> >  >everything in user space.
> >  >
> >  >With this NBD server I tested the compression ratios that my scheme
> >  >could achieve, and they were much better than those achieved by
> cramfs,
> >  >and close to tar.gz ratios. This I wasn't expecting, but it was a
> nice
> >  >surprise :)
> >
> > I'm very surprised you got ratios better than CramFS, which were close
> 
> > to tar.gz.  Cramfs is actually quite efficient in it's use of
> metadata,
> > what lets cramfs down is that it compresses in units of the page size
> or
> > 4K blocks.  Cloop/Squashfs/tar.gz use much larger blocks which obtain
> > much better compression ratios.
> >
> > What size blocks did you do your compression and/or what compression
> > algorithm did you use?  There is a dramatic performance trade-off
> here.
> > If you used larger than 4K blocks every time your compressing block
> > device is presented with a (probably 4K) block update, you need to
> > decompress your larger compression block, very slow.  If you used 4K
> > blocks then I cannot see how you obtained better compression than
> cramfs.
> 
> You are absolutely correct. I was using 32k block size, with 512 byte
> "sector size". A 32k block would have to compress into an integer number
> of 512 byte sectors. Most of my wasted space comes from this, but I was
> assuming that this would have to work over a real block device, so I
> tried as much as possible to make every read/write request to the
> underlying file to be "512-byte block"-aligned.
> 
> The compression algorithm was simply the standard zlib deflate.
> 
> But has I said before, my major concern was compression ratio.
> 
> I left the block size selectable on mk.zloop, so that I could test
> several block sizes and measure compress ratio / performance.
> 
> >From what I remember, 4k block sizes really hurt compression ratio. 32k
> was almost as good as 128k or higher.
> 
> What I would really like to know is if anyone has real world
> applications for a compression scheme like this, or is this just a waste
> of time...
> 
> --
> Paulo Marques - www.grupopie.com
> "In a world without walls and fences who needs windows and gates?"
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
