Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSEBNGv>; Thu, 2 May 2002 09:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSEBNGu>; Thu, 2 May 2002 09:06:50 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:2983 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S314394AbSEBNGt>; Thu, 2 May 2002 09:06:49 -0400
Date: Thu, 2 May 2002 14:08:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order
 allocs
In-Reply-To: <20020502142441.A1668@in.ibm.com>
Message-ID: <Pine.LNX.4.21.0205021312370.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Suparna Bhattacharya wrote:
[ discussion of PG_inuse / PG_partial / PG_large snipped ]

Any of those can handle that job (distinguishing non0orders),
but I do believe you want a further PG_ flag for crash dumps.

The pages allocated GFP_HIGHUSER are about as uninteresting
as the free pages: the cases where they're interesting (for
analyzing a kernel crash, as opposed to snooping on a crashed
customer's personal data!) are _very_ rare, but the waste of
space and time putting them in a crash dump is very often
abominable, and of course worse on larger machines.

As someone else noted in this thread, the kernel tries to keep
pages in use anyway, so omitting free pages won't buy you a great
deal on its own.  And I think it's to omit free pages that you want
to distinguish the count 0 continuations from the count 0 frees?

PG_highuser? PG_data?  Or inverses: PG_internal? PG_dumpable?
I think not PG_highuser, because it's too specific to what just
happens to be the best, but inadequate, test I've found so far.

A first guess is that pages allocated with __GFP_HIGHMEM can be
omitted from a dump, but that works out wrong on vmalloced space
and on highmem pagetables, both of which are important in a dump.
GFP_HIGHUSER test dumps vmalloced pages, and both Andrea's 2.4 or
Ingo's 2.5 highmem pagetables.  But (notably in reboot after crash:
dump copied from swap) memory can be full of GFP_USER blockdev pages.

Hugh

