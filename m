Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRJZSZv>; Fri, 26 Oct 2001 14:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278823AbRJZSZm>; Fri, 26 Oct 2001 14:25:42 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:50816 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S278818AbRJZSZd>; Fri, 26 Oct 2001 14:25:33 -0400
Date: Fri, 26 Oct 2001 20:25:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Richard Henderson <rth@redhat.com>
cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
In-Reply-To: <20011026100346.C1663@redhat.com>
Message-ID: <Pine.GSO.3.96.1011026200722.24417C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Richard Henderson wrote:

> >  The following trivial patch reportedly fixes OSF/1 programs using 31-bit
> > addressing.  It's already present in the -ac tree; I guess it just got
> > lost during a merge.  It applies fine to 2.4.13. 
> 
> This is the patch that Jay Estabrook forwarded me that I rejected
> in favour of writing a special arch_get_unmapped_area.

 Ah, that is a fine approach as well; I just considered the change small
enough it's not worth making it arch-specific.  Besides, my patch alsoo 
has a small advantage of keeping the search algorithm the same across all
the archs.

> > It used to do so.  It breaks things such as dynamic linking of shared
> > objects linked at high load address.
> 
> Err, how?

 I mean, the original algorithm as implemented in 2.4.9.  If you had asked
e.g. for memory above TASK_SIZE you would have got an error no matter how
much address space was still available below.

> > It breaks mmap() in principle, as it shouldn't fail when invoked with
> > a non-zero, non-MAP_FIXED, invalid address if there is still address
> > space available elsewhere. 
> 
> No, it doesn't.  Or rather, it only does if you only bothered
> to search once.  IMO one should search thrice: once at addr,
> once at TASK_UNMAPPED_BASE, and once at PAGE_SIZE.

 OK, but I'd prefer to avoid searching overlapping areas over and over
again for performance's sake.  My solution does a single lookup and a
single search, effectively covering at least the whole space that would be
used if no address preference was specified; more if a program asked for
space below TASK_UNMAPPED_BASE (= "yes, I know what I'm doing, I want to
limit my brk() space"). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

