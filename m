Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUJFTZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUJFTZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJFTZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:25:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:9902 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269375AbUJFTXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:23:33 -0400
Date: Wed, 6 Oct 2004 21:23:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20041006192335.GH10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com> <20041006180421.GD10153@wohnheim.fh-wedel.de> <20041006181958.GB27300@kroah.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20041006181958.GB27300@kroah.com>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 11:19:58 -0700, Greg KH wrote:
> On Wed, Oct 06, 2004 at 08:04:21PM +0200, J?rn Engel wrote:
> > On Wed, 6 October 2004 10:38:23 -0700, Greg KH wrote:
> > > 
> > > Your printk() calls need the proper KERN_* level.
> > 
> > As does the original one.  Which one would you like for both?
> 
> KERN_WARNING perhaps?

As in the patch below?

> > > usually do not have a /dev/null this early in the boot process).  Does
> > > this mean we should add a /dev/null to the initramfs image, like the
> > > /dev/console node we currently have there?
> > 
> > Yes, that would fix the case.  Is this a problem?
> 
> I don't have a problem with doing that.

Then please do so. :)

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth

Some userspace applications rely on the assumption that fd's 0, 1 and
2 are always open and function as raw stdin, stdout and stderr,
respectively.

With no console registered, init get's called without those fd's
already open.  Arguably, init should know better, handle that case and
fix things before forking other processed.  But what about
init=/bin/bash?  Ok, bash could be fixed as well, as could...

Instead, this patch opens /dev/null when /dev/console doesn't work.
It swallows all output and doesn't give much input, but programs can
handle that just fine.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 main.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


--- linux-2.6.8cow/init/main.c~console	2004-10-05 20:46:40.000000000 +0200
+++ linux-2.6.8cow/init/main.c	2004-10-06 21:14:43.000000000 +0200
@@ -695,8 +695,13 @@
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		printk("Warning: unable to open an initial console.\n");
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
+		printk(KERN_WARNING
+			"Warning: unable to open an initial console.\n");
+		if (sys_open("/dev/null", O_RDWR, 0) == 0)
+			printk(KERN_WARNING
+				"         Falling back to /dev/null.\n");
+	}
 
 	(void) sys_dup(0);
 	(void) sys_dup(0);
