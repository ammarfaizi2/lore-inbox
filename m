Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSFMBeG>; Wed, 12 Jun 2002 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSFMBeF>; Wed, 12 Jun 2002 21:34:05 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:1341 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317393AbSFMBeC>; Wed, 12 Jun 2002 21:34:02 -0400
Date: Thu, 13 Jun 2002 02:33:54 +0100
From: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <3D07C977.7090603@zytor.com>
Message-ID: <Pine.SGI.4.33.0206130210170.4638397-100000@mole.bio.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, H. Peter Anvin wrote:
> Anton Altaparmakov wrote:
> >>
> >> Note that there is no requirement that we're still on cpu "cpu" when
> >> we allocate the buffer.  Furthermore, if we fail, we just loop right
> >> back to the top.
> >
> > What is the point though? Why not just:
> >
> >         if (!unlikely(decompression_buffers)) {
> >                 down_sem();
> >                 allocate_decompression_buffers();
> >                 up_sem();
> >         }
> >
> > And be done with it?
> >
> > I don't see any justification for the increased complexity...
>
> Race condition -- you have to drop out of the critical section before
> you grab the allocation sempahore, and another CPU can grab the
> semaphore in that time.
>
> Thus, the buffers might appear right under your nose.

The code would be run outside the critical region... But correct about
the race. I thought that was obvious and wasn't suggesting the above to be
the actual code... That was supposed to be obvious from lack of error
handling etc... Never mind. My mistake, I should have been more precise
the first time round, here is the actual code I had in mind:

[snip]
	if (unlikely(!ntfs_compression_buffers)) {
		int err;

		/*
		 * This code path only ever triggers once so we take it
		 * out of line.
		 */
		if ((err = try_to_allocate_compression_buffers())) {
			// TODO: do appropriate cleanups
			return err;
		}
	}
	disable_preempt();
	cb = ntfs_compression_buffers[smp_processor_id()];
[snip]

and try_to_allocate_compression_buffers would be:

int try_to_allocate_compression_buffers(void)
{
	int err = 0;

	down(&ntfs_lock);
	if (likely(!ntfs_compression_buffers))
		err = allocate_compression_buffers();
	up(&ntfs_lock);
	return err;
}

and allocate_compression_buffers() is the same as it is now. Actually I
was going to fuse try_to_allocate and allocate into one function but as I
am showing above it is clearer to see what I had in mind...

Happy now? This basically just defers the allocation to a bit later. As it
is at the moment the allocation happens at mount time of a partition which
supports compression. Note that the code in super.c would still need to
exist due to reference counting so we know when we can free the buffers
again. The only thing changed in super.c will be to remove the actual call
to allocate_compression_buffers, all else stays in place. Otherwise we
have no way to tell when we can throw away the buffers.

Best regards,

Anton

