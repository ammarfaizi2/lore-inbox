Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277242AbRJLFtO>; Fri, 12 Oct 2001 01:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277231AbRJLFtE>; Fri, 12 Oct 2001 01:49:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:22793 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277246AbRJLFsw>;
	Fri, 12 Oct 2001 01:48:52 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15302.33862.136753.909880@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2001 15:48:54 +1000 (EST)
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.12 breaks debian install disks
In-Reply-To: <Pine.LNX.4.10.10110111008300.24112-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.10.10110111008300.24112-100000@innerfire.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack writes:

> When trying to load a reiserfs enabled boot disk on a Dell PowerEdge 
> I get:
> 
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeimg unused kernel memory: 192k freed
> (hangs here) 
> 
> The problem appears on 2.4.11-pre6 and 2.4.12 but 2.4.9 was fine.
> This problem appears both whith and without the Dell AACraid patches.

This could be the same problem that I reported some time ago, where if
you send a signal to the init process while it is running /linuxrc,
the system will hang.  In my case the problem was with this code in
prepare_namespace() in init/main.c:

	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
	if (pid>0)
		while (pid != wait(&i));

If a signal becomes pending, the wait will not block, but the signal
never gets delivered because the process is still running inside the
kernel (signals only get delivered on the exit from kernel to user
space).

One solution would be to change it to something like this (caution,
completely untested):

	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
	if (pid > 0) {
		while (pid != wait(&i)) {
			if (signal_pending(current)) {
				spin_lock_irq(&current->sigmask_lock);
				flush_signals(current);
				recalc_sigpending(current);
				spin_unlock_irq(&current->sigmask_lock);
			}
		}
	}

Another alternative would be to block signals like request_module() in
kernel/kmod.c does.

HTH,
Paul.
