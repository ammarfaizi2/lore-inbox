Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbULBTB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbULBTB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULBTB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:01:26 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:22001 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261717AbULBTBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:01:18 -0500
Subject: Re: [PATCH 4/6] Add dynamic context transition support to SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
In-Reply-To: <20041202103456.O14339@build.pdx.osdl.net>
References: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil>
	 <20041202103456.O14339@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102013788.26015.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 13:56:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 13:34, Chris Wright wrote:
> > +		/* Only allow single threaded processes to change context */
> > +		if (atomic_read(&p->mm->mm_users) != 1) {
> > +			struct task_struct *g, *t;
> > +			struct mm_struct *mm = p->mm;
> > +			read_lock(&tasklist_lock);
> > +			do_each_thread(g, t)
> > +				if (t->mm == mm && t != p) {
> > +					read_unlock(&tasklist_lock);
> > +					return -EPERM;
> > +				}
> > +			while_each_thread(g, t);
> > +			read_unlock(&tasklist_lock);
> 
> That's heavy handed.  Can't you track this at clone time?  Or at least
> do this after the AVC check, so it's not always locking task list.

Hmmm...if the latter is a concern, it seems like there are other cases
that likewise need fixing, e.g. sys_getpriority or sys_setpriority. 
Earlier version of the patch did a simple check of thread_group_empty()
but that didn't catch CLONE_VM w/o CLONE_THREAD, and simple check of
mm_users can produce false positives, e.g. another process reading your
/proc/pid/<xxx> file and holding a reference to the mm temporarily.

We could set a flag in the task security structure upon
selinux_task_create upon CLONE_VM, I suppose, and inherit it in
selinux_task_alloc_security.  That would prohibit any use after you've
ever created a thread, even if none of the other threads are still
around, which is stronger than we need, but probably not an obstacle. 
Is that what you had in mind?
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

