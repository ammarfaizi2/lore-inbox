Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbTFSPDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbTFSPDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:03:39 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:29334 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265737AbTFSPDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:03:37 -0400
Message-ID: <3EF1D326.4040109@sun.com>
Date: Thu, 19 Jun 2003 11:13:42 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v2
References: <11504.1056033106@warthog.warthog>
In-Reply-To: <11504.1056033106@warthog.warthog>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>>>Then have a daemon that can take a request to mount and then reply with
>>>the mount parameters, allowing the trap fs to obtain a vfsmount via
>>>do_kern_mount(). I would make the trap fs supply the daemon with an fd
>>>attached to the trap rootdir to act as a token representing the request
>>>(and controlling its lifetime).
>>>
>>>      
>>>
>>You would have to go this route.  I think Al's opinion in this is that 
>>your original proposal allows arbitrary dentry's in the tree to act as 
>>traps.  As such, there is no way for a derived namespace to manipulate 
>>that trap at all.
>>    
>>
>
>  
>
>>By implying that the trap is installed via mount says you are now proposing
>>that every trap is represented by its own superblock.
>>    
>>
>
>This is more or less what Al suggested, except that he suggested "traps" are
>special vfsmounts that don't have superblocks, dentries, and inodes.
>

Introducing special trap vfsmounts w/o super_blocks means we can no 
longer have arbitrary actions on those traps.  AFS wants to define what 
happens in kernelspace, autofs wants to define it in userspace.  Last I 
checked, vfsmount doesn't have an ops structure.

> 
>  
>
>>You're new proposal is exactly what I have been working on, autofs 
>>direct mountpoints using the less intrusive follow_link magic Anvin has 
>>mentioned on a previous thread both here and on autofs@vger.
>>
>>The one problem with this solution is the following breaks:
>>
>># installtrap /foo host:/export/foo
>><userspace daemon listens for requests to mount>
>># newnssh
>>newnssh # cd /foo
>>
>>Oops, the daemon started from the initial namespace doesn't have access 
>>to the namespace in my second shell.
>>    
>>
>
>Yes. You can see that happening now with autofs and amd. However it does work
>with my suggestion because the "automounter" code just returns a namespace
>independent vfsmount, which the VFS can then bind into the appropriate
>namespace and the appropriate place.
>

This only works for mounts performed in kernel space.  It doesn't lend 
itself to performing mounts in userspace and would force autofs to 
re-implement mount(1) parsing/struct packing in kernelspace.  Definitely 
not a good solution.

>
>  
>
>>The most reasonable way I can see to cope with this is to allow 
>>CAP_SYS_ADMIN processes the ability to change namespaces.  Eg, the 
>>daemon can be told which pid triggered the trap on /foo, 
>>open(/proc/<pid>/mounts) and perform a ioctl(IOC_USENAMESPACE) on it.
>>
>>What do you guys think?
>>    
>>
>
>I think a better way is for the kernel to pass the daemon a file descriptor
>attached to the mount point. This would then act as a token representing the
>request, and as such it automatically includes the mount point info (struct
>file has vfsmount/dentry pointers) and can also be used to manage the lifetime
>of the request.
>
>I'd then make there be either a "mount" ioctl/fcntl on that fd that uses the
>info stored on the struct file, or perhaps provide an "fmount" syscall (but
>you have to be careful - otherwise someone can use an arbitrary
>cross-namespace fd to mangle some other namespace).
>  
>
A mount ioctl on the fd is probably a good idea:
    - it would require modifying mount(1) so that you can have it use 
the fd ioctl in lieu of sys_(old)mount.
    - he have to ask ourselves, does this logic really belong in vfs? or 
is it better placed in a filesystem-independent implementation.

I'm still partial to the idea that a usenamespace ioctl on 
/proc/<pid>/mounts is a cleaner solution in the long run, both for 
automounting as well as for administration tools.

Mike Waychison

