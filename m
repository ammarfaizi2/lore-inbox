Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbRADHPH>; Thu, 4 Jan 2001 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRADHO5>; Thu, 4 Jan 2001 02:14:57 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46597 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129588AbRADHOp>; Thu, 4 Jan 2001 02:14:45 -0500
Date: Thu, 4 Jan 2001 03:23:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: try_to_swap_out() return value problem?
In-Reply-To: <Pine.LNX.4.10.10101032047590.8789-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101040308450.1174-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Your latest changes to try_to_swap_out() does not seem to be obviously
correct.

	-   if (mm->swap_cnt)
	-       mm->swap_cnt--;
	+   if (!mm->swap_cnt)
	+       return 1;
	+
	+   mm->swap_cnt--;

Having swap_cnt == 0 does not necessarily mean that we successfully freed
a page (look at the page aging and locking checks in try_to_swap_out).

Now refill_inactive() relies on the assumption that swap_out() returning 
1 means we successfully freed a page:

                while (swap_out(priority, gfp_mask)) {
                        made_progress = 1;
                        if (--count <= 0)
                                goto done;
                }




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
