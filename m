Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbTISQkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTISQkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:40:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22160 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261622AbTISQkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:40:45 -0400
Date: Fri, 19 Sep 2003 17:40:44 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@debian.org>
Subject: What's the point of __KERNEL_SYSCALLS__?
Message-ID: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I can tell, __KERNEL_SYSCALLS__ (see asm-*/unistd.h) are
merely an indirection for calling sys_foo -- they don't seem to play
around with DS or FS or whatever x86 register name got turned into an
arch-independent way of saying what userspace is.

Given that, why should they exist?  It only encourages monstrosities
like sp8870_read_code() in drivers/media/dvb/frontends/alps_tdlb7.c that
probably don't work anyway.

The following are unused:
	setsid
	write

read is used by DVB and the wavefront sound driver
lseek is only used by DVB
dup is used only by init/main.c and could easily call sys_dup() instead.
execve is used by kmod, init/main.c, sbus/char/{bbc_,}envctrl.c and
	arch/sparc64/kernel/power.c
open is used by DVB, init/main.c and wavefront.
close is used by wavefront.  (DVB calls sys_close directly).
_exit is used by arch/ia64/kernel/process.c
waitpid is used by kernel/workqueue.c and net/ipv4/ipvs/ip_vs_sync.c

This doesn't seem like a big list to clean up.  Any objections to
getting rid of them and making the calls directly?  If nothing else,
at least it would make it explicit when we possibly needed to be calling
set_fs(KERNEL_DS) instead.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
