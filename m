Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTD1BhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTD1BhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:37:13 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:4816 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263348AbTD1BhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:37:11 -0400
Date: Sun, 27 Apr 2003 18:49:26 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
cc: Mark Grosberg <mark@nolab.conman.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <yw1xptn7z9m6.fsf@zaphod.guide>
Message-ID: <Pine.LNX.4.53.0304271843010.8792@twinlark.arctic.org>
References: <Pine.BSO.4.44.0304272114560.23296-100000@kwalitee.nolab.conman.org>
 <yw1xptn7z9m6.fsf@zaphod.guide>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2003, Måns Rullgård wrote:

> Mark Grosberg <mark@nolab.conman.org> writes:
>
> > > If you do this, _please_ make it compat with NT.
> >
> > Actually, I thought about this. My first thought is this could benefit
> > WINE running on Linux. Then (not like I'm a Wine expert by any means) I
> > figured it might be an issue as far as having to do some preliminary
> > wineserver setup work (if anybody on this list knows better than me, speak
> > up!)
> >
> > But yeah, basically, something similar to NT's CreateProcess(). For the
> > cases where the one-step process creation is sufficient.
>
> Is that the call that takes dozens of parameters?  Copying :-) that
> is, IMHO, straight against the UNIX philosophy.

unfortunately you want those dozen parameters, they all have a purpose...
which is what makes such a call suspect in the first place.

vfork() solves the mm copying problem, which eliminates half the reason
for a combined fork-exec syscall.

the only time fork-exec is inefficient, given the existence of vfork, is
when you need to fork a process which has a lot of fd.  and by "a lot" i
mean thousands.

in that case even F_CLOEXEC isn't a good answer -- because it's a pain in
the ass to set because it requires an extra system call for the most
important case -- sockets.  otherwise you have to iterate over the entire
fd array to close things... which isn't so hot for multiprocessor setups.

but even this has a potential work-around using procfs -- use clone() to
get the vfork semantics without also copying the fd array.  then open
/proc/$ppid/fd/N for any file descriptors you want opened in the forked
process.

given both vfork and procfs i'm not sure there's any other performance
benefit a combined fork+exec syscall offers...  and if procfs isn't fast
enough for this then that's a better place to focus effort :)

-dean
