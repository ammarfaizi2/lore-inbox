Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTLGQTa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLGQTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:19:30 -0500
Received: from smtp.mailix.net ([216.148.213.132]:30045 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S264444AbTLGQT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:19:26 -0500
Date: Sun, 7 Dec 2003 17:19:20 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FIx 'noexec' behavior
Message-ID: <20031207161920.GA1715@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031207133906.GA1140@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207133906.GA1140@steel.home>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-12-07 13:42:00, wli wrote:
> > I had to put a check for 'file' (as Ulrich suggested).
> > Otherwise it deadlocks again.
> > Is it possible for ->f_vfsmnt to be NULL at all? Should it be tested?
> > diff -Nru a/mm/mmap.c b/mm/mmap.c
> > --- a/mm/mmap.c Sun Dec  7 14:37:33 2003
> > +++ b/mm/mmap.c Sun Dec  7 14:37:33 2003
> > @@ -478,7 +478,7 @@
> >         if (file && (!file->f_op || !file->f_op->mmap))
> >                 return -ENODEV;
> >  
> > -       if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
> > +       if ((prot & PROT_EXEC) && file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
> >                 return -EPERM;
> >  
> >         if (!len)
> 
> This does not resemble the code I was looking at from current bk.
> 

probably you were looking at the already fixed code:

ChangeSet@1.1512, 2003-12-06 14:34:40-08:00, torvalds@home.osdl.org +1 -0
  Fix the PROT_EXEC breakage on anonymous mmap.

  Clean up the tests while at it.

	if (file) {
		if (!file->f_op || !file->f_op->mmap)
			return -ENODEV;

		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
			return -EPERM;
	}


The code I was looking at was the one from Ulrich:

ChangeSet 1.1507 2003/12/04 22:26:06 drepper@redhat.com
  [PATCH] Fix 'noexec' behaviour

  We should not allow mmap() with PROT_EXEC on mounts marked "noexec",
  since otherwise there is no way for user-supplied executable loaders
  (like ld.so and emulator environments) to properly honour the
  "noexec"ness of the target.

	if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
		return -EPERM;


