Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWDWQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWDWQuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWDWQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:50:40 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56309 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751423AbWDWQuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:50:39 -0400
Subject: Re: kfree(NULL)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hua Zhong <hzhong@gmail.com>, "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <444A7E85.4030803@yahoo.com.au>
References: <001201c6663e$983f7960$0200a8c0@nuitysystems.com>
	 <444A7E85.4030803@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 12:50:23 -0400
Message-Id: <1145811023.13155.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 05:05 +1000, Nick Piggin wrote:
> Hua Zhong wrote:
> >  > There is a judgement to be made at each call site of kfree 
> > 
> >>(and similar functions) about whether the argument is rarely 
> >>NULL, or could often be NULL.  If the janitors have been 
> >>making this judgement, I apologise, but I haven't seen them 
> >>doing that.
> >>
> >>Paul.
> > 
> > 
> > Even if the caller passes NULL most of the time, the check should be removed.
> > 
> > It's just crazy talk to say "you should not check NULL before calling kfree, as long as you make sure it's not NULL most of the
> > time".
> 
> It can reduce readability of the code [unless it is used in error path
> simplification, kfree(something) usually suggests kfree-an-object].
> 
> If the caller passes NULL most of the time, it could be in need of
> redesign.
> 
> I don't actually like kfree(NULL) any time except error paths. It is
> subjective, not crazy talk.

I wrote a little hack that detects up to 1000 callers of kfree(NULL) and
outputs what it finds with sysrq-l.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114564257500757&w=2

It found right away, two function in transaction.c from the jbd code,
that were freeing an object that sometimes gets allocated.  Andrew
Morton already submitted the patch in the -mm tree to fix it:

-       kfree(new_transaction);
+       if (unlikely(new_transaction))          /* It's usually NULL */
+               kfree(new_transaction);
        return ret;
 }
 
@@ -724,7 +725,8 @@ done:
        journal_cancel_revoke(handle, jh);
 
 out:
-       kfree(frozen_buffer);
+       if (unlikely(frozen_buffer))    /* It's usually NULL */
+               kfree(frozen_buffer);

Where he uses unlikely and nicely documents that it is usually NULL (of
course the "unlikely" sort of says that already ;)

I've been running this patched kernel for a couple of days on a mostly
idle machine, (I don't need it right now, so I just let it run) and it
has shown some more problem areas.  probably occurred when updatedb
kicked off.

Here's the dump:

SysRq : Show stats on kfree
Total number of NULL frees:      1589709
Total number of non NULL frees:  69448
Callers of NULL frees:
[       27]  c0154bcd - do_tune_cpucache+0x13d/0x230
[      631]  c025b9dd - class_device_add+0xcd/0x300
[       30]  c019523c - sysfs_d_iput+0x3c/0x8e
[       44]  c0193750 - sysfs_hash_and_remove+0xd0/0x110
[        1]  c01f4787 - kobject_cleanup+0x37/0x90
[        1]  c025bf73 - class_dev_release+0x23/0x90
[       14]  c021b615 - tty_write+0x105/0x220
[       20]  c025b5ff - class_device_del+0x16f/0x190
[        6]  c021cd34 - release_mem+0x174/0x2a0
[       79]  c011e804 - do_sysctl+0x94/0x250
[   352161]  c01aafc4 - start_this_handle+0x234/0x4b0
[   430089]  c01aba66 - do_get_write_access+0x2e6/0x5a0
[    16730]  c01abdf0 - journal_get_undo_access+0xd0/0x120
[   788641]  c01a3c9f - ext3_clear_inode+0x2f/0x40
[        3]  c0194a0c - sysfs_dir_close+0x6c/0x90
[      252]  c0304e1d - inet_sock_destruct+0xad/0x1f0
[        1]  c030a698 - ip_rt_ioctl+0xe8/0x130
[      968]  c02e2669 - ip_push_pending_frames+0x2d9/0x400
[        6]  c02d69b0 - netlink_release+0x1c0/0x300
[        5]  c02ba79b - sock_fasync+0x13b/0x150

start_this_handle and do_get_write_access have already been fixed, but
now it's looking like journal_get_undo_access and ext3_clear_inode are
problem children too.

-- Steve


