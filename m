Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJaQy2>; Thu, 31 Oct 2002 11:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSJaQy2>; Thu, 31 Oct 2002 11:54:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19207 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263143AbSJaQy0>; Thu, 31 Oct 2002 11:54:26 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.25023.211776.529580@laputa.namesys.com>
Date: Thu, 31 Oct 2002 20:00:47 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]: reiser4 [8/8] reiser4 code
In-Reply-To: <Pine.GSO.4.21.0210311121520.16688-100000@weyl.math.psu.edu>
References: <15809.22155.408140.213679@laputa.namesys.com>
	<Pine.GSO.4.21.0210311121520.16688-100000@weyl.math.psu.edu>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: My ELBOW is a remote FRENCH OUTPOST!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > 
 > 
 > On Thu, 31 Oct 2002, Nikita Danilov wrote:
 > 
 > >  > And you want that to be reviewed until tonight?
 > >  > 
 > > 
 > > No. But changes to the core are not very complicated. If Linus "reviews"
 > > and accepts them life of reiser4 would be much simpler.
 > 
 > Changes to the core consist (AFAICS) of exporting a bunch of functions
 > with no explanation of the way they are used - with some of them it's
 > really straightforward (and can go in at any point), with some one
 > would expect really detailed explanation and code review (your comments
 > regarding fsync_super() export trigger all sorts of alarms for me).

Let's start from fsync_super() then.

Reiser4 has data journalling.

When ->writepage() is called on dirtied page, page joins transaction.
During umount all out-standing transaction have to be committed.  But if
file were mmapped, then, at the moment of the call to ->kill_super()
pages can be dirtied without ->writepage() ever called on them.

generic_shutdown_super() calls fsync_super(sb) (which will call
->writepage() on each dirty page) and then invalidate_inodes().

Reiser4 has commit out-standing transactions -between- these two points:
after ->writepage() has been called on all dirty pages, but before
inodes were destroyed. Thus, we cannot use
kill_block_super()/generic_shutdown_super().

 > 
 > PS: Cc'ing a posting on a public list to a subscribers-only one is
 > generally not a nice thing to do...  Cc: trimmed.

Arghh... Sorry, it will be fixed... soon.

 > 

Nikita.
