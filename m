Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268311AbTCFTCb>; Thu, 6 Mar 2003 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268312AbTCFTCb>; Thu, 6 Mar 2003 14:02:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:16352 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S268311AbTCFTCa>; Thu, 6 Mar 2003 14:02:30 -0500
Date: Thu, 6 Mar 2003 19:14:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nonlinear oddities
In-Reply-To: <Pine.LNX.4.44.0303061618460.2422-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303061903170.1215-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Hugh Dickins wrote:
> 1.  Revert MAP_NONLINEAR and VM_NONLINEAR: I can easily imagine wanting
> VM_NONLINEAR in future, warning that vma is unusual, but currently it's
> not useful: install_page just needs to SetPageAnon if the page is put
> somewhere try_to_unmap_obj_one wouldn't be able to find it.

Now I think about it more, install_page's SetPageAnon is not good at all.
That (unlocked) page may already be mapped into other vmas as a shared
file page, non-zero mapcount, we can't suddenly switch it to Anon
(pte_chained) without doing the work to handle that case.

Before Ingo's file-offset-in-pte, it would have been consistent without
any SetPageAnon there, because the remapped pages would be unreliable
unless locked, and having them unfindable is equivalent to being locked.

But if we're to bother with file-offset-in-pte, then we have to bother
with finding the remapped pages, handling mapped-earlier case properly.

Hugh

