Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUIIS4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUIIS4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUIISyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:54:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:43228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266674AbUIISsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:48:52 -0400
Date: Thu, 9 Sep 2004 11:48:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909114846.V1924@build.pdx.osdl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909181034.GF10046@lkcl.net>; from lkcl@lkcl.net on Thu, Sep 09, 2004 at 07:10:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> On Thu, Sep 09, 2004 at 09:19:31AM -0700, Chris Wright wrote:
> > * Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> > > 
> > > i have confidence that this patch will provide support for
> > > BOTH incoming AND outgoing per-program packet filtering.
> > 
> > Programs can share a socket.  Incoming is in interrupt context.  You
> > have no idea who will be woken up.  How do you handle this?
>  
>  chris, hi,
> 
>  thank you for mentioning this - i can quite cheerfully say
>  that i have absolutely no idea what you are referring to, because
>  i lack the knowledge on the design / inner workings to be able
>  to say, but i am going to attempt to work out what you could
>  mean.  please bear with me.

Heh, ok ;-)

>  perhaps you could help guide me through the ipt_owner.c code
>  (or point me in the direction of some appropriate notes,
>   documentation or prior discussions, or alternatively help
>   me out with some keywords to search for).
> 
>  i didn't understand why the proscription that ipt_owner not
>  be used for INCOMING packets (which someone mentioned to me).
> 
>  so if nothing else, like the other ipt_owner things, this patch
>  would only be suitable for OUTGOING rules, yes?

Yes, outgoing you know who sent it, the rule is checked in process
context.

>  well, that's better than a kick in the teeth - esp. for userspace
>  programs.
> 
>  doesn't help me with apollon (gift file sharing daemon which is
>  kicked off in userspace by apollon client program) but hey.
> 
>  anyway.
> 
>  so we have, in the completely uncommented code ipt_owner.c, the
>  match() function.  it passes in a sk_buff which has some packet
>  header structs, a struct sock, which points to a file, which,
>  from the usage inside match() shows me that the sk_buff has a
>  uid and gid associated with its socket.

No, it's indirect through the file (socket(2) returns a descriptor which
is a handle to a struct file *).  The file can be shared.

>  okay, then we come to something like oh i dunno match_pid().
> 
>  this calls find_task_by_pid() on the iptables-owner-recorded
>  PID.
> 
>  then, that task has files (including sockets) associated with it,
>  so you have to search through every socket of that thing.  task.
>  and you're looking for the file struct of the incoming packet.
> 
>  i'm ASSUMING that when you search the task that the task's
>  files - (struct ttask_struct*)p)->files - contains AAALLLL
>  sockets and files of that task, not just some it feels like.

that's correct.

>  am i right about this?
> 
>  okay.  what happens for _shared_ sockets.
> 
>  under these circumstances... if you only had one rule for one
>  PID, and the socket was shared with another PID then... yes, you'd
>  end up in a situation where
> 
>  in fact, for servers which fork, this would be a problem.
> 
>  the task_struct would duplicate the files, you'd end up with a
>  different PID...

yes.

>  ... therefore, _that's_ why ipt_owner is not recommended for use
>  with the --pid-owner argument because it's too fluid.
> 
>  is this what you are referring to when you say:

Yes.  Although consider fork/exec (so proc is different).

> 	> Programs can share a socket.  Incoming is in interrupt context.  You
> 	> have no idea who will be woken up.  How do you handle this?
> 
>  okay, assuming that this _is_ what you are referring to, i'll describe
>  how i BELIEVE my patch to be different, and PLEASE, not least because i
>  need to know the answer before i deploy this patch in a live system
>  (*gibber*) but also for other people considering using this, please
>  correct me on any points i may have got wrong.
> 
>  the difference between --pid-owner (IPT_OWNER_PID) and the new patch is
>  that when a server forks(), i don't imagine that the mountpoint+inode
>  (new IPT_OWNER_DEV+IPT_OWNER_INO) is going to change!

not really much different from comm match, right?  other than it's a
better match on the process?  i assume you look for a match then stop.
if the match is good, and the rule is allow...you have no idea who that
packet will be delievered to.  it's queued to the socket, and if more
than one process is waiting on that socket, you don't know which one
will be woken up.  so with this level of inaccuaracy, it's hard to say
you are buying security...

>  ... or, and this might be the crux of the matter: when
>  sockets are shared (e.g. via servers doing a fork(), is the
>  files_struct REALLY duplicated such that the comparison if
>  (fckeck_files(files, i) == file) check in match_sid(),
>  match_pid(), etc. will FAIL, or are the files_struct entries
>  shared between tasks - in particular are they shared between
>  tasks that have been fork()ed?

they are shared (i.e. another refcount on same structure).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
