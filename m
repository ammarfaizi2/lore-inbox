Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVBWBgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVBWBgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVBWBgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 20:36:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:40594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261383AbVBWBgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 20:36:37 -0500
Date: Tue, 22 Feb 2005 17:36:31 -0800
From: Chris Wright <chrisw@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.11-rc4 i386] Re-order <linux/fs.h> includes to fix userland breakage
Message-ID: <20050223013631.GC21662@shell0.pdx.osdl.net>
References: <20050222215141.GA30663@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222215141.GA30663@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Rini (trini@kernel.crashing.org) wrote:
> The following moves all includes <linux/fs.h> (except <linux/ioctl.h>
> and <linux/config.h> down to below the existing __KERNEL__ test.  None
> of these includes are needed by the user-visible portions of the header,
> and in some cases can cause userland apps to break.  For example, LTP
> and sash with an empty <linux/autoconf.h> will fail thusly:
> cc -Wall  -I../../include -g -Wall -I../../../../include -Wall    setrlimit02.c -L../../../../lib -lltp  -o setrlimit02
> In file included from /usr/include/asm/atomic.h:6,
>                  from /usr/include/linux/fs.h:20,
>                  from setrlimit02.c:46:
> /usr/include/asm/processor.h:68: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
> /usr/include/asm/processor.h:68: error: requested alignment is not a constant

This change is spewing warnings like:

  CC      init/main.o
In file included from include/linux/fs.h:202,
                 from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/limits.h:4:1: warning: "NR_OPEN" redefined
In file included from include/linux/proc_fs.h:6,
                 from init/main.c:17:
include/linux/fs.h:24:1: warning: this is the location of the previous definition
  CC      init/do_mounts.o
In file included from include/linux/fs.h:202,
                 from include/linux/tty.h:20,
                 from init/do_mounts.c:5:
include/linux/limits.h:4:1: warning: "NR_OPEN" redefined
In file included from include/linux/tty.h:20,
                 from init/do_mounts.c:5:
include/linux/fs.h:24:1: warning: this is the location of the previous definition

Move limits.h include back above __KERNEL__ to quiet things back down.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/linux/fs.h 1.377 vs edited =====
--- 1.377/include/linux/fs.h	2005-02-22 13:44:27 -08:00
+++ edited/include/linux/fs.h	2005-02-22 17:26:03 -08:00
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <linux/ioctl.h>
+#include <linux/limits.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -199,7 +200,6 @@ extern int dir_notify_enable;
 #ifdef __KERNEL__
 
 #include <linux/linkage.h>
-#include <linux/limits.h>
 #include <linux/wait.h>
 #include <linux/types.h>
 #include <linux/kdev_t.h>
