Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSKDRqt>; Mon, 4 Nov 2002 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbSKDRqt>; Mon, 4 Nov 2002 12:46:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:2319 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S262214AbSKDRqq>;
	Mon, 4 Nov 2002 12:46:46 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15814.46090.7694.593433@laputa.namesys.com>
Date: Mon, 4 Nov 2002 20:53:14 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alexander Zarochentcev <zam@Namesys.COM>, Hans Reiser <reiser@Namesys.COM>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@Namesys.COM>,
       umka <umka@Namesys.COM>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <20021104171055.GD8606@louise.pinerecords.com>
References: <200210312334.18146.Dieter.Nuetzel@hamburg.de>
	<3DC1B2FA.8010809@namesys.com>
	<3DC1D63A.CCAD78EF@digeo.com>
	<3DC1D885.6030902@namesys.com>
	<3DC1D9D0.684326AC@digeo.com>
	<3DC1DF02.7060307@namesys.com>
	<20021101102327.GA26306@louise.pinerecords.com>
	<15810.46998.714820.519167@crimson.namesys.com>
	<20021102133824.GL28803@louise.pinerecords.com>
	<15814.25070.118410.47102@laputa.namesys.com>
	<20021104171055.GD8606@louise.pinerecords.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: Qaddafi Serbian Cocaine dirty bomb Uzi Craig Livingstone
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe writes:
 > >  > Hi,
 > >  > 
 > >  > Another one: trying to build 2.5.45 off a reiser4 mountpoint, I get:
 > >  > 
 > >  > reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
 > >  > WARNING: Flush raced against extent->tail
 > >  > reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
 > >  > WARNING: flush failed: -11
 > >  > jnode_flush failed with err = -11
 > > 
 > > Can you please try the following patch to the fs/reiser4/flush.c:
 > > ----------------------------------------------------------------------
 > > --- /tmp/flush.c	Mon Nov  4 14:32:21 2002
 > > +++ flush.c	Mon Nov  4 14:32:32 2002
 > > @@ -3149,7 +3149,8 @@ flush_scan_extent(flush_scan * scan, int
 > >  				   only. Will be removed. */
 > >  				warning("nikita-2732", 
 > >  					"Flush raced against extent->tail");
 > > -				ret = -EAGAIN;
 > > +				scan->stop = 1;
 > > +				ret = 0;
 > >  				goto exit;
 > >  			}
 > >  			assert("jmacd-1230", item_is_extent(&scan->parent_coord));
 > 
 > Seems to fix the flush errors, however, I can still see the race warnings.

Good. Warning was left there for debugging. I shall remove it.

 > Worse though, at one point I stumbled upon the following:
 > 
 > $ df /ap
 > Filesystem           1k-blocks      Used Available Use% Mounted on
 > /dev/sda2              1490332 -73786976294838198272   1498808 101% /ap
 > 
 > This was right after I hit the reset button while compiling the kernel
 > off a reiser4 mountpoint, went on to finish the build after reboot and
 > then "rm -rf"'d the whole source tree (i.e. there was nothing on the
 > filesystem again).
 > 
 > reiser4.o is 20021031 plus the rmdir leak fix from this thread plus
 > your patch above.

Do you have debugging on?

 > 
 > >  > ... after which r4 crashes completely --
 > >  > Starts to hog all cpu time and umount() never goes through.
 > > 
 > > Try to wait a bit more and check whether any more "WARNING: Too many
 > > iterations" appear, OK?
 > 
 > Jup, now all I get is the race warnings.
 > 
 > -- 
 > tomas szepe <szepe@pinerecords.com>

Nikita.
