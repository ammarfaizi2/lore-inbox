Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSASNyE>; Sat, 19 Jan 2002 08:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSASNxz>; Sat, 19 Jan 2002 08:53:55 -0500
Received: from [202.54.26.202] ([202.54.26.202]:63625 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S289115AbSASNxg>;
	Sat, 19 Jan 2002 08:53:36 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B46.004C44FE.00@sandesh.hss.hns.com>
Date: Sat, 19 Jan 2002 19:17:49 +0530
Subject: free_swap_and_cache() doubt
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=r74OtHhBrgU6dojNPp7kRghFEN8MJorvzlmv2BmKrOzGjeemmyQ2L7aA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=r74OtHhBrgU6dojNPp7kRghFEN8MJorvzlmv2BmKrOzGjeemmyQ2L7aA
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline




Hi,
  I am reading 2.4.16, let us assume following scenario

swap_map[offset] == 2;
and page->count == 2; (before function execution)
vm_swap is full (nr_swap_pages*2 > total_swap_pages);

first question is the above case possible.

if yes,
  then
    after execution of this function, we would have page->count == 1, i.e.
mapped by some process, with good page->index and what we have is, the
associated
swap entry is already freed.

Am i wrong somewhere ??

-----
Amol


void free_swap_and_cache(swp_entry_t entry)
{
        struct swap_info_struct * p;
        struct page *page = NULL;

        p = swap_info_get(entry);
        if (p) {
                if (swap_entry_free(p, SWP_OFFSET(entry)) == 1)
                        page = find_trylock_page(&swapper_space, entry.val);
                swap_info_put(p);
        }
        if (page) {
                page_cache_get(page);
                /* Only cache user (+us), or swap space full? Free it! */
                if (page_count(page) == 2 || vm_swap_full()) {
                        delete_from_swap_cache(page);
                        SetPageDirty(page);
                }
                UnlockPage(page);
                page_cache_release(page);
        }
}

--0__=r74OtHhBrgU6dojNPp7kRghFEN8MJorvzlmv2BmKrOzGjeemmyQ2L7aA
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable


?


"DISCLAIMER: This message is proprietary to Hughes Software Systmes Lim=
ited
(HSS) and/or its customers and intended solely for the use of the indiv=
idual or
organisation to whom it is addressed. It may contain  privileged or con=
fidential
information.  If you have received this message in error, please notify=
 the
originator immediately. If you are not the intended recipient, you are =
notified
that you are strictly prohibited from using, copying, altering, or disc=
losing
the contents of this message. HSS accepts no responsibility for loss or=
 damage
arising from the use of the information transimitted by this email incl=
uding
damage from virus."



=

--0__=r74OtHhBrgU6dojNPp7kRghFEN8MJorvzlmv2BmKrOzGjeemmyQ2L7aA--

