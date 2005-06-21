Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVFUEeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVFUEeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFUEb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:31:56 -0400
Received: from CPE000f6690d4e4-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.134]:30150
	"EHLO vertex") by vger.kernel.org with ESMTP id S261859AbVFUCOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:14:42 -0400
Subject: Re: [patch] inotify.
From: John McCutchan <ttb@tentacle.dhs.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <17079.25741.91251.232880@cse.unsw.edu.au>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175605.GB1981@tentacle.dhs.org>
	 <20050617143334.41a31707.akpm@osdl.org> <1119044430.7280.22.camel@phantasy>
	 <1119052357.7280.24.camel@phantasy>
	 <17079.25741.91251.232880@cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 22:15:37 -0400
Message-Id: <1119320137.17767.10.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 10:51 +1000, Neil Brown wrote:
> I haven't yet decided if I like it or not, but maybe I have some
> useful comments to make...
> 
> > +
> > +Q: What is the design decision behind using an-fd-per-device as
> > +opposed to an fd-per-watch?
> > +
> > +A: An fd-per-watch quickly consumes more file descriptors than
> > +are allowed, more fd's than are feasible to manage, and more
> > +fd's than are ideally select()-able.  Yes, root can bump the
> > +per-process fd limit and yes, users can use epoll, but requiring
> > +both is silly and an extraneous requirement.  A watch consumes
> > +less memory than an open file, separating the number spaces is
> > +thus sensible.  The current design is what user-space developers
> > +want: Users open the device, once, and add n watches, requiring
> > +but one fd and no twiddling with fd limits.
> > +Opening /dev/inotify two thousand times is silly.  If we can
> > +implement user-space's preferences cleanly--and we can, the idr
> > +layer makes stuff like this trivial--then we should.
> > +
> 
> 
> To address the particular points:
>  - "An fd-per-watch quickly consumes more file descriptors than
>     are allowed"
> 
>   I note that the current limit if 'wd's is 8192 per user, compared
>   with the default 'fd' limit of 1024 per process.  So if a user has
>   more than 8 processes making very heavy use of inotify, they would
>   be better off with the file-descriptor limit...
>   So I don't find this argument convincing.
> 
>   I would suggest that it be removed, and you put in a separate
>   section discussion resource usage and limits.  You could explain why
>   you don't use rlimit (probably not a hard case to win) and why the
>   sysadmin cannot give different limits to different users (as a
>   sys-admin, I would fight that), and why no one user would ever want
>   more than about 8 processes using inotify :-)
> 

Looking at beagle, it is a single process that can easily watch more
than 1024 directories. Beagle would have to work around the 1024 limit
by managing processes, each of which watch a fraction of the total
watches. PITA. Also, 8192 was an arbitrary choice that seemed big enough
for most users needs and all of these limits can be set in sysfs.
Checkout /sys/misc/inotify.

>  -  "more fd's than are feasible to manage,"
> 
>    It's not clear what this means.  The program will still need to
>    manage lots of 'wd's.  How is this different from handling 'fd's?
>    The only 'manage'ment issue I could come up with is the hassle of
>    shepherding all these 'wd's through a 'fork', only to close them
>    before an 'exec'.  Is that what you mean?  If so it would help to
>    make it more explicit.
> 

The program doesn't really have to manage the wd's. A program simply
needs a map from wd to it's own structure.

Assume for a moment that we had chosen a fd-as-watch approach. Now take
beagle, which has tons of watches. Every time beagle goes through it's
loop, it has to add each of those watch-fd's to the select table, then
check for each one afterwards. It's pretty easy to see how this is
unmanageable and a waste of CPU time. 


>    Using the fd from /dev/inotify like a 'bag' of 'wd's which can be
>    closed as a whole or passed around (through fork or exec or even
>    over a unix domain socket) is, I think, I strong point.  You could
>    possibly leverage that in selling the current inotify interface.
> 

This is a great way of thinking about it.

> 
>  - "A watch consumes less memory than an open filep"
> 
>    This is largely valid.  Two other possible responses:
>    
>    1/ Make the filep smaller.  Not every 'struct file' needs 
>    read-ahead data (which is BIG).  Not every file needs the
>    fown_struct.  I suspect that a small and generic struct file could
>    be created which was embedded inside a larger less generic struct
>    file when needed..  If the size if filep is really an issue.
> 
>

Maybe a good idea, but this is overkill for inotify.

>    2/ An fd doesn't *have* to correspond to a 'struct file'.
>    Suppose we allowed the 'watch_fd' systemcall to return an fd which
>    actually mapped to a struct inotify_watch.  Possibly using a few
>    high bits to differentiate different types of 'fds'.
>    Most system calls would reject these fds immediately.  Those we
>    wanted to handle them could easily be fixed.
>    So sys_close would know how to close them.  sys_fcntl would need to be
>    able to set close-on-exec.  Maybe a few others like poll.
>    But from user-space, it would be 'just another fd'.
>
>

Why bother though? The idr layer lets us have a integer that maps to a 
data structure in kernel space, pretty much for free. 


-- 
John McCutchan <ttb@tentacle.dhs.org>
