Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUFZHcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUFZHcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 03:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUFZHci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 03:32:38 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:44697 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266014AbUFZHcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 03:32:33 -0400
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Reply-To: goldwyn_r@myrealbox.com
From: "Goldwyn Rodrigues" <goldwyn_r@myrealbox.com>
To: adilger@clusterfs.com
CC: linux-kernel@vger.kernel.org
Date: Sat, 26 Jun 2004 11:39:53 +0530
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1088230193.9825981cgoldwyn_r@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have a real demand for doing this?  Given that block devices are
> limited to 16TB on 32-bit architectures (page size * long), and ext3
> files themselves are limited to 4TB+ (i386 page size again) because of
> the triple-indirect block limit this isn't much of a win until we go to
> something like extents.  Are you using a non-i386 architecture?


As for the demad, I am not sure. But I have heard of enterprise level guys crying for bigger files, and thus trying to move their entire enterprise linux solution to different filesystems such as GFS. I don't know the architecture they are using.

I am using i386 architecture. As mentioned in my previous mail, I went ahead and made a few more changes to add an extra triple indirect field by replacing l_i_reserved2 to push the limits to 8TB but filesystem utilities like fsck din't like the change and changed the file size of the sparse file back to 4TB. If we really want to push it to extents it would require a radical change, which I am not sure if the community would accept. However, I am ready with it and could post the same.


> If we started using larger blocksizes for systems that have larger than
> 4kB pages (i.e. not i386) this would become an issue.  At some point
> having giant files w/o extents is pointless (performance is too bad),
> so we could also put the high blocks count in as part of the extent data
> (e.g. i_blocks[14]) since the format would be gratuitously incompatible
> anyways.

I din't quite understand this point. Do you mean to say that we keep such data elsewhere if required, and then read such data only for large systems. As in, do another block read?


> 
>>@@ -1003,9 +1003,9 @@
>> 	res += 1LL << (bits-2);
>> 	res += 1LL << (2*(bits-2));
>> 	res += 1LL << (3*(bits-2));
>>-	res <<= bits;
>>-	if (res > (512LL << 32) - (1 << bits))
>>-		res = (512LL << 32) - (1 << bits);
>>+	/* Since another block is added, we add the same number again */
>>+	res += 1LL << (3*(bits-2));
>>+	res <<=bits;
> 
> 
> This is incorrect.  All that this change does is remove the extra
> "res > (512LL << 32) - (1 << bits)" limit.  Even that could be removed
> for sparse files without any of these changes if we wanted to check
> at block allocation time whether we would overflow the i_blocks limit.
> 


Oops. Sorry, I mixed it with my 8TB code. The actual patch should look like:

diff -Nru /usr/src/linux-2.6.5-orig/fs/ext3/super.c /usr/src/linux-2.6.5-4TB/fs/ext3/super.c
--- /usr/src/linux-2.6.5-orig/fs/ext3/super.c   2004-04-04 09:08:14.000000000 +0530
+++ /usr/src/linux-2.6.5-4TB/fs/ext3/super.c    2004-06-26 10:39:05.000000000 +0530
@@ -1003,9 +1003,7 @@
        res += 1LL << (bits-2);
        res += 1LL << (2*(bits-2));
        res += 1LL << (3*(bits-2));
-       res <<= bits;
-       if (res > (512LL << 32) - (1 << bits))
-               res = (512LL << 32) - (1 << bits);
        return res;
 }




>>{
>>        struct buffer_head * bh;
>>-       int prev_blocks;
>>+       sector_t prev_blocks;
> 
> 
> This is a good fix regardless (at least change it to long from int).

long carries only 32 bits on i386 arch so I had to change it sector_t.

> 
> That isn't really a test of anything, since a sparse file will not use 
> more than 2^32 blocks.

I agree with you, but i386 is all I have for now. :)


>>#define i_blocks_high		osd1.linux1.l_i_reserved1
> 
> 
> If we really wanted to avoid being incompatible with Hurd (I personally
> don't care about that, but someone who knows more should comment on how
> badly this will screw things for it) we could use one of the other
> fields in
> the inode like m_i_frag + m_i_fsize, or i_faddr as none of them is
> actually
> used.  We also only really need 24 bits of this word before we hit the
> 64-bit byte i_size limit so we may as well be prudent and mask off the
> high
> byte for later use.

Its a good idea, if we can pick one 16bit field and another 8bit field. If fragments are not really used we could use l_i_frag and i_pad1 from the union. Please don't use variables wrt to masix in this context, it confused me.

But I need to know for sure that these variables are not used at all.


> In any case, we need to wrap this with some sort of COMPAT flag in the
> superblock, and probably a per-inode flag as well, so we know to trust
> this value.

Thanks, will work on it.

> 
>>@@ -393,7 +393,11 @@
>> 	unsigned int		i_blkbits;
>> 	unsigned long		i_blksize;
>> 	unsigned long		i_version;
>>+#if !defined(CONFIG_EXT3_LARGE_FILE_SUPPORT) || defined(CONFIG_64BIT)
>> 	unsigned long		i_blocks;
>>+#else
>>+	unsigned long long	i_blocks;
>>+#endif /* CONFIG_EXT3_LARGE_FILE_SUPPORT */
> 
> 
> Why not just declare this as sector_t?
> 

Okay. Will do that. Thanks again.
I will work on the suggested changes till then.

-- 
Goldwyn :o)



