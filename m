Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJ0Nwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJ0Nwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:52:40 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:13193 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262799AbTJ0Nwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:52:39 -0500
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: arekm@pld-linux.org, lkml <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       James Morris <jmorris@redhat.com>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20031025224950.001b4055.akpm@osdl.org>
References: <200310260045.52094.arekm@pld-linux.org>
	 <20031025185055.4d9273ae.akpm@osdl.org>
	 <20031025224950.001b4055.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1067262721.18818.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Oct 2003 08:52:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-26 at 01:49, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > but the wider question would be: is the SELinux
> >  d_instantiate callout allowed to sleep?  A quick audit seems to indicate
> >  that it's OK, but only by luck I think.
> 
> proc_pid_lookup() calls d_add->d_instantiate under task->proc_lock, so
> inode_doinit_with_dentry() is called under spinlock on this path as well.
> 
> Manfred, is there any particular reason why proc_pid_lookup()'s d_add is
> inside the lock?

This shouldn't be a problem for SELinux, because the /proc/pid inodes
are initialized by proc_pid_make_inode via the security_task_to_inode
hook (=> selinux_task_to_inode), so inode_doinit_with_dentry will bail
immediately on the first test of isec->initialized prior to any blocking
calls.

I asked Al Viro about this issue back when the proc locking change was
introduced (circa 2.5.70), and he seemed to agree that the SELinux code
is safe in this case.  He was concerned about the change in behavior for
d_instantiate, but d_instantiate seems to be the more general location
to perform inode security initialization for the majority of filesystem
types; hooking in iget() would only handle a subset of filesystems.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

