Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbTBWMuI>; Sun, 23 Feb 2003 07:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268359AbTBWMuI>; Sun, 23 Feb 2003 07:50:08 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:1973 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268323AbTBWMuI>;
	Sun, 23 Feb 2003 07:50:08 -0500
Date: Sun, 23 Feb 2003 14:00:04 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302231300.h1ND04Ch008890@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: [BUG] 2.5.62 kmod rewrite broke modprobe's install command
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.5.62, modprobe logs "FATAL: Error -1" when invoked
via request_module() to run a trivial /bin/true "install" command.
This problem did not exist in 2.5.61 or earlier kernels.

Repeat-by: Build a kernel without the RTC driver, put
"install char-major-10-135 /bin/true" in /etc/modprobe.conf
(new ugly way of saying "alias ... off"), od -c /dev/rtc,
and observe the modprobe error in /var/log/messages.
This will trigger the problem with 100% repeatability for me.

The reason this happens is that in 2.5.62, modprobe is started
with SIGCHLD set to SIG_IGN and not blocked. The "install"
command is run by system(), but due to SIGCHLD being SIG_IGN,
the child (which terminates quickly) is reaped automatically.
The parent process (modprobe) does a wait or waitpid, which fails
with ECHILD since the child is already gone. system() returns -1,
and modprobe logs a fatal error.

In 2.5.61 and earlier kernels, modprobe is started with SIGCHLD
set to SIG_DFL and not blocked, and system() works normally.

/Mikael
