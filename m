Return-Path: <linux-kernel-owner+w=401wt.eu-S1753526AbWL1NC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbWL1NC0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbWL1NCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:02:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35412 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbWL1NCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:02:25 -0500
Message-ID: <4593C051.2020400@redhat.com>
Date: Thu, 28 Dec 2006 08:02:09 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] VFS: Busy inodes after unmount. Self-destruct in 5 seconds.
 Have a nice day...
References: <200612281027.09783.jesper.juhl@gmail.com>
In-Reply-To: <200612281027.09783.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> I get this message in my webservers (with NFS mounted homedirs) logs once 
> in a while : 
> 
>   kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> It doesn't seem to have any bad effect on anything, but it would be nice 
> to know if there is any cause for concern.
> 

It is cause for concern. This means that the filesystem was unmounted (and the 
superblock was freed), but the inode structs are still hanging around. The 
"self-destruct" is telling you that eventually, this machine will crash due to 
this. If you see this message you should probably plan a reboot sometime.

What will happen is that eventually the kernel may try to reference these 
inodes, but they now have pointers into a freed superblock. If that superblock 
memory was reused for another purpose, you'll likely crash.

IMO, we should probably consider this to be a BUG(), but that only really is 
helpful if you can capture a coredump and can try to track down why these inodes 
couldn't be flushed correctly. In the very least, it's probably time to change 
this message to be less cryptic.

I've seen some sporadic reports of this problem on earlier kernels in situations 
where a NFS server is unable to be contacted for a while, but have not gotten 
enough info to get a handle on it.

-- Jeff

