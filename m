Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264772AbSKEKGt>; Tue, 5 Nov 2002 05:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264777AbSKEKGr>; Tue, 5 Nov 2002 05:06:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59154 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264772AbSKEKGq>; Tue, 5 Nov 2002 05:06:46 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.39064.694477.303428@crimson.namesys.com>
Date: Tue, 5 Nov 2002 13:08:24 +0300
To: Tomas Szepe <szepe@pinerecords.com>
Cc: reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <20021105095904.GC19762@louise.pinerecords.com>
References: <3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
	<15810.46998.714820.519167@crimson.namesys.com>
	<20021102132421.GJ28803@louise.pinerecords.com>
	<15814.21309.758207.21416@laputa.namesys.com>
	<3DC773B0.4070701@namesys.com>
	<20021105095904.GC19762@louise.pinerecords.com>
X-Mailer: VM 7.00 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe writes:
 > > >> > This should help:
 > > >> > 
 > > >> > diff -Nru a/txnmgr.c b/txnmgr.c
 > > >> > --- a/txnmgr.c	Wed Oct 30 18:58:09 2002
 > > >> > +++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
 > > >> > @@ -1917,7 +1917,7 @@
 > > >> >  		return;
 > > >> >  	}
 > > >> >  
 > > >> > -	if (!jnode_is_unformatted) {
 > > >> > +	if (jnode_is_znode(node)) {
 > > >> >  		if ( /**jnode_get_block(node) &&*/
 > > >> >  			   !blocknr_is_fake(jnode_get_block(node))) {
 > > >> >  			/* jnode has assigned real disk block. Put it into
 > > >> 
 > > >> 
 > > >> Jup, this fixes the leak, but free space still isn't reported accurately
 > > >> until after sync gets called, which I believe is a bug too.
 > > >
 > > >In reiser4 allocation of disk space is delayed to transaction commit. It
 > > >is not possible to estimate precisely amount of disk space that will be
 > > >allocated during commit, and hence statfs(2) results are not updated
 > > >until one does sync(2) (forcing commit) or transaction is committed due
 > > >to age (10 minutes by default).
 > > >
 > > The above is badly phrased, and the behavior complained of is indeed
 > > a bug not a feature.  Please fix.
 > 
 > I just noticed the file
 > http://thebsh.namesys.com/snapshots/2002.10.31/reiser4.diff
 > had changed, the difference from the original 20021031 snapshot being:
 > 
 > --- fs_reiser4.diff.old 2002-10-31 14:11:50.000000000 +0100
 > +++ fs_reiser4.diff.new 2002-11-04 16:57:46.000000000 +0100
 > @@ -46903,7 +46903,7 @@
 >  +#if REISER4_USER_LEVEL_SIMULATION
 >  +#    define check_spin_is_locked(s)     spin_is_locked(s)
 >  +#    define check_spin_is_not_locked(s) spin_is_not_locked(s)
 > -+#elif defined( CONFIG_DEBUG_SPINLOCK ) && defined( CONFIG_SMP )
 > ++#elif 0 && defined( CONFIG_DEBUG_SPINLOCK ) && defined( CONFIG_SMP )
 >  +#    define check_spin_is_not_locked(s) ( ( s ) -> owner != get_current() )
 >  +#    define spin_is_not_locked(s)       ( ( s ) -> owner == NULL )
 >  +#    define check_spin_is_locked(s)     ( ( s ) -> owner == get_current() )
 > 
 > So either someone is messing about with your webserver or you want multiple
 > versions of the supposedly same diff floating around (not exactly suitable
 > for gathering bugreports, is it?).  If you're short on disk space, how about
 > gzipping the fs diff?  Squeezes down to ~500k from almost 2MB.

done for 2002.10.31 snapshot.

 > 
 > -- 
 > Tomas Szepe <szepe@pinerecords.com>

-- 
Alex.
