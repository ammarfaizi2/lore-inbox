Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSI0AY7>; Thu, 26 Sep 2002 20:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSI0AY7>; Thu, 26 Sep 2002 20:24:59 -0400
Received: from relay1.pair.com ([209.68.1.20]:29715 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S261585AbSI0AY6>;
	Thu, 26 Sep 2002 20:24:58 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D93A8C8.EB1BB878@kegel.com>
Date: Thu, 26 Sep 2002 17:39:36 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: OOM killer hints (was: Re: Kernel call chain search tool?)
References: <3D913D58.49D855DB@kegel.com> <1033053348.1269.37.camel@irongate.swansea.linux.org.uk> <3D93331C.86F87359@kegel.com> <20020927000451.98A9E398@merlin.webofficenow.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Thursday 26 September 2002 12:17 pm, Dan Kegel wrote:
> 
> > If only the darn program didn't have so many threads, RLIMIT_AS
> > or the no-overcommit patch would be perfect.  I unfortunately can't
> > get rid of the threads, so I'm stuck trying to figure out some way
> > to kill the right program when the system gets low on memory.
> >
> > Maybe I should look at giving the OOM killer hints?
> 
> The OOM killer should certainly know about threads and thread groups.  If you
> kill one thread, you generally have to kill the whole group because there's
> no way of knowing if that thread was holding a futex or otherwise custodian
> of critical data and thus you just threw the program into la-la land.

The OOM killer gets that part right; it kills all threads that share the
same mm.   Where it screws up is in picking the process to kill.
This is understandable, since it's a tough problem.

Hey, how about this: I could teach the OOM killer to look at
RLIMIT_RSS.  Processes which were at or nearly at their RLIMIT_RSS
would be killed first.  That would be more generally useful than
my hacky little patch, and it would be even tinier.  Like this, say:

--- oom_kill.c.orig	Thu Sep 26 17:31:12 2002
+++ oom_kill.c	Thu Sep 26 17:36:44 2002
@@ -86,6 +86,15 @@
		points *= 2;

	/*
+	 * Processes at or near their RSS or AS limits are probably causing
+	 * trouble, so double their badness points.
+	 */
+	if (((3 * p->mm->rss) / 4) >= (p->rlim[RLIMIT_RSS].rlim_max >>
PAGE_SHIFT))
+		points *= 2;
+	if (((3 * p->mm->total_vm) / 4) >= (p->rlim[RLIMIT_AS].rlim_max >>
PAGE_SHIFT))
+		points *= 2;
+
+	/*
	 * Superuser processes are usually more important, so we make it
	 * less likely that we kill those.
	 */

How's that look?
- Dan
