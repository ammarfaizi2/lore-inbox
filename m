Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVIPTbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIPTbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVIPTbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:31:39 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:56853 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750792AbVIPTbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:31:38 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       rolandd@cisco.com
Subject: Re: [RFC] utterly bogus userland API in infinibad
X-Message-Flag: Warning: May contain useful information
References: <20050916181132.GF19626@ftp.linux.org.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Sep 2005 12:31:30 -0700
In-Reply-To: <20050916181132.GF19626@ftp.linux.org.uk> (Al Viro's message of
 "Fri, 16 Sep 2005 19:11:32 +0100")
Message-ID: <52fys4lsh9.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 16 Sep 2005 19:31:31.0196 (UTC) FILETIME=[3D8753C0:01C5BAF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Exhibit A:
 > 
 > 	opening uverbs... is done by ib_uverbs_open() (in
 > drivers/infinib*d/core/uverbs_main.c).   Aside of a number of obvious
 > leaks, it does a number of calls of ib_uverbs_event_init().  Each of
 > those does something amazingly bogus:
 > 	* allocates a descriptor
 > 	* allocates struct file
 > 	* associates that struct file with root of their pseudo-fs
 > 	* inserts it into caller's descriptor table
 > ... and leaves an unknown number of those if open() fails, while we
 > are at it.  With zero indications for caller and no way to find out.

Sorry, but the obvious leaks aren't obvious to me.  Could you give
more details?

It is a good point that we might leak file descriptors if open() fails
halfway through.  I guess we should wait to do the fd_install()s until
we're sure that everything has succeeded.

 > 	What's more, you _can_ get those descriptors afterwards, if open()
 > had succeeded.  All you need to do is...

Not sure I follow this.  The intention is that those file descriptors
be available to userspace for poll(), read(), etc.

 > Exibit B:
 > 	... write() to said descriptor.  Buffer should contain a struct
 > that will be interpreted.  Results will be written to user memory, at the
 > addresses contained in that struct.  Said results might include the
 > descriptors shat upon by open().  Nice way to hide an ioctl(), folks...

 > Note that this "interface" assumes that only original opener will write
 > to that file - for anybody else descriptors obviously will not make any
 > sense.

 > BTW, due to the way we do opens, if another thread sharing descriptor
 > table will guess the number of first additional descriptor to be opened
 > and just loops doing close() on it, we'll actually get our ib_uverbs_file
 > kfreed right under us.  

Good point.  What do other interfaces that create file descriptors do?
For example, in fs/eventpoll.c, I don't see anything obvious in
sys_epoll_create() that protects the file descriptor from being closed
between ep_getfd() and ep_file_init().

It seems that waiting to do the fd_install()s until we're just about
to return to userspace anyway would be good enough.

 > May I ask who had come up with that insanity?  Aside of inherent ugliness
 > and abuse of fs syscalls, it simply doesn't work.  E.g. leaks on failed
 > open() are going to be fun to fix...

I'm the insane one.  I'm happy to fix it up, but do you have a
preference for what the interface should look like?  I don't think we
want 30+ new system calls for InfiniBand and I don't think we want a
single horrible multiplexed system call.  I don't think ioctl() is any
better or worse than write(), so I could go either way.  Anyway, what
do you suggest?

Not to be peevish, but I actually described exactlyl this scheme in
email to lkml, cc'ed to Al, in Message-ID: <52k6qn229h.fsf@topspin.com>
back in January.  For some reason, this email doesn't seem to have
been archived on the web (I'm happy to resend if anyone wants), but Al
certainly replied to part of it (saying that yes, get_sb_pseudo()
should be exported).

Thanks,
  Roland
