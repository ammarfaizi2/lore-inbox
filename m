Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUBJRPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBJROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:14:04 -0500
Received: from nevyn.them.org ([66.93.172.17]:22462 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266027AbUBJRLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:11:12 -0500
Date: Tue, 10 Feb 2004 12:10:55 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Chua <jchua@fedex.com>,
       jeffchua@silk.corp.fedex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
Message-ID: <20040210171055.GA32612@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jeff Chua <jchua@fedex.com>,
	jeffchua@silk.corp.fedex.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com> <20040209225336.1f9bc8a8.akpm@osdl.org> <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com> <20040210082514.04afde4a.akpm@osdl.org> <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 08:31:24AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 10 Feb 2004, Andrew Morton wrote:
> > 
> > ah, thanks.
> > 
> > Like this?
> 
> That will just break. The reason for the "compiler.h" include is the 
> "__user" part of fpstate, so now you'll get a parse error later if 
> non-kernel code includes this.
> 
> So the rule should still be: don't include kernel headers from user 
> programs. But if it's needed for some reason, that #ifdef needs to be 
> somewhere else (inside "compiler.h" or something).

This is what Debian has been using.  I believe the other folks with a
glibc-kernel-headers package based on 2.6 do something similar.  I
don't know how you'll feel about adding this sort of crap to the
kernel, though.  Someone else needs to find time to start linuxabi
moving again...

--- include/linux/compiler.h	2003-10-15 11:13:09.000000000 -0400
+++ include/linux/compiler.h.t	2003-11-01 18:04:19.000000000 -0500
@@ -9,6 +9,15 @@
 # define __kernel
 #endif
 
+#if !defined(__KERNEL__)
+/* Debian: Most of these are inappropriate for userspace.  */
+/* We don't define likely, unlikely, or barrier; they're namespace-intrusive
+   and should not be needed outside of __KERNEL__.  For __attribute_pure__
+   and __attribute_used__ we use glibc's definitions.  */
+# include <sys/cdefs.h>
+# define __deprecated
+#else
+
 #if __GNUC__ > 3
 # include <linux/compiler-gcc+.h>	/* catch-all for GCC 4, 5, etc. */
 #elif __GNUC__ == 3
@@ -86,4 +95,6 @@
     (typeof(ptr)) (__ptr + (off)); })
 #endif
 
+#endif /* __KERNEL__ */
+
 #endif /* __LINUX_COMPILER_H */

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
