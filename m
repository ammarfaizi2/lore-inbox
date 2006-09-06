Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWIFCf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWIFCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWIFCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 22:35:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:46717 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751431AbWIFCf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 22:35:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mEijdwgehazWlKZ8uxdSN0KW+2cYfwb7H7rn2UA6md1iRhqheeRHPdjsO4UVuU69lDH+AFV5yEoqLc6aDI1scDUjLzvYglsfCGdNFV7/uKVTYNSM2oOHvr6Rtm1E+Q6tITtISruuFFd4EiGtPQqAxQube8fCKg8xaWBjIusZBgg=
Message-ID: <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
Date: Wed, 6 Sep 2006 10:35:55 +0800
From: Aubrey <aubreylee@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, davidm@snapgear.com,
       gerg@snapgear.com
In-Reply-To: <3551.1157448903@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
	 <17162.1157365295@warthog.cambridge.redhat.com>
	 <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
	 <3551.1157448903@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I agree with most of your opinion. Using PG_slab is really a
quickest way to determine the size of the object. But I think using a
flag named "PG_slab" on a memory algorithm named "slob" seems not
reasonable. It may confuse the people who start to read the kernel
source code. So I'm writing to ask if there is a better solution to
fix the issue.

-Aubrey

On 9/5/06, David Howells <dhowells@redhat.com> wrote:
> Aubrey <aubreylee@gmail.com> wrote:
>
> > IMHO the problem is nommu.c is written for slab only. So when slob is
> > enabled, it need to be considered to make some modification to make
> > two or more memory allocator algorithms work properly, rather than to
> > force all others algorithm to be compatible with the current one(slab)
> > to match the code in the nommu.c, which is not common enough.
> >
> > Does that make sense?
>
> No, not really.
>
> The point is that kobjsize() needs to determine the size of the object it has
> been asked to assess.  It knows how to do that directly if the page is
> allocated by the main page allocator, but not if the page belongs to the slab
> allocator.  The quickest way it can determine this is to look at PG_slab.  In
> such a case it defers to the slab allocator for a determination.
>
> What I don't want to happen is that we have to defer immediately to the slob
> allocator which then goes and searches various lists to see if it owns the
> page.  Remember: unless the page is _marked_ as belonging to the slob
> allocator, the slob allocator may _not_ assume any of the metadata in struct
> page is valid slob metadata.  It _has_ to determine the validity of the page
> by other means _before_ it can use the metadata, and that most likely means a
> search.  This is why PG_slab exists: if it is set, you _know_ you can
> instantly trust the metadata.
>
> Since slob appears to be an entry-point-by-entry-point replacement for the
> slab allocator, the slob allocator can also mark its pages for anything that's
> looking to defer to it using PG_slab since the presence of slab and slob are
> mutually exclusive.
>
> Also, we already have two major memory allocator algorithms in the kernel at
> any one time: (1) the main page allocator and (2) slab or slob.  We don't
> really want to start going to three or more.
>
>
> So, I come back to the main question: Why don't you want to use PG_slab?
>
> David
>
