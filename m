Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283825AbRK3Vx5>; Fri, 30 Nov 2001 16:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283819AbRK3Vxm>; Fri, 30 Nov 2001 16:53:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:21231 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283821AbRK3Vx1>;
	Fri, 30 Nov 2001 16:53:27 -0500
Date: Fri, 30 Nov 2001 14:52:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
Message-ID: <20011130145223.Q15936@lynx.no>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C072279.D346CD09@zip.com.au> <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0111301344330.17515-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Nov 30, 2001 at 01:44:42PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2001  13:44 -0200, Marcelo Tosatti wrote:
> Now are you sure this can't break anything ? 

What fun would that be, if you couldn't follow in Linus' footsteps?
People would get complacent if things didn't break now and again ;-).

Anyways, you never want to put a change that is not a specific bug
fix in a -rc patch anyways.  Save it for a -pre patch, where you expect
at least some testing before it is released.

> On Thu, 29 Nov 2001, Andrew Morton wrote:
> > mark_inode_dirty() is quite expensive for journalling filesystems,
> > and we're calling it a lot more than we need to.
> > 
> > --- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
> > +++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
> > @@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
> >   
> >  void update_atime (struct inode *inode)
> >  {
> > +	if (inode->i_atime == CURRENT_TIME)
> > +		return;
> >  	if ( IS_NOATIME (inode) ) return;
> >  	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
> >  	if ( IS_RDONLY (inode) ) return;
> > 
> > 
> > with this patch, the time to read a 10 meg file with 10 million
> > read()s falls from 38 seconds (ext3), 39 seconds (reiserfs) and
> > 11.6 seconds (ext2) down to 10.5 seconds.

Well, just doing a code check of the update_atime() and UPDATE_ATIME()
users, and they are all in readlink(), follow_link(), open_namei(),
and various fs _readdir() codes.  None of them (AFAICS) depend on the
mark_inode_dirty() as a side-effect.  This means it should be safe.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

