Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSKGIqY>; Thu, 7 Nov 2002 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266410AbSKGIqY>; Thu, 7 Nov 2002 03:46:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50244 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266367AbSKGIqX>; Thu, 7 Nov 2002 03:46:23 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Nov 2002 01:50:28 -0700
In-Reply-To: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
Message-ID: <m14ratepbf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am now officially grumpy.  From a code perspective splitting kexec
into two phases load, and execute is a simple change to make.  From a
semantics standpoint things get ugly, and messy.  And that means I
can't just dash off another patch.

There are currently 2 cases that it would be nice to have work.
1) Load a new kernel and immediately execute it.
2) Load a new kernel and execute it on panic.

At first glance splitting the code into a load and execute phases allows
us to use one mechanism to accomplish both goals.  In practice
that does not work.  There are 2 problems.

panic does not call sys_reboot it rolls that functionality by hand.
And to a certain extent it makes sense for panic to take a different
path because we know something is badly wrong so we need to be extra
careful.

In staging the image we allocate a whole pile of pages, and keep them
locked in place.  Waiting for years potentially until the machine
reboots or panics.   This memory is not accounted for anywhere so no
one can see that we have it allocated, which makes debugging hard.
Additionally in locking up megabytes for a long period of time we
create unsolvable fragmentation issues for the mm layer to deal with.

In a unified design I can buffer the image in the anonymous pages of a
user space process just as well as I can in locked down kernel memory.
So factoring sys_kexec in to load and execute pieces only helps for
executing the new image on a kernel panic, and that case does not
actually work.

So currently factoring kexec looks like a pointless exercise, that
will just lead to more pain.

I am left with the following questions.
- How should the pages allocated to an early loaded image be accounted
  for?
- How do we avoid making life hard for the mm system with an early
  loaded image?
- Is it safe to call sys_reboot from panic?
- Can we simply factor out the sequence:
		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
		system_running = 0;
		device_shutdown();
  And place it into it's own subroutine?
- What does the current mcore implementation do?  And is that a good
  model to follow to resolve some of these issues?


Eric

