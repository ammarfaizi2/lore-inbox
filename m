Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVERX3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVERX3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVERX3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:29:08 -0400
Received: from one.firstfloor.org ([213.235.205.2]:17541 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262283AbVERX3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:29:02 -0400
To: Terence Ripperda <tripperda@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with 2.6.12 and ioremap/iounmap
References: <20050518224353.GL2596@hygelac>
From: Andi Kleen <ak@muc.de>
Date: Thu, 19 May 2005 01:29:01 +0200
In-Reply-To: <20050518224353.GL2596@hygelac> (Terence Ripperda's message of
 "Wed, 18 May 2005 17:43:53 -0500")
Message-ID: <m1zmusyuyq.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> writes:


> this appears to be the 'vmalloc guard page causing change_page_attr
> problems' bug. at one point, iounmap subtracted the guard page before
> calling change_page_attr, but I see this was reverted as part of a
> recent cleanup.

Hmm, yes looks like it was reintroduced. 

> from looking at the implementation in 2.6.12-pre4, I'm not clear how

I suppose you mean rc4, not pre4?

> the guard page is accounted for in iounmap. in vmalloc.c, the guard
> page is subtracted from the vm_struct in remove_vm_area (which calls
> unmap_vm_area). but iounmap in ioremap.c calls unmap_vm_area directly
> rather than calling remove_vm_area, so the guard page is never 
> subtracted and the wrong size is passed to change_page_attr.

Ok obviously needs to be fixed. 

>
> is the intent that iounmap should call remove_vm_area rather than
> unmap_vm_area (with additional changes to not unlink the vma itself)?
> or that the guard page should be removed by unmap_ rather than
> remove_?

There doesn't seem to be a clear rule, that is where the confusion
comes from I guess. I would consider it cleaner to handle it in
the higher level vmalloc code.

>
> when debugging this issue, I also ran into problems with iounmap using
> virt_to_page on a pci IO region. this problem went away when I tried
> calling change_page_attr_addr with the virtual address instead. but

A patch for that already went into mainline.

> perhaps iounmap should be calling ioremap_change_attr rather than

What is ioremap_change_attr? 

> change_page_attr directly. I'll run some additional tests and send out
> a patch.

-Andi
