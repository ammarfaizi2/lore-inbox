Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUBLKEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 05:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266320AbUBLKEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 05:04:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42378 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266314AbUBLKEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 05:04:06 -0500
Date: Thu, 12 Feb 2004 11:04:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <20040212100446.GA2862@elte.hu>
References: <1076384799.893.5.camel@gaston> <Pine.LNX.4.58.0402100814410.2128@home.osdl.org> <20040210173738.GA9894@mail.shareable.org> <20040213002358.1dd5c93a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213002358.1dd5c93a.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > The real question is - why does malloc() break?  I'd expect malloc()
> > to use MAP_ANON these days, when brk() fails.  But it seems not.
> 
> Yep, that's the real bug.

i've pasted the relevant glibc malloc code below - it does use mmap() as
a fallback.

why in this particular case it failed i dont know - i believe some
_minimal_ brk space is supposed to be available though, so if you break
mmap() to fill in the brk space then that might break glibc assumptions.

	Ingo


  if (size > 0)
    brk = (char*)(MORECORE(size));

  if (brk != (char*)(MORECORE_FAILURE)) {
    /* Call the `morecore' hook if necessary.  */
    if (__after_morecore_hook)
      (*__after_morecore_hook) ();
  } else {
  /*
    If have mmap, try using it as a backup when MORECORE fails or
    cannot be used. This is worth doing on systems that have "holes" in
    address space, so sbrk cannot extend to give contiguous space, but
    space is available elsewhere.  Note that we ignore mmap max count
    and threshold limits, since the space will not be used as a
    segregated mmap region.
  */

#if HAVE_MMAP
    /* Cannot merge with old top, so add its size back in */
    if (contiguous(av))
      size = (size + old_size + pagemask) & ~pagemask;

    /* If we are relying on mmap as backup, then use larger units */
    if ((unsigned long)(size) < (unsigned long)(MMAP_AS_MORECORE_SIZE))
      size = MMAP_AS_MORECORE_SIZE;

    /* Don't try if size wraps around 0 */
    if ((unsigned long)(size) > (unsigned long)(nb)) {

      char *mbrk = (char*)(MMAP(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE));

      if (mbrk != MAP_FAILED) {

        /* We do not need, and cannot use, another sbrk call to find end */
        brk = mbrk;
        snd_brk = brk + size;

        /*
           Record that we no longer have a contiguous sbrk region.
           After the first time mmap is used as backup, we do not
           ever rely on contiguous space since this could incorrectly
           bridge regions.
        */
        set_noncontiguous(av);
      }
    }
#endif
  }

