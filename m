Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264807AbSKEI0x>; Tue, 5 Nov 2002 03:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSKEI0x>; Tue, 5 Nov 2002 03:26:53 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58897 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264807AbSKEI0v>; Tue, 5 Nov 2002 03:26:51 -0500
From: Alexander Zarochentcev <zam@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.33089.583184.62816@crimson.namesys.com>
Date: Tue, 5 Nov 2002 11:28:49 +0300
To: reiser@namesys.com
Cc: Nikita Danilov <Nikita@namesys.com>, Tomas Szepe <szepe@pinerecords.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <3DC773B0.4070701@namesys.com>
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
	<15814.21309.758207.21416@laputa.namesys.com>
	<3DC773B0.4070701@namesys.com>
X-Mailer: VM 7.00 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reiser writes:
 > Nikita Danilov wrote:
 > 
 > >Tomas Szepe writes:
 > > > > This should help:
 > > > > 
 > > > > diff -Nru a/txnmgr.c b/txnmgr.c
 > > > > --- a/txnmgr.c	Wed Oct 30 18:58:09 2002
 > > > > +++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
 > > > > @@ -1917,7 +1917,7 @@
 > > > >  		return;
 > > > >  	}
 > > > >  
 > > > > -	if (!jnode_is_unformatted) {
 > > > > +	if (jnode_is_znode(node)) {
 > > > >  		if ( /**jnode_get_block(node) &&*/
 > > > >  			   !blocknr_is_fake(jnode_get_block(node))) {
 > > > >  			/* jnode has assigned real disk block. Put it into
 > > > 
 > > > 
 > > > Jup, this fixes the leak, but free space still isn't reported accurately
 > > > until after sync gets called, which I believe is a bug too.
 > >
 > >In reiser4 allocation of disk space is delayed to transaction commit. It
 > >is not possible to estimate precisely amount of disk space that will be
 > >allocated during commit, and hence statfs(2) results are not updated
 > >until one does sync(2) (forcing commit) or transaction is committed due
 > >to age (10 minutes by default).
 > >
 > >  
 > >
 > The above is badly phrased, and the behavior complained of is indeed a 
 > bug not a feature.  Please fix.  
 > 
 > statfs should be updated immediately in accordance with estimates used 
 > by the space reservation code, and then adjusted at commit time in 
 > accordance with actual usage.

We should not do that unless we implement forcing of commits at out of free
space situation.

 > 
 > Andreas, the performance advantage is achieved using much more than the 
 > amount of RAM available on the computer, and is therefore mostly 
 > independent of max transaction age.  The appropriate setting of 
 > transaction max age depends on the user.  The setting we chose is 
 > appropriate for software developers doing compiles.  It is not clear to 
 > me yet what the right setting is.  Perhaps 3 minutes is more 
 > appropriate.  I was probably overly influenced by Drew Roselli's 
 > statistics on how long the cyle is between rewrites.  Her statistics are 
 > probably skewed by having lots of CS students using the machines she got 
 > her data from.  5 seconds is too short to perform good layout 
 > optimization for subsequent reads.
 > 
 > Hans
 > 

-- 
Alex.
