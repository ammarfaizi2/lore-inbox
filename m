Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285072AbRLQJrO>; Mon, 17 Dec 2001 04:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRLQJrE>; Mon, 17 Dec 2001 04:47:04 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:41956 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S285072AbRLQJqz>; Mon, 17 Dec 2001 04:46:55 -0500
Message-Id: <5.1.0.14.2.20011217093040.0319a310@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 17 Dec 2001 09:47:08 +0000
To: Ville Herva <vherva@niksula.hut.fi>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Ia64 unaligned accesses in ntfs driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011217090545.N12063@niksula.cs.hut.fi>
In-Reply-To: <20011216191325.K12063@niksula.cs.hut.fi>
 <20011216124328.E21566@niksula.cs.hut.fi>
 <20011216191325.K12063@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:05 17/12/01, Ville Herva wrote:
>I get unaligned accesses from these addresses:
>
>kernel unaligned access to 0xe00000006fb49719, ip=0xa000000000265050
>
>from ksymoops:
>Adhoc a000000000265050 <[ntfs]ntfs_decompress+d0/320>
>Adhoc a000000000262d80 <[ntfs]ntfs_decompress_run+2a0/3c0>
>Adhoc a000000000262ba0 <[ntfs]ntfs_decompress_run+c0/3c0>
>Adhoc a000000000262d60 <[ntfs]ntfs_decompress_run+280/3c0>
>
>Are these dangerous? I gather IA64 port has some kind of handler for these,
>since they don't oops.

They are at least one of the explanations why the driver would not work on 
non-intel arch... I gather most other arch don't cope with unaligned 
accesses. I am surprised those are the only ones you see actually...

This particular function is not implemented correctly anyway - it will not 
work on BE arch for example (despite all the endian conversion functions, 
some of which are wrong AFAIK).

The changes to make the driver clean are too complex and I am not going to 
bother considering the replacement ntfs driver (ntfs tng available from 
linux-ntfs cvs on sourceforge) is close to being ready for inclusion into 
2.5.x (as soon as read support is completed I will submit it, probably 
sometime in January). If anyone wants to work on the old driver I am happy 
to take patches. (-;

The new driver should be completely endianness clean and any unaligned 
accesses will be dealt with as they are identified. I know of a few 
possible ones which I will need to verify and wrap in the get unaligned 
macros before release. But for tracking down the rest I will need people to 
test the driver as I don't have access to any non-ia32 arch to test on 
myself... I don't think there will be many though as most structures in 
ntfs have nice alignment guarantees. - The mapping pairs array being a 
notable difference which is the source of the unaligned accesses you 
report. The new driver handles them correctly by working on a byte-by-byte 
basis instead of doing multi-byte accesses, which is the correct way to 
decompress the mapping pairs array.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

