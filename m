Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSKEHYd>; Tue, 5 Nov 2002 02:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264768AbSKEHYd>; Tue, 5 Nov 2002 02:24:33 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:48612 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264790AbSKEHYa>; Tue, 5 Nov 2002 02:24:30 -0500
Message-ID: <3DC773B0.4070701@namesys.com>
Date: Mon, 04 Nov 2002 23:30:56 -0800
From: reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com>	<200210312334.18146.Dieter.Nuetzel@hamburg.de>	<3DC1B2FA.8010809@namesys.com>	<3DC1D63A.CCAD78EF@digeo.com>	<3DC1D885.6030902@namesys.com>	<3DC1D9D0.684326AC@digeo.com>	<3DC1DF02.7060307@namesys.com>	<20021101102327.GA26306@louise.pinerecords.com>	<15810.46998.714820.519167@crimson.namesys.com>	<20021102132421.GJ28803@louise.pinerecords.com> <15814.21309.758207.21416@laputa.namesys.com>
In-Reply-To: <3DC19F61.5040007@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Tomas Szepe writes:
> > > This should help:
> > > 
> > > diff -Nru a/txnmgr.c b/txnmgr.c
> > > --- a/txnmgr.c	Wed Oct 30 18:58:09 2002
> > > +++ b/txnmgr.c	Fri Nov  1 20:13:27 2002
> > > @@ -1917,7 +1917,7 @@
> > >  		return;
> > >  	}
> > >  
> > > -	if (!jnode_is_unformatted) {
> > > +	if (jnode_is_znode(node)) {
> > >  		if ( /**jnode_get_block(node) &&*/
> > >  			   !blocknr_is_fake(jnode_get_block(node))) {
> > >  			/* jnode has assigned real disk block. Put it into
> > 
> > 
> > Jup, this fixes the leak, but free space still isn't reported accurately
> > until after sync gets called, which I believe is a bug too.
>
>In reiser4 allocation of disk space is delayed to transaction commit. It
>is not possible to estimate precisely amount of disk space that will be
>allocated during commit, and hence statfs(2) results are not updated
>until one does sync(2) (forcing commit) or transaction is committed due
>to age (10 minutes by default).
>
>  
>
The above is badly phrased, and the behavior complained of is indeed a 
bug not a feature.  Please fix.  

statfs should be updated immediately in accordance with estimates used 
by the space reservation code, and then adjusted at commit time in 
accordance with actual usage.

Andreas, the performance advantage is achieved using much more than the 
amount of RAM available on the computer, and is therefore mostly 
independent of max transaction age.  The appropriate setting of 
transaction max age depends on the user.  The setting we chose is 
appropriate for software developers doing compiles.  It is not clear to 
me yet what the right setting is.  Perhaps 3 minutes is more 
appropriate.  I was probably overly influenced by Drew Roselli's 
statistics on how long the cyle is between rewrites.  Her statistics are 
probably skewed by having lots of CS students using the machines she got 
her data from.  5 seconds is too short to perform good layout 
optimization for subsequent reads.

Hans

