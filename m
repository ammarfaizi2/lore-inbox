Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSAUBMM>; Sun, 20 Jan 2002 20:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288851AbSAUBMD>; Sun, 20 Jan 2002 20:12:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285692AbSAUBLm>; Sun, 20 Jan 2002 20:11:42 -0500
Date: Mon, 21 Jan 2002 02:12:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
Message-ID: <20020121021224.O21279@athlon.random>
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com.suse.lists.linux.kernel> <3C48607C.35D3DDFF@redhat.com.suse.lists.linux.kernel> <20020120201603.L21279@athlon.random.suse.lists.linux.kernel> <p734rlg90ga.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <p734rlg90ga.fsf@oldwotan.suse.de>; from ak@suse.de on Sun, Jan 20, 2002 at 10:28:21PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 10:28:21PM +0100, Andi Kleen wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> > 
> > if you read in chunks of a few mbytes per read syscall, the lack of
> > readahead shouldn't make much difference (this is true for both raid and
> > standalone device). If there's a relevant difference it's more liekly an
> > issue with the blocksize.
> 
> The problem with that is that doing overlapping IO requires much more
> effort (you need threads in user space). If you don't do overlapping
> IO you add a latency bubble for each round trip to user space after you
> read one big chunk and submitting the request for the next big chunk.
> Your disk will not be constantly streaming, because of these pauses where
> it doesn't have an request to process. 

correct, we can't keep the pipeline always full, the larger the size of
the read/write, the lower it will matter, this is the only way to hide
the pipeline stall at the moment (like with rawio).

> The application could do it using some aio setup, but it gets rather
> complicated and the kernel already knows how to do that well.

yes, in short the API to allow the userspace to keep the I/O pipeline
full with a ring of user buffers is not available at the moment.

As you say one could try to workaround it by threading the I/O in
userspace but it would get rather dirty (and with a scheduling
overhead).

> 
> I think an optional readahead mode for O_DIRECT would be useful. 

to do transparent readahead we'll need to use the pagecache, so we'd need
to make copies of pages with the cpu between usermemory and pagecache,
but the nicer part of O_DIRECT is that it skips the costly copies
with the cpu on the membus, so I usually disagree about trying to allow
O_DIRECT to support readahead. I believe if you need readahead, you
probably shouldn't use O_DIRECT in the first place.

Andrea
