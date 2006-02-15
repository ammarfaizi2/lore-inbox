Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWBOTOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWBOTOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBOTOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:14:04 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39609 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932158AbWBOTOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:14:02 -0500
Subject: ptrace and threads
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 15 Feb 2006 14:14:01 -0500
Message-Id: <1140030841.10553.9.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a proper, non-racy, way to hand a ptraced child off from one
tracing process to another tracing process?

Specifically, I want to architect my tracing application such that each
traced process is traced by a separate thread.

For non-threaded applications, I was adding CLONE_STOPPED to the
clone(2) flags of the child.  This way, when the child process started
up, it would be stopped and a new tracing thread could PTRACE_ATTACH to
it before any system calls were executed.  Unfortunately, this method
doesn't seem to work for threaded traced processes.  The reason is that
the SIGSTOP may be delivered to the traced parent instead of the traced
child, because signal handlers are shared.

My next thought was to add CLONE_PTRACE to the flags.  This way, the
tracing process gets signaled via wait before the child begins to
execute.  The problem now is that I need to the have a separate
monitoring thread take control of the child.  I tried using
ptrace(PTRACE_DETACH, ..., ..., SIGSTOP) in the original tracing process
to stop the process after the fork, followed by a ptrace(PTRACE_ATTACH)
in the new tracing process.  Again, the STOP signal doesn't seem to be
reliably delivered (and the man page says you can't use SIGSTOP as an
argument to PTRACE_CONT and that PTRACE_DETACH's semantics match those
of PTRACE_CONT).

Thank you,
Charles

P.S. I am not subscribed to lkml, so please Cc: me on replies.

