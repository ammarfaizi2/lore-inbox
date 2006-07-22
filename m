Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWGVDif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWGVDif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 23:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGVDif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 23:38:35 -0400
Received: from science.horizon.com ([192.35.100.1]:40510 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751272AbWGVDie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 23:38:34 -0400
Date: 21 Jul 2006 23:38:33 -0400
Message-ID: <20060722033833.10407.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Bad ext3/nfs DoS bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static inline int ext3_valid_inum(struct super_block *sb, unsigned long ino)
>> +{
>> +	return ino == EXT3_ROOT_INO ||
>> +		ino == EXT3_JOURNAL_INO ||
>> +		ino == EXT3_RESIZE_INO ||
>> +		(ino > EXT3_FIRST_INO(sb) &&
>> +		 ino <= le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count));
>> +}
> 
> One would expect the inode validity test to be
> 
> 	(ino >= EXT3_FIRST_INO(sb)) && (ino < ...->s_inodes_count))
> 
> but even this assumes that s_inodes_count is misnamed and really should be
> called s_last_inode_plus_one.  If it is not misnamed then the validity test
> should be
> 
> 	(ino >= EXT3_FIRST_INO(sb)) &&
> 		(ino < EXT3_FIRST_INO(sb) + ...->s_inodes_count))
> 
> Look through the filesystem for other uses of EXT3_FIRST_INO().  It's all
> rather fishily inconsistent.

Er... I'm not an authoritative speaker, but it seems very simple to me.

Inodes are indexed starting from 1; the index 0 is reserved, and the first
inode on disk is number 1.

Thus, potentially valid inode numbers are 1 through s_inodes_count,
inclusive. Thus the <=.  If this were a standard 0-based index, it would
be <, but it's not.

Further, a range of low inode numbers are reserved for special purposes.
Only a few inode numbers in this range are valid.  However, these
numbers are still assigned space in the inode tables.

The only confusing term is EXT3_FIRST_INO, which is actually
more like EXT3_RESERVED_INODES.  The same 1-based indexing explains
the use of > rather than >= there.
