Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSKDKxr>; Mon, 4 Nov 2002 05:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSKDKxr>; Mon, 4 Nov 2002 05:53:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:57362 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264637AbSKDKxp>; Mon, 4 Nov 2002 05:53:45 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15814.21309.758207.21416@laputa.namesys.com>
Date: Mon, 4 Nov 2002 14:00:13 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alexander Zarochentcev <zam@namesys.com>, Hans Reiser <reiser@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <20021102132421.GJ28803@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com>
	<200210312334.18146.Dieter.Nuetzel@hamburg.de>
	<3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
	<15810.46998.714820.519167@crimson.namesys.com>
	<20021102132421.GJ28803@louise.pinerecords.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: Is this my STOP??
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe writes:
 > > This should help:
 > > 
 > > diff -Nru a/txnmgr.c b/txnmgr.c
 > > --- a/txnmgr.c	Wed Oct 30 18:58:09 2002
 > > +++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
 > > @@ -1917,7 +1917,7 @@
 > >  		return;
 > >  	}
 > >  
 > > -	if (!jnode_is_unformatted) {
 > > +	if (jnode_is_znode(node)) {
 > >  		if ( /**jnode_get_block(node) &&*/
 > >  			   !blocknr_is_fake(jnode_get_block(node))) {
 > >  			/* jnode has assigned real disk block. Put it into
 > 
 > 
 > Jup, this fixes the leak, but free space still isn't reported accurately
 > until after sync gets called, which I believe is a bug too.

In reiser4 allocation of disk space is delayed to transaction commit. It
is not possible to estimate precisely amount of disk space that will be
allocated during commit, and hence statfs(2) results are not updated
until one does sync(2) (forcing commit) or transaction is committed due
to age (10 minutes by default).

 > 
 > Compare:
 > [reiser3]
 > $ pwd
 > /tmp
 > $ dd if=/dev/zero of=testfile bs=16k count=64
 > 64+0 records in
 > 64+0 records out
 > $ df /
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda1               526296    330696    195600  63% /
 > $ rm testfile
 > $ df /
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda1               526296    329672    196624  63% /
 > $ sync
 > $ df /

[...]

Nikita.
