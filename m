Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130316AbRAFRI5>; Sat, 6 Jan 2001 12:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbRAFRIr>; Sat, 6 Jan 2001 12:08:47 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:34802 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S130316AbRAFRIf>;
	Sat, 6 Jan 2001 12:08:35 -0500
Message-ID: <3A575104.F06D87BC@leoninedev.com>
Date: Sat, 06 Jan 2001 12:08:20 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Wragg <dpw@doc.ic.ac.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/MTRR locks 2.4.0 on init
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu> <y7rk889wk6o.fsf@sytry.doc.ic.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg wrote:

> Something like this would be better:
> if (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1) == -EINVAL) {
>         /* Find the largest power-of-two */
>         while (temp_size & (temp_size - 1))
>                 temp_sze &= (temp_size - 1);
>         mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1);
> }
> (But this is just a very crude way to work around the inflexibility of
> the MTRRs.  Rather than cluttering up calls to mtrr_add, it would be
> better to fix this properly

    I agree.  VesaFB is the only code (as far as I know) which attempts to grab
an MTRR more than once.  The restrictions on MTRR size and alignment are too
numerous to attempt a logical resizing in a small amount of code-- especially
since the retrictions are different depending on the processor.  Might I suggest
that the looping code be taken out entirely, perhaps outputting success or
failure like:
#ifdef CONFIG_MTRR
if (mtrr)
  if (mtrr_add(video_base, video_size, MTRR_TYPE_WRCOMB, 1) == -EINVAL)
    printk(KERN_INFO "vesafb:  Could not allocate MTRR\n");
  else
    printk(KERN_INFO "vesafb:  MTRR Write-Combining enabled\n");
#endif  /* CONFIG_MTRR */

Bry

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
