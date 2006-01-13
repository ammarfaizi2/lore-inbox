Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422957AbWAMUv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWAMUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbWAMUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:51:57 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:2176 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1422955AbWAMUvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:51:54 -0500
Date: Fri, 13 Jan 2006 13:51:52 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, torvalds@osdl.org,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Message-ID: <20060113205152.GD7641@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Takashi Sato <sho@tnes.nec.co.jp>, torvalds@osdl.org,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, trond.myklebust@fys.uio.no
References: <20060112183319.526b877a.akpm@osdl.org> <000101c61848$4dd3b5b0$4168010a@bsd.tnes.nec.co.jp> <20060113122820.18b751b0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113122820.18b751b0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 13, 2006  12:28 -0800, Andrew Morton wrote:
> So now we're proposing to repeat the sector_t problem with a bunch of new
> fields.  Fortunately we're less likely to be putting these particular
> fields into printk statements but I note that CIFS (at least) has a couple
> such statements and with your patch they're now generating warnings (and
> potential runtime bugs).
> 
> On the other hand, for a fairly fat .config which has 17 filesystems in
> .vmlinux:
> 
>    text    data     bss     dec     hex filename
> 4633032 1011304  248288 5892624  59ea10 vmlinux		CONFIG_LSF=y
> 4633680 1011304  248288 5893272  59ec98 vmlinux		CONFIG_LSF=n
> 
> It's probably less 0.5 kbytes for usual embedded .config.
> I just don't think the benefit of CONFIG_LSF outweighs its costs.

We were originally going to use CONFIG_LBD, but there were some complaints
that "sector_t" isn't the right variable to use for this, even though they
are remarkably close.  That would at least remove one config change.

I don't think the cost is in the vmlinux itself, but rather that having a
long long for i_blocks is overkill for any but the very largest systems
(Lustre has been running fine w/o this, at the expense of some accuracy
for the i_blocks count on many-TB files).  Growing struct inode for these
0.0000001% of systems is probably harmful for small systems, given how
many inodes are used in a system.

Two options exist IMHO:
- remove the new CONFIG_* parameters and stick with CONFIG_LBD (this could
  still use a separate type from sector_t if desired) to reduce the amount
  of testing combinations needed
- make the new CONFIG_* default to on and allow it to be disabled with
  CONFIG_BASE_SMALL

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

