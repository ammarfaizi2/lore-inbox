Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSGDWXF>; Thu, 4 Jul 2002 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGDWXE>; Thu, 4 Jul 2002 18:23:04 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41223 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315260AbSGDWXD>;
	Thu, 4 Jul 2002 18:23:03 -0400
Date: Thu, 4 Jul 2002 15:23:57 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
Message-ID: <20020704222357.GD418@kroah.com>
References: <3D23EA93.7090106@us.ibm.com> <20020704071004.GI29657@kroah.com> <3D23F88C.2050502@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D23F88C.2050502@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 06 Jun 2002 20:26:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 12:26:04AM -0700, Dave Hansen wrote:
> Greg KH wrote:
> >On Wed, Jul 03, 2002 at 11:26:27PM -0700, Dave Hansen wrote:
> >>I saw your talk about driverfs at OLS and it got my attention.  When 
> >>my BKL debugging patch showed some use of the BKL in driverfs, I was 
> >>very dissapointed (you can blame Greg if you want).
> >
> >Blame me?  Al Viro pushed that BKL into the file, not I :)
> 
> But you're so much closer :)  Did he push the mknod stuff too?

Yes he did.  Bitkeeper is your friend for finding out these kinds of
things :)

> 
> >>text from dmesg after BKL debugging patch:
> >>release of recursive BKL hold, depth: 1
> >>[ 0]main:492
> >>[ 1]inode:149
> >
> >This means what?
> 
> BKL was acquired at main.c:492 and current->lock_depth was 0
> then
> BKL was acquired at inode.c:149 and current->lock_depth was 1

So go pick on init/main.c, not us poor little ram based filesystems...

> >>I see no reason to hold the BKL in your situation.  I replaced it with 
> >>i_sem in some places and just plain removed it in others.  I believe 
> >>that you get all of the protection that you need from dcache_lock in 
> >>the dentry insert and activate.  Can you prove me wrong?
> >
> >I see no reason to really care :)
> >Can you prove that driverfs (or pcihpfs or usbfs) accesses are on a
> >critical path that removing the BKL usage here actually helps?
> 
> Nope.  I'm pretty sure that it isn't in a critical path anywhere, nor 
> are there any performance benefits.  It is simply an annoying use that 
> is relatively easy to remove.  It's kinda like using spaces instead of 
> tabs; most people won't notice, but some people really care :)

Heh, since you've seen my talk twice, there is a real reason for the
tabs instead of spaces.  It's not just me being annoying.  Well ok, I'm
probably being annoying, but you should know better by now :)

> >I think that driverfs_mknod() needs some kind of protection now that you
> >have removed it.
> 
> Do you just want to make sure it isn't called concurrently, or is 
> there some other BKL-protected area that you're concerned about. 
> driverfs_mknod() doesn't appear to be doing anything sneaky like 
> sleeping or calling itself, so I think a simple spinlock will work 
> just fine.

bleah, a proliferation of a zillion little spinlocks all across the
kernel is not my idea of fun :(

I don't know if a simple spinlock can help us here.  Look at
driverfs_get_inode() and follow that into the vfs layer.  Make sure all
of that is race safe (and isn't currently relying on the BKL.)  I'll
defer to Al Viro's opinion about this, as I don't quite know all of the
side effects going on at this moment in time.

thanks,

greg k-h
