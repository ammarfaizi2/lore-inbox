Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRC2AIh>; Wed, 28 Mar 2001 19:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132621AbRC2AI1>; Wed, 28 Mar 2001 19:08:27 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:25099 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S132625AbRC2AIO>;
	Wed, 28 Mar 2001 19:08:14 -0500
To: Rik van Riel <riel@conectiva.com.br>,
   Robert Suetterlin <sutter@robert2.mpe-garching.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not MTRR !? was: ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2
In-Reply-To: <Pine.LNX.4.21.0103281052510.8261-100000@imladris.rielhome.conectiva>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 29 Mar 2001 00:07:17 +0000
Message-ID: <y7rk859780a.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:
> On Wed, 28 Mar 2001, Robert Suetterlin wrote:
> > reg00: base=0xfb000000 (4016MB), size=  16MB: uncachable, count=1
> > reg01: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1
> > reg02: base=0x00000000 (   0MB), size=8192MB: write-back, count=1
> > reg03: base=0x200000000 (8192MB), size=4096MB: write-back, count=1
> > reg04: base=0x300000000 (12288MB), size=2048MB: write-back, count=1
> > reg05: base=0x380000000 (14336MB), size=1024MB: write-back, count=1
> > reg06: base=0x3c0000000 (15360MB), size= 512MB: write-back, count=1
> > reg07: base=0x3e0000000 (15872MB), size= 256MB: write-back, count=1
>                                            ------  +
>                                           15.75 GB
> 
> It looks like the last 256MB isn't cached (well, it doesn't
> have an MTRR at all) and Linux starts loading programs from
> the top of memory ...

It looks like the BIOS ran out of MTRRs.  I suspect this is one of the
reasons that Intel changed the PPro spec to allow overlapping MTRRs in
some cases, with uncached taking precedence.  The following sequence
of /proc/mtrr commands should give the same uncachable range with all
memory write-back cached:

# cat >/proc/mtrr
disable=2
disable=3
disable=4
disable=5
disable=6
disable=7
base=0 size=0x400000000 type=write-back
base=0x400000000 size=0x4000000 type=write-back
base=0x404000000 size=0x1000000 type=write-back
^D

(I think all those zeros are correct. 0x400000000 == 16GB, 0x4000000
== 64MB, 0x1000000 == 16MB)

It's probably also worth seeing if a BIOS update is available.


Dave Wragg
