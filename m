Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSEML3l>; Mon, 13 May 2002 07:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSEML3k>; Mon, 13 May 2002 07:29:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19322 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312601AbSEML3k>; Mon, 13 May 2002 07:29:40 -0400
Date: Mon, 13 May 2002 12:32:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: swap_dup/swap_free: Bad swap file entry
In-Reply-To: <87held2iyv.fsf@CERT.Uni-Stuttgart.DE>
Message-ID: <Pine.LNX.4.21.0205131219590.966-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Florian Weimer wrote:
> What do these messages mean?  That something is terribly hosed?

I'm afraid so.

> swap_dup: Bad swap file entry 1842b040
> VM: killing process cc1
> swap_free: Bad swap file entry 1dab3064
> swap_free: Bad swap file entry 1842b040
> swap_free: Bad swap file entry 18429040
> swap_free: Bad swap file entry 31d7303c
> swap_free: Bad swap offset entry 31d71000

They mean that junk (corruption) has been found in your pagetables
- and the swap dup/free code was the first to notice.  Of course,
it could sometimes mean that the swap allocation code has gone wrong,
but from the numbers here (userspace pointers?) I'd guess not.

The worry is not so much the bad entries identified by these messages,
as the possible entries not reported, which looked like present page
table entries, and may have led to the wrong pages being freed (but
if all the corruption was userspace pointers, good chance that they
all looked more like even swap entries than odd page table entries:
I'm presuming x86).

> (This is from a UP 2.4.18 kernel with XFS 1.1 patches.)
> 
> Is this caused by a hardware defect (broken IDE interface, maybe; in
> our case VIA vt8233)?

That I can't judge.  I'd wonder about the XFS patches,
but I've no good grounds for that suspicion.

It looks as if a page is being used for two purposes (one of as your
pagetable) at the same time, but how that comes about I don't know -
though once it starts happening, the freeing of wrong pages as above
an multiply the effect.  It's always worth giving memtest86 a go in
such cases, but there's nothing here that particularly suggests bad
memory as the culprit.

Hugh

