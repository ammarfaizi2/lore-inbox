Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289679AbSAOVXk>; Tue, 15 Jan 2002 16:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289671AbSAOVXa>; Tue, 15 Jan 2002 16:23:30 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23989 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289679AbSAOVXO>; Tue, 15 Jan 2002 16:23:14 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201152123.g0FLN6K06540@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
To: axboe@suse.de (Jens Axboe)
Date: Tue, 15 Jan 2002 13:23:06 -0800 (PST)
Cc: andrea@suse.de (Andrea Arcangeli), jlbec@evilplan.org (Joel Becker),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <20020115145549.M31878@suse.de> from "Jens Axboe" at Jan 15, 2002 01:55:49 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wouldn't this cause, single IO to split into (possibly) 3 I/Os for 
RAW VARY on all unaligned IOs ? In that case, wouldn't it be better
of doing entire I/O with 512byte buffer heads, so that all of them 
can be merged ?

IMHO, preventing the merge due to b_size mismatch just to handle few
drivers/hardware may be overkill. This will penalize all the drivers
which can handle variable size IOs also. Isn't it ? Leaving it to
the driver and doing variable size I/O on only the drivers that can 
handle them, may be a better option ?

In my initial version of RAW VARY patch, I split the I/Os into possibly
3 I/O in raw.c. Do brw_kiovec(.., 512) for the first page and last pages &
4K for the middle pages. It showed reduction in CPU utilization for
large IOs. But it since it could split single I/O into 3 I/Os, i did
not see significant I/O throughput improvement.

Regards,
Badari



> 
> On Tue, Jan 15 2002, Jens Axboe wrote:
> > On Tue, Jan 15 2002, Andrea Arcangeli wrote:
> > > actually we could also forbid merging at the ll_rw_block layer if b_size
> > > is not equal, maybe that's the simpler solution to that problem after
> > > all, merging between kiovec I/O and buffered I/O probably doesn't
> > > matter.
> > 
> > Agreed, this is also what I suggested.
> 
> Here's the right version, sorry. This still potentially decrements
> elevator sequence wrongly for a missed front merge, but that's an issue
> I can definitely live with :-)
> .... 
