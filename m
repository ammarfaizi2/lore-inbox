Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbULBTTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbULBTTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbULBTTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:19:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:26061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261731AbULBTTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:19:03 -0500
Date: Thu, 2 Dec 2004 11:18:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
Subject: Re: [PATCH 4/6] Add dynamic context transition support to SELinux
Message-ID: <20041202111859.A2357@build.pdx.osdl.net>
References: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil> <20041202103456.O14339@build.pdx.osdl.net> <1102013788.26015.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1102013788.26015.192.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Dec 02, 2004 at 01:56:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2004-12-02 at 13:34, Chris Wright wrote:
> > That's heavy handed.  Can't you track this at clone time?  Or at least
> > do this after the AVC check, so it's not always locking task list.
> 
> Hmmm...if the latter is a concern, it seems like there are other cases
> that likewise need fixing, e.g. sys_getpriority or sys_setpriority. 

At least not introducing new paths.

> Earlier version of the patch did a simple check of thread_group_empty()
> but that didn't catch CLONE_VM w/o CLONE_THREAD, and simple check of
> mm_users can produce false positives, e.g. another process reading your
> /proc/pid/<xxx> file and holding a reference to the mm temporarily.

Yes, number of spots that inc mm_users, and CLONE_VM is clearly the
critical bit more so than posix thread.

> We could set a flag in the task security structure upon
> selinux_task_create upon CLONE_VM, I suppose, and inherit it in
> selinux_task_alloc_security.  That would prohibit any use after you've
> ever created a thread, even if none of the other threads are still
> around, which is stronger than we need, but probably not an obstacle. 
> Is that what you had in mind?

No, I was thinking of actually tracking the threads, since you know when
they come and go.  One way would be to share task_security_struct via
refcnt for threads, although this could get sticky.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
