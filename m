Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317569AbSFDLjx>; Tue, 4 Jun 2002 07:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSFDLjw>; Tue, 4 Jun 2002 07:39:52 -0400
Received: from pat.uio.no ([129.240.130.16]:55184 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317569AbSFDLjv>;
	Tue, 4 Jun 2002 07:39:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
Date: Tue, 4 Jun 2002 13:39:32 +0200
User-Agent: KMail/1.4.1
Cc: Anton Altaparmakov <aia21@cantab.net>,
        "David S. Miller" <davem@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1023096034.19717.62.camel@storm.christs.cam.ac.uk> <shshekkbnrr.fsf@charged.uio.no> <3CFC603E.A7DC1525@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206041339.32899.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 08:37, Andrew Morton wrote:

> The problem was that pagecache data on the NFS client was showing
> incorrect chunks of several k's of zeroes.  No particuar alignment,
> either.  And it only happened when the machine is under page-replacement
> pressure.  And only when the machine has highmem.
>
> It'd be nice to understand _why_ it fixed it.  Do we know why NFS
> was losing data when using KM_USER0?  As far as I can see the new
> and old code look pretty darn similar.   Interested.

Anton's Oops showed that kmap_atomic(page, KM_USER0) is sometimes failing to 
return an address, something that we cannot accept in a networking bottom 
half (performance and reliability would suck if we had to delay and retry). 
That indicates that something is calling kmap_atomic() and then getting 
interrupted before it can call kunmap_atomic().

>From what I can see, the only other place where KM_USER0 is employed would be 
in the *_highpage() helper routines in include/linux/highmem.h. These 
routines are used in various places, but are usually not protected against 
(soft and hard) interrupts or kernel pre-emption. Could it be that the latter 
is what is causing trouble?

Cheers,
  Trond
