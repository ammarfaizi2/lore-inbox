Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFSDe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFSDe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbUFSDe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:34:26 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62605 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263062AbUFSDeY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:34:24 -0400
Message-Id: <200406190334.i5J3Y6D1015854@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ashwin Rao <ashwin_s_rao@yahoo.com>
Cc: haveblue@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Atomic operation for physically moving a page (for memory defragmentation) 
In-Reply-To: Your message of "Fri, 18 Jun 2004 20:15:36 PDT."
             <20040619031536.61508.qmail@web10902.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1974871443P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jun 2004 23:34:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1974871443P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jun 2004 20:15:36 PDT, Ashwin Rao said:

> The problem is the memory fragmentation. The code i am
> writing is for the memory defragmentation as proposed
> by Daniel Phillips, my project partner Alok mooley has
> given mailed a simple prototype in the mid of feb.

OK.. Now we're getting somewhere. ;)  (Feel free to ignore
the rest - I'm *not* a memory management expert, but
a few thoughts come to mind - things that might help the
real experts answer the question..)

> > (*) Yes, I know the BKL isn't something you want to
> > grab if you can help it.
> 
> Isnt it a bad idea to take the BKL, the performance of
> SMP systems will drastically be hampered.

As I noted - not something you *want* to grab.  But sometimes,
especially when it's in error recovery, code may want to be able
to tell *everything* else to stay put for a moment while it figures
out what it needs to do next...

> The way we work is as follows
> Initially a block is selected which can be moved i.e
> pages on lru or free and the pages are moved to a

Out of curiosity, have you done any modeling to see how often
you need to move a page to coalesce holes and keep fragmentation
down?  The "best" solution will quite likely be vastly different if it's
something that needs to be done only as a "last resort" (i.e. order-N
allocations are failing for non-large N), or if it's something that
works best if it's being done several times a second during normal
system operation, etc....

> suitable free pages. The main problem arises during
> the copying and updation process. All the ptes are to
> updates. a method similar to try_to_unmap_one  is used
> to identify the ptes and the physical address is
> updated.

> The problem we are facing is to maintain the atomicity
> of this operation on SMP boxes.

Ahh..  Is there one thing in particular that causes the issues?
It may make sense to grab whatever lock usually controls that,
at least as a first-cut (what lock(s) are used by try_to_unmap_one,
for instance).  There's probably already a suitable lock, already
grabbed by whatever code is interfering with what your code is doing..


--==_Exmh_-1974871443P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA07QtcC3lWbTT17ARAtDbAJ4oZxQq7W8ohAkwoq3PLtwASUMgLACgttUu
w7zwFSrr6jgPcXtv/58Qojc=
=yOwq
-----END PGP SIGNATURE-----

--==_Exmh_-1974871443P--
