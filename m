Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUIIXE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUIIXE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUIIXE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:04:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:52161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266733AbUIIXEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:04:53 -0400
Date: Thu, 9 Sep 2004 16:04:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909160449.E1924@build.pdx.osdl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909114846.V1924@build.pdx.osdl.net> <20040909212514.GA10892@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909212514.GA10892@lkcl.net>; from lkcl@lkcl.net on Thu, Sep 09, 2004 at 10:25:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> On Thu, Sep 09, 2004 at 11:48:46AM -0700, Chris Wright wrote:
> 
> > not really much different from comm match, right?  
> 
>  based code on match_comm.
> 
> > other than it's a
> > better match on the process?  
> 
>  yes?
> 
> > i assume you look for a match then stop.
> 
>  added match_inode() after match_comm().  cut/paste job (my favourite
>  way of programming).
> 
> > if the match is good, and the rule is allow...you have no idea who that
> > packet will be delievered to.  
> 
>  allow, allow...
> 
> > it's queued to the socket, and if more
> > than one process is waiting on that socket, you don't know which one
> > will be woken up.
> 
>  well... okay, i must be missing something.
> 
>  what's the disconnect between the task_list and the sockets (sk_buff)
>  that makes that [not knowing which one will be woken up] relevant?

There's nothing stopping the following:  

exec good_proc
	socket()
	fork
	exec bad_proc

Now good_proc and bad_proc are sharing a socket.  Packet comes in
destined for that socket.  Rule says it's ok to deliver to socket
(because of good_proc).  Packet delivered to socket, wakes up waiters
(good and bad).  Now, what's stopping the bad_proc from reading from the
socket?

>  so it's a socket: let's take an example - and i'm assuming for now
>  that things like passing file descriptors over unix-domain-sockets
>  between processes just ... doesn't happen, okay? :)

These do happen, which is part of the problem ;-)

>  apache.
> 
>  an executable named apache creates a TCP socket and binds to port 80,
>  and let's assume it's the prefork model, so it binds to port 80 and
>  then starts sharing that [as you say, with refs] between all the
>  apache processes.
> 
>  in this instance, all the processes are going to be named "apache",
>  yes?
> 
>  they'll all have the same inode number.
> 
>  under these circumstances, i don't honestly think it makes
>  any difference as to whether one process named apache is
>  waiting on the socket and another process also named apache
>  (fired up from the same inode) gets woken up.

Sure.  Now, take xinted...it happens to close all of the fds except for
the one it's sending on down to the child from within the child just
prior to exec, but you get the idea.

>  i mean, _yes_ it would be a problem if there really were two
>  apaches run from different configuration files [that bound to
>  different port numbers - i do this all the time and then run
>  *another* apache web server in a DMZ to do proxy redirects]
> 
>  under these circumstances the best you could hope to do to get
>  some sort of separation would be to copy the apache binary
>  e.g. have an apache2-8000 and an apache2-80, and apply a
>  different set of rules to match each separate binary.

*nod*, or have something that's labelling each context, and match on
that.  even this isn't quite enough, w/out watching how fds get passed
around.

>  _or_, is there something "odd" going on, that i've missed?
> 
> > so with this level of inaccuaracy, it's hard to say
> > you are buying security...
> 
>  well with a default rule of "deny"...
> 
>  what have i missed?  i no unnerstand!
> 
>  in match_inode, it's an "and" rule, i.e. _only_ tasks with
>  the right dev+inode, and then _only_ those tasks with sockets
>  matching the right one get through...

it got through, but does the process you want get the packet?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
