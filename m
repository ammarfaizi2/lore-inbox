Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWHJV7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWHJV7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWHJV7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:59:34 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:39354 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750910AbWHJV7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:59:32 -0400
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608101833480.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
	 <20060809234019.c8a730e3.akpm@osdl.org> <20060810153150.GB21801@thunk.org>
	 <Pine.LNX.4.64.0608101833480.6762@scrub.home>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 10 Aug 2006 14:59:21 -0700
Message-Id: <1155247161.4505.5.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 18:37 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 10 Aug 2006, Theodore Tso wrote:
> 
> > Ext4 will support a 48-bit blocknumber format for extents, but I do
> > want to make ext4 suitable as a general purpose filesystem, and 32-bit
> > systems will be around for I fear far longer than people might wish.
> > So while I agree that we shouldn't go _too_ far out of our way to make
> > things efficient on 32-bit systems, if it's not that much work to
> > support a 32-bit sector_t, we ought to do it.
> > 
> > So how about a compromise?  We allow for a 32-bit sector_t in ext4,
> > but we drop the SECTOR_FMT, and rely on %llu and typecasts in
> > printk's.  Then the only other extra hair in the filesystem code will
> > be a mount-time check to make sure we don't try to mount a large
> > filesystem on system with a 32-bit sector_t.
> 
> Thanks, that's what I was hoping for. :)
> Disallowing to mount large fs without CONFIG_LBD is not a real problem and 
> then also truncation is not an issue anymore (except maybe for e2fsck).
> 

Just to clarify, the current code (both ext3/4) already check the
filesystem blocks number before mounting it...it fails to mount the
large device if sector_t is 32bit:

in fs/ext4/super.c:

static int ext4_fill_super (struct super_block *sb, void *data, int
silent)
{
	.....
       if (EXT4_BLOCKS_COUNT(es) >
                    (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
                printk(KERN_ERR "EXT4-fs: filesystem on %s:"
                        " too large to mount safely\n", sb->s_id);
                if (sizeof(sector_t) < 8)
                        printk(KERN_WARNING "EXT4-fs: CONFIG_LBD not "
                                        "enabled\n");
                goto failed_mount;
        }
}
> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

