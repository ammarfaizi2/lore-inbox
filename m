Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQL0Rif>; Wed, 27 Dec 2000 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbQL0RiZ>; Wed, 27 Dec 2000 12:38:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29456 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129428AbQL0RiO>; Wed, 27 Dec 2000 12:38:14 -0500
Date: Wed, 27 Dec 2000 13:14:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <m3k88mb28v.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0012271309510.11471-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Dec 2000, Christoph Rohland wrote:

> BTW: The generic swapoff path itself has still races if a process is
> paging in a page which is just freed on swap by try_to_unuse. It gives
> 'VM: bad swap entries' and worse. But this is not shmem
> specific. Marcelo would you like to look into this?

Sure. 

Look at this comment on try_to_unuse():

             swap_device_lock(si);
             for (i = 1; i < si->max ; i++) {
                 if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD) {
                                /*
                                 * Prevent swaphandle from being completely
                                 * unused by swap_free while we are trying
                                 * to read in the page - this prevents warning
                                 * messages from rw_swap_page_base.
                                 */
                                if (si->swap_map[i] != SWAP_MAP_MAX)
                                        si->swap_map[i]++;
                                swap_device_unlock(si);
                                goto found_entry;
...


I think that incrementing the swap entry count will not allow swap from
removing the swap entry (as the comment says)

What I'm missing here?

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
