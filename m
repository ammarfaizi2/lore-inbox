Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSA3A4d>; Tue, 29 Jan 2002 19:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSA3A4Y>; Tue, 29 Jan 2002 19:56:24 -0500
Received: from nat.overture.com ([208.50.18.5]:31647 "EHLO
	tiresias.corp.go2.com") by vger.kernel.org with ESMTP
	id <S285161AbSA3A4N>; Tue, 29 Jan 2002 19:56:13 -0500
Message-ID: <3C5744A7.E11B72CA@overture.com>
Date: Tue, 29 Jan 2002 16:56:07 -0800
From: Xeno <xeno@overture.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.4: NFS client kmapping across I/O
In-Reply-To: <Pine.LNX.4.21.0201291701510.1367-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>
> We will in any case want to make the RPC layer 'page aware' in
> order to be able to make use of the zero-copy socket stuff
> (a.k.a. sendpage()).  I'm still not ready to detail exactly how
> it should be done though. I'll have to get back to you on this one...

Oh, yeah, zero-copy is definitely the way to go.  No hurry, the
workaround is good enough for now.  Thanks, Trond!

Hugh Dickins wrote:
> 
> I don't think the kmap area was really designed to be so small, it's
> just that nobody ever got around to allowing more than one page table
> for it.  It was surely absurd that HIGHMEM64G (doubly-sized ptes so half
> as many per page table) should be limited to fewer kmaps than HIGHMEM4G.

Thanks for the patch, Hugh, I may try it out when I get some free
hardware next week.  Looks like there is already a limit of 256 pages
kmapped per mount built into the NFS client, so LAST_PKMAP of 1800 would
allow heavy I/O to 7 mounts before filling up the kmap table, up from 2
mounts.

I wasn't sure about the kmap table size because of the loops in
flush_all_zero_pkmaps and map_new_virtual.  In the worst case, when the
table is nearly full, like when NFS is maxing it out, each of those
operations will tend to scan through the table without finding much that
can be freed/used.  I don't have a machine where I can tinker with it at
the moment, though, so I'm not sure how much it matters.

Xeno
