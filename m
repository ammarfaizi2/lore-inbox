Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSFLVGc>; Wed, 12 Jun 2002 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317322AbSFLVGb>; Wed, 12 Jun 2002 17:06:31 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:12271 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314433AbSFLVGb>; Wed, 12 Jun 2002 17:06:31 -0400
Date: Wed, 12 Jun 2002 15:03:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Message-ID: <20020612210356.GD682@clusterfs.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>,
	vda@port.imtp.ilyichevsk.odessa.ua,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612213746.045b7b60@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2002  21:41 +0100, Anton Altaparmakov wrote:
> At 20:39 12/06/02, Andreas Dilger wrote:
> >At most you
> >will need to loop once for each available CPU if you are unlucky enough
> >to be rescheduled to a different CPU after each call to vmalloc().
> 
> Um are you suggesting compression buffers to be per mounted volume? That 
> would be more wasteful than the current approach of one buffer per CPU 
> globally for all of ntfs driver.

No, my mistake.  You should check whatever array you want.

> vfree() at a guess (I may be completely wrong on that one in which case I 
> appologize!) can also sleep so that breaks that scheme.

Well, just get rid of the while loop then and use an if+goto for both
the vmalloc and the vfree case.  At most we can loop NR_CPUS times.


	char *newbuf = NULL;
	int cpunum;
       
recheck:
	cpunum = current_cpu();
	if (unlikely(ntfs_compr_array[cpunum] == NULL)) {
		newbuf = vmalloc(NTFS_DECOMPR_BUFFER_SIZE);

		/*
		 * Re-check the buffer case we slept in vmalloc() and
		 * someone else already allocated a buffer for "this" CPU.
		 */
		if (likely(ntfs_compr_array[cpunum] == NULL)) {
			ntfs_compr_array[cpunum] = newbuf;
			newbuf = NULL;
		}
		goto recheck;
	}
	/* Hmm, we slept in vmalloc and we don't need the new buffer */
	if (unlikely(newbuf != NULL)) {
		vfree(newbuf);
		goto recheck;
	}

> But if doing something like that I might as well use the present 
> approach and just allocate all buffers at once if they haven't been 
> allocated yet and be done with it. Then no vfree()s are needed either and 
> then it really does work. (-;

But then you may be allocating a lot of memory for CPUs that don't
even exist, which is the whole point of this exercise.  Better to do
it on-demand and loop for the very few times needed.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

