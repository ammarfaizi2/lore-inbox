Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKJMpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKJMpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKJMpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:45:41 -0500
Received: from [194.90.237.34] ([194.90.237.34]:21391 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1750702AbVKJMpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:45:40 -0500
Date: Thu, 10 Nov 2005 14:48:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110124853.GD16589@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051110123538.GL8942@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110123538.GL8942@minantech.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gleb Natapov <gleb@minantech.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Tue, Nov 08, 2005 at 11:34:07PM +0200, Michael S. Tsirkin wrote:
> > Index: linux-2.6.14-dontcopy/mm/madvise.c
> > ===================================================================
> > --- linux-2.6.14-dontcopy.orig/mm/madvise.c	2005-10-28
> 02:02:08.000000000 +0200
> > +++ linux-2.6.14-dontcopy/mm/madvise.c	2005-11-08
> 23:28:56.000000000 +0200
> > @@ -31,6 +31,12 @@ static long madvise_behavior(struct vm_a
> >  	case MADV_RANDOM:
> >  		new_flags |= VM_RAND_READ;
> >  		break;
> > +	case MADV_DONTCOPY:
> > +		new_flags |= VM_UDONTCOPY;
> > +		break;
> > +	case MADV_DOCOPY:
> > +		new_flags &= ~VM_UDONTCOPY;
> > +		break;
> >  	default:
> >  		break;
> >  	}
> I think you are removing VM_RAND_READ/VM_SEQ_READ here.

True, we need something like

        switch (behavior) {
        case MADV_SEQUENTIAL:
                new_flags = (vma->vm_flags & ~VM_READHINTMASK) | VM_SEQ_READ;
                break;
        case MADV_RANDOM:
                new_flags = (vma->vm_flags & ~VM_READHINTMASK) | VM_RAND_READ;
                break;
        case MADV_DONTCOPY:
                new_flags |= VM_UDONTCOPY;
                break;
        case MADV_DOCOPY:
                new_flags &= ~VM_UDONTCOPY;
                break;
        default:
                break;
        }

Thanks!

> Also perhapse we should skip VM_SHARED VMAs?

Why?

> --
> 			Gleb.
> 

-- 
MST
