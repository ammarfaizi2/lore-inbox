Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281807AbRKQTDR>; Sat, 17 Nov 2001 14:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281808AbRKQTDI>; Sat, 17 Nov 2001 14:03:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14298 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281807AbRKQTDD>;
	Sat, 17 Nov 2001 14:03:03 -0500
Date: Sat, 17 Nov 2001 14:03:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: wwcopt@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
In-Reply-To: <Pine.LNX.4.33.0111171052060.1458-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111171359410.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Nov 2001, Linus Torvalds wrote:

> 
> On Sat, 17 Nov 2001, Alexander Viro wrote:
> >
> > Frankly, I'd prefer to try (b) before reverting to (a).  Patch doing that
> > variant follows.  Linus, your opinion?
> 
> (d) make seq_file have my originally suggested "subposition" code.
> 
> Ie make the X low bits of "pos" be the position in the record, with the
> high bits of "pos" being the current "record index" kind of thing.
> 
> That makes lseek() happy.

It will not help.  lseek() in question is relative and crosses the
record boundary.  I.e. we have

	n = read(fd, buf, ...);
	/* process k bytes */
	lseek(fd, k-n, SEEK_CUR);

and that will break just as the current variant does.  It's not about
seek to remembered position - it's a relative seek to calculated offset.
Calculated from number of bytes returned by read().

