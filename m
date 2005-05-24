Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVEXRSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVEXRSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEXRR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:17:59 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:21802 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261904AbVEXRQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:16:45 -0400
Message-ID: <4293612F.3000708@google.com>
Date: Tue, 24 May 2005 10:15:27 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaVYK-0003ko-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaVYK-0003ko-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> (Sorry for replying in two parts, I missed this in the first reading)
> 
> 
>>>>walking mountpoints in userspace: 
>>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109875012510262&w=2
>>>
>>>
>>>Is this needed?  Userspace can find out mountpoints from /proc/mounts
>>>(or something similar for detached trees).
>>>
>>
>>With detached mountpoints (and especially with detached mountpoint
>>_trees_) it can become very difficult to assess which trees are which.
>>
>>Also, just like /proc/PID/fd/*, /proc/mounts is built according to
>>_current_'s root.  This only gives a skewed view of what is going on.
> 
> 
> I'm thinking of /proc/PID/fdinfo/FD/mounts or similar.
> 
> 
>>>>attaching mountpoints in userspace:
>>>>http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109875063100111&w=2
>>>
>>>
>>>Again, bind from/to /proc/PID/fd/FD should work without any new
>>>interfaces.
>>
>>No..  It wouldn't.  Pathname resolution is doing everything according to
>>the ->readlink information provided by this magic proc files, again in
>>current's namespace.  If you care to hijack ->follow_link, prepare
>>yourself for a slew of corner cases.
> 
> 
> No need to hijack, it's already done.  Removing calls to
> proc_check_root() will allow access to different namespaces detached
> mounts, etc.  It's been tried and actually works.
> 

See previous message as why we don't want to allow this.

> What's more you don't even need /proc, just pass a file descriptor
> (with reference to mount in different namespace, etc.) to another
> process with SCM_RIGHTS, do fchrdir(fd), and then do mount --bind,
> etc.  This actually works with an unmodified kernel.

It shouldn't.  An unmodified kernel has check_mnt to keep you from doing 
this.

> 
> 
>>>>detaching mountpoints in userspace:
>>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109880051800963&w=2
>>>
>>>
>>>What's wrong with sys_umount()?
>>
>>sys_umount only works with paths in current's namespace. It doesn't
>>allow you to handle vfsmounts as primaries in userspace.
> 
> 
> But it does.  Again, either with fchdir() or /proc.
> 
> fchdir() has the drawback of only working on directories, and that a
> process has only one CWD.  The /proc approach has no such limitations.
> 

Again, check_mnt won't let this happen.

Another limitation is that manipulating mounts in another namespace 
breaks namespace->list locking..    Add that to a todo list if you still 
think this is a good idea.

Mike Waychison
