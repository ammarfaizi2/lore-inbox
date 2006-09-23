Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWIWQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWIWQEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWIWQEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:04:14 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:6054 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751263AbWIWQEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:04:13 -0400
Date: Sat, 23 Sep 2006 17:04:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
In-Reply-To: <451555CB.5010006@aknet.ru>
Message-ID: <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
 <451555CB.5010006@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 16:03:55.0756 (UTC) FILETIME=[DF2D02C0:01C6DF29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006, Stas Sergeev wrote:
> Hugh Dickins wrote:
> 
> > It's hardly any surprise, is it, that if a distro chooses now
> > to mount something "noexec", a problem is then found with a few
> > things which want otherwise?
> They do not "want otherwise". They do the right thing - use
> shm_open() and then mmap(), but mmap() suddenly fails. The apps
> are not guilty. Neither I think the debian guys are.

Debian wants /dev/shm mounted "noexec" for whatever reason,
these apps want otherwise: to be able to mmap PROT_EXEC on it.

> 
> > And it seems unlikely that the answer
> > is then to modify the kernel, to weaken the very protection they're
> > wanting to add?
> I don't think they want to prevent PROT_EXEC mmaps. Almost
> certainly not. Maybe they thought they would only block mere
> execve() calls and the like, I don't know. My point is that
> this change (use of "noexec") should not break the properly
> written apps, but right now it does. Is it stated anywhere
> in the shm_open() manpage or elsewhere that you must not use
> "noexec" on tmpfs or you'll get troubles with mmap?

No, it's not.  But this doesn't have much to do with tmpfs,
nor with shm_open.  It's just that the kernel is not allowing
mmap PROT_EXEC on a MNT_NOEXEC mount.  Which seems reasonable
(though you can argue that mprotect ought to disallow it too).

If that's a problem for something, don't mount "noexec"
(but I'm not the one to recommend a secure configuration).

> 
> > The original 2.6.0 patch (later backported into 2.4.25) was
> > <drepper@redhat.com>
> >  [PATCH] Fix 'noexec' behaviour
> >  We should not allow mmap() with PROT_EXEC on mounts marked "noexec",
> >  since otherwise there is no way for user-supplied executable loaders
> >  (like ld.so and emulator environments) to properly honour the
> >  "noexec"ness of the target.
> Thanks for the pointer, but that looks like the user-space
> issue to me. Why ld.so can't figure out the "noexecness" and
> do the right thing itself?

That would be tiresome work.

> Or does it figure out the "noexecness"
> exactly by trying the PROT_EXEC mmap and see if it fails?

Exactly.

Hugh
