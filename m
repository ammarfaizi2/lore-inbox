Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSGOUr5>; Mon, 15 Jul 2002 16:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSGOUr4>; Mon, 15 Jul 2002 16:47:56 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1797 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317628AbSGOUrz>; Mon, 15 Jul 2002 16:47:55 -0400
Date: Mon, 15 Jul 2002 22:50:46 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715205046.GB30630@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <s5gwurxt59x.fsf@egghead.curl.com> <20020715151833.GA22828@merlin.emma.line.org> <s5g4rf1t1j6.fsf@egghead.curl.com> <20020715181650.GA20665@merlin.emma.line.org> <s5gwurwstuj.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <s5gwurwstuj.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> > Postfix is ahead of that: it omits the first fsync() you suggest,
> > because the +x flag, while necessary, is not sufficient to mark the
> > mail as "complete, further processing allowed". The "message file"
> > is a structured file format that has an "end" record at the end of
> > the file.
> 
> This is not sufficient!  Data writes are NOT guaranteed to be ordered.
> It is permissible for the file system to flush the first and last
> block of a file to disk BEFORE flushing the middle.  You either need
> the double fsync() or you need a checksum in the file; simple markers
> are not enough to make a real guarantee.  And MTAs should be making
> real guarantees!

*shrug* sounds plausible. Isn't this a case for data=ordered? The data
blocks are there before the +x flag is committed, or am I mistaken here?

However, as Postfix by default imposes chattr +S on its queue, nothing
is lost except performance. Or is not even chattr +S sufficient here
with single fsync()?

> Failing to call fsync() at all (i.e., failing to commit metadata
> updates) is what can recreate dead files.

Doesn't apply.

> > Postfix' local(8) daemon additionally relies on rename(2) being
> > synchronous (in Maildir delivery), it does not fsync() after rename.
> > OTOH, the file is completely in Maildir/tmp/somename, so it's not
> > really lost, just invisible.
> 
> No, it is lost, because the file's creation is not guaranteed to have
> happened at all!  (Well, depending on the file system and the
> semantics.  I think I need to write this up more clearly.)

Euhm, assume chattr +S on Maildir/tmp/ -- this is where the file is
created. Now, a rename() is issued, from a chattr +S (sync) directory to
a chattr -S directory. Is this safe or will the destination directory
also have to be +S? If so, it might be very useful performance-wise to
NOT have files inherit the +S flag.

> As I said, the issue is what descriptors they should call fsync() on.
> On Linux, fsync() on a file's descriptor will commit the file's
> contents; a second fsync() on the containing directory's descriptor
> will commit the rename()/link().

MTA authors will probably not go this length.

- -- 
Matthias Andree
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9MzWmFmbjPHp/pcMRApLEAJ9B5m5b5ith6jkgaR5kt9oG2/AvAACfe0Vc
32OZjmHKYclz9JlB9kjUW+M=
=grP2
-----END PGP SIGNATURE-----
