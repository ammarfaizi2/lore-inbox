Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSFLTl6>; Wed, 12 Jun 2002 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSFLTl5>; Wed, 12 Jun 2002 15:41:57 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:34542 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317314AbSFLTlz>; Wed, 12 Jun 2002 15:41:55 -0400
Date: Wed, 12 Jun 2002 13:39:21 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Message-ID: <20020612193921.GA682@clusterfs.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	vda@port.imtp.ilyichevsk.odessa.ua,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2002  19:34 +0100, Anton Altaparmakov wrote:
> At 18:36 12/06/02, Andreas Dilger wrote:
> >1) Allocate an array of NULL pointers which is NR_CPUs in size (you could 
> >   do this all the time, as it would only be a few bytes)
> 
> Yes, that is fine.
> 
> >2) If you need to do decompression on a cpu you check the array entry
> >   for that CPU and if is NULL you vmalloc() the decompression buffers once
> >   for that CPU.  This avoid vmalloc() overhead for each read.
> 
> The vmalloc() sleeps and by the time you get control back you are executing 
> on a different CPU. Ooops. The only valid way of treating per-cpu data is:
> 
> - disable preemption
> - get the cpu number = START OF CRITICAL SECTION: no sleep/schedule allowed
> - do work using the cpu number
> - reenable preemption = END OF CRITICAL SECTION
> 
> The only thing that could possibly be used inside the critical region is 
> kmalloc(GFP_ATOMIC) but we are allocating 64kiB so that is not an option. 
> (It would fail very quickly due to memory fragmentation, the order of the 
> allocation is too high.)

Well, then you can still do the one-time allocation for that CPU slot,
and re-check the CPU number after vmalloc() returns.  If it is different
(or always, for that matter) then you jump back to the "is the array for
this CPU allocated" check until the array _is_ allocated for that CPU
and you don't need to allocate it (so you won't sleep).  At most you
will need to loop once for each available CPU if you are unlucky enough
to be rescheduled to a different CPU after each call to vmalloc().

Like:
	int cpunum = this_cpu();
	char *newbuf = NULL;

	while (unlikely(NTFS_SB(sb)->s_compr_array[cpunum] == NULL)) {
		newbuf = vmalloc(NTFS_DECOMPR_BUFFER_SIZE);

		/* Re-check the buffer case we slept in vmalloc() and
		 * someone else already allocated a buffer for "this" CPU.
		 */
		if (likely(NTFS_SB(sb)->s_compr_array[cpunum] == NULL)) {
			NTFS_SB(sb)->s_compr_array[cpunum] = newbuf;
			newbuf = NULL;
		}
		cpunum = this_cpu();
	}
	/* Hmm, we slept in vmalloc and we don't need the new buffer */
	if (unlikely(newbuf != NULL))
		vfree(newbuf);

> >3) Any allocated buffers are freed in the same manner they are now -
> >   when the last compressed volume is unmounted.  There may be some or
> >   all entries that are still NULL.
> >
> >This also avoids allocating buffers when there are no files which are
> >actually compressed.
> 
> True it does, but unfortunately it doesn't work. )-:

Now it does... ;-).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

