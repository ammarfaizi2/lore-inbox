Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135850AbRDTKN0>; Fri, 20 Apr 2001 06:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135849AbRDTKNQ>; Fri, 20 Apr 2001 06:13:16 -0400
Received: from nef.ens.fr ([129.199.96.32]:1286 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S135847AbRDTKNG>;
	Fri, 20 Apr 2001 06:13:06 -0400
Date: Fri, 20 Apr 2001 12:13:12 +0200
From: =?ISO-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200104201013.MAA03512@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Children first in fork
In-Reply-To: <9bn90l$anp$1@penguin.transmeta.com>
In-Reply-To: <20010419133538.A28654@quatramaran.ens.fr> <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com> <200104191256.OAA31141@quatramaran.ens.fr> <9bn3sr$fer$1@picard.cistron.nl> <9bn90l$anp$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, you wrote:
>You're probably even better off just intercepting the fork, turning it
>into a clone, and setting the CLONE_PTRACE option. Which (together with
>tracing the parent, which you will obviously be doing already in order
>to do all this in the first place) will nicely cause the child to get an
>automatic SIGSTOP _and_ be already traced.

Well, I tried that, and it doesn't work. The problem is that the child
starts ptraced, but it is its parent that will receive a signal for each
syscall, and not the program that ptraces its parent. Of course, the
parent will probably be a little bit confused by that (as it doesn't expect
to receive those signals) and the monitoring programm won't see anything.

Maybe it would work if the function copy_flags in fork.c was modified
into:
-----------------------------------------------------------------
--- fork-old.c  Fri Apr 20 12:01:09 2001
+++ fork.c      Fri Apr 20 12:05:57 2001
@@ -552,8 +552,14 @@
 
        new_flags &= ~(PF_SUPERPRIV | PF_USEDFPU | PF_VFORK);
        new_flags |= PF_FORKNOEXEC;
-       if (!(clone_flags & CLONE_PTRACE))
+       if (!(clone_flags & CLONE_PTRACE)) {
                new_flags &= ~(PF_PTRACED|PF_TRACESYS);
+               if (p->p_pptr->flags &= PF_PTRACED) {
+                       REMOVE_LINKS(p);
+                       p->p_pptr = p->p_pptr->p_pptr;
+                       SET_LINKS(child);
+               }
+       }
        if (clone_flags & CLONE_VFORK)
                new_flags |= PF_VFORK;
        p->flags = new_flags;
-----------------------------------------------------------------
(sorry, it is a 2.2.19pre8 kernel, and I don't know what have changed
since in that file)
Ok, I haven't tried it (can't reboot a machine now), and I don't know
what I am talking about, but the idea is simply ``if CLONE_PTRACE is set,
and the parent is ptraced, then the child's effective parent should be
its grandfather.''

Was it the way it was intended to work ? As it is now, I don't see any
use of the CLONE_PTRACE flag.

Éric Brunet
