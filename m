Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKFNzd>; Mon, 6 Nov 2000 08:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbQKFNzX>; Mon, 6 Nov 2000 08:55:23 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:27912 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129183AbQKFNzL>; Mon, 6 Nov 2000 08:55:11 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, kanoj@google.engr.sgi.com,
        torvalds@transmeta.com
Message-ID: <CA25698F.004C5DEA.00@d73mta05.au.ibm.com>
Date: Mon, 6 Nov 2000 19:20:05 +0530
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Thanks.
 That sounds like a reasonable approach to take.

  Regards
 - Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


"David S. Miller" <davem@redhat.com> on 11/06/2000 08:44:29 AM

Please respond to "David S. Miller" <davem@redhat.com>

To:   Suparna Bhattacharya/India/IBM@IBMIN
cc:   linux-kernel@vger.kernel.org, ak@suse.de, kanoj@google.engr.sgi.com
Subject:  Re: Oddness in i_shared_lock and page_table_lock nesting
      hierarchies ?




   From: bsuparna@in.ibm.com
   Date:  Sun, 5 Nov 2000 11:21:05 +0530

      However, in the vmtruncate code, it looks like the hierarchy is
      reversed.

It is a well known bug amongst gurus :-) I sent a linux24 bug addition
to Ted Ty'tso a week or so ago but he dropped it aparently.

Ted, I'm resending this below, please add it to the linux24 list
thanks.

X-Coding-System: undecided-unix
Date: Fri, 13 Oct 2000 17:36:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: tytso@mit.edu
Subject: New BUG for todo list


This bug will essentially hard-hang an SMP system if triggered.  Linus
and myself both know about it already for some time now, the fix is
straight forward, just nobody has coded it up and tested it yet.

The problem basically is that mm/memory.c:vmtruncate() violates the
lock acquisition ordering rules when both mm->page_table_lock and
mapping->i_shared_lock must both be acquired.  All other instances (in
the mmap/munmap syscalls for example) acuire the page_table_lock then
the i_shared_lock.  vmtruncate() on the other hand acquires the locks
i_shared_lock first then page_table_lock.

Essentially I would describe this in the TODO list as:

     vmtruncate() violates page_table_lock/i_shared_lock
     acquisition ordering rules leading to deadlock

The fix is to actually keep vmtruncate() how it is, and change the
ordering rules for the rest of the kernel to follow vmtruncate()'s
lock ordering.  Linus agreed with me on this because the more natural
data inspection flow is to go from the object to mappings of that
object.

I'm going to try and work on this change this weekend, but I want it
to be in the bug list so that it _is_ accounted for.

Later,
David S. Miller
davem@redhat.com





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
