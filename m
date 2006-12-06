Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937656AbWLFVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937656AbWLFVTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937652AbWLFVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:19:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:28644 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937656AbWLFVTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:19:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TyEIQSGFVgtQcE2Xdfu2zyWQaXDf8+wfMYlaTS9nSILWhuxhyhI0RgidEXOUmmM+/kMXe3i6w8o+43hRvf7WG2NNdZ7lulQt5z9RDG13ES/6Wz7W1BhJcck1llQjmzM0qvRynOHVaVGqLrl62miawb6P7zuq5tJK24FAXI8jpMw=
Message-ID: <f383264b0612061319k16809e35tb04d04fa16f976b1@mail.gmail.com>
Date: Wed, 6 Dec 2006 13:19:41 -0800
From: "Matt Reimer" <mattjreimer@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061205.165948.98864221.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
	 <20061205.132412.116353924.davem@davemloft.net>
	 <f383264b0612051657r2b62c7acnf10b2800934ab8b3@mail.gmail.com>
	 <20061205.165948.98864221.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, David Miller <davem@davemloft.net> wrote:
> From: "Matt Reimer" <mattjreimer@gmail.com>
> Date: Tue, 5 Dec 2006 16:57:12 -0800
>
> > Right, but isn't he declaring that each architecture needs to take
> > care of this? So, say, on ARM we'd need to make kunmap() not a NOP and
> > call flush_dcache_page() ?
>
> No.  He is only solving a problem that occurs on HIGHMEM
> configurations on systems which can have D-cache aliasing
> issues.

Are you sure? James specifically mentions "non-highmem architectures,"
and "all architectures with coherence issues," which would seem to
include ARM (which is my concern).

For your convenience I quote the whole commit message below.

Matt

[PATCH] update to the kernel kmap/kunmap API

Give non-highmem architectures access to the kmap API for the purposes of
overriding (this is what the attached patch does).

The proposal is that we should now require all architectures with coherence
issues to manage data coherence via the kmap/kunmap API.  Thus driver
writers never have to write code like

    kmap(page)
    modify data in page
    flush_kernel_dcache_page(page)
    kunmap(page)

instead, kmap/kunmap will manage the coherence and driver (and filesystem)
writers don't need to worry about how to flush between kmap and kunmap.

For most architectures, the page only needs to be flushed if it was
actually written to *and* there are user mappings of it, so the best
implementation looks to be: clear the page dirty pte bit in the kernel page
tables on kmap and on kunmap, check page->mappings for user maps, and then
the dirty bit, and only flush if it both has user mappings and is dirty.
