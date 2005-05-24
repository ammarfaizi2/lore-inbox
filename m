Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVEXIp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVEXIp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVEXImB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:42:01 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:58886 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261460AbVEXI00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:26:26 -0400
To: mike@waychison.com
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <4292D416.5070001@waychison.com> (message from Mike Waychison on
	Tue, 24 May 2005 03:13:26 -0400)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com>
Message-Id: <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 10:25:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> >>Referencing vfsmounts in userspace using a file descriptor:
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109871948812782&w=2
> > 
> > 
> > Why not just use /proc/PID/fd/FD?
> 
> In what sense?  readlink of /proc/PID/fd/* will provide a pathname
> relative to current's root: useless for any paths not in current's
> namespace.

Not readlink, but actual dereference of link will give you exactly the
vfsmount/dentry the file was opened on.  If you want to bind/move
whatever on that mount, that's possible, even if it's a "detached
tree".

> Also, if we were to hijack /proc/PID/fd/* for cross namespace
> manipulation, then we'd be enabling any root user on the system to
> modify anyone's namespace.

No.  Obviously there must be limitations on which process can access
/proc/PID/fd.  It's obviously safe to allow 'self' for example.  But
any process you can ptrace should also be safe.

> This interface also has the huge advantage that you gain all the goodies
> of using file descriptors, such as SCM_RIGHTS.  You can hand of entire
> trees of mountpoints between applications without ever even binding them
> to any namespace whatsoever.

Why is that dependent on the interface?  The /proc interface already
allows _everything_ you want to do with file descriptors.  Only the
the necessary restrictions should be worked out.

> Tie this in with some userspace code that can mount devices for users
> with restrictions and appropriate policy, you can create some API+daemon
> for regular user apps to get things mounted in a way that guarantees
> hiding from other users.

Yes.  And I think that can be done without any new magic ioctls.  Just
with mount/umount and /proc.

The implementation is another question.  I'll look through your
patches to see how you achieve all this.

Thanks,
Miklos
