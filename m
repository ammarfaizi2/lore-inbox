Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVL3WJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVL3WJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVL3WJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:09:15 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31996 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750885AbVL3WJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:09:14 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051230215544.GI27284@gaz.sfgoth.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20051230215544.GI27284@gaz.sfgoth.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 17:09:02 -0500
Message-Id: <1135980542.6039.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 13:55 -0800, Mitchell Blank Jr wrote:
> Steven Rostedt wrote:
> > I've added a global remove_proc_lock to protect this section of code.  I
> > was going to add a lock to proc_dir_entry so that the locking is only
> > cut down to the same parent, but since this function is called so
> > infrequently, why waste more memory then is needed.  One global lock
> > should not cause too much of a headache here.
> 
> Are you sure that it's the only place where we need guard ->subdir?  It
> looks like proc_lookup() and proc_readdir() use the BLK when walking that
> list, so probably the best fix would be to use that lock everywhere else
> ->subdir is touched

Good point.

God, we should be getting rid of the stupid BKL, not add more.  But
seeing that this is what is used to protect that list, I guess I'll add
it.

I'm also assuming that interrupt context wont use this.

-- Steve

Index: linux-2.6.15-rc7/fs/proc/generic.c
===================================================================
--- linux-2.6.15-rc7.orig/fs/proc/generic.c	2005-12-30 14:19:39.000000000 -0500
+++ linux-2.6.15-rc7/fs/proc/generic.c	2005-12-30 17:05:56.000000000 -0500
@@ -693,6 +693,8 @@
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
+
+	lock_kernel();
 	for (p = &parent->subdir; *p; p=&(*p)->next ) {
 		if (!proc_match(len, fn, *p))
 			continue;
@@ -713,6 +715,7 @@
 		}
 		break;
 	}
+	unlock_kernel();
 out:
 	return;
 }


