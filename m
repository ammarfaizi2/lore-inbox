Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291096AbSBGEDa>; Wed, 6 Feb 2002 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291097AbSBGEDS>; Wed, 6 Feb 2002 23:03:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58517 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291096AbSBGEDG>;
	Wed, 6 Feb 2002 23:03:06 -0500
Date: Wed, 06 Feb 2002 20:01:00 -0800 (PST)
Message-Id: <20020206.200100.85392985.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: Ulrich.Weigand@de.ibm.com, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: The IBM order relaxation patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16YcH1-0006ua-00@the-village.bc.nu>
In-Reply-To: <OF5FF19417.595BC760-ONC1256B58.00762715@de.ibm.com>
	<E16YcH1-0006ua-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 7 Feb 2002 00:18:47 +0000 (GMT)

   > >with a GPF flag? What they describe does not happen in an
   > >interrupt context, so we can sleep.
   > 
   > Because nobody even *tries* to free adjacent pages to build up
   > a free order-2 area.  You could wait really long ...
   
   Without the rmap patch you can't easily do it
   
One change from Rik's VM (both of them, the 2.4.9 based AC stuff and
RMAP) and the current stuff in Linus's tree is that order 2 and
smaller are treated all equally.

This got rid of a lot of problems on Sparc64 and with AF_UNIX sockets
for example.  Sparc64 has the same issue as the IBM patch is trying
to solve, we need order 1 pages for our page table allocations.  And
AF_UNIX was trying to use large linear buffers for better performance
during bulk transfers.

Btw, the AF_UNIX side of this results in all kinds of MYSQL
performance problems, or at least this is how I remember it.
(for more details on this grep for SKB_MAX_ALLOC in current
 2.4.x/2.5.x sources, in particular the references in
 include/linux/skbuff.h and net/unix/af_unix.c)

There was even a linux-kernel thread about all of this back in
the 2.4.{13,14,15} days, perhaps someone can find it on
marc.theaimsgroup.com

I do not think the Linus VM behavior is unreasonable, which basically
amounts to continually trying to free pages for all order 3 and below
allocations (if you can sleep and you aren't PF_MEMALLOC etc.).

   > rmap method could help here, because with reverse mappings we
   > can at least try to free adjacent areas (because we then at least
   > *know* who's using the pages).
   
   rmap definitely makes it a real no brainer to do this at least for small
   clusters of pages. Doing large chunks gets progressively harder

You just have to be careful that you don't let the algorithm
degenerate into a dumb scan, which is the kind of silly stuff
the VM used to do back in the pre-2.2.x days :-)
