Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUKACXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUKACXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 21:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUKACXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 21:23:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261719AbUKACXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 21:23:12 -0500
Date: Mon, 1 Nov 2004 02:23:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org, fare@tunes.org
Cc: Grant Grundler <grundler@parisc-linux.org>
Subject: Bug in cpu_to_le32
Message-ID: <20041101022311.GG8958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grant Grundler spotted we weren't using the optimised byteswap routines
on PA-RISC.  Here's why:

include/linux/byteorder/generic.h:90:#define le32_to_cpu __le32_to_cpu
include/linux/byteorder/big_endian.h:33:#define __le32_to_cpu(x) ___swab32((__force __u32)(__le32)(x))
and byteorder/swab.h:
#define ___swab32(x) \
({ \
        __u32 __x = (x); \
        ((__u32)( \
                (((__u32)(__x) & (__u32)0x000000ffUL) << 24) | \
                (((__u32)(__x) & (__u32)0x0000ff00UL) <<  8) | \
                (((__u32)(__x) & (__u32)0x00ff0000UL) >>  8) | \
                (((__u32)(__x) & (__u32)0xff000000UL) >> 24) )); \
})

So le32_to_cpu() doesn't use optimised assembler on any platform.  And for
all you using ext3 on i386 ...

include/linux/byteorder/generic.h:95:#define cpu_to_be32 __cpu_to_be32
include/linux/byteorder/little_endian.h:38:#define __cpu_to_be32(x) ((__force __be32)___swab32((x)))

So it's not being used there either.  What is ___swabN() for anyway?  It seems
to be a duplicate of ___constant_swabN().

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
