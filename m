Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSFCKMJ>; Mon, 3 Jun 2002 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSFCKLx>; Mon, 3 Jun 2002 06:11:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44009 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317347AbSFCKLs>; Mon, 3 Jun 2002 06:11:48 -0400
Date: Mon, 3 Jun 2002 11:14:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which
 requires atomic operations to access
In-Reply-To: <20020602224422.GP14918@holomorphy.com>
Message-ID: <Pine.LNX.4.21.0206031051370.10595-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, William Lee Irwin III wrote:
> page->flags is effectively a lock word as its various bits are updatable
> and accessible only by atomic operations. This patch removes the update
> of page->flags in __free_pages_ok() with non-atomic operations in favor
> of using atomic bit operations to update the bits to be cleared.
> 
>  	ClearPageDirty(page);
> -	page->flags &= ~(1<<PG_referenced);
> +	ClearPageUptodate(page);
> +	ClearPageSlab(page);
> +	ClearPageNosave(page);
> +	ClearPageChecked(page);

Don't all those atomic volatile bitops slow down a hotpath for no real
gain?  I'm all for clearing all possible flag bits at that point, but
would prefer just one mask myself.  But given all the preceding tests,
and the ClearPageDirty, perhaps I'm foolish to question your additions.

And wasn't it originally clearing the referenced bit, now leaving it?

Hugh

