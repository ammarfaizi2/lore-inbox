Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUJFTVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUJFTVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJFTVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:21:32 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:48301 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269373AbUJFTU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:20:57 -0400
Date: Wed, 6 Oct 2004 21:20:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20041006192048.GG10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <20041006180145.GC10153@wohnheim.fh-wedel.de> <20041006181836.GA27300@kroah.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041006181836.GA27300@kroah.com>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: greg@kroah.com, alan@lxorguk.ukuu.org.uk, rmk+lkml@arm.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 11:18:36 -0700, Greg KH wrote:
> 
> Care to send a patch to do this?

Below.  Never tried udev and/or hotplug, never even looked at the code
yet.  So you better don't trust me.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu

Open the standard fds 0, 1 and 2 for usermode helpers.  Or at least
try to do so.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 kmod.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2.6.8cow/kernel/kmod.c~hotplug	2004-09-04 22:59:14.000000000 +0200
+++ linux-2.6.8cow/kernel/kmod.c	2004-10-06 21:16:16.000000000 +0200
@@ -166,6 +166,13 @@
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* Try to open either /dev/console or /dev/null for fds 0, 1 and 2 */
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		(void) sys_open("/dev/null", O_RDWR, 0);
+
+	(void) sys_dup(0);
+	(void) sys_dup(0);
+
 	retval = -EPERM;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
