Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbUKLAbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUKLAbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbUKLA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:29:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:16862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbUKLA1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:27:44 -0500
Date: Thu, 11 Nov 2004 16:27:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] VM accounting change
Message-Id: <20041111162736.0c9d5dae.akpm@osdl.org>
In-Reply-To: <20041112001337.GR1740@hygelac>
References: <20041111223245.GA15759@hygelac>
	<20041111150710.6855398a.akpm@osdl.org>
	<20041112001337.GR1740@hygelac>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> wrote:
>
> On Thu, Nov 11, 2004 at 03:07:10PM -0800, akpm@osdl.org wrote:
> > VM_LOCKED|VM_IO doesn't seem to be a sane combination.  VM_LOCKED means
> > "don't page it out" and VM_IO means "an IO region".  The kernel never even
> > attempts to page out IO regions because they don't have reverse mappings. 
> > Heck, they don't even have pageframes.
> > 
> > How about you drop the VM_LOCKED?
> 
> sounds good, I can do that.
> 
> on a related note, there are a couple of flags that I'm not 100% clear
> on the difference between, mainly:
> 
> VM_LOCKED
> PG_locked
> PG_reserved
> 
> everything I've seen in the past has suggested that drivers set the
> PG_reserved flag for memory allocations intended to be locked down in
> memory for extensive dma (the bttv driver had always been pointed to
> as an example of that).
> 
> I'm not clear how that differs from PG_locked and VM_LOCKED. is
> PG_reserved still the suggested way to properly lock memory down, or
> is there a more generally accepted method?

VM_LOCKED means that someone did mlock() and the VMA isn't eligible for
paging.

PG_locked is very different: it provides the caller with exclusive access
the page while its actual contents are being changed.  It's also used as a
synchronisation point for adding to and removing from pagecache.  It's
pretty much a pagecache concept rather than an MM concept.

PG_reserved does mean that the page is "special" and the VM should just
leave the thing alone - some device driver owns the page and knows how to
manage it.

VM_RESERVED is a bit of a mystery, really and we've had some trouble over
the semantics of this vs PG_reserved.  Presumably it's supposed to be like
PG_reserved, only for whole mmap regions.  It may not work properly because
it gets damn little testing.

We really should have gone through and rationalised, consolidated and
documented the PageReserved/VM_RESERVED code in the 2.5 cycle but it didn't
happen.  The most noxious part is all the testing of PG_reserved in the
core kernel page refcounting logic.

