Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWFIVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWFIVYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWFIVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:24:44 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:38008 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932238AbWFIVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:24:42 -0400
Date: Fri, 9 Jun 2006 14:24:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609212410.GJ3574@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609210319.GF10524@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 05:03:19PM -0400, Theodore Tso wrote:
> This is going to happen regardless of whether we call the code base
> "ext3" or "ext4".  Anytime you make format changes (in this case, to
> support larger disk sizes) older kernels won't support it any more.
> Surprise!  

	Of course format changes break things.  But if you claim that
"X" and "Y" are the same thing, and they aren't, people won't see it
coming.

> wasn't able to check the filesystem.  But this was actually Red Hat's
> fault, in that they shouldn't have transparently added the extended
> attribute feature without first asking the user's permission.   

	Sure it was Red Hat's fault.  Knowing who to blame doesn't solve
the existing problem, though.  They never even put out e2fsck upgrades
for older distros, which would have solved the problem just as easily.

> Being able to forward upgrade to newer filesystem formats is a good
> thing, and has a long history; users don't like to do a backup,
> reformat, and restore pass if they can't help that.  Heck, Microsoft
> Windows even has a way that they can upgrade a FAT filesystem to their
> latest NTFSv5 filesystem using a userspace progam.  Providing such a
> capability is not a bad thing, and in fact it is a good thing.  The
> bad thing to do is to do the conversion without first asking the
> user's permission (for example just as Windows XP does when you first
> boot a preinstalled system on a laptop for the first time).

	This entire statement is true.  However, note that "FAT" becomes
"NTFSv5", and there is no expectation, implicit or explicit, that you
can use "FAT" to mount the changed volume.
	You can call the new filesystem ext4, and mount an old ext3 as
ext4, and guess what?  You're just as forward compatible, but now you've
explictly specified the lack of backwards compatibility.  You could even
provide a userspace tool just like in your example to switch an INCOMPAT
feature.

> People seem to be arguing that just because an distribution installer
> _could_ do a backwards incompatible upgrade without first asking
> permission first, we must not provide the capability at all, and make
> it be the case that the only way to upgrade from ext3 to ext4 is with
> a backup, reformat, and restore.  Surely that doesn't make sense!

	There is no reason you need a backup/restore cycle.  Mount it as
ext4, and forever forward its an ext4.  In the ext2->ext3 cycle, we
called it "tunefs -J".
 
> So how about we trust the distributions to be a bit more careful
> this time around?

	Haha, you're funny.
	Seriously, Ted, I personally have one concern here.  I don't
care much about the maintainability of one code base versus two.  Both
have advantages and problems.  I care a little that my "used to be
stable" ext3 code base might be destabilized, but I know that the ext2/3
team has been better than most at stable code transitions.
	What I do care is that "ext3" can no longer mount partition X.
That's gonna happen.  This thing still has the same name, but it is in
actuality something very different.  When ext2 could no longer mount a
journaled version of itself, we changed it to "ext3".
	Heck, forget the name, just make the breakage more explicit.  Do
it at mkfs/tunefs time.  "tunefs -extents" or "mkfs -t ext3 -extents".
A mount option assumes that you can do with or without it.  If you do it
once, you can mount the next time without it and stuff Just Works.  Even
htree follows this.  A clean unmount leaves a clean directory structure
that a non-htree driver can use.

Joel

-- 

"Not being known doesn't stop the truth from being true."
        - Richard Bach

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
