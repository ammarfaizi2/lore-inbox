Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317397AbSFMBps>; Wed, 12 Jun 2002 21:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSFMBpr>; Wed, 12 Jun 2002 21:45:47 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:18493 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317397AbSFMBpl>; Wed, 12 Jun 2002 21:45:41 -0400
Date: Thu, 13 Jun 2002 02:45:40 +0100
From: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <3D07F797.6030007@zytor.com>
Message-ID: <Pine.SGI.4.33.0206130241230.4638397-100000@mole.bio.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, H. Peter Anvin wrote:
> Anton Altaparmakov wrote:
> >
> > The code would be run outside the critical region... But correct about
> > the race. I thought that was obvious and wasn't suggesting the above to be
> > the actual code... That was supposed to be obvious from lack of error
> > handling etc... Never mind. My mistake, I should have been more precise
> > the first time round, here is the actual code I had in mind:
> >
> > [snip]
> > 	if (unlikely(!ntfs_compression_buffers)) {
> > 		int err;
> >
> > 		/*
> > 		 * This code path only ever triggers once so we take it
> > 		 * out of line.
> > 		 */
> > 		if ((err = try_to_allocate_compression_buffers())) {
> > 			// TODO: do appropriate cleanups
> > 			return err;
> > 		}
> > 	}
> > 	disable_preempt();
> > 	cb = ntfs_compression_buffers[smp_processor_id()];
> > [snip]
> >
> > and try_to_allocate_compression_buffers would be:
> >
> > int try_to_allocate_compression_buffers(void)
> > {
> > 	int err = 0;
> >
> > 	down(&ntfs_lock);
> > 	if (likely(!ntfs_compression_buffers))
> > 		err = allocate_compression_buffers();
> > 	up(&ntfs_lock);
> > 	return err;
> > }
> >
> > and allocate_compression_buffers() is the same as it is now. Actually I
> > was going to fuse try_to_allocate and allocate into one function but as I
> > am showing above it is clearer to see what I had in mind...
> >
> > Happy now? This basically just defers the allocation to a bit later. As it
> > is at the moment the allocation happens at mount time of a partition which
> > supports compression. Note that the code in super.c would still need to
> > exist due to reference counting so we know when we can free the buffers
> > again. The only thing changed in super.c will be to remove the actual call
> > to allocate_compression_buffers, all else stays in place. Otherwise we
> > have no way to tell when we can throw away the buffers.
>
> I presume allocate_compression_buffers() allocates *all* buffers, and
> doesn't return error if there is nothing to allocate?  If so, the above
> code should be OK.
>
> If allocate_compression_buffers() either doesn't check if it has already
> allocated, or returns an error if buffers were already allocated, then
> the above code is OK *EXCEPT IN THE CASE OF HOTSWAP CPUs*.
>
> My originally proposed code allocated one buffer at a time, and should
> be correct even in the presence of hotswap CPUs.

allocate_compression_buffers() currently allocates all buffers up
smp_num_cpus which is fine without hotswap cpus. Once hotswap cpus path
goes in, then the allocation will be (pseudo code):

	for (i = 0; i < NR_CPUS; i++) {
		if (cpu_possible(i)) {
			ntfs_compression_buffer[i] = vmalloc();
			// TODO handle errors
		}
	}

That means in words that we allocate buffers only once and for all
existing cpu SOCKETS, i.e. including all potentially hotpluggable cpus
which are currently offline. - If someone invents hotpluggable cpu sockets
at some point then they should be burnt at the stake! (-;

Best regards,

	Anton

