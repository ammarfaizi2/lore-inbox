Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265642AbSJXUHA>; Thu, 24 Oct 2002 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSJXUHA>; Thu, 24 Oct 2002 16:07:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27830 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265642AbSJXUG7>;
	Thu, 24 Oct 2002 16:06:59 -0400
Subject: [RFC] shared credentials with vfs snapshotting
From: "David C. Hansen" <haveblue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave McCracken <dmccr@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 13:12:40 -0700
Message-Id: <1035490360.9081.73.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch combines the ideas from two others:  Dave McCracken's 
combination of task credentials into a single structure which is 
shared between threads:
http://marc.theaimsgroup.com/?t=102830918300009&r=1&w=2
And Trond Myklebust's snapshotting of the vfs-specific parts of
the cred structure which are passed down into vfs and are strictly
copy-on-write. 
http://marc.theaimsgroup.com/?t=103081191900001&r=1&w=2
http://marc.theaimsgroup.com/?t=103074984200004&r=1&w=2
http://www.fys.uio.no/~trondmy/src/2.5.32-alpha

Implementing the appearance of shared credentials to userspace requires
large amounts of code to be added in the threading libraries.  The
addition of code here is reasonalbly small.  

This patch is by no means complete or correct.  It completely ignores
the credential sharing flag for now.  It is just here to demonstrate the
combination of the two ideas.  Please don't go applying it to anything
;)

I think that the core of what is needed is in the attached patch.  Most
of what is left can be accomplished with s/->uid/->cred->uid/ and
s/->fsuid/->cred->vfscred->uid/

And, as Trond says:
> Unfortunately there's still a bit more to do. I need to get
> the file creation ops (i_op->create()/symlink()/mknod()/mkdir()) to
> take a vfs_cred* argument. If not, you risk having the
> inode->i_uid/i_gid set to values that differ from the ones checked by
> the calls to ->permission().


-- 
Dave Hansen
haveblue@us.ibm.com

