Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVABPwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVABPwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVABPwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:52:09 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:49829 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261265AbVABPvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:51:18 -0500
Date: Sun, 2 Jan 2005 16:51:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [4/4]
Message-ID: <20050102155107.GB5164@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <Pine.LNX.4.61.0412270837001.19240@chimarrao.boston.redhat.com> <1104226960.27708.321.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104226960.27708.321.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 10:42:40AM +0100, Thomas Gleixner wrote:
> On Mon, 2004-12-27 at 08:38 -0500, Rik van Riel wrote:
> > On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
> > 
> > > --- x/mm/oom_kill.c.orig	2004-12-24 17:53:50.807536152 +0100
> > > +++ x/mm/oom_kill.c	2004-12-24 18:01:19.903263224 +0100
> > > @@ -45,18 +45,30 @@
> > > unsigned long badness(struct task_struct *p, unsigned long uptime)
> > > {
> > 
> > > 	/*
> > > +	 * Processes which fork a lot of child processes are likely
> > > +	 * a good choice. We add the vmsize of the childs if they
> > > +	 * have an own mm. This prevents forking servers to flood the
> > > +	 * machine with an endless amount of childs
> > > +	 */
> > 
> > I'm not sure about this one.  You'll end up killing the
> > parent httpd and sshd, instead of letting them hang around
> > so the system can recover by itself after the memory use
> > spike is over.
> 
> The selection is adding the child VM size, but the killer itself kills a
> child process first, so the parent is not the one which is killed in the
> first place.

The other part of Thomas's change is this one:

+static struct mm_struct *oom_kill_process(task_t *p)
+{
+ 	struct mm_struct *mm;
+	struct task_struct *c;
+	struct list_head *tsk;
+
+	/* Try to kill a child first */
+	list_for_each(tsk, &p->children) {
+		c = list_entry(tsk, struct task_struct, sibling);
+		if (c->mm == p->mm)
+			continue;
+		mm = oom_kill_task(c);
+		if (mm)
+			return mm;
+	}
+	return oom_kill_task(p);
+}

Thomas's changes worked better than previous code so far, he can clearly
identify forkbombs or services spread across multiple processes.
Without these changes it was trivial to fool the oom killer and lead to
sshd and other services being killed, so his changes makes lots of sense
to me. It seems certainly better than the current code.

Actually the only question I made to him is why he doesn't kill the
"parent" instead of adding the above code, that is what is being
discussed here, but I was suggesting it as a good thing, not as a bad
thing. If we have a fork bomb killing the master parent would be
optimal. What he does above by killing the childs first is a lot more
conservative and I'm fine with it as well.
