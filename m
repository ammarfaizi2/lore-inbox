Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWBBQu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBBQu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBBQu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:50:59 -0500
Received: from silver.veritas.com ([143.127.12.111]:57482 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932169AbWBBQu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:50:58 -0500
Date: Thu, 2 Feb 2006 16:51:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mprotect() resets caching policy
In-Reply-To: <43DA1166.4040700@tungstengraphics.com>
Message-ID: <Pine.LNX.4.61.0602021612370.8207@goblin.wat.veritas.com>
References: <43DA1166.4040700@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-844626267-1138899070=:8207"
X-OriginalArrivalTime: 02 Feb 2006 16:50:36.0981 (UTC) FILETIME=[CA964650:01C62818]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-844626267-1138899070=:8207
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jan 2006, Thomas Hellstr=C3=B6m wrote:
>=20
> I'm working on an infrastructure to allow drm clients to flip arbitrary p=
ages
> in and out of the AGP aperture (or any similar device). In order to avoid
> conflicting mappings for those pages, the caching attribute of both the k=
ernel
> mapping and all VMA's is changed when binding / unbinding.

I can't comment on that plan.

> However, I noticed that mprotect() will, when run on a non-cached VMA, re=
set
> the caching policy. The line in mm/mprotect.c causing this problem is
>=20
> newprot =3D protection_map[newflags & 0xf];
>=20
> So a user could potentially run mprotect() and create a conflicting mappi=
ng
> which presumably is bad for stability on some architectures.

Perhaps: I think it already depends on what the architecture does.
newprot is used (a) to set vm_page_prot and (b) for use in pte_modify
(which change_protection applies to each pte present).

Now I think vm_page_prot is irrelevant to the kinds of VMA you are
interested in?  It's essential to provide the permissions/protections
when faulting a new page in, but your VMAs are fully managed by the
driver, and have all ptes already in place?  So wouldn't use vm_page_prot.

And pte_modify is implemented per-architecture: looking just at the
i386 implementation, yes, _PAGE_CHG_MASK looks like it'll mask off
the bits you understandably want it to retain.

> Since mprotect() only deals with rwx protection. I figure replacing the a=
bove
> with something like
>=20
> newprot =3D (vm_page_prot & ~MPROT_MASK) | (protection_map[newflags & 0xf=
] &
> MPROT_MASK)
>=20
> Where MPROT_MASK is a arch-dependent mask identifying the bits available =
to
> mprotect().

I think it's the per-architecture implementations of pte_modify that
you need to adjust.

It might be nice, but probably irrelevant, to have vm_page_prot maintained
in a similar way.  Whether every arch can do that with a straightforward
MPROT_MASK or _PAGE_CHG_MASK is not obvious to me: would more likely
need a pte_modify-like macro to do it.

But would that even be correct?  The same vm_page_prot would be applied
also to anonymous COWed pages from the mapping.  Very exceptional in the
case that interests you; but perhaps it's simpler to keep vm_page_prot
just for the rwx part of it.

> Alternatively, is there a way to disable mprotect() for a VMA?

Not at present.  It would be easier to add a VM_flag for that,
than to correct every architecture's pte_modify.  I'm not sure
whether "easier" amounts to "better" here.

> Finally, is there a chance to get protection_map[] exported to modules?

I very much doubt that.  Exporting a functional interface to it would
be preferable; but even that, I think the core mm would strongly resist
- the less of the pte business we export the better.  What were you
wanting it exported for?

Hugh
--8323584-844626267-1138899070=:8207--
