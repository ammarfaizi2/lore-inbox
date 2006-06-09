Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWFIVDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWFIVDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWFIVDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:03:36 -0400
Received: from thunk.org ([69.25.196.29]:18342 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030225AbWFIVDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:03:35 -0400
Date: Fri, 9 Jun 2006 17:03:19 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609210319.GF10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609203803.GF3574@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 01:38:03PM -0700, Joel Becker wrote:
> 	Filesystem features are different.  There is a permanent state
> that the older code cannot read.  Alex claims people just shouldn't use
> "-o extents", but the fact is their distro will choose it for them.  We
> have multiboot machines in our test lab, because like many people we
> don't have unlimited funds.  What happened when we installed the 2.6
> distros?  All of a sudden the older 2.4 distros wouldn't mount the
> shared filesystems, becuase of ext3 features.  

This is going to happen regardless of whether we call the code base
"ext3" or "ext4".  Anytime you make format changes (in this case, to
support larger disk sizes) older kernels won't support it any more.
Surprise!  

In the case you were referring to, one specific distribution, Red Hat,
silently added the extended attributes feature to the filesystem
because it was needed by SELINUX.  This was actually a backwards
compatible feature, so that older 2.4 based distributions could
*mount* the filesystem.  Unfortunately e2fsck needs to be more
careful, and so the problem was that the older distribution's fsck
wasn't able to check the filesystem.  But this was actually Red Hat's
fault, in that they shouldn't have transparently added the extended
attribute feature without first asking the user's permission.   

Being able to forward upgrade to newer filesystem formats is a good
thing, and has a long history; users don't like to do a backup,
reformat, and restore pass if they can't help that.  Heck, Microsoft
Windows even has a way that they can upgrade a FAT filesystem to their
latest NTFSv5 filesystem using a userspace progam.  Providing such a
capability is not a bad thing, and in fact it is a good thing.  The
bad thing to do is to do the conversion without first asking the
user's permission (for example just as Windows XP does when you first
boot a preinstalled system on a laptop for the first time).

People seem to be arguing that just because an distribution installer
_could_ do a backwards incompatible upgrade without first asking
permission first, we must not provide the capability at all, and make
it be the case that the only way to upgrade from ext3 to ext4 is with
a backup, reformat, and restore.  Surely that doesn't make sense!

> This wasn't the kernel driver, this was merely the tools!  Surprise!
> We made no choice to use new features, and they were thrust upon us.
> This will happen to others.

I suspect that Red Hat has learned from that past experience, and
won't be making that mistake again, at least without explicitly
requesting the user's permission.  So how about we trust the
distributions to be a bit more careful this time around?

						- Ted
