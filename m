Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJQQfW>; Thu, 17 Oct 2002 12:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJQQfW>; Thu, 17 Oct 2002 12:35:22 -0400
Received: from crack.them.org ([65.125.64.184]:44297 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261478AbSJQQfV>;
	Thu, 17 Oct 2002 12:35:21 -0400
Date: Thu, 17 Oct 2002 12:40:40 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: phil-list@redhat.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021017164040.GA12608@nevyn.them.org>
Mail-Followup-To: phil-list@redhat.com,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>,
	S Vamsikrishna <vamsi_krishna@in.ibm.com>,
	Mark Gross <markgross@thegnar.org>,
	Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 11:11:21AM +0200, Ingo Molnar wrote:
> - properly wait for all threads that share the same MM to serialize with
>   the coredumping thread. This is CLONE_VM based, not tied to
>   CLONE_THREAD and/or signal semantics, ie. old-style (or different-style)
>   threaded apps will be properly stopped as well.
> 
>   The locking might look a bit complex, but i wanted to keep the
>   __exit_mm() overhead as low as possible. It's not quite trivial to get
>   these bits right, because 'sharing the MM' is detached from signals
>   semantics, so we cannot rely on broadcast-kill catching all threads. So
>   zap_threads() iterates through every thread and zaps those which were
>   left out. (There's a minimal race left in where a newly forked child
>   might escape the attention of zap_threads() - this race is fixed by the
>   OOM fixes in the mmap-speedup patch.)

My only problem with this is that you're waiting for all threads by
SIGKILLing them.  If a process vforks or clones, and then the child
crashes, the parent will receive a SIGKILL - iff we are dumping core. 
That's a change in behavior that seems a bit too arbitrary to me.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
