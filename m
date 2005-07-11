Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGKKdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGKKdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVGKKdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:33:45 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:58079 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261614AbVGKKdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:33:44 -0400
Date: Mon, 11 Jul 2005 12:32:37 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Lack of Documentation about SA_RESTART...
Message-ID: <20050711123237.787dfcde@localhost>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation (man pages & info libc) doesn't cover well interaction
between various syscalls and SA_RESTART flag of sigaction()... I wonder
why!

	> MAN SIGACTION <

"SA_RESTART
Provide behaviour compatible with BSD signal semantics by
making certain system calls restartable across signals."

	certain?!? :-O!


	> INFO LIBC <

"   One important exception is `EINTR' (*note Interrupted Primitives::).
Many stream I/O implementations will treat it as an ordinary error,
which can be quite inconvenient.  You can avoid this hassle by
installing all signals with the `SA_RESTART' flag."


" -- Macro: int SA_RESTART
     This flag controls what happens when a signal is delivered during
     certain primitives (such as `open', `read' or `write'), and the
     signal handler returns normally.  There are two alternatives: the
     library function can resume, or it can return failure with error
     code `EINTR'."

	Ok, "info libc" is a bit better.


But what I'm looking for is a list of syscalls that are automatically
restarted when SA_RESTART is set, and especially in what conditions.

For example: read(), write(), open() are obviously restarted, but even
on non-blocking fd?
And what about connect() and select() for example?

There are a lot of syscalls that can fail with "EINTR"! What's the
advantage of using SA_RESTART if one doesn't know what syscalls are
restarted?

One should always check for "EINTR" or use "TEMP_FAILURE_RETRY()" macro
as suggested in "info libc" !


Looking at the source I can easly see that a syscall is retarted when it
returns "-ERESTARTSYS" and SA_RESTART flag is set. Should I look at the
code for every syscall / particular condition?


Example of behavior: according to source code it seems that "connect()"
(the "net/ipv4/af_inet.c : inet_stream_connect()" implementation)
returns -ERESTARTSYS if interrupted, but if the socket is in
non-blocking mode it returns -EINTR.


SUMMARY:

1) there is a reason for this lack of documentation?

2) what can I safely assume about syscalls restart when using SA_RESTART
flag?


Bye,

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
