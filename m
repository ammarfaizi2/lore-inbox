Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIISEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIISEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUIISBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:01:55 -0400
Received: from open.hands.com ([195.224.53.39]:9178 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266391AbUIIR73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:59:29 -0400
Date: Thu, 9 Sep 2004 19:10:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909181034.GF10046@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909091931.K1973@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 09:19:31AM -0700, Chris Wright wrote:
> * Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> > wow, gosh, it works.
> > 
> > okay, this is a patch to add support in iptables for per-program
> > firewall filtering.
> > 
> > also included is the patches to iptables-1.2.11.
> > 
> > i have confidence that this patch will provide support for
> > BOTH incoming AND outgoing per-program packet filtering.
> 
> Programs can share a socket.  Incoming is in interrupt context.  You
> have no idea who will be woken up.  How do you handle this?
 
 chris, hi,

 thank you for mentioning this - i can quite cheerfully say
 that i have absolutely no idea what you are referring to, because
 i lack the knowledge on the design / inner workings to be able
 to say, but i am going to attempt to work out what you could
 mean.  please bear with me.

 perhaps you could help guide me through the ipt_owner.c code
 (or point me in the direction of some appropriate notes,
  documentation or prior discussions, or alternatively help
  me out with some keywords to search for).

 i didn't understand why the proscription that ipt_owner not
 be used for INCOMING packets (which someone mentioned to me).

 so if nothing else, like the other ipt_owner things, this patch
 would only be suitable for OUTGOING rules, yes?

 well, that's better than a kick in the teeth - esp. for userspace
 programs.

 doesn't help me with apollon (gift file sharing daemon which is
 kicked off in userspace by apollon client program) but hey.

 anyway.

 so we have, in the completely uncommented code ipt_owner.c, the
 match() function.  it passes in a sk_buff which has some packet
 header structs, a struct sock, which points to a file, which,
 from the usage inside match() shows me that the sk_buff has a
 uid and gid associated with its socket.

 okay, then we come to something like oh i dunno match_pid().

 this calls find_task_by_pid() on the iptables-owner-recorded
 PID.

 then, that task has files (including sockets) associated with it,
 so you have to search through every socket of that thing.  task.
 and you're looking for the file struct of the incoming packet.

 i'm ASSUMING that when you search the task that the task's
 files - (struct ttask_struct*)p)->files - contains AAALLLL
 sockets and files of that task, not just some it feels like.

 am i right about this?


 okay.  what happens for _shared_ sockets.

 under these circumstances... if you only had one rule for one
 PID, and the socket was shared with another PID then... yes, you'd
 end up in a situation where

 in fact, for servers which fork, this would be a problem.

 the task_struct would duplicate the files, you'd end up with a
 different PID...


 ... therefore, _that's_ why ipt_owner is not recommended for use
 with the --pid-owner argument because it's too fluid.

 is this what you are referring to when you say:

	> Programs can share a socket.  Incoming is in interrupt context.  You
	> have no idea who will be woken up.  How do you handle this?

 okay, assuming that this _is_ what you are referring to, i'll describe
 how i BELIEVE my patch to be different, and PLEASE, not least because i
 need to know the answer before i deploy this patch in a live system
 (*gibber*) but also for other people considering using this, please
 correct me on any points i may have got wrong.


 the difference between --pid-owner (IPT_OWNER_PID) and the new patch is
 that when a server forks(), i don't imagine that the mountpoint+inode
 (new IPT_OWNER_DEV+IPT_OWNER_INO) is going to change!

 ... or, and this might be the crux of the matter: when
 sockets are shared (e.g. via servers doing a fork(), is the
 files_struct REALLY duplicated such that the comparison if
 (fckeck_files(files, i) == file) check in match_sid(),
 match_pid(), etc. will FAIL, or are the files_struct entries
 shared between tasks - in particular are they shared between
 tasks that have been fork()ed?

 if they are NOT shared between tasks, then how is it possible
 to ensure that two processes do not attempt to bind to the same
 port number, for example?

 l.
 
