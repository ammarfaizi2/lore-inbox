Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTIHKFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTIHKFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:05:43 -0400
Received: from users.linvision.com ([62.58.92.114]:14266 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262315AbTIHKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:05:41 -0400
Date: Mon, 8 Sep 2003 12:05:31 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908120531.A28937@bitwizard.nl>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908094825.GD10487@namesys.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:48:25PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Sep 08, 2003 at 11:33:04AM +0200, Rogier Wolff wrote:
> > > > > > There  is no installation program that will fail with: "Sorry, 
> > > > > > you only have 100 million inodes free, this program will need
> > > > > > 132 million after installation", and it allows me a quick way 
> > > > > > of counting the number of actual files on the disk.... 
> > > > > You cannot. statfs(2) only exports "Total number of inodes on disk" and
> > > > > "number of free inodes on disk" values for fs. df substracts one from another one
> > > > > to get "number of inodes in use".
> > > > So, you report "oids_in_use + 100M" as total and "100M" as free inodes 
> > > > on disk. Voila!
> > > Yes, we thought about that too. Need to be careful to not overflow
> > > "long int".  
> > > And idea of filesystem with variable amount of inodes over time
> > > sounds confusing to me, too.  ]
> > SO? That's actually the case. So it's confusing. So you're confusing
> > people even more by telling nothing. Great. 
> 
> Well, but statfs(2) does not return an "inodes in use" value, that's it.
> 
> > #define LARGE_NUMBER 100000
> > out->total_inodes = fs->oids_in_use + LARGE_NUMBER; 
> > if (out->total_inodes < fs->oids_in_use) 
> >    out -> total_inods = MAXINT;
> > out -> free_inodes = LARGE_NUMBER; 
> > Three lines of code fixes that. 
> 
> Yes, and you get complete crap once you hit the overflow condition?

No. Not complete crap. It's a thirty two bit integer. What do you expect
when you hit the "limit"?

What will ext2 report when you have 4G inodes in use?

Just capping is the best way. 

And as Reiserfs has the option of still storing (at least)
LARGE_NUMBER more files it can simply report that as well. 

Anyway, I happen to (also) work for a company called
"harddisk-recovery.nl". We get to see varying types of uses for
harddisk and their contents. So far we've had two clients with more
than half a million files. One had 3.6 and the other had 4.7 million
files. Trust me, those are extreme. Oh, and we have on the order of 10
million files ourselves (but notquite that many inodes!). We're
extreme.

The tendency is that when disks get larger, so do the files. The
number of files grows much slower than the number of bytes. 

So a factor of 1000 will last us some 40 years instead of the 20 that
Mr Moore predicts. Now Alan is saying that by the time we have
512Mbyte of RAM on video cards we'll all be using 64 bit anyway. Well
I predict that he's a bit optimistic in that respect. But in 40 years,
you'll have your new 64 bit statfs. You can be certain of that.

> > > Well, if current interface does not allow to see all the stuff you want to,
> > > time to change (introduce new one) interface, anyway.
> > Fine, introduce a new interface. But report as much as you can on the
> > old interface. Remember you can read/write/seek files using the 32bit
> > interface even though the new (seek-, and stat-) interface uses 64
> > bits.
 
> You need to open a file with O_LARGEFILE first, so old binaries
> still won't work.

1) I can still work on files smaller than 2G without problems. 

2) If my shell uses O_LARGEFILE, I can redirect stdin and stdout
to large files anyway, even if the app would open without O_LARGEFILE. 

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
