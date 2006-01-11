Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWAKNCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWAKNCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWAKNCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:02:10 -0500
Received: from a.relay.invitel.net ([62.77.203.3]:29155 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1751484AbWAKNCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:02:08 -0500
Date: Wed, 11 Jan 2006 14:02:55 +0100
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: fork(): parent or child should run first?
Message-ID: <20060111130255.GC30219@lgb.hu>
Reply-To: lgb@lgb.hu
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136983910.2929.39.camel@laptopd505.fenrus.org>
X-Operating-System: vega Linux 2.6.12-10-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ok, you're absolutly right here. My problem is to find some solution and not
to change the behaviour of fork() of course :) It's quite annoying to
introduce some kind of IPC between parent and childs just for transferring a
single pid_t ;-) Using exit status would be great (I would transfer "n")
because it can be got by eg waitpid() in signal handler, however exit status
is limited it status & 0377 which is too short range for us ;-( As a
solution I've created a pid_t array and a counter which is filled by signal
handler with pid_t got by waitpid() and then I use it in the main loop to do
the cleanup in parent. Well, this is quite good, the only problem of mine
that some kind of race condition may occur when altering/using these
structures between the main loop and signal handler ...

Again, thanks for the info.

- Gábor

On Wed, Jan 11, 2006 at 01:51:50PM +0100, Arjan van de Ven wrote:
> On Wed, 2006-01-11 at 13:37 +0100, Gábor Lénárt wrote:
> > Hello,
> > 
> > The following problem may be simple for you, so I hope someone can answer
> > here. We've got a complex software using child processes and a table
> > to keep data of them together, like this:
> > 
> > childs[n].pid=fork();
> > 
> > where "n" is an integer contains a free "slot" in the childs struct array.
> > 
> > I also handle SIGCHLD in the parent and signal handler  searches the childs
> > array for the pid returned by waitpid(). However here is my problem. The
> > child process can be fast, ie exits before scheduler of the kernel give
> > chance the parent process to run, so storing pid into childs[n].pid in the
> > parent context is not done yet. Child may exit, than scheduler gives control
> > to the signal handler before doing the store of the pid (if child run for
> > more time, eg 10 seconds it works of course). So it's impossible to store
> > child pids and search by that information in eg the signal handler? It's
> > quite problematic, since the code uses blocking I/O a lot, so other
> > solutions (like searching in childs[] in the main program and not in signal
> > handler) would require to recode the whole project. The problem can be
> > avoided with having a fork() run the PARENT first, but I thing this is done
> > by the scheduler so it's a kernel issue. Also the problem that source should
> > be portable between Linux and Solaris ...
> 
> you just cannot depend on which would run first, child or parent. Even
> if linux would do it the other way around, you have no guarantee. Think
> SMP or Dual Core processors and time slices and cache misses... your
> code just HAS to be able to cope with it. Even on solaris ;)
> 
> 

-- 
- Gábor
