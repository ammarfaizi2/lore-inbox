Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030709AbWLETyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030709AbWLETyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030815AbWLETyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:54:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54512 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030621AbWLETyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:54:31 -0500
Date: Tue, 5 Dec 2006 11:54:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@skynet.ie>
cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061205171705.GC20614@skynet.ie>
Message-ID: <Pine.LNX.4.64.0612051145510.18687@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie> <20061204143435.6ab587db.akpm@osdl.org>
 <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
 <Pine.LNX.4.64.0612050806300.11213@schroedinger.engr.sgi.com>
 <20061205171705.GC20614@skynet.ie>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1700579579-1273590264-1165348459=:18687"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1700579579-1273590264-1165348459=:18687
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Dec 2006, Mel Gorman wrote:

> Portions of it sure, but to offline the DIMM, all pages must be removed f=
rom
> it. To guarantee the offlining, that means only __GFP_MOVABLE allocations
> are allowed within that area and a zone is the easiest way to do it.

We were talking about the memory map (page struct array) not the page in=20
the DIMM per se. The memory map could also be made movable to deal with=20
pages overlapping boundaries (I am not sure that there is really a problem=
=20
at this time, we can probably afford to require the complete removal of a=
=20
page full of page structs. This is true in the the vmemmap case.=20
Sparsemem has large memmap chunks that may span multiple pages but=20
that could be fixed by changing the chunk size.

> Now, that said, if anti-fragmentation only uses lower PFNs, the number
> of active unmovable pages has to be large enough to span all DIMMs
> before the offlining would fail. This problem will be hit in some
> situations.
>=20
> > Set a flag in the page struct of those page struct pages=20
> > straddling the border and free the page struct pages describing only
> > memory in the DIMM.
> >=20
>=20
> I'm not sure what you mean by this. If I wanted to offline a DIMM and I h=
ad
> anti-frag (specifically the portion of it that allows a flag that affects=
 a
> whole block of pages), I would mark all the MAX_ORDER_NR_PAGES blocks the=
re
> as going offline so that the pages will not be reallocated. Some time in
> the future, the DIMM will be offlined but it could be an indefinte length
> of time. If the DIMM consisted of just ZONE_MOVABLE, it could be offlined
> in the length of time it takes to migrate all pages elsewhere or page the=
m out.

You have a block full of page structs (that is placed on other memory than=
=20
the DIMM). Some of the pages belonging to the page structs are in the area=
=20
to be offlined and other are not. Then you can remove the pages to be=20
offlined from the freelist (if they are on it) and from usage (by=20
migration or recleaim) and then mark them as unused. Marking them as=20
unused could then be as simple as setting PG_reserved.
>=20
> > This is *node* hotplug and we already have a node/zone structure etc wh=
ere=20
> > we could set some option to require only movable allocations.
>=20
> True. It would be a bit of a hack, but it's work without needing zones.

We must have some means of marking a node as removalbe anyways in order=20
to support node hotplug=AE What is so hackish about it?

> > I still do not see a need for additional zones.
>=20
> It's needed if you want to 100% guarantee the ability to offline a DIMM u=
nder
> all circumstances. However, ZONE_MOVABLE comes with it's own problems suc=
h
> as not allowing kernel allocations like network buffers.

You cannot offline all DIMMS since (at least at this point in time) we=20
need memory that is not movable. If you have multiple DIMMS then the=20
additional DIMMS may be placed in areas of a zone that cannot take=20
unmovable MAX_ORDER_NR_PAGES blocks.
---1700579579-1273590264-1165348459=:18687--
