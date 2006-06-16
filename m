Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWFPWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWFPWZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFPWZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:25:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:56983 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbWFPWZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:25:29 -0400
From: Neil Brown <neilb@suse.de>
To: Jan Blunck <jblunck@suse.de>
Date: Sat, 17 Jun 2006 08:25:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17555.12234.347353.670918@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, dgc@sgi.com, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
In-Reply-To: message from Jan Blunck on Friday June 16
References: <20060601095125.773684000@hasse.suse.de>
	<17539.35118.103025.716435@cse.unsw.edu.au>
	<20060616155120.GA6824@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday June 16, jblunck@suse.de wrote:
> On Mon, Jun 05, Neil Brown wrote:
> 
> > I understand that this is where problem is because the selected
> > dentries don't stay at the end of the list very long in some
> > circumstances. In particular, other filesystems' dentries get mixed
> > in. 
> 
> No. The problem is that the LRU list is too long and therefore unmounting
> seems to take ages.
> 

But I cannot see that the whole LRU list needs to be scanned during
unmount.
The only thing that does that is shrink_dcache_sb, which is used:
  in do_remount_sb
  in __invalidate_device
  in a few filesystems (autofs, coda, smbfs)
 and not when unmounting the filesystem (despite the comment).

(This is in 2.6.17-ec6-mm2).

I can see that shrink_dcache_sb could take a long time and should be
fixed, which should be as simple as replacing it with
shrink_dcache_parent; shrink_dcache_anon.

But I'm still puzzled as to why a long dcache LRU slows down
unmounting. 

Can you give more details?

Thanks,
NeilBrown

