Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269834AbTGKJCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269842AbTGKJCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:02:32 -0400
Received: from ns.suse.de ([213.95.15.193]:36874 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269835AbTGKJBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:01:49 -0400
Date: Fri, 11 Jul 2003 11:16:30 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
Message-ID: <20030711091630.GA2707@wotan.suse.de>
References: <20030711014154.GA15238@wotan.suse.de> <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 07:35:22PM -0700, Linus Torvalds wrote:
> 
> On Fri, 11 Jul 2003, Andi Kleen wrote:
> > 
> > This patch deprecates sysctl(2) by adding a printk to it. There is one
> > important user of it - glibc checks kernel.version in the startup code -
> > which is still handled without message. This needs to be still handled,
> > but the hope is that there are no other users of the numerical interface.
> 
> I'd prefer to first _only_ deprecate it, and if somebody really really 
> decides that they want another interface than /proc too, we can re-visit 
> the thing then.

Ok fine for me. Here is a new patch that only deprecates. 

> I doubt there is any real reason to not just use the /proc interface, and 
> I dislike pre-emptive engineering.

I don't feel particularly strongly about the sysctl_name thing, if you
think it's not necessary great.

-Andi

-------------

Deprecate numerical sysctl namespace. The only exception is kernel/version,
which is widely used in glibc. The new recommended interface is /proc/sys


--- linux-2.5/include/linux/sysctl.h	2003-06-06 17:55:40.000000000 +0200
+++ linux-2.5-amd64/include/linux/sysctl.h	2003-07-09 23:15:45.000000000 +0200
@@ -6,16 +6,10 @@
  ****************************************************************
  ****************************************************************
  **
- **  WARNING:  
  **  The values in this file are exported to user space via 
- **  the sysctl() binary interface.  Do *NOT* change the 
- **  numbering of any existing values here, and do not change
- **  any numbers within any one set of values.  If you have
- **  to redefine an existing interface, use a new number for it.
- **  The kernel will then return ENOTDIR to any application using
- **  the old binary interface.
- **
- **  --sct
+ **  the sysctl() binary interface.  However this interface
+ **  is unstable and deprecated and will be removed in the future. 
+ **  For a stable interface use /proc/sys.
  **
  ****************************************************************
  ****************************************************************
--- linux-2.5/kernel/sysctl.c	2003-07-04 23:52:20.000000000 +0200
+++ linux-2.5-amd64/kernel/sysctl.c	2003-07-11 03:25:18.000000000 +0200
@@ -823,7 +838,16 @@
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
-		
+	
+	if (tmp.nlen != 2 || tmp.name[0] != CTL_KERN ||
+	    tmp.name[1] != KERN_VERSION) { 
+		int i;
+		printk(KERN_INFO "%s: numerical sysctl ", current->comm); 
+		for (i = 0; i < tmp.nlen; i++) 
+			printk("%d ", tmp.name[i]); 
+		printk("is obsolete.\n");
+	} 
+
 	lock_kernel();
 	error = do_sysctl(tmp.name, tmp.nlen, tmp.oldval, tmp.oldlenp,
 			  tmp.newval, tmp.newlen);
