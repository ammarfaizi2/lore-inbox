Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269697AbUINS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269697AbUINS24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269604AbUINSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:21:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3526 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269639AbUINSTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:19:11 -0400
Message-Id: <200409130825.i8D8P6gA029615@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 - 'journal block not found' - ext3 on crack? 
In-Reply-To: Your message of "Fri, 03 Sep 2004 16:48:24 PDT."
             <20040903164824.4a3b0ee1.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200409021815.i82IFpLT022145@turing-police.cc.vt.edu>
            <20040903164824.4a3b0ee1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_421444723P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Sep 2004 04:25:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_421444723P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Sep 2004 16:48:24 PDT, Andrew Morton said:

(Sorry for the delay in following up...)

> > Sep  2 12:42:50 turing-police kernel: journal_bmap: journal block not found
 at offset 2316 on dm-6
> > Sep  2 12:42:52 turing-police kernel: Aborting journal on device dm-6.

> Probably caused by an I/O error (or data loss) performing metadata reads.

I'd be willing to buy that, except that it's been hitting me off-and-on and
there's NEVER a dmesg entry indicating an actual I/O problem.  Also, I never
hit it against 2.6.8.1-mm4 - I've only seen it against -rc1-mm2 and -rc1-mm4
(didn't try mm1 or mm3).  I'm always leery of silent "must be I/O error"
problems that show up when you upgrade the software.. ;)

Here's one against -mm4 last night:

Sep 12 03:00:03 turing-police kernel: audit(1094972403.380:0): avc:  denied  { search } for  pid=14808 ex
e=/usr/bin/whereis name=man dev=dm-1 ino=18869 scontext=user_u:user_r:user_crond_t tcontext=system_u:obje
ct_r:man_t tclass=dir
Sep 12 03:37:04 turing-police kernel: journal_bmap: journal block not found at offset 12 on dm-6
Sep 12 03:37:04 turing-police kernel: Aborting journal on device dm-6.
Sep 12 03:37:04 turing-police kernel: __journal_remove_journal_head: freeing b_committed_data
Sep 12 03:37:04 turing-police last message repeated 4 times
Sep 12 03:37:07 turing-police kernel: ext3_abort called.
Sep 12 03:37:07 turing-police kernel: EXT3-fs error (device dm-6): ext3_journal_start: Detected aborted journal
Sep 12 03:37:07 turing-police kernel: Remounting filesystem read-only
Sep 12 03:37:07 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted


Absolutely nothing out of the kernel for 37 minutes straight, till suddenly it
decides that /home has a problem (Yes, there *was* plenty activity on the disk
at the time - the usual 3AM cron-based disk thrashers, and I was trying to
catch up on lkml, hit 'commit' for a bunch of pending 'delete messages', and
things just sort of sat there because the file system just evaporated out from
under it).

> > Of interest:
> > 
> > 1) Didn't see this under 2.6.8-mm4.
> > 2) Neither time had any actual disk I/O error messages...
> > 3) I'm using ext3-on-LVM, if that matters...
> 
> Let me guess: raid5?

Nope. ext3, lvm, and a single laptop IDE disk under it all....

journal_bmap() appears to eventually end up down in ext3_get_branch(). Is it
possible that there's some weird locking/race issue where we end up calling
__bread() for the block, but get a bh that has wrong/bogus uptodate/dirty
flags? (this only seems to bite under high (for a laptop) I/O - while updatedb
or tripwire are running in background, or reading down my mail in the morning,
or doing a large compile/make, etc) Is it possible for the journal to wrap
around and we come back to an "old" page that *still* hasn't made it out to
disk due to LVM/elevator/etc issues (even though enough other I/O requests have
been retired to keep things happy?)


--==_Exmh_421444723P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBRVlecC3lWbTT17ARAsAHAKDXi2fUIhbT4LhhVUNj+SqAmADIdwCgqEDd
zvPuFnHHwOOIQRPiu43bplk=
=Ya3w
-----END PGP SIGNATURE-----

--==_Exmh_421444723P--
