Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937137AbWLDQwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937137AbWLDQwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937139AbWLDQwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:52:07 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:53205 "EHLO
	slurp.thebarn.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937137AbWLDQwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:52:03 -0500
Message-ID: <45745207.4030107@thebarn.com>
Date: Mon, 04 Dec 2006 10:51:19 -0600
From: Russell Cattelan <cattelan@thebarn.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wcheng@redhat.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com>	<20061127165239.9616cbc9.akpm@osdl.org>	<456CACF3.7030200@redhat.com>	<20061128162144.8051998a.akpm@osdl.org>	<456D2259.1050306@redhat.com>	<456F014C.5040200@redhat.com> <20061201132329.4050d6cd.akpm@osdl.org> <45730E36.10309@redhat.com>
In-Reply-To: <45730E36.10309@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wendy Cheng wrote:

> Andrew Morton wrote:
>
>> On Thu, 30 Nov 2006 11:05:32 -0500
>> Wendy Cheng <wcheng@redhat.com> wrote:
>>
>>  
>>
>>>
>>> The idea is, instead of unconditionally dropping every buffer 
>>> associated with the particular mount point (that defeats the purpose 
>>> of page caching), base kernel exports the "drop_pagecache_sb()" call 
>>> that allows page cache to be trimmed. More importantly, it is 
>>> changed to offer the choice of not randomly purging any buffer but 
>>> the ones that seem to be unused (i_state is NULL and i_count is 
>>> zero). This will encourage filesystem(s) to pro actively response to 
>>> vm memory shortage if they choose so.
>>>   
>>
>>
>> argh.
>>  
>>
> I read this as "It is ok to give system admin(s) commands (that this 
> "drop_pagecache_sb() call" is all about) to drop page cache. It is, 
> however, not ok to give filesystem developer(s) this very same 
> function to trim their own page cache if the filesystems choose to do 
> so" ?
>
>> In Linux a filesystem is a dumb layer which sits between the VFS and the
>> I/O layer and provides dumb services such as reading/writing inodes,
>> reading/writing directory entries, mapping pagecache offsets to disk
>> blocks, etc.  (This model is to varying degrees incorrect for every
>> post-ext2 filesystem, but that's the way it is).
>>  
>>
> Linux kernel, particularly the VFS layer, is starting to show signs of 
> inadequacy as the software components built upon it keep growing. I 
> have doubts that it can keep up and handle this complexity with a 
> development policy like you just described (filesystem is a dumb layer 
> ?). Aren't these DIO_xxx_LOCKING flags inside __blockdev_direct_IO() a 
> perfect example why trying to do too many things inside vfs layer for 
> so many filesystems is a bad idea ? By the way, since we're on this 
> subject, could we discuss a little bit about vfs rename call (or I can 
> start another new discussion thread) ?
>
> Note that linux do_rename() starts with the usual lookup logic, 
> followed by "lock_rename", then a final round of dentry lookup, and 
> finally comes to filesystem's i_op->rename call. Since lock_rename() 
> only calls for vfs layer locks that are local to this particular 
> machine, for a cluster filesystem, there exists a huge window between 
> the final lookup and filesystem's i_op->rename calls such that the 
> file could get deleted from another node before fs can do anything 
> about it. Is it possible that we could get a new function pointer 
> (lock_rename) in inode_operations structure so a cluster filesystem 
> can do proper locking ?

It looks like the ocfs2 guys have the similar problem?

http://ftp.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20060924/0009-PATCH-Allow-file-systems-to-manually-d_move-inside-of-rename.txt

Does this change help fix gfs lock ordering problem as well?


-Russell Cattelan
cattelan@xfs.org
