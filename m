Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUIIVQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUIIVQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIIVP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:15:57 -0400
Received: from open.hands.com ([195.224.53.39]:52700 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267633AbUIIVOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:14:01 -0400
Date: Thu, 9 Sep 2004 22:25:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909212514.GA10892@lkcl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909114846.V1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909114846.V1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 11:48:46AM -0700, Chris Wright wrote:

> >  to say, but i am going to attempt to work out what you could
> >  mean.  please bear with me.
> 
> Heh, ok ;-)
 
 :) *mmm*

> >  so we have, in the completely uncommented code ipt_owner.c, the
> >  match() function.  it passes in a sk_buff which has some packet
> >  header structs, a struct sock, which points to a file, which,
> >  from the usage inside match() shows me that the sk_buff has a
> >  uid and gid associated with its socket.
> 
> No, it's indirect through the file (socket(2) returns a descriptor which
> is a handle to a struct file *).  The file can be shared.
 
 struct file* - that'd explain why you have to go through
 some hoops, using fcheck_files().

> >  the difference between --pid-owner (IPT_OWNER_PID) and the new patch is
> >  that when a server forks(), i don't imagine that the mountpoint+inode
> >  (new IPT_OWNER_DEV+IPT_OWNER_INO) is going to change!
> 
> not really much different from comm match, right?  

 based code on match_comm.

> other than it's a
> better match on the process?  

 yes?

> i assume you look for a match then stop.

 added match_inode() after match_comm().  cut/paste job (my favourite
 way of programming).

> if the match is good, and the rule is allow...you have no idea who that
> packet will be delievered to.  

 allow, allow...

> it's queued to the socket, and if more
> than one process is waiting on that socket, you don't know which one
> will be woken up.

 well... okay, i must be missing something.

 what's the disconnect between the task_list and the sockets (sk_buff)
 that makes that [not knowing which one will be woken up] relevant?

 so it's a socket: let's take an example - and i'm assuming for now
 that things like passing file descriptors over unix-domain-sockets
 between processes just ... doesn't happen, okay? :)

 apache.

 an executable named apache creates a TCP socket and binds to port 80,
 and let's assume it's the prefork model, so it binds to port 80 and
 then starts sharing that [as you say, with refs] between all the
 apache processes.

 in this instance, all the processes are going to be named "apache",
 yes?

 they'll all have the same inode number.

 under these circumstances, i don't honestly think it makes
 any difference as to whether one process named apache is
 waiting on the socket and another process also named apache
 (fired up from the same inode) gets woken up.

 i mean, _yes_ it would be a problem if there really were two
 apaches run from different configuration files [that bound to
 different port numbers - i do this all the time and then run
 *another* apache web server in a DMZ to do proxy redirects]

 under these circumstances the best you could hope to do to get
 some sort of separation would be to copy the apache binary
 e.g. have an apache2-8000 and an apache2-80, and apply a
 different set of rules to match each separate binary.

 
 _or_, is there something "odd" going on, that i've missed?

> so with this level of inaccuaracy, it's hard to say
> you are buying security...

 well with a default rule of "deny"...

 what have i missed?  i no unnerstand!

 in match_inode, it's an "and" rule, i.e. _only_ tasks with
 the right dev+inode, and then _only_ those tasks with sockets
 matching the right one get through...

 and you'd only use this in combination with other "match" rules which
 get "and"ed in - e.g. match dev+inode _and_ match port 80 _and_ match
 TCP before jumping to "ACCEPT"...

 so if anything, you could end up being _too_ specific and end up
 falling through to the default "DENY" rule.

 which is the whole idea.
 
 or in the case of fireflier, falling through to the default "QUEUE"
 rule to trigger user intervention.


> >  ... or, and this might be the crux of the matter: when
> >  sockets are shared (e.g. via servers doing a fork(), is the
> >  files_struct REALLY duplicated such that the comparison if
> >  (fckeck_files(files, i) == file) check in match_sid(),
> >  match_pid(), etc. will FAIL, or are the files_struct entries
> >  shared between tasks - in particular are they shared between
> >  tasks that have been fork()ed?
> 
> they are shared (i.e. another refcount on same structure).
 
 *whew* that makes it a lot easier.

 l.

