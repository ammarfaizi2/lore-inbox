Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316490AbSFDGeI>; Tue, 4 Jun 2002 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFDGeH>; Tue, 4 Jun 2002 02:34:07 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:37389 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S316490AbSFDGeF>; Tue, 4 Jun 2002 02:34:05 -0400
Message-ID: <3CFC603E.A7DC1525@zip.com.au>
Date: Mon, 03 Jun 2002 23:37:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Anton Altaparmakov <aia21@cantab.net>,
        "David S. Miller" <davem@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
In-Reply-To: <1023096034.19717.62.camel@storm.christs.cam.ac.uk>
		<3CFB3B87.74C7E9DF@zip.com.au> <shshekkbnrr.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Andrew Morton <akpm@zip.com.au> writes:
> 
>      > Anton Altaparmakov wrote:
>     >>
>     >> Hi,
>     >>
>     >> Just got this (reproducible) kernel panic (BUG in
>     >> asm-i386/highmem.h::kmap_atomic(), the if
>     >> (!pte_none(*(kmap_pte-idx))) BUG(); triggers). It happens every
>     >> time I boot and on an NFS mount do a ./configure.
> 
>      > Dunno about this one.  I'm seeing some (totally different) NFS
>      > funnies at present - pagecache data on the client is coming up
>      > zeroes under memory pressure.  Trond mentioned that NFS
>      > recently went to kmap_atomic, so there is a common thread
>      > there.
> 
> Following an off-list chat with David, I believe that the appended
> patch should fix the problem reported by Anton. It replaces the
> obsolete km_type "KM_SKB_DATA" with an entry that the RPC layer can
> use in the socket bottom half.
> 
> I'm less sure whether or not it will fix your problem, Andrew, but I'm
> hoping you'll find time to give it a brief test ;-)...

It fixed it.

The problem was that pagecache data on the NFS client was showing
incorrect chunks of several k's of zeroes.  No particuar alignment,
either.  And it only happened when the machine is under page-replacement
pressure.  And only when the machine has highmem.

It'd be nice to understand _why_ it fixed it.  Do we know why NFS
was losing data when using KM_USER0?  As far as I can see the new
and old code look pretty darn similar.   Interested.

-
