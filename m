Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161476AbWHJRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbWHJRTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161478AbWHJRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:19:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:27544 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161476AbWHJRTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:19:48 -0400
Message-ID: <44DB6AB1.3010602@us.ibm.com>
Date: Thu, 10 Aug 2006 10:19:45 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/9] support >32 bit ext4 filesystem block type in kernel
References: <1155172860.3161.82.camel@localhost.localdomain> <20060809234033.4681017b.akpm@osdl.org>
In-Reply-To: <20060809234033.4681017b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 09 Aug 2006 18:21:00 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> 
>>Redefine ext4 in-kernel filesystem block type (ext4_fsblk_t) from unsigned
>>long to sector_t, to allow kernel to handle  >32 bit ext4 blocks.
>>
> 
> 
> I don't get it.

The intention is able to support 48bit ext4 on 64bit and 32bit arch 
whenevern CONFIG_LBD is enabled (or when sector_t is actually 64 bit). 
It just seems waste of memory to support 48bit in-kernel ext4 blks on 32 
bit if CONFIG_LBD is disabled, since we won't support large device anyway.

ext3_fsblk_t was a unsigned long type before, which is always 32bit on 
32bit arch. Thus we convert the ext3_fsblk_t to sector_t and depend on 
CONFIG_LBD to decide whether we need 48bit in-kernel variables.(on-disk 
block numbers are always 48 bit).

> 
> Randomly-chosen snippet:
> 
> 
>>@@ -274,7 +274,8 @@ static int find_group_orlov(struct super
>> 	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
>> 	avefreei = freei / ngroups;
>> 	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
>>-	avefreeb = freeb / ngroups;
>>+	avefreeb = freeb;
>>+	sector_div(avefreeb, ngroups);
>> 	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
>> 
>> 	if ((parent == sb->s_root->d_inode) ||
> 
> 
> Here, `avefreeb' is still a 32-bit type.  Why feed it into sector_div()?
> 
avefreeb is ext3_fsblk_t type(sector_t type), which is 64bit on 64bit 
arch and 64bit on 32bit arch if CONFIG_LBD is enabled.

> 
>>@@ -303,13 +304,15 @@ static int find_group_orlov(struct super
>> 		goto fallback;
>> 	}
>> 
>>-	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) - freeb) / ndirs;
>>+	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
>>+	sector_div(blocks_per_dir, ndirs);
> 
> 
> And here le32_to_cpu() is very much a 32-bit type.  Why sector_div()?

ah, sorry about the confusing, s_blocks_count (the number of blocks on 
this fs, on-disk) should be always 48bit value, and should not use 
le32_to_cpu() to read-in. That is being fixed in [patch 9/9] 64bit 
metadata support,  where we convert 32 bit s_blocks_count to sector_t, 
and also use mixro EXT4_BLOCKS_COUN(es) to read in the blocks count:

@@ -304,7 +306,7 @@ static int find_group_orlov(struct super
  		goto fallback;
  	}

-	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
+	blocks_per_dir = EXT4_BLOCKS_COUNT(es) - freeb;

This patch[3/9] is just fix the in-kernel blocks type...We trying to do 
this incrementally: first, support in-kernel blocks type >32bit, then 
change the on-disk blocks type to >32bit.

> 
> And I agree with me: we want to get all the sector_t's out of this
> filesystem.  unsigned long long, do_div()?
> 

Thanks,Mingming

