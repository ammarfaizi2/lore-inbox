Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWGNQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWGNQsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWGNQsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:48:18 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:55462 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161267AbWGNQsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:48:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VJO7fccKaryeB6CXeh/sfT4ZZeRQYy90uD1SRDezfSSPprBxU7NdTAdP8aGSqq6LZNPx/NCz8blRSk4OvvWBn3qt67Xw7wA4+8iU0WBQr8YTD6IkmobN/FqQTpfWwysPuEy0eNi4W9l0IDteYGedQQFrJuawhYPXZIGkFl44VOg=
Message-ID: <35f686220607140948g2b0eab42i8c2f182e729cc8e1@mail.gmail.com>
Date: Fri, 14 Jul 2006 09:48:15 -0700
From: "Alok kataria" <alokkataria1@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [patch] lockdep: annotate mm/slab.c
Cc: "Andrew Morton" <akpm@osdl.org>, arjan@infradead.org, torvalds@osdl.org,
       penberg@cs.helsinki.fi, mingo@elte.hu, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       alok.kataria@calsoftinc.com, kiran@scalex86.com
In-Reply-To: <Pine.LNX.4.64.0607132040550.32134@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1152763195.11343.16.camel@linuxchandra>
	 <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
	 <1152818472.3024.75.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
	 <20060713161620.f61d2ac0.akpm@osdl.org>
	 <Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
	 <20060713200234.d30cf1b8.akpm@osdl.org>
	 <Pine.LNX.4.64.0607132009520.32134@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0607132040550.32134@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Christoph Lameter <clameter@sgi.com> wrote:
> On Thu, 13 Jul 2006, Christoph Lameter wrote:
>
> > The fix by removing the dropping of the lock in free_block could cause
> > retaking the list_lock that we already hold in the OFF_SLAB case (even in
> > the non NUMA case).
>
> That retaking only occurs if the general slab cache used for the cache
> management is the same general slab where we are freeing from.
>
> Otherwise we are acquiring the list_locks of two distinct slab caches

There can be a _theoretical_ case in which we have a cache (X) which
has its slab descriptor  from another cache (Y), and this caches slab
descriptor too comes from another cache (Z) ...and so on.
In this case there can be a recursive lock issue.
But _practically_ speaking i don't think this nesting of
slab-descriptors can go down till a depth greater than 2 (because
slab-descriptors come from a array-size cache, and getting a slab
descriptor which has size greater than 1K is very rare). And this
thing forming a cycle is virtually impossible.

> which may introduce an issue of lock ordering.
>

> So reversing the patch seems to be the right measure after all. But we
> have the two weird locking scenarios above.

Yes that is the easiest way out, but let me give it a second thought.

Thanks & Regards,
Alok
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
A computer scientist is someone who, when told to "Go to Hell," sees
the "go to," rather than the destination, as harmful.

Alok Kataria
