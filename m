Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVK2A51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVK2A51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVK2A51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:57:27 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:17599 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932296AbVK2A51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:57:27 -0500
Subject: [PATCH] 0/3 Add pselect/ppoll()
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: drepper@redhat.com, linuxppc-dev@ozlabs.org, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 29 Nov 2005 00:57:17 +0000
Message-Id: <1133225837.31573.110.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following implementation of ppoll() and pselect() system calls
depends on the architecture providing a TIF_RESTORE_SIGMASK flag in the
thread_info.

These system calls have to change the signal mask during their
operation, and signal handlers must be invoked using the new, temporary
signal mask. The old signal mask must be restored either upon successful
exit from the system call, or upon returning from the invoked signal
handler if the system call is interrupted. We can't simply restore the
original signal mask and return to userspace, since the restored signal
mask may actually block the signal which interrupted the system call.

The TIF_RESTORE_SIGMASK flag deals with this by causing the syscall exit
path to trap into do_signal() just as TIF_SIGPENDING does, and by
causing do_signal() to use the saved signal mask instead of the current
signal mask when setting up the stack frame for the signal handler -- or
by causing do_signal() to simply restore the saved signal mask in the
case where there is no handler to be invoked.

The first patch implements the sys_pselect() and sys_ppoll() system
calls, which are present only if TIF_RESTORE_SIGMASK is defined. That
#ifdef should go away in time when all architectures have implemented
it. The second patch implements TIF_RESTORE_SIGMASK for the PowerPC
kernel (in the -mm tree), and the third patch then removes the
arch-specific implementations of sys_rt_sigsuspend() and replaces them
with generic versions using the same trick.

-- 
dwmw2


