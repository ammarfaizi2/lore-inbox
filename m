Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUIMX27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUIMX27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUIMX26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:28:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:64415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269060AbUIMX2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:28:53 -0400
Date: Mon, 13 Sep 2004 16:26:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: fix posix-timers leak and pending signal loss
Message-Id: <20040913162645.448e6131.akpm@osdl.org>
In-Reply-To: <200409110759.i8B7x5OH019867@magilla.sf.frob.com>
References: <200409110759.i8B7x5OH019867@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> I've found some problems with exec and fixed them with this patch to de_thread.
> 
>  The first problem is that exec fails to clean up posix-timers.  This
>  manifests itself in two ways, one worse than the other.  In the
>  single-threaded case, it just fails to clear out the timers on exec.
>  POSIX says that exec clears out the timers from timer_create (though not
>  the setitimer ones), so it's wrong that a lingering timer could fire after
>  exec and kill the process with a signal it's not expecting.  In the
>  multi-threaded case, it not only leaves lingering timers, but it leaks
>  them entirely when it replaces signal_struct, so they will never be freed
>  by the process exiting after that exec.  The new per-user
>  RLIMIT_SIGPENDING actually limits the damage here, because a UID will fill
>  up its quota with leaked timers and then never be able to use timer_create
>  again (that's what my test program does).  But if you have many many
>  untrusted UIDs, this leak could be considered a DoS risk.
> 
>  The second problem is that a multithreaded exec loses all pending signals.
>  This is violation of POSIX rules.  But a moment's thought will show it's
>  also just not desireable: if you send a process a SIGTERM while it's in
>  the middle of calling exec, you expect either the original program in that
>  process or the new program being exec'd to handle that signal or be killed
>  by it.  As it stands now, you can try to kill a process and have that
>  signal just evaporate if it's multithreaded and calls exec just then.  
>  I really don't know what the rationale was behind the de_thread code that
>  allocates a new signal_struct.  It doesn't make any sense now.  The other
>  code there ensures that the old signal_struct is no longer shared.  Except
>  for posix-timers, all the state there is stuff you want to keep.  So my
>  changes just keep the old structs when they are no longer shared, and all
>  the right state is retained (after clearing out posix-timers).
> 
>  The final bug is that the cumulative statistics of dead threads and dead
>  child processes are lost in the abandoned signal_struct.  This is also
>  fixed by holding on to it instead of replacing it.

The patch comes at an awkward time - I'd prefer that the leak fix be merged
up immediately, but the rest appears less serious.  And you're playing in
an area which likes to explode in our faces.

Had you not rolled three distinct patches into one (hint) I'd have
forwarded along the leak fix and sat on the rest for post-2.6.9.

What can we do about this?
