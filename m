Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFBVD>; Fri, 5 Jan 2001 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbRAFBUn>; Fri, 5 Jan 2001 20:20:43 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:29190 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S129324AbRAFBUl> convert rfc822-to-8bit; Fri, 5 Jan 2001 20:20:41 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        bmayland@leoninedev.com (Bryan Mayland)
Cc: kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] VESA framebuffer w/MTRR locks 2.4.0 on init
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 06 Jan 2001 01:20:15 +0000
Message-ID: <y7rk889wk6o.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > loop with no exit, as each size mtrr fails.
> >                  while (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB,
> > 1)==-EINVAL) {
> >                          temp_size >>= 1;
> >                  }
> 
> Ok that one is the bug.

Even with the obvious bug fixed, that code is strange.  "temp_size >>=
1" does little to improve the chances of the mtrr_add succeeding.
Something like this would be better:

if (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1) == -EINVAL) {
        /* Find the largest power-of-two */
        while (temp_size & (temp_size - 1))
                temp_sze &= (temp_size - 1);

        mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1);
}


(But this is just a very crude way to work around the inflexibility of
the MTRRs.  Rather than cluttering up calls to mtrr_add, it would be
better to fix this properly, either by implementing PAT support
(Zoltán Böszörményi said he was working on that), or by having a
user-space helper program to make more intelligent MTRR allocations,
or both.)


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
