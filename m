Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCYBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCYBEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCYBEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:04:23 -0500
Received: from [198.99.130.12] ([198.99.130.12]:33178 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751246AbWCYBEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:04:23 -0500
Date: Fri, 24 Mar 2006 20:05:24 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/16] UML - Memory hotplug
Message-ID: <20060325010524.GA8117@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:45:35PM -0800, Andrew Morton wrote:
> The `= 0;' causes this to consume space in vmlinux's .data.  If we put it
> in bss and let crt0.o take care of zeroing it, we save a little disk space.

Yup.

> > +			page = alloc_page(GFP_ATOMIC);
> 
> That's potentially quite a few atomically-allocated pages.  I guess UML is
> more resistant to oom than normal kernels (?) but it'd be nice to be able to
> run page reclaim here.

This is the big question with this patch.  How incestuous do I want to
get with the VM system in order to get it to free up pages?  For now,
I decided to be fairly hands-off, allocate as many pages as I can get,
and return the total number to the host.  The host, if it wasn't happy
with the results, can wait a bit while the UML notices that it is
really low on memory and frees some up, and then hit up the UML for
the remainder.

> > +	char buf[sizeof("18446744073709551615\0")];
> 
> rofl.  We really ought to have a #define for "this architecture's maximum
> length of an asciified int/long/s32/s64".  Generally people do
> guess-and-giggle-plus-20%, or they just get it wrong.

I can write one up.  I did some quick grepping, and there are a good
number of constant over-estimates, plus some which might be in danger
with an large number of devices, plus one (kallsyms.c) which actually
does some sane-looking approximate math to get a reasonable number (which
is then doubled).

>  * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
>  * Other filesystems return -ENOSYS.
> 
> Are you expecting that this memory is backed by tmpfs?

Yes, but there should be some checking of this beforehand.

Drop this version for now, and I'll send a new one to cover these
problems plus the one that BlaisorBlade pointed out.

				Jeff
