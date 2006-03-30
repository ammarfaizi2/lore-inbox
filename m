Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWC3TBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWC3TBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWC3TBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:01:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:45777 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750739AbWC3TBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:01:16 -0500
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060330173637.GV5030@schatzie.adilger.int>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060330173637.GV5030@schatzie.adilger.int>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 30 Mar 2006 11:01:11 -0800
Message-Id: <1143745271.3896.15.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 10:36 -0700, Andreas Dilger wrote:
> On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> > There are places in ext3 code to use "int" to represent block numbers in
> > kernel(not on-disk). This seems the "only" reason that why we can only
> > have 8TB ext3 rather than 16TB.  Most times it just a bug with no
> > particular reason why not use unsigned 32 bit value, so the fix is easy.
> > 
> > However, it is not so straightforward fix for the ext3 block allocation
> > code, as ext3_new_block() returns a block number, and "-1" to indicating
> > block allocation failure. Ext3 block reservation code, called by
> > ext3_new_block(), thus also use "int" for block numbers in some places.
> 
Hi Andreas,

> What might make the code a lot clearer, easier to audit, and easier to
> fix in the future is to declare new types for fs block offsets and group
> block offsets.  Something like "ext3_fsblk" and "ext3_grblk".  That way,
> we can declare ext3_fsblk as "unsigned long" and "ext3_grblk" as "unsigned
> int", 

Yep, that makes sense. If we do this, the patch needs more audit, as the
existing code uses "unsigned long" for block numbers in many many
places.

Also I think it might make sense to define "ext3_fileblk" for logical
block type, as right now many functions called "block" in many places
for file logical block, and it takes some to determine whether it's a
file logical block or physical block.

> and we could optionally change ext3_fsblk to be "unsigned long long"
> later to support 64-bit filesystems without having to re-patch all of the
> code.
> 
I do have an untested patch which tries to change all fs-wide block
numbers from "unsigned long" to "sector_t" type as Laurent suggested. He
did this in his 64 bit ext3 block number support patch. I wasn't sure if
we should do this for current 32 bit ext3 or wait until other 64 bit
patches.

Yeah, with the suggestion you made above, this change should be easy to
support 64bit filesystem without go through all the code again.

> It would be more clear what type of block offset a function is handling
> (fs-wide or group-relative). 

Okey, I will add more comments in the function.

>  If we wanted to be able to overload the
> block number with an error code we could use ERR_PTR and PTR_ERR like
> macros, and just restrict the filesystem to 2^32 - 1024 blocks until we
> extend it to 64 bits.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

