Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVFUA6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVFUA6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVFUAzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:55:51 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:51416 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261758AbVFUAv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:51:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Robert Love <rml@novell.com>
Date: Tue, 21 Jun 2005 10:51:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17079.25741.91251.232880@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Christoph Hellwig <hch@lst.de>, arnd@arndb.de, zab@zabbo.net,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patch] inotify.
In-Reply-To: message from Robert Love on Friday June 17
References: <1118855899.3949.21.camel@betsy>
	<42B1BC4B.3010804@zabbo.net>
	<1118946334.3949.63.camel@betsy>
	<200506171907.39940.arnd@arndb.de>
	<20050617175605.GB1981@tentacle.dhs.org>
	<20050617143334.41a31707.akpm@osdl.org>
	<1119044430.7280.22.camel@phantasy>
	<1119052357.7280.24.camel@phantasy>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday June 17, rml@novell.com wrote:
> On Fri, 2005-06-17 at 17:40 -0400, Robert Love wrote:
> 
> > I wrote this up the first time you asked:
> > 
> > 	Documentation/filesystems/inotify.txt
> 
> If there is something I should add, just holler.  I will write an
> encyclopedia if need be.

I haven't yet decided if I like it or not, but maybe I have some
useful comments to make...

> +
> +Q: What is the design decision behind using an-fd-per-device as
> +opposed to an fd-per-watch?
> +
> +A: An fd-per-watch quickly consumes more file descriptors than
> +are allowed, more fd's than are feasible to manage, and more
> +fd's than are ideally select()-able.  Yes, root can bump the
> +per-process fd limit and yes, users can use epoll, but requiring
> +both is silly and an extraneous requirement.  A watch consumes
> +less memory than an open file, separating the number spaces is
> +thus sensible.  The current design is what user-space developers
> +want: Users open the device, once, and add n watches, requiring
> +but one fd and no twiddling with fd limits.
> +Opening /dev/inotify two thousand times is silly.  If we can
> +implement user-space's preferences cleanly--and we can, the idr
> +layer makes stuff like this trivial--then we should.
> +


To address the particular points:
 - "An fd-per-watch quickly consumes more file descriptors than
    are allowed"

  I note that the current limit if 'wd's is 8192 per user, compared
  with the default 'fd' limit of 1024 per process.  So if a user has
  more than 8 processes making very heavy use of inotify, they would
  be better off with the file-descriptor limit...
  So I don't find this argument convincing.

  I would suggest that it be removed, and you put in a separate
  section discussion resource usage and limits.  You could explain why
  you don't use rlimit (probably not a hard case to win) and why the
  sysadmin cannot give different limits to different users (as a
  sys-admin, I would fight that), and why no one user would ever want
  more than about 8 processes using inotify :-)

 -  "more fd's than are feasible to manage,"

   It's not clear what this means.  The program will still need to
   manage lots of 'wd's.  How is this different from handling 'fd's?
   The only 'manage'ment issue I could come up with is the hassle of
   shepherding all these 'wd's through a 'fork', only to close them
   before an 'exec'.  Is that what you mean?  If so it would help to
   make it more explicit.

   Using the fd from /dev/inotify like a 'bag' of 'wd's which can be
   closed as a whole or passed around (through fork or exec or even
   over a unix domain socket) is, I think, I strong point.  You could
   possibly leverage that in selling the current inotify interface.


 - "and more fd's than are ideally select()-able"
  and "users can use epoll, but requiring [it] is silly and an
      extraneous requirement"

  Having to use epoll *should* not be a problem.
  "Surely" thought I "you an just select on the fd returned by
  epoll_create, and then adding inotify to your select() loop should
  be just as easy with epoll as with /dev/inotify".  But then I
  discovered that you cannot select() on the epoll fd :-(
  Maybe this should be fixed rather than be used as an excuse.


 - "A watch consumes less memory than an open filep"

   This is largely valid.  Two other possible responses:
   
   1/ Make the filep smaller.  Not every 'struct file' needs 
   read-ahead data (which is BIG).  Not every file needs the
   fown_struct.  I suspect that a small and generic struct file could
   be created which was embedded inside a larger less generic struct
   file when needed..  If the size if filep is really an issue.

   2/ An fd doesn't *have* to correspond to a 'struct file'.
   Suppose we allowed the 'watch_fd' systemcall to return an fd which
   actually mapped to a struct inotify_watch.  Possibly using a few
   high bits to differentiate different types of 'fds'.
   Most system calls would reject these fds immediately.  Those we
   wanted to handle them could easily be fixed.
   So sys_close would know how to close them.  sys_fcntl would need to be
   able to set close-on-exec.  Maybe a few others like poll.
   But from user-space, it would be 'just another fd'.

   You wouldn't be able to use these 'fds' in select(), but I think we
   can all agree that you probably wouldn't want to.

   It is also worth noting that there is a more telling reason to not
   use "struct file" than the size.  A 'struct file' points to a
   dentry.  A 'struct inotify_watch' points to an inode.  This
   difference is fairly crucial to how inotify works.
  

I hope some of these reflections are useful.

NeilBrown
