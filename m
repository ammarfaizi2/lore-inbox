Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbREHUHH>; Tue, 8 May 2001 16:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbREHUG5>; Tue, 8 May 2001 16:06:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42256 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135239AbREHUGn>; Tue, 8 May 2001 16:06:43 -0400
Date: Tue, 8 May 2001 15:28:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: oddity with page_launder() handling of dirty pages
Message-ID: <Pine.LNX.4.21.0105081514420.7774-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I was just wondering how bad the current way of writing out dirty pages is
wrt multiple page_launder() users. 

We don't remove a dirty page from the inactive dirty list when writing it
out (as opposed to "direct" page->buffers ll_rw_block() IO). 

When we have multiple users inside page_launder(), that means a dirty page
which is being written out (and has an additional reference gotten by the
writer) but has no page->buffers mapping yet will be moved to the
beginning of the active list and kept there until the reference is
released by the writer (since refill_inactive_scan() will not move it back
to the inactive dirty list because of the extra reference). 

Remeber that we limit the amount of swap writeout's at rw_swap_page(), so
any writepage() which blocks there will have its page moved to the
_beginning_ of the active list because it has no page->buffers yet. 

Linus, since you wrote that part of the code, I ask you: do you have any
reason to not remove a page being writepage()'d from the
inactive_dirty_list to avoid this kind of problems ? 

(the page must be added back to the inactive_dirty_list again after the
writeout, yes).

