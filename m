Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUCVTDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUCVTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:03:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:64387 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262257AbUCVTCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:02:03 -0500
Date: Mon, 22 Mar 2004 19:02:01 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VMA_MERGING_FIXUP and patch
In-Reply-To: <20040322175216.GJ3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
> 
> what about this?
> 
> @@ -344,6 +360,10 @@ void fastcall page_remove_rmap(struct pa
>    
>   out_unlock:
>  	page_map_unlock(page);
> +
> +	if (page_test_and_clear_dirty(page) && !page_mapped(page))
> +		set_page_dirty(page);
> +
>  	return;
>  }

No, it has to be
	if (!page_mapped(page) && page_test_and_clear_dirty(page))
		set_page_dirty(page);
but the positioning is fine.

> @@ -523,6 +543,11 @@ int fastcall try_to_unmap(struct page * 
>  		dec_page_state(nr_mapped);
>  		ret = SWAP_SUCCESS;
>  	}
> +	page_map_unlock(page);
> +
> +	if (page_test_and_clear_dirty(page) && ret == SWAP_SUCCESS)
> +		set_page_dirty(page);
> +
>  	return ret;
>  }

No, it has to be
	if (ret == SWAP_SUCCESS && page_test_and_clear_dirty(page))
		set_page_dirty(page);

Personally, I'd prefer we leave try_to_unmap with the lock we
had on entry, and do this at the shrink_list end - though I
can see that the way you've done it actually reduces the code.

(The s390 header file comments that the page_test_and_clear_dirty
needs to be done while not mapped, because of race with referenced
bit, and we are opening up to a race now; but unless s390 is very
different, I see nothing wrong with a rare race on referenced -
whereas everything wrong with any race that might lose dirty.)

Excited by that glimpse of find_pte_nonlinear you just gave us;
disappointed to find it empty ;-)

Hugh

