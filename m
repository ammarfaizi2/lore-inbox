Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTLDXXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTLDXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:23:54 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:53116 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S263728AbTLDXXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:23:50 -0500
Date: Thu, 4 Dec 2003 17:23:48 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031204172348.A14054@hexapodia.org>
References: <200312041432.23907.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200312041432.23907.rob@landley.net>; from rob@landley.net on Thu, Dec 04, 2003 at 02:32:23PM -0600
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> You can make a file with a hole by seeking past it and never writing to that 
> bit, but is there any way to punch a hole in a file after the fact?  (I mean 
> other with lseek and write.  Having a sparse file as the result....)

No, the only way to add a hole to a file is ftruncate(), lseek(),
write() (at least, that's the case at the UNIX API level).

> What are the downsides of holes?  (How big do they have to be to
> actually save space, is there a performance penalty to having a file
> with 1000 4k holes in it, etc...)

It's filesystem-dependent; some filesystems don't implement sparse
files.  The lower bound is one block; on extents-based filesystems like
XFS it might be bigger.  (If you've got 1GB of data, then a 1MB block of
zeros, then another GB of data, you're probably better off allocating a
single 2GB extent rather than two smaller extents with a hole.)

There's no inherent downside to holey files; in fact they can be a
straight-up performance win -- that's a block that doesn't need to be
read from disk, just hand the user a COW pointer to your zero page.  And
if you're lucky and the preceding and following blocks are allocated
adjacent on disk, you can do it all as a single streaming IO.

That said, having holes might make some pessimal behaviors more likely.

I'm curious -- does NTFS implement sparse files?  Does the Win32 API
provide any way to manipulate them?  Does the NT kernel have any sparse
file handling?

-andy

(This post is an exercise in "post possibly-inaccurate information in an
attempt to elicit corrections from people who know better", so take what
I say with a grain of salt.)
