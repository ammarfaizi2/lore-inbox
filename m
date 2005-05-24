Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVEXRM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVEXRM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEXRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:12:50 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:18149 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261889AbVEXRK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:10:57 -0400
Message-ID: <42935FCB.1010809@google.com>
Date: Tue, 24 May 2005 10:09:31 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>>>Referencing vfsmounts in userspace using a file descriptor:
>>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2
>>>
>>>
>>>Why not just use /proc/PID/fd/FD?
>>
>>In what sense?  readlink of /proc/PID/fd/* will provide a pathname
>>relative to current's root: useless for any paths not in current's
>>namespace.
> 
> 
> Not readlink, but actual dereference of link will give you exactly the
> vfsmount/dentry the file was opened on.  If you want to bind/move
> whatever on that mount, that's possible, even if it's a "detached
> tree".

Removing proc_check_root essentially removes any protection that 
namespaces provided in the first place.

Think of it like virtual memory.  You can fork off and create your own 
COW instance, and no one can see what you are doing unless they ptrace 
you or explicitly ask you.  The mountfd model allows for explicit 
handing off of vfsmounts between namespaces without allowing arbitrary 
access.

> 
> 
>>Also, if we were to hijack /proc/PID/fd/* for cross namespace
>>manipulation, then we'd be enabling any root user on the system to
>>modify anyone's namespace.
> 
> 
> No.  Obviously there must be limitations on which process can access
> /proc/PID/fd.  It's obviously safe to allow 'self' for example.  But
> any process you can ptrace should also be safe.
> 

Yet even this doesn't allow userspace to define it's own policy for 
inter-namespace manipulation.

> 
>>This interface also has the huge advantage that you gain all the goodies
>>of using file descriptors, such as SCM_RIGHTS.  You can hand of entire
>>trees of mountpoints between applications without ever even binding them
>>to any namespace whatsoever.
> 
> 
> Why is that dependent on the interface?  The /proc interface already
> allows _everything_ you want to do with file descriptors.  Only the
> the necessary restrictions should be worked out.
> 

Worked out where?  Allowing this stuff to happen in /proc forces you to 
set this policy in the kernel.

> 
>>Tie this in with some userspace code that can mount devices for users
>>with restrictions and appropriate policy, you can create some API+daemon
>>for regular user apps to get things mounted in a way that guarantees
>>hiding from other users.
> 
> 
> Yes.  And I think that can be done without any new magic ioctls.  Just
> with mount/umount and /proc.
> 
> The implementation is another question.  I'll look through your
> patches to see how you achieve all this.
> 

Beware that due to the detached-subtrees bit, the locking became a bit 
ugly, requiring a global rw_lock for mntget/mntput.  I still haven't 
figured out a better way to keep per-vfsmounts counts and per-subtree 
counts in sync.

That said, the common case is a read lock, for shared access. Only on 
mnt_attach / mnt_detach (usually a slowpath anyway) do we require 
exclusive access.  This would have been a good candidate for brlocks if 
they were still around.

Mike Waychison
