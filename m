Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbTCGFPH>; Fri, 7 Mar 2003 00:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCGFPG>; Fri, 7 Mar 2003 00:15:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40140 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261347AbTCGFPF>; Fri, 7 Mar 2003 00:15:05 -0500
Date: Fri, 7 Mar 2003 05:27:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: vandrove@vc.cvut.cz, <helgehaf@aitel.hist.no>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vm_area_struct slab corruption
In-Reply-To: <20030306145223.67d571b1.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303070454320.1938-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > +	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
> > +	 * unmapped vm_area_struct will remain in use: so lower split_vma
> > +	 * places tmp vma above, and higher split_vma places tmp vma below.
> 
> Cough.  Would it be clearer to just return the address of the surviving vma
> from do_munmap()?  Via an extra arg, or a PTR_ERR thingy?

Sneeze.  Address of the surviving?  I think you must mean address of
the vma now previous to what's been unmapped, NULL if none previous.

Hmm, could do that: it would make the interface between move_vma and
do_munmap less fragile.  But it wouldn't make move_vma any clearer or
easier - can't make use of that previous vma without the same analysis
of cases as before.

If adding an extra arg, then the extra arg to add would be what Alan
did in 2.4-ac, int acct to control whether it does the VM_ACCOUNTing.
I resisted adding that (changing odd distant drivers), and I may have
been wrong to do so.

I'm just reluctant to make more change here at this moment, my focus
is elsewhere.  I cannot approach move_vma without wanting to change
more than is safe to do in a rush: it should be using your newer
can_vma_merge_ stuff; does its merging have to look so complex?
needs to check if do_munmap failed and behave sanely if so.
But I can't let slab corruption and backtraces await my leisure.

Hugh

