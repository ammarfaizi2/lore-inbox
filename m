Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDBVla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUDBVla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:41:30 -0500
Received: from ida.rowland.org ([192.131.102.52]:7684 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261187AbUDBVlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:41:17 -0500
Date: Fri, 2 Apr 2004 16:41:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
In-Reply-To: <20040402043814.GA6993@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC: list pruned on the assumption that most recipients aren't interested]

On Fri, 2 Apr 2004, Maneesh Soni wrote:

> Yes, see the patch below. Probably the race window has become smaller but
> Badness message is also an indication that somewhere kobject_cleanup has 
> started. I have not yet seen why race is still there.

Yes.  Although the problem can't be due to a race if it involves code 
that's protected by a semaphore.

Did this Badness message come from within check_perm()?  I don't see how
that could happen with this patch.  You're guaranteed that the refcount is
positive until after sysfs_remove_dir() returns.  It's _supposed_ to be
positive, anyway; maybe it isn't.  You could try checking for that, at the
end of sysf_remove_dir().

> There is one more bigger problem in this approach. It may miss kobject_put() in 
> sysfs_release() call and result will be memory leak, ->release() is not called,
> rmmod hang, etc etc. So using ->d_fsdata for this purpose is not the proper
> solution, IMO.

You're quite correct.  d_fsdata must remain set so that previous
references can be dropped.  Some other part of the dentry or the inode has
to be used instead.  I don't know what would be appropriate, perhaps one 
of the flags bits.

Alan Stern

