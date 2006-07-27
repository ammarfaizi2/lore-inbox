Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWG0Gvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWG0Gvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWG0Gvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:51:31 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:39612 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751812AbWG0Gvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:51:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=e11c0/wKtplmpT+2I+go9x4ny6GGXVVVsZN/IWXCANchBbBc1SlY0A6zO+ENzb1c5L3lM+GVurcYAZxtP7BrtLOE2fnXiLpD8gTtn8WHNw8I94459N+h5ClYa3SZldE5JsFZVyaxyq40/F/aVfh1OhS+wYSkEryOp+GOVUHpLkE=  ;
Message-ID: <44C86271.9030603@yahoo.com.au>
Date: Thu, 27 Jul 2006 16:51:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BUG?] possible recursive locking detected
References: <200607261805.26711.eike-kernel@sf-tec.de> <20060726225311.f51cee6d.akpm@osdl.org>
In-Reply-To: <20060726225311.f51cee6d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 26 Jul 2006 18:05:21 +0200
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> 
> 
>>Hi,
>>
>>I did some memory stress test (allocating and mlock()ing a huge number of 
>>pages) from userspace. At the very beginning of that I got that error long 
>>before the system got unresponsible and the oom killer dropped in.
>>
>>Eike
>>
>>=============================================
>>[ INFO: possible recursive locking detected ]
>>kded/5304 is trying to acquire lock:
>> (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
>>
>>but task is already holding lock:
>> (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
>>
>>other info that might help us debug this:
>>3 locks held by kded/5304:
>> #0:  (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
>> #1:  (shrinker_rwsem){----}, at: [<c1046312>] shrink_slab+0x25/0x136
>> #2:  (&type->s_umount_key#14){----}, at: [<c106be2e>] prune_dcache+0xf6/0x144
>>
>>stack backtrace:
>> [<c1003aa9>] show_trace_log_lvl+0x54/0xfd
>> [<c1004915>] show_trace+0xd/0x10
>> [<c100492f>] dump_stack+0x17/0x1c
>> [<c102e0e1>] __lock_acquire+0x753/0x99c
>> [<c102e5ac>] lock_acquire+0x4a/0x6a
>> [<c11f4609>] __mutex_lock_slowpath+0xb0/0x1f4
>> [<c11f476e>] mutex_lock+0x21/0x24
>> [<f0854fc4>] ntfs_put_inode+0x3b/0x74 [ntfs]
>> [<c106cf3f>] iput+0x33/0x6a
>> [<c106b707>] dentry_iput+0x5b/0x73
>> [<c106bd15>] prune_one_dentry+0x56/0x79
>> [<c106be42>] prune_dcache+0x10a/0x144
>> [<c106be95>] shrink_dcache_memory+0x19/0x31
>> [<c10463bd>] shrink_slab+0xd0/0x136
>> [<c1047494>] try_to_free_pages+0x129/0x1d5
>> [<c1043d91>] __alloc_pages+0x18e/0x284
>> [<c104044b>] read_cache_page+0x59/0x131
>> [<c109e96f>] ext2_get_page+0x1c/0x1ff
>> [<c109ebc4>] ext2_find_entry+0x72/0x139
>> [<c109ec99>] ext2_inode_by_name+0xe/0x2e
>> [<c10a1cad>] ext2_lookup+0x1f/0x65
>> [<c1064661>] do_lookup+0xa0/0x134
>> [<c1064e9a>] __link_path_walk+0x7a5/0xbe4
>> [<c1065329>] link_path_walk+0x50/0xca
>> [<c106586d>] do_path_lookup+0x212/0x25a
>> [<c1065da9>] __user_walk_fd+0x2d/0x41
>> [<c10600bd>] vfs_stat_fd+0x19/0x40
>> [<c10600f5>] vfs_stat+0x11/0x13
>> [<c1060826>] sys_stat64+0x14/0x2a
>> [<c1002845>] sysenter_past_esp+0x56/0x8d
> 
> 
> We hold the ext2 directory mutex, and ntfs_put_inode is trying to take an
> ntfs i_mutex.  Not a deadlock as such, but it could become one in ntfs if
> ntfs ever does a __GFP_WAIT allocation inside i_mutex, which it surely
> does.

Though it should be using GFP_NOFS, right? So the dcache shrinker would
not reenter the fs in that case.

I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
cause any problem?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
