Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRBPPRy>; Fri, 16 Feb 2001 10:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRBPPRn>; Fri, 16 Feb 2001 10:17:43 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:17556 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129175AbRBPPRf>; Fri, 16 Feb 2001 10:17:35 -0500
Message-ID: <3A8D46C6.3873DF22@uow.edu.au>
Date: Sat, 17 Feb 2001 02:27:02 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <200102092240.OAA15902@penguin.transmeta.com> <3A8B08C7.BD79E3B4@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Intel Pentium III and P 4 have hardcoded "fast stringcopy" operations
> that invalidate whole cachelines during write (documented in the most
> obvious place: multiprocessor management, memory ordering)

Which are dramatically slower than a simple `mov' loop for just
about all alignments, except for source and dest both eight-byte
aligned.

For example, copying an unchached source to an uncached dest,
with the source misaligned, my PIII Coppermine does 108 MBytes/sec
with `rep;movsl' and 149 MBytes/sec with an open-coded variant
of our copy_csum routines.  That's a lot.  Similar results
on a PII and a PIII Katmai.

On the K6-2, however, the string operation is almost always
a win.

It seems that a good approximation for our bulk-copy strategy is:

	if (AMD) {
		string_copy();
	} else if (intel) {
		if ((source|dest) & 7)
			duff_copy();
		else
			string_copy();
	} else {
		quack();
	}

This will make our Intel copies 20-40% faster than
at present, depending upon the distribution of
alignments.  (And for networking, the distribution
is pretty much uniform).

Somewhere on my to-do list is getting lots of people to
test lots of architectures with lots of combinations of
[source/dest][cached/uncached] at lots of alignments
to confirm if this will work.

If you have time, could you please grab

	http://www.uow.edu.au/~andrewm/linux/cptimer.tar.gz

and teach it how to do SSE copies, in preparation for this
great event?

Thanks.

-
