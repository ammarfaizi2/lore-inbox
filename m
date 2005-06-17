Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVFQB6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVFQB6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVFQB6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:58:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261894AbVFQB6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:58:24 -0400
Date: Thu, 16 Jun 2005 18:57:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
Message-Id: <20050616185754.3646511e.akpm@osdl.org>
In-Reply-To: <42B22CD3.9080600@nortel.com>
References: <42B1DBF1.4020904@nortel.com>
	<20050616135708.4876c379.akpm@osdl.org>
	<42B20317.6000204@nortel.com>
	<20050616162933.25dee57b.akpm@osdl.org>
	<42B22CD3.9080600@nortel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> wrote:
>
> Andrew Morton wrote:
> > Chris Friesen <cfriesen@nortel.com> wrote:
> 
> >>Currently tmpfs reuses the simple_dir_operations from libfs.c.
> >>
> >>Would it make sense to add the empty fsync() function there, and have 
> >>all other users pick it up as well?  Is this likely to break stuff?
> >  
> > Isn't simple_sync_file() suitable?
> 
> I think it would be fine.  The issue is that currently for directories 
> tmpfs doesn't have it's own set of operations--it reuses the 
> simple_dir_operations set of file ops from libfs.
> 
> We could make a tmpfs-specific set of operations that is identical to 
> simple_dir_operations but with the addition of setting the fsync 
> function to simple_sync_file().
> 
> Alternately, if it makes sense for all the users of 
> simple_dir_operations we could modify it directly and all of the other 
> users of simple_dir_operations would get the change for free.  I don't 
> know enough about the other filesystems to know if this makes sense or not.
> 

hm, what a lot of filesystems.

bix:/usr/src/linux-2.6.12-rc6> grep -rl simple_dir_operations .            
./drivers/usb/gadget/inode.c
./drivers/usb/core/inode.c
./drivers/isdn/capi/capifs.c
./drivers/oprofile/oprofilefs.c
./drivers/misc/ibmasm/ibmasmfs.c
./fs/libfs.c
./fs/debugfs/inode.c
./fs/autofs/inode.c
./fs/devpts/inode.c
./fs/hugetlbfs/inode.c
./fs/ramfs/inode.c
./include/linux/fs.h
./net/sunrpc/rpc_pipe.c
./kernel/cpuset.c
./security/selinux/selinuxfs.c
./ipc/mqueue.c
./mm/shmem.c

I can't think of any reason why any of these would want fsync(dir_fd) to
return -EINVAL.

