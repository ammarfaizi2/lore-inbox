Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbSLaCtM>; Mon, 30 Dec 2002 21:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSLaCtM>; Mon, 30 Dec 2002 21:49:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267129AbSLaCtL>; Mon, 30 Dec 2002 21:49:11 -0500
Date: Mon, 30 Dec 2002 18:52:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jakub Jelinek <jakub@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: glibc binaries w/ sysenter support
In-Reply-To: <3E0F5233.5050209@redhat.com>
Message-ID: <Pine.LNX.4.44.0212301838050.1614-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Uli,

 can you tell me what the new glibc does for different "clone()" system
calls? It turns out that some of the different process creation calls are
rather nasty to handle with the "call *syscallptr" approach. We have a few 
differenct cases:

 - vfork() is nasty, because it must not have a stack frame that the
   parent needs and that might get destroyed by the child.

 - clone(.. newesp != 0 ..) is nasty, because the esp correction depends 
   on just what kind of system call it was, and the current kernel doesn't 
   know and really doesn't even _want_ to know.

I know glibc does the inlined "int 0x80" for the vfork() case, but I
wonder if you saw the problem for thread creation? I think that one has to
use the old-style inlined "int 0x80" too in order to avoid stack
confusion.. And since the glibc "clone()" wrapper call gives the user the 
option to set a non-zero ESP, that one has to do it too.

(Both of these are really independent of "sysenter" itself, and will be
visible even on machines without any sysenter support, since they are both
stack offset issues caused simply by the fact that we use a trampoline to
jump to the system call).

Comments? Can anybody find any other nasty cases where the stack pointer 
matters for the system call (or an argument is used for a start ptr return 
value)?

			Linus

