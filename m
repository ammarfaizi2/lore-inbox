Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbTHTC0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTHTC0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:26:17 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:47117 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261523AbTHTC0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:26:13 -0400
Date: Wed, 20 Aug 2003 04:26:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
Message-ID: <20030820042610.A2596@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com> <20030819210623.A2195@pclin040.win.tue.nl> <3F427766.5020105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F427766.5020105@redhat.com>; from drepper@redhat.com on Tue, Aug 19, 2003 at 12:15:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:15:50PM -0700, Ulrich Drepper wrote:

> > I just tried NFS client 2.6.0-test3, NFS server 2.0.34, try test on client.
> > No problems. ftruncate did not fail.
> > 
> > (Do you require some NFS version?)
> 
> I have no special settings.  It's an out-of-the-box RHL9 server setting,
> using NFSv3.
>
> Does the 2.0 kernel have NFSv3?  That might be why you don't see it.

No it doesnt.

So, instead of testing let us just read the source.
I do not completely understand all details yet, but the
interesting parts seem to live in nfs/dir.c.

Since NFS v2/v3 is stateless, doing things with open fds will fail.
This deviation from Unix semantics is repaired by replacing an unlink
by a "silly rename".

Your testprogram works under 2.4 and fails under 2.6.
The conclusion is no doubt that 2.4 does the silly rename
and 2.6 does not.
Why not?
2.4 says
	error = nfs_sillyrename(dir, dentry);
2.6 says
	if (atomic_read(&dentry->d_count) > 1)
		error = nfs_sillyrename(dir, dentry);

Your testprogram does a dup(), but that will not increment d_count,
so that is still 1 and 2.6 doesnt do the sillyrename.

[I must read further but have no time. Probably Trond will tell us
all details.]

Andries



