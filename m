Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137020AbRAHSbH>; Mon, 8 Jan 2001 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143699AbRAHSar>; Mon, 8 Jan 2001 13:30:47 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:61433 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S137020AbRAHSag>; Mon, 8 Jan 2001 13:30:36 -0500
Date: Mon, 8 Jan 2001 16:30:10 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Sergey E. Volkov" <sve@raiden.bancorp.ru>, linux-kernel@vger.kernel.org,
        Christoph Rohland <cr@sap.com>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Linus Torvalds wrote:
> On Mon, 8 Jan 2001, Rik van Riel wrote:
> > 
> > We need a check in deactivate_page() to prevent the kernel
> > from moving pages from locked shared memory segments to the
> > inactive_dirty list.
> > 
> > Christoph?  Linus?
> 
> The only solution I see is something like a "active_immobile"
> list, and add entries to that list whenever "writepage()"
> returns 1 - instead of just moving them to the active list.
> 
> Seems to be a simple enough change. The main worry would be
> getting the pages _off_ such a list:

Just marking them with a special "do not deactivate me"
bit seems to work fine enough. When this special bit is
set, we simply move the page to the back of the active
list instead of deactivating.

And when the bit changes again, the page can be evicted
from memory just fine. In the mean time, the locked pages
will also have undergone normal page aging and at unlock
time we know whether to swap out the page or not.

I agree that this scheme has a higher overhead than your
idea, but it also seems to be a bit more flexible and
simple.  Alternatively, we could just scan the wired_list
once a minute and move the unwired pages to the active
list.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
