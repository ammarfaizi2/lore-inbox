Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWIEDwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWIEDwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 23:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWIEDwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 23:52:41 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:24974 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965135AbWIEDwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 23:52:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRpr1aslAIqV8tHOPSlXA8qrh1H3sy9IlPhnKsreMIf2xnkWAtQM+s1epsXIGJ86kZENJOBcqZzDI5H9DFMn0DFSIwN/qThPKcmfUAPvj1ZoEFv4HlLta0s550U87qieNq3U+Ql0B4v2bJ+bIUfBW8bsrkJt6iUe0qh9Ynyma54=
Message-ID: <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
Date: Tue, 5 Sep 2006 11:52:39 +0800
From: Aubrey <aubreylee@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, davidm@snapgear.com,
       gerg@snapgear.com
In-Reply-To: <17162.1157365295@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
	 <17162.1157365295@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO the problem is nommu.c is written for slab only. So when slob is
enabled, it need to be considered to make some modification to make
two or more memory allocator algorithms work properly, rather than to
force all others algorithm to be compatible with the current one(slab)
to match the code in the nommu.c, which is not common enough.

Does that make sense?

Regards,
-Aubrey

On 9/4/06, David Howells <dhowells@redhat.com> wrote:
>
> Aubrey <aubreylee@gmail.com> wrote:
>
> > Is there any solution/patch to fix the issue?
>
> Make the SLOB allocator mark its pages PG_slab, just like the SLAB allocator
> does.  I think this should be okay as the SLOB allocator and the SLAB
> allocator seem to be mutually exclusive.
>
> Using PG_slab would also give an instant check to things like SLOB's kfree().
>
> > +#ifdef CONFIG_SLAB
> >        if (PageSlab(page))
> > +#endif
>
> This is not a valid workaround as the object won't necessarily have been
> allocated from a slab (shared ramfs mappings and SYSV SHM for example).  You
> may not pass to ksize() objects allocated by means other than SLAB/SLOB.
>
> David
>
