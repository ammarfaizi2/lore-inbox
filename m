Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSGHAi7>; Sun, 7 Jul 2002 20:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSGHAi6>; Sun, 7 Jul 2002 20:38:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11757 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316682AbSGHAi5>;
	Sun, 7 Jul 2002 20:38:57 -0400
Message-ID: <3D28DF9E.20907@us.ibm.com>
Date: Sun, 07 Jul 2002 17:41:02 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Greg KH <gregkh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
References: <Pine.LNX.4.33.0207051043120.8496-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>>I see no reason to hold the BKL in your situation.  I replaced it with 
>>>i_sem in some places and just plain removed it in others.  I believe 
>>>that you get all of the protection that you need from dcache_lock in 
>>>the dentry insert and activate.  Can you prove me wrong?
>>
>>No, and I'm not about to try very hard. It appears that the place you 
>>removed it should be fine. In driverfs_unlink, you replace it with i_sem. 
>>ramfs, which driverfs mimmicks, doesn't hold any lock during unlink. It 
>>seems it could be removed altogether. 
> 
> 
> Actually, taking i_sem is completely wrong. Look at vfs_unlink() in 
> fs/namei.c:
> 
>         down(&dentry->d_inode->i_sem);
>         if (d_mountpoint(dentry))
>                 error = -EBUSY;
>         else {
>                 error = dir->i_op->unlink(dir, dentry);
>                 if (!error)
>                         d_delete(dentry);
>         }
>         up(&dentry->d_inode->i_sem);
> 
> Then, in driverfs_unlink:
> 
> 	struct inode *inode = dentry->d_inode;
> 
> 	down(&inode->i_sem);    
> 
> 
> You didn't test this on file removal did you? A good way to verify that 
> you have most of your bases covered is to plug/unplug a USB device a few 
> times. I learned that one from Greg, and it's caught several bugs.

I need to get some USB devices that work in Linux!

> Anyway, I say that the lock can be removed altogether. Ditto for mknod as 
> well.

I agree.  It looks like vfs_unlink() provides all of the protection 
that is needed.  No BKL, no more i_sem uses.  I'm asking Al Viro about 
driverfs_get_inode().  It looks like it will be safe and correct to 
use i_sem there, but stay tuned, it may not be necessary at all.

-- 
Dave Hansen
haveblue@us.ibm.com

