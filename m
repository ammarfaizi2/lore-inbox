Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWC3Rgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWC3Rgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC3Rgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:36:41 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:2540 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750923AbWC3Rgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:36:40 -0500
Date: Thu, 30 Mar 2006 10:36:37 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060330173637.GV5030@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
	Laurent Vivier <Laurent.Vivier@bull.net>,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> There are places in ext3 code to use "int" to represent block numbers in
> kernel(not on-disk). This seems the "only" reason that why we can only
> have 8TB ext3 rather than 16TB.  Most times it just a bug with no
> particular reason why not use unsigned 32 bit value, so the fix is easy.
> 
> However, it is not so straightforward fix for the ext3 block allocation
> code, as ext3_new_block() returns a block number, and "-1" to indicating
> block allocation failure. Ext3 block reservation code, called by
> ext3_new_block(), thus also use "int" for block numbers in some places.

What might make the code a lot clearer, easier to audit, and easier to
fix in the future is to declare new types for fs block offsets and group
block offsets.  Something like "ext3_fsblk" and "ext3_grblk".  That way,
we can declare ext3_fsblk as "unsigned long" and "ext3_grblk" as "unsigned
int", and we could optionally change ext3_fsblk to be "unsigned long long"
later to support 64-bit filesystems without having to re-patch all of the
code.

It would be more clear what type of block offset a function is handling
(fs-wide or group-relative).  If we wanted to be able to overload the
block number with an error code we could use ERR_PTR and PTR_ERR like
macros, and just restrict the filesystem to 2^32 - 1024 blocks until we
extend it to 64 bits.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

