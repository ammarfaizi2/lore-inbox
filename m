Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJZJmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJZJmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:42:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19681 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263009AbTJZJl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:41:58 -0500
Date: Sun, 26 Oct 2003 09:41:57 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: arekm@pld-linux.org, linux-kernel@vger.kernel.org, jmorris@redhat.com,
       sds@epoch.ncsc.mil, manfred@colorfullife.com
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
Message-ID: <20031026094157.GV7665@parcelfarce.linux.theplanet.co.uk>
References: <200310260045.52094.arekm@pld-linux.org> <20031025185055.4d9273ae.akpm@osdl.org> <20031025224950.001b4055.akpm@osdl.org> <20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk> <20031026014153.0fdbd50a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026014153.0fdbd50a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 01:41:53AM -0700, Andrew Morton wrote:

> > AFAICS, we can move d_add() right before taking the spinlock.  It's there
> > to protect the ->proc_dentry assignment.
> 
> In which case we don't need to take the lock at all.  Two instances.

Yes, we do.  At least we used to - the other side of that code assumes
that holding the spinlock is enough to keep ->proc_dentry unchanged.
And no, I hadn't done the analysis of changes that had come with the
"task" ugliness.

> What protects against concurrent execution of proc_pid_lookup() and
> proc_task_lookup()?  I think nothing, because one is at /proc/42 and the
> other is at /proc/41/42; the parent dir inodes are different.  hmm.
>
> > *However*, I would like to point out that we are holding ->i_sem on the
> > procfs root at that point, so any blocking code in d_instantiate() would
> > better be careful to avoid deadlocks if it wants to play with procfs itself -
> > we are not in a locking-neutral situation here, spinlock or not.
> 
> "procfs root", or parent dir??

For proc_pid_lookup() they are the same.
