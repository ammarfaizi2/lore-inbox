Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVEXJaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVEXJaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVEXJ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:29:52 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:19134 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261768AbVEXJPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:15:36 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091529.D0B6FFA21@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:15:29 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id DD358FB7E

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:50 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261364AbVEXGjR (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:39:17 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVEXGjR

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:39:17 -0400

Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:37129 "EHLO

	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP

	id S261353AbVEXGiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:38:16 -0400

Received: from miko by dorka.pomaz.szeredi.hu with local (Exim 3.36 #1 (Debian))

	id 1DaSRW-0003V9-00; Tue, 24 May 2005 07:59:06 +0200

To: raven@themaw.net
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org,
	linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au> (message

	from Ian Kent on Tue, 24 May 2005 09:06:07 +0800 (WST))

Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests

References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>

 <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>

 <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>

Message-Id: <E1DaSRW-0003V9-00@dorka.pomaz.szeredi.hu>

From: Miklos Szeredi <miklos@szeredi.hu>
Date:	Tue, 24 May 2005 07:59:06 +0200

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



> > > Perhaps not in this case.
> > 
> > Maybe I'm misunderstanding.
> > 
> > Are you talking about an automounted filesystem, or the autofs
> > filesystem itself.
> 
> I'm talking about the autofs filesystem (actually the autofs4 module).

OK.

> > 
> > With the later I can well imagine that you have problems with bind and
> > move.
> 
> yep.
> 
> I'm not really concerned about whether bind and move mounts work or not. I 
> just need to establish whether these should be supported and if so, how 
> they should work so I can resolve the problem. Personally, I would be 
> happy to say these types of mounts are not supported by autofs if I could 
> veto the requests.

Does it work if somebody renames a directory in the path leading to
the autofs mountpoint?  The result is very similar to move mount.

You could solve both, by having the automoutnter daemon chdir to the
autofs root, and then it would just not care about any namespace
changes outside it's own filesystem.

Bind and clone(... CLONE_NEWNS) are trickier if you want to make
automounting work in the new instance.  It should be workable, if the
autofs kernel module returns a reference not just to the dentry but
the dentry/vfsmount pair to the daemon.  For example it could open a
file descriptor with dentry_open() refering to the mountpoint, and
pass that to userspace.  The daemon then can do the mount on in
(either by doing fchdir(fd) and 'mount blah .', or 'mount blah
/proc/PID/fd/FD').

This is all very theoretical, I don't know how the internals of
autofs...

On a related note, have you looked at using the kernel atumounter
support for autofs? (Documentation/filesystems/automount-support.txt)

Miklos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

