Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVBZR6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVBZR6A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVBZR6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:58:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:35980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261243AbVBZR55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:57:57 -0500
Date: Sat, 26 Feb 2005 09:58:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, kwc@citi.umich.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org
Subject: Re: [PATCH] Properly share process and session keyrings with
 CLONE_THREAD 
In-Reply-To: <22037.1109423277@redhat.com>
Message-ID: <Pine.LNX.4.58.0502260947230.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502251149320.9237@ppc970.osdl.org> 
 <25723.1109339172@redhat.com>  <22037.1109423277@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, David Howells wrote:
> 
> There's a per-thread keyring available too; and that is strictly per thread.

Ahh, I'd forgotten about that. Yeah, as long as the per-thread thing is
still there, I guess I'm ok with it (what I _really_ don't want to lose is
the ability to have independent threads - threaded servers using
per-request keys etc, and that's my main gripe with the stupid POSIX
threading model: it takes away per-thread data).

Can you not do the "thread_group_lock()" thing, though? I hate hiding
locks in "helper functions". You search for the lock, and now you've
hidden that "siglock" usage away and made it very different from all the
other siglock usage. You've also hidden the fact that it accesses
"current->signal" (while not hiding it would mean that the code would 
likely be more cleanly done as

	struct sighand *grp = current->sighand;

	spin_lock_irq(grp->siglock);
	.. access group keys ..
	spin_unlock_irq(grp->siglock);

Also, you have "current->thread_group" in there:

	+       key_check(current->thread_group->session_keyring);
	+       key_check(current->thread_group->process_keyring);

which seems to have gotten through only because your key debug stuff is 
disabled..

		Linus

