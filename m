Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310178AbSCFVY4>; Wed, 6 Mar 2002 16:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310194AbSCFVYq>; Wed, 6 Mar 2002 16:24:46 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:9885 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S310178AbSCFVYf>; Wed, 6 Mar 2002 16:24:35 -0500
Date: Wed, 6 Mar 2002 21:27:00 +0000
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Dike <jdike@karaya.com>, David Woodhouse <dwmw2@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020306212700.A16144@clueful.co.uk>
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com> <E16iiQQ-00087K-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16iiQQ-00087K-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Mar 06, 2002 at 08:54:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has the
> > equivalent of MADV_DONTNEED) would need a hook in free_pages to make that
> > happen.
> 
> VM allows you to give it back a page and if you use it again you get a
> clean copy.

Yep, clean as in a page of zeroes when you touch it. (DIAGNOSE X'10' as
documented in the "CP Programming Services" manual, to be precise).

>             What it seems to lack is the more ideal "here have this page
> and if I reuse it trap if you did throw it out" semantic.

We're looking at ways of having fancier memory management information
pass between Linux and CP (it's safer to say CP (the "kernel" part of
VM/ESA and z/VM) than VM, given the ambiguous and confusing dual
meaning of "VM" otherwise :-).

> > > That BTW is an issue for more than UML - it has a bearing on running
> > > lots of Linux instances on any supervisor/virtualising system like S/390
> > 
> > On a side note, the "unused memory is wasted memory" behavior that UML and 
> > Linux/s390 inherit is also less than optimal for the host.
> 
> Yes. I believe IBM folks are studying that

Indeed. A "quich hack" that turns out to have rather useful, fun
properties is to have a little device driver (can be a module) which
stores "negative pages" in the page cache by allocating page cache
pages for the device's inode and then invoking the CP "release page"
call mentioned above. Linux thinks the page is "useful" and so keeps
it around until memory pressure kicks it out whereas the underlying
CP knows it's a hole making the resident size and working set of the
Linux image reduce. Add in a bit of feedback to get Linux re-reading
the "device" into cache proportionally to how much CP wants to kick
*out* resident pages from the image. Fun... However, closer
integration with the main mm system is the "proper" way to do it
(but depends on stuff like the latency, overheads and information
shared with CP so is a little more than an afternoon hack.)

--Malcolm

-- 
Malcolm Beattie <mbeattie@clueful.co.uk>
Linux Technical Consultant
IBM EMEA Enterprise Server Group...
...from home, speaking only for myself
