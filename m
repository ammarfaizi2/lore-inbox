Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTI3Q2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTI3Q2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:28:39 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:9942 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261740AbTI3Q2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:28:37 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Message-Id: <1064939275.673.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Sep 2003 18:27:55 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I finally figured out why on a friend machine, his nr_queued_signals is
continuously growing until reaching nr_max_signals, thus preventing
queuing of RT signals, for example causing do_notify_parent() to fail
(libpthread uses sig 33 which is RTMIN+1 typically) leading to all sorts
of zombies floating around etc...

The problem is a bug in kupdated (possibly shared by other kernel code
manipulating a task tsk->pending.signal mask "by hand") that gets
triggered, in this case, by the infamous noflushd, but other culprits
are possible.

The bug is simple: the SIGSTOP sent to kupdated gets queued (allocated
& queued actually) since we try to queue one non-RT signal nowadays.

However, when "receiving" it, kupdated will "manually" clear it from
signal pending mask and will _not_ dequeue it. Thus, that signal will
stay forever in kupdated signal queue, it will never be deallocated and
nr_queued_signals will never be decreased.

Actually, further sigstops will stack there as well since kupdated is
clearing it from tsk->pending.signal so further queuing won't "notice"
it's already there.
That clearing also prevents handle_stop_signal() from flushing it from
the queue when SIGCONT is received.

The only thing I can see that could get rid of those signals  is
flush_sigqueue(), but of course, this is never called for a kernel
thread like kupdated.

So there is a clear bug in kupdated, I suppose the fix is to call
something like dequeue_signal() from kupdated instead of hacking
tsk->pending.signal. I need to test a fix before I post a patch.

Do we have a smiliar bug(s) with other bits of kernel "manipulating"
the pending signal mask this way ? I don't know what others may do
here, so if you know something like that, please speak up.

Ben.


