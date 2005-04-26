Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVDZJR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVDZJR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDZJRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:17:49 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:19871 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261417AbVDZJR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:17:29 -0400
To: jamie@shareable.org
CC: linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050425191015.GC28294@mail.shareable.org> (message from Jamie
	Lokier on Mon, 25 Apr 2005 20:10:15 +0100)
Subject: Re: [PATCH] private mounts
References: <3WWwR-3hT-35@gated-at.bofh.it> <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org>
Message-Id: <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 11:16:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess for this thread to make any progress, we need a set of coherent
> > requirements from FUSE team.
> 
> Yes.  A list of use-cases from the FUSE team which would be nice 
> to use would be a good start.

What kind of usecases would you like to see?  FUSE filesystems are
used just like any other filesystem, so listing "copy file from x to
z" and suchlike seems pointless ;)

> Then people who aren't so close to FUSE can suggest alternative ways
> of doing those, until we whittle down to the essential features that
> aren't already available in the kernel, if any.

The most important difference between orinary filesystems and FUSE is
the fact, that the filesystem data/metadata is provided by a userspace
process run with the privileges of the mount "owner" instead of the
kernel, or some remote entity usually running with elevated
privileges.

The security implication of this is that a non-privileged user must
not be able to use this capability to compromise the system.  Obvious
requirements arising from this are:

 - mount owner should not be able to get elevated privileges with the
   help of the mounted filesystem

 - mount owner should not be able to induce undesired behavior in
   other users' or the super user's processes

 - mount owner should not get illegitimate access to information from
   other users' and the super user's processes

These are currently ensured with the following constraints:

 1) mount is only allowed to directory or file which the mount owner
   can modify without limitation (write access + no sticky bit for
   directories)

 2) nosuid,nodev mount options are forced

 3) any process running with fsuid different from the owner is denied
    all access to the filesystem

1) and 2) are ensured by the "fusermount" mount utility which is a
   setuid root application doing the actual mount operation.

3) is ensured by a check in the permission() method in kernel

I started thinking about doing 3) in a different way because Christoph
H. made a big deal out of it, saying that FUSE is unacceptable into
mainline in this form.

The suggested use of private namespaces would be OK, but in their
current form have many limitations that make their use impractical (as
discussed in this thread).

Suggested improvements that would address these limitations:

  - implement shared subtrees

  - allow a process to join an existing namespace (make namespaces
    first-class objects)

  - implement the namespace creation/joining in a PAM module

With all that in place the check of owner against current->fsuid may
be removed from the FUSE kernel module, without compromising the
security requirements. 

Suid programs still interesting questions, since they get access even
to the private namespace causing some information leak (exact
order/timing of filesystem operations performed), giving some
ptrace-like capabilities to unprivileged users.  BTW this problem is
not strictly limited to the namespace approach, since suid programs
setting fsuid and accessing users' files will succeed with the current
approach too.

Is this information enough for further progress to be made?

Thanks for the help,
Miklos

