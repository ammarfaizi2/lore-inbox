Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUAJFnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUAJFnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:43:40 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:23556 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264881AbUAJFni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:43:38 -0500
Date: Sat, 10 Jan 2004 13:43:13 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFF09D9.40909@sun.com>
Message-ID: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Mike Waychison wrote:

>
> > Indeed, I
> >haven't solved my requirement of a transparent autofs filesystem aka.
> >Solaris automounter again. A difficult problem that will require
> >considerable effort.
> >
> >
> >
> What do you mean by this?  Something that doesn't show up in
> /proc/mounts?  I don't see this as much of an issue..  On any decently
> large machine, there are so many entries anyway that /etc/mtab and
> /proc/mounts become humanly unparseable anyhow.

Transparency of an autofs filesystem (as I'm calling it) is the situation
where, given a map

/usr	/man1	server:/usr/man1
	/man2	server:/usr/man2

where the filesystem /usr contains, say a directory lib, that needs to be
available while also seeing the automounted directories.

>
> >>>Mmm. The vfsmount_lock is available to modules in 2.6. At least it was in
> >>>test11. I'm sure I compiled the module under 2.6 as well???
> >>>
> >>>I thought that, taking the dcache_lock was the correct thing to do when
> >>>traversing a dentry list?
> >>>
> >>>
> >>>
> >>>
> >>>
> >>Walking dentrys still takes the dcache_lock, however walking vfsmounts
> >>takes the vfsmount_lock.  dcache_lock is no longer used for fast path
> >>walking either (to the best of my understanding).
> >>
> >>find . -name '*.[ch]' -not -path '*SCCS*' | xargs grep vfsmount_lock |
> >>grep EXPORT
> >>
> >>
> >
> >Strange. How does the module compile I wonder? How does it load without
> >unresolved symbols? Another little mystery to work on.
> >
> >
> >
> No, you're module doesn't use vfsmount_lock.  At least the module in
> autofs4-2.4-module-20031201.tar.gz doesn't.

This is the 2.4 code. I do (or though I was able to) use the vfsmount_lock
in the 2.6 patches I have in
kernel.org/pub/linux/kernel/people/raven/autofs4-2.6. This is bad for me.

>
> >>The raciness comes from the fact that we now support the lazy-mounting
> >>of multimount offsets using embedded direct mounts.  Autofs4 mounts all
> >>(or as much as it can) from the multimount all together, and unmounts it
> >>all on expiry.
> >>
> >>
> >
> >But 4.1 does lazy mount for several maps. Mounts that are triggered
> >during the umount step of the expire are put on a wait queue along with
> >the task requesting the umount. I think autofs always worked that way.
> >
> >
> >
> This isn't lazy mounting per se.  If you are talking about autofs4's use
> of AUTOFS_INF_EXPIRING, it's there to prevent somebody from walking into
> a multimount while it is expiring.

Or any umount when sending the expire request to userspace.



