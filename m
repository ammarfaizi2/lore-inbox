Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264495AbRFKMxP>; Mon, 11 Jun 2001 08:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264476AbRFKMxF>; Mon, 11 Jun 2001 08:53:05 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:54518 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264552AbRFKMwz>; Mon, 11 Jun 2001 08:52:55 -0400
Message-ID: <3B24BD57.E1D6D1D0@uow.edu.au>
Date: Mon, 11 Jun 2001 22:45:11 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate_inode_pages
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu> <01061000533601.03897@starship> <3B22CDFA.2BC46385@uow.edu.au>,
		<3B22CDFA.2BC46385@uow.edu.au> <01061018402300.05248@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Sunday 10 June 2001 03:31, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > > This is easy, just set the list head to the page about to be truncated.
> >
> > Works for me.
> 
> It looks good, but it's black magic

No, it's wrong.  I'm getting BUG()s in clear_inode():

485             if (inode->i_data.nrpages)
486                     BUG();

(gdb) p inode->i_data
$5 = {clean_pages = {next = 0xd7423ae4, prev = 0xc1628280}, dirty_pages = {next = 0xd7423aec, prev = 0xd7423aec}, 
  locked_pages = {next = 0xd7423af4, prev = 0xd7423af4}, nrpages = 0x1, a_ops = 0xc02e4940, host = 0xd7423a40, 
  i_mmap = 0x0, i_mmap_shared = 0x0, i_shared_lock = {lock = 0x1}, gfp_mask = 0x5}

(gdb) p *(struct page *)0xd7423ae4
$6 = {list = {next = 0xd7423ae4, prev = 0xc1628280}, mapping = 0xd7423aec, index = 0xd7423aec, 
  next_hash = 0xd7423af4, count = {counter = 0xd7423af4}, flags = 0x1, lru = {next = 0xc02e4940, 
    prev = 0xd7423a40}, age = 0x0, wait = {lock = {lock = 0x0}, task_list = {next = 0x1, prev = 0x5}}, 
  pprev_hash = 0x0, buffers = 0x0, virtual = 0x0, zone = 0x0}
(gdb) p &inode->i_data

The lists are mangled.

I think what's happening is:

                curr = curr->next;
                offset = page->index;

                /* Is one of the pages to truncate? */
                if ((offset >= start) || (*partial && (offset + 1) == start)) {
                        list_del(head);
                        list_add_tail(head, curr);

`curr' can point to `head' when we get inside the `if'.
So we do, effectively,

	list_del(head);
	list_add_tail(head, head);

Which turns mapping->clean_pages into an empty list,
and the target page.list thinks it's on a list, but
really isn't.  A subsequent list_del() on the page
screws things up somehow.

Ho-hum.  I'll have another go tomorrow.  Probably a
simple `if (curr != head)' will cure it.

-
