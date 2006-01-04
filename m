Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWADLZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWADLZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWADLZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:25:03 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:8312 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751711AbWADLZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:25:01 -0500
Message-ID: <43BBB12D.80008@sw.ru>
Date: Wed, 04 Jan 2006 14:27:41 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rostedt@goodmis.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
References: <1135973075.6039.63.camel@localhost.localdomain>	<1135978110.6039.81.camel@localhost.localdomain>	<20051230154647.5a38227e.akpm@osdl.org>	<43B64712.3000105@sw.ru> <20060104013658.620e51e6.akpm@osdl.org>
In-Reply-To: <20060104013658.620e51e6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Hi Andrew,
>>
>>I have a full patch for this.
> 
> 
> Please don't top-post.  It makes things hard...
do you prefer separate mails with patch and with reference to original 
report? will do so.

>>I don't remember the details yet, but lock was not god here, we used 
>>semaphore. I pointed to this problem long ago when fixed error path in 
>>proc with moduleget.
>>
>>This patch protects proc_dir_entry tree with a proc_tree_sem semaphore. 
>>I suppose lock_kernel() can be removed later after checking that no proc 
>>handlers require it.
>>Also this patch remakes de refcounters a bit making it more clear and 
>>more similar to dentry scheme - this is required to make sure that 
>>everything works correctly.
>>
>>Patch is against 2.6.15-rcX and was tested for about a week. Also works 
>>half a year on 2.6.8 :)
>>
>>[ patch which uses an rwsem for procfs and somewhat removes lock_kernel() ]
>>
> 
> 
> I worry about replacing a spinlock with a sleeping lock.  In some
> circumstances it can cause a complete scalability collapse and I suspect
> this could happen with /proc.  Although I guess the only fastpath here is
> proc_readdir(), and as the lock is taken there for reading, we'll be OK..
> 
> The patch does leave some lock_kernel() calls behind.  If we're going to do
> this, I think they should all be removed?
> 
> Races in /proc have been plentiful and hard to find.  The patch worries me,
> frankly.  I'd like to see quite a bit more description of the locking
> schema and some demonstration that it's actually complete before taking the
> plunge.

ok, here goes some more descriptions:

1.
proc_readdir is a sleeping ops:
sys_getdents
`- vfs_readdir
      `- proc_readdir
           `- filldir
                `- put_user/copy_to_user
that's why we must use semaphore. of course spinlock can be used too,
but this will case another problem: it must be dropped to call filldir, but
beofre it will be retaken the dentry being filldir-ed may be removed and
we won't see it's siblings in output.

2.
lock_kernel() is needed to handle at least simultaneous sys_read vs
create_proc_entry with sequental de->proc_fops = XXX. this can be
handled by passing fops directly to create_proc_entry.
i.e. there is a 3rd problem I pointed to you before:
create_proc_entry() and setting of de->owner/de->proc_fops is inatomic.
lock_kernel() is not a best way to protect against this, sure...
I would prefer to fix it with a separate patch somehow...

3.
refcounting:
each proc_dir_entry's refcounter is the reference from inode plus
references from children. once this count reaches zero - dentry is freed.
so on each proc_register() parent is get-ed, on each remove_proc_entry
parent is put-ed.

Kirill

