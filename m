Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752096AbWHOESq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWHOESq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 00:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbWHOESq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 00:18:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:39155 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752096AbWHOESp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 00:18:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=AoFj979Cb4uyiJ9ogPqSIAY7JD5WG7/NUYZlxD683B5AS1qnOUyV9p94CbWXycARjO7sHIm7wMs59l7GyJsY0rpGt2jOMlNCaWr8ZHlejzUWLYRQsyPSAiyUZmQ1STUgbZv7YykCYXj9JzswE7nhU+GqXO39EASw+HZhq5nEqKQ=
Date: Tue, 15 Aug 2006 08:18:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop second arg of unregister_chrdev()
Message-ID: <20060815041841.GC5163@martell.zuzino.mipt.ru>
References: <20060815033522.GA5163@martell.zuzino.mipt.ru> <20060814204817.d9365586.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814204817.d9365586.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 08:48:17PM -0700, Andrew Morton wrote:
> On Tue, 15 Aug 2006 07:35:22 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > * "name" is trivially unused.
>
> OK.
>
> > * Requirement to pass to unregister function anything but cookie you've
> >   got from register counterpart is wrong. It creates opportunity to
> >   diverge, it create opportunity for bugs if enforced:
> >
> > 	/*
> > 	 * XXX(hch): bp->b_count_desired might be incorrect (see
> > 	 * xfs_buf_associate_memory for details),
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >
> > 	 *                                        but fortunately
> > 	 * the Linux version of kmem_free ignores the len argument..
> > 	 */
> > 	 kmem_free(bp->b_addr, bp->b_count_desired);
>
> I don't understand that.

	p = malloc(size);
	free(p);
is good. You don't have to remember "size" which sometimes nontrivially
calculated until free time.

	mmio = ioremap(start, size);
	iounmap(mmio);
is good too for same reasons. Agree so far?

Ergo,
	major = register_chrdev(0, "foo", &foo_fops);
	unregister_chrdev(major);
is good too even if people don't forget to pass the same "foo" in two
places. Luckily, unregister_chrdev() ignores name arg, so passing wrong
won't do any harm.

> >  64 files changed, 97 insertions(+), 97 deletions(-)
>
> I do understand that.  This'll cause some grief.

In kernel, hardly...

$ grep unregister_chrdev -w -n 2.6.18-rc4-mm1
33126:  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
35853:  unregister_chrdev(MSR_MAJOR, "cpu/msr");
35861:  unregister_chrdev(MSR_MAJOR, "cpu/msr");
134610:         unregister_chrdev(LP_MAJOR, "lp");
291207:-        unregister_chrdev(hptiop_cdev_major, "hptiop");
352167:+    unregister_chrdev(major_number, "SerialQT_USB");

Two rejects, 4 fuzzy places.

> I'd suggest that we add a
> new unregister_char_dev() or something, and do

But there is register_CHRDEV_region, unregister_CHRDEV_region,
alloc_CHRDEV_region, register_CHRDEV. Should I change the spelling of
register_chrdev() for a good measure, too?

> static inline unregister_chrdev(unsigned int major, const char *name)
> {
> 	return unregister_char_dev(major);
> }

> then migrate callers over to unregister_char_dev() in an organised fashion,
> via maintainers where poss.
>
> Then mark unregister_chrdev() deprecated for a while.
>
> Then nuke it.

