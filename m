Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131752AbQLJWW2>; Sun, 10 Dec 2000 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133054AbQLJWWI>; Sun, 10 Dec 2000 17:22:08 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:56074 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S131752AbQLJWWD>;
	Sun, 10 Dec 2000 17:22:03 -0500
Date: Sun, 10 Dec 2000 22:55:29 +0100
From: Miloslav Trmac <mitr@volny.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] truncate () doesn't clear partial pages
Message-ID: <20001210225529.A3730@linux.localdomain>
In-Reply-To: <20001210210352.A764@linux.localdomain> <Pine.GSO.4.21.0012101529470.4846-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012101529470.4846-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Dec 10, 2000 at 03:30:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Dec 10, 2000 at 03:30:41PM -0500, Alexander Viro wrote:
> On Sun, 10 Dec 2000, Miloslav Trmac wrote:
> > Hi,
> > vmtruncate () in test11 doesn't clear ends of partial pages. Patch is attached
> 
> It doesn't and it shouldn't. That's done in ->truncate(). Check ext2_truncate()
> for example.
ext2_truncate () (or block_truncate_page (), to be precise) clears end of
page-cache page. partial_clear () in mm/memory.c is IMHO supposed to clear
ends of anonymous pages (created from COW on MAP_PRIVATE mappings).
I wasn't adding any new functionality, just correcting the old
implementation (which would never trigger).

[Yes, currently it would clear the end of the page-cache
page as many times as the page is accessible trough a pte.
partial_clear () should probably clear *only* anonymous
and swap pages.]

Actually, I'm not that sure that MAP_PRIVATE partial pages should be
cleared; SuSv2 only says "the whole pages beyond the new end will be
discarded" [ftruncate ()] and "It is unspecified whether modifications
to the underlying object done after the MAP_PRIVATE mapping is established
are visible through the MAP_PRIVATE mapping." [mmap ()].
So maybe not clearing the pages is The Right Thing - especially as it avoids
the trouble with swapped-out pages. Remove partial_clear () completely, then.
	Mirek Trmac
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
