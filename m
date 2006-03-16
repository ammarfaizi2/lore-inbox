Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWCPML0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWCPML0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 07:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbWCPML0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 07:11:26 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:56974 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751975AbWCPMLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 07:11:25 -0500
Message-ID: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: <cmm@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Date: Thu, 16 Mar 2006 21:11:17 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> You changed most of the affected variables from "int" to "unsigned int",
> that seems allow block number to address 2^32. It probably a good thing
> to consider change the variables to sector_t type, so when the time we
> want to support for 64 bit block number, we don't have to re-do the
> similar work again.  Laurent did very similar work on this before.

sector_t is 8bytes on normal configuration and there are many
variables for blocks on ext2/3.  I thought extending variables may
influence on performance, so I didn't change.

> Besides these limitations, I think there is one more to limit ext3
> filesystem size to 8TB
> 
> - The superblock format currently stores the number of block groups as a
> 16-bit integer, and because (on a 4 KB blocksize filesystem) the maximum
> number of blocks in a block group is 32,768 , a combination of these
> constraints limits the maximum size of the filesystem to 8 TB

Is it s_block_group_nr in ext3_super_block?
mke2fs sets 65535 to the field if the number of block groups is greater
than 65535.  Current kernel ignores the field and re-calculate from
other fields.  findsuper command is the only user of it and it simply prints
the value.  So, it does not limit the maximum size of the filesystem to 8 TB.
I  confirmed that mke2fs with my change could make the filesysytem
which has more than 65536 groups and it could be mounted.

> I noticed that the first patch set combines changes to ext2 filesystem
> and changes to ext3 filesystem. It would be nice to split the changes to
> two different filesystems.

Ok, I'll split it later.

> But that doesn't fix all th problem. We still have places in ext3 block
> reservation code that use int for system-wide block numbers. For e.g.,
> alloc_new_reservation(), group_first_block, group_end_block, start_block
> are all filesystem wide block numbers, they need to be changed. I will
> check the code more closely tomorrow to see if the changes will break
> any assumptions.

Thank you, I missed it.  I'm looking forward to seeing your report.

> Also, I noticed that in your first patch, you changed a few variables
> for logical block number from "long" to "unsigned int". Just want to
> point out that's a seperate issue- that's for enlarge the file size, not
> for expand the max filesystem size.

Ok, I'll remove them when I update the patch next time.
They are left because I'm considering enlarging the file size max too...

>> -static int ext3_alloc_block (handle_t *handle,
>> - struct inode * inode, unsigned long goal, int *err)
>> +static unsigned int ext3_alloc_block (handle_t *handle,
>> + struct inode * inode, unsigned int goal, int *err)
>>  {
> 
> I did some changes in the same code to support ext3 multiple block
> allocation. Those patches removed this function ext3_alloc_block(). The
> patches are sitting in mm tree now.
> 
> BTW, why we change from unsigned long back to unsigned int here?

Because ext3_alloc_branch calls ext3_alloc_block with int type for the
block number and ext3_alloc_blocks returns int type.

>>  struct ext3_block_alloc_info *block_i =  EXT3_I(inode)->i_block_alloc_info;
>> @@ -505,21 +505,21 @@ static unsigned long ext3_find_goal(stru
>>  static int ext3_alloc_branch(handle_t *handle, struct inode *inode,
>>       int num,
>>       unsigned long goal,
>> -      int *offsets,
>> +      unsigned int *offsets,
>>       Indirect *branch)
> 
> offsets[] array here store the index position within a indirect block,
> where the physical block is stored. The indirect block takes a 4k block,
> holds up to 1K entry of physical block numbers, so int type for the
> index is good enough.

Ok, I'll update them too.
