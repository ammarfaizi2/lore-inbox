Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967963AbWLEBUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967963AbWLEBUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 20:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967964AbWLEBUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 20:20:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:56207 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967963AbWLEBUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 20:20:51 -0500
From: Neil Brown <neilb@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Date: Tue, 5 Dec 2006 12:20:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17780.51561.386274.179811@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>,
       Al Viro <viro@ftp.linux.org.uk>, Andi Kleen <ak@suse.de>,
       reiserfs-dev@namesys.com, sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
In-Reply-To: message from Randy Dunlap on Monday December 4
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
	<200611190650.49282.ak@suse.de>
	<45608FC2.5040406@suse.com>
	<200611191959.55969.ak@suse.de>
	<4560AAC1.3000800@oracle.com>
	<20061119205711.GE3078@ftp.linux.org.uk>
	<4560DB6B.9020601@suse.com>
	<20061128114757.8b027341.randy.dunlap@oracle.com>
	<20061204161906.f3531b75.randy.dunlap@oracle.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday December 4, randy.dunlap@oracle.com wrote:
> 
> Ingo, Neil:
> 
> Al has summarized that csum_partial() is arch-specific.
> However, drivers/md/md.c uses it.

Yep.

> 
> Does that mean that RAID volumes are not portable across
> (some) architectures?

Yep.  version-0.90 superblocks are already not portable between archs
of different endianness.  There can also be issues between arch with
different implementations of csum_partial, though the use of csum_fold
in
	if (csum_fold(calc_sb_csum(sb)) != csum_fold(sb->sb_csum)) {
		printk(KERN_WARNING "md: invalid superblock checksum on %s\n",
			b);
(in super_90_load in md.c) tries to alleviate this.

> 
> Should md.c use a specific, known, fixed (as in static,
> arch-independent) version of csum_partial()?

For version-1 superblocks it uses arch-independent byte-order and
arch-independent checksums but....

> 
> Will changing now possibly make some existing volumes
> non-portable?

.. it really is too late for 0.90 superblocks.  Certainly changing it
would back things for people who want to revert to an earlier kernel.

The use of csum_fold has been in place since late 2004 so you would
need to go quite a long way back to hit problems... and if you go that
far back you could hit problems with mdadm too (as mdadm calculated
the checksum the same on all architectures...).

So maybe we could get rid of csum_partial and use a replacement and
still have most things work.... tested patched would be considered :-)

NeilBrown
