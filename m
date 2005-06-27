Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVF0Gav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVF0Gav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVF0G1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:27:50 -0400
Received: from h80ad25a1.async.vt.edu ([128.173.37.161]:15818 "EHLO
	h80ad25a1.async.vt.edu") by vger.kernel.org with ESMTP
	id S261861AbVF0G0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:26:32 -0400
Message-Id: <200506270624.j5R6OWFn008836@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Hubert Chan <hubert@uhoreg.ca>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Mon, 27 Jun 2005 00:54:17 CDT."
             <42BF9489.9080202@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <87y88webpo.fsf@evinrude.uhoreg.ca> <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>
            <42BF9489.9080202@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119853471_3633P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 02:24:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119853471_3633P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Jun 2005 00:54:17 CDT, David Masover said:

> There has been some mention of inheritance, but I've forgotten how
> that's supposed to work.  If there's some sort of inheritance where
> children inherit properties of their parent directory, and also inherit
> changes to those properties, than Hans probably wants that to be the
> prefered way of doing things?

Well, the 'chmod g+s dirname/' example *is* just "children inherit the
group of the directory", and somebody didn't like that.. ;)

> > Now throw in multiple users and CPU limits.  User A enters that directory and
> > references everything, causing the buffer cache to get filled up.  While there,
> > A makes changes, so the pages are dirty - "for i in */*; do echo " " >> $i; done"
> > would do the job...  User B now does something that causes a writeback of one
> > of those buffer cache pages.
> > 
> > A) What process currently gets ticked for the CPU and I/O for the writeback?
> > 
> > B) In your model, who will get ticked for the resources?
> > 
> > C) Will the users riot? (Note that you can't win here - currently, the "price"
> > of writing back A's and B's pages are about equal.  However, if A gets dinked
> > for an expensive writeback due to B's process, A will get miffed.  If B gets
> > charge for an expensive writeback of A's, B will get miffed. If you say "screw it"
> > and bill it to a kernel thread, the bean counters will get miffed... ;)
> 
> If I understand this correctly, this is somewhat like if user A creates
> a 50 meg file on a system with 100 megs free RAM, and user B runs
> "sync".  Also similar to if B were to suddenly fill up 75 megs of RAM,
> forcing A's file to be flushed -- last I checked, in Reiser4, only a
> sync or memory pressure causes writes to flush.

Exactly the same sort of thing - traditionally it's been more or less ignored
in the system accounting, because A would usually average out to causing as
many I/Os as B did, and they were roughly equal in cost so it was a wash.
However, if one user has a much higher per-page cost than the other, the
imbalance can start to matter *very* quickly....

> Right?  This is tempting to comment on, but I want to make sure I grok
> it first...

For more fun, consider how you can write 1 megabyte of data to a file,
lseek to the beginning and start writing again - and you go over quota
on the *second* write even though you're over-writing already existing
data.  Can happen if you're compressing, and the second write doesn't
compress as well as the first. (To be fair, we already have similar
issues with sparse files - but at least 'tar --sparse' has an easy way
to deal with it compared to this. ;)

--==_Exmh_1119853471_3633P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv5ufcC3lWbTT17ARAl5/AJ4w7OJfB4koyo8i0/Oj6NHhqhcHYgCdGVIW
4B9nWbIJIMjaJPn8y6IB/Gw=
=0JiG
-----END PGP SIGNATURE-----

--==_Exmh_1119853471_3633P--
