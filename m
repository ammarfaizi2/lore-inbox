Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTJZI0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 03:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbTJZI0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 03:26:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262882AbTJZI0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 03:26:14 -0500
Date: Sun, 26 Oct 2003 08:26:10 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: arekm@pld-linux.org, linux-kernel@vger.kernel.org, jmorris@redhat.com,
       sds@epoch.ncsc.mil, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
Message-ID: <20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk>
References: <200310260045.52094.arekm@pld-linux.org> <20031025185055.4d9273ae.akpm@osdl.org> <20031025224950.001b4055.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025224950.001b4055.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 10:49:50PM -0700, Andrew Morton wrote:
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

AFAICS, we can move d_add() right before taking the spinlock.  It's there
to protect the ->proc_dentry assignment.

*However*, I would like to point out that we are holding ->i_sem on the
procfs root at that point, so any blocking code in d_instantiate() would
better be careful to avoid deadlocks if it wants to play with procfs itself -
we are not in a locking-neutral situation here, spinlock or not.
