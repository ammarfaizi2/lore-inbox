Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJWF6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJWF6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUJWF4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:56:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:44991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267612AbUJWEZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:25:44 -0400
Date: Fri, 22 Oct 2004 21:25:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: BUG_ONs in signal.c?
In-Reply-To: <200410230414.i9N4Edia027359@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410222121040.2101@ppc970.osdl.org>
References: <200410230414.i9N4Edia027359@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Oct 2004, Roland McGrath wrote:
>
> Once group_exit is set, it should never be cleared and group_exit_code
> should never be changed.

Hmm? Another signal that kills another thread, but isn't a core-dump 
signal, will go through the __group_complete_signal() code in 
kernel/signal.c, and do

                        p->signal->group_exit_code = sig;

adn the only locking there is the siglock/tasklist_lock as far as I can 
see.

So as far as I can tell, I see

	coredump thread			other thread
	===============			============

	do_coredump()
	current->signal->group_exit_code = exit_code
	coredump_wait(mm);

					/* gets fatal non-coredump signal */
					current->signal->group_exit_code = sig;
	...
	BUG_ON(current->signal->group_exit_code != exit_code);
	!!BOOM!!

No?

		Linus
