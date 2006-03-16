Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWCPBN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWCPBN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWCPBN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:13:26 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:8051 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751858AbWCPBN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:13:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IwG7/7/Qz++8E+pgORMG7rIDVkWYMgCEPy65RpXkWxYkUCS3uVNmOwQXQnx9De7mDDJsbpS6b9NgGMKxocgCT6DS3e2GpBFAyc6lSwAocQyG2RfdOr666ilgcC8cK+mFsV6HHPVvGtuZAGKpGwVaBGGGKfkR6fK4W7wzqVNCxSk=
Message-ID: <4418BBF3.407@gmail.com>
Date: Thu, 16 Mar 2006 09:14:27 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6-m1 PATCH] Connector: Filesystem Events Connector
References: <4418375C.5090703@gmail.com> <20060315152855.65f89bf1.akpm@osdl.org>
In-Reply-To: <20060315152855.65f89bf1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Yi Yang <yang.y.yi@gmail.com> wrote:
>   
>> This patch implements a new connector, Filesystem Event Connector,
>>  the user can monitor filesystem activities via it, currently, it
>>  can monitor access, attribute change, open, create, modify, delete,
>>  move and close of any file or directory.
>>
>> Every filesystem event will include tgid, uid and gid of the process
>>  which triggered this event, process name, file or directory name 
>> operated by it.
>>     
>
> Why does Linux need this feature?
>
> It seems quite duplicative of the fsnotify stuff.
>   
inotify just focuses on changes in filesystem, it can't tell us who is 
doing, moreover, it addes several
 system calls, I think its API is hard to use, but filesystem connector 
focuses on who is doing and what
is done, it uses netlink API, so for user application, it is easy to 
use, to be most important, many event
 mechanisms in kernel are implemented by netlink, for example, 
KOBJECT_UEVENT, PROC_EVENTS
, if all the event mechanisms use netlink, it is very easy to unify user 
space APIs.

But current situation is that  inotify used a new mechanism, although 
that can be done by netlink.

>   
>>  	/* both times implies a utime(s) call */
>>  	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
>>  	{
>>  		in_mask |= IN_ATTRIB;
>>  		dn_mask |= DN_ATTRIB;
>> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
>>  	} else if (ia_valid & ATTR_ATIME) {
>>  		in_mask |= IN_ACCESS;
>>  		dn_mask |= DN_ACCESS;
>> +		fsevent_mask |= FSEVENT_ACCESS;
>>  	} else if (ia_valid & ATTR_MTIME) {
>>  		in_mask |= IN_MODIFY;
>>  		dn_mask |= DN_MODIFY;
>> +		fsevent_mask |= FSEVENT_MODIFY;
>>  	}
>>  	if (ia_valid & ATTR_MODE) {
>>  		in_mask |= IN_ATTRIB;
>>  		dn_mask |= DN_ATTRIB;
>> +		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
>>  	}
>>  
>>  	if (dn_mask)
>> @@ -238,6 +279,11 @@ static inline void fsnotify_change(struc
>>  		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
>>  						  dentry->d_name.name);
>>  	}
>> +	if (fsevent_mask) {
>> +		if (S_ISDIR(inode->i_mode))
>> +			fsevent_mask |= FSEVENT_ISDIR;
>> +		raise_fsevent(dentry, fsevent_mask);
>> +	}
>>  }
>>     
>
> hmm, I wonder if the compiler is smart enough to recognise that
> fsevent_mask isn't used and to eliminate all this new code when
> CONFIG_FS_EVENTS=n
>   
Sorry, this is my mistake, I'll upload a new version.
>   
>> +extern void raise_fsevent_move(struct inode * olddir, const char * oldname, struct inode * newdir, const char * newname, u32 mask);
>>     
>
> Try to keep code looking nice in an 80-col display please.
>   
OK.
>
>   
>> +int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
>> +{
>> +	struct cn_msg *msg;
>> +	struct fsevent *event;
>> +	__u8 * buffer;
>> +	int namelen = 0;
>> +	static unsigned long last;
>> +	static int fsevent_sum = 0;
>> +
>> +	if (atomic_read(&cn_fs_event_listeners) < 1)
>> +		return 0;
>> +
>> +	spin_lock(&fsevent_ratelimit_lock);
>>
>>     
>
> yipes.  We just went through considerable pain fixing performance problems
> with inotify, and this patch brings them back, only much much worse.
>   
fsevent will have lower overhead than inotify, because it don't need any 
comparison to decide whether this inode is watched,
 and it don't need generate a event for this inode's parent. I will 
consider to how to remove lock.
> See ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/broken-out/inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
>
>   

