Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946884AbWKAOA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946884AbWKAOA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946885AbWKAOA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:00:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:61463 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946884AbWKAOA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:00:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elXsoXwXbm7y3xUORT7Y3YqG1JSxfT12Mw+TlG0RnVUcgEkVJZ0mUa8Cdb43QStOw+m1S+tXnt9+SNLbpSgfBmizPlttOP6e9kn3PyADRGa+5b2Pn6Lbfw+Tf/XSpN/Mm54BPh+9zxs6SKoK8jfQcFxLmkA55m5/L3MO8LZdeq0=
Message-ID: <b681c62b0611010600n2de56017i71f092c345db331a@mail.gmail.com>
Date: Wed, 1 Nov 2006 19:30:25 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: "Guillermo Marcus Martinez" <marcus@ti.uni-mannheim.de>
Subject: Re: mmaping a kernel buffer to user space
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454899E9.1090900@ti.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4547150F.8070408@ti.uni-mannheim.de>
	 <loom.20061101T120846-320@post.gmane.org>
	 <454899E9.1090900@ti.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Guillermo Marcus Martinez <marcus@ti.uni-mannheim.de> wrote:
> Rolf Offermanns schrieb:
> > Guillermo Marcus <marcus <at> ti.uni-mannheim.de> writes:
> >> Note: I am using kernel 2.6.9 for these tests, as it is required by my
> >> current setup. Maybe this issue has already been addressed in newer
> >> kernel. If that is the case, please let me know.
> >
> > Have a look at this article:
> >
> > "The evolution of driver page remapping"
> > http://lwn.net/Articles/162860/
> >
> > It should make things clearer.
> >
> > The "API changes in the 2.6 kernel series" page is also a very good read:
> > http://lwn.net/Articles/2.6-kernel-api/
> >
> > HTH,
> > Rolf
>
> Thanks for the links!
>
> Yes, it looks like a step in the right direction. However, the article
> says about vm_insert_page(): "...What it does require is that the page
> be an order-zero allocation obtained for this purpose...", therefore
> making it also unusable for this case (mmaping a pci_alloc_consistent).
>
> I think the limitation (being order zero), is related to the page
> counting, as I understand that for bigger order allocations, only the
> first-page counter is incremented (not every page). If that is a
> problem, I guess I would also see a problem with my workaround, and I
> see none (yet). So I may try in a newer kernel and see if I can use it
> to walk the pages on the mmap without using the nopage().

Setting 'PG_reserved' bit of all allocated pages & then calling
remap_page/pfn_range()
will do the things for 2.6.9.

>
> My suggestion would be to add two functions: pci_map_consistent() and
> dma_map_coherent() to address this issue, and their corresponding
> unmap's. That will make sure all that is needed is done, is a clean and
> consistent with the pci_ and dma_ APIs, and fills a mmap requirement not
> covered by the other functions.
>
> Best wishes,
> Guillermo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
