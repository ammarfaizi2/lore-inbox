Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTJZIk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 03:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbTJZIk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 03:40:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:33476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262814AbTJZIk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 03:40:58 -0500
Date: Sun, 26 Oct 2003 01:41:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: arekm@pld-linux.org, linux-kernel@vger.kernel.org, jmorris@redhat.com,
       sds@epoch.ncsc.mil, manfred@colorfullife.com
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
Message-Id: <20031026014153.0fdbd50a.akpm@osdl.org>
In-Reply-To: <20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk>
References: <200310260045.52094.arekm@pld-linux.org>
	<20031025185055.4d9273ae.akpm@osdl.org>
	<20031025224950.001b4055.akpm@osdl.org>
	<20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sat, Oct 25, 2003 at 10:49:50PM -0700, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > but the wider question would be: is the SELinux
> > >  d_instantiate callout allowed to sleep?  A quick audit seems to indicate
> > >  that it's OK, but only by luck I think.
> > 
> > proc_pid_lookup() calls d_add->d_instantiate under task->proc_lock, so
> > inode_doinit_with_dentry() is called under spinlock on this path as well.
> > 
> > Manfred, is there any particular reason why proc_pid_lookup()'s d_add is
> > inside the lock?
> 
> AFAICS, we can move d_add() right before taking the spinlock.  It's there
> to protect the ->proc_dentry assignment.

In which case we don't need to take the lock at all.  Two instances.

What protects against concurrent execution of proc_pid_lookup() and
proc_task_lookup()?  I think nothing, because one is at /proc/42 and the
other is at /proc/41/42; the parent dir inodes are different.  hmm.

> *However*, I would like to point out that we are holding ->i_sem on the
> procfs root at that point, so any blocking code in d_instantiate() would
> better be careful to avoid deadlocks if it wants to play with procfs itself -
> we are not in a locking-neutral situation here, spinlock or not.

"procfs root", or parent dir??
