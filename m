Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWAFTgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWAFTgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWAFTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:36:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964775AbWAFTgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:36:08 -0500
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <43BEA970.4050704@pobox.com>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136544309.2940.25.camel@laptopd505.fenrus.org>
	 <43BEA970.4050704@pobox.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 20:35:59 +0100
Message-Id: <1136576160.2940.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 12:31 -0500, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> > Subject: when CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
> > to decide what to inline and what not - instead of the kernel forcing gcc
> > to inline all the time. This requires several places that require to be 
> > inlined to be marked as such, previous patches in this series do that.
> > This is probably the most flame-worthy patch of the series.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> NAK, for what it's worth...  This should be first integrated with its 
> own "off switch", and then later added to optimze-for-size.

at the same time I'd not want such a config option to linger around
forever; if we do one config option per patch it gets unmanagable.
How about this?





if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
to decide what to inline and what not - instead of the kernel forcing gcc
to inline all the time. This requires several places that require to be 
inlined to be marked as such, previous patches in this series do that.


Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/linux/compiler-gcc4.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.15/include/linux/compiler-gcc4.h
===================================================================
--- linux-2.6.15.orig/include/linux/compiler-gcc4.h
+++ linux-2.6.15/include/linux/compiler-gcc4.h
@@ -3,9 +3,11 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
+#ifdef CONFIG_FORCED_INLINING
+# define inline			inline		__attribute__((always_inline))
+# define __inline__		__inline__	__attribute__((always_inline))
+# define __inline		__inline	__attribute__((always_inline))
+#endif
 #define __always_inline		inline __attribute__((always_inline))
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
Index: linux-2.6.15/lib/Kconfig.debug
===================================================================
--- linux-2.6.15.orig/lib/Kconfig.debug
+++ linux-2.6.15/lib/Kconfig.debug
@@ -186,6 +186,20 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
+config FORCED_INLINING
+	bool "Force gcc to inline functions marked 'inline'"
+	depends on DEBUG_KERNEL
+	default y
+	help
+	  This option determines if the kernel forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable for the gcc 3.x series of
+	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
+	  disabling this option will generate a smaller kernel there. Hopefully
+	  this algorithm is so good that allowing gcc4 to make the decision can
+	  become the default in the future, until then this option is there to
+	  test gcc for this.
+
 config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL
Index: linux-2.6.15/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.15.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6.15/Documentation/feature-removal-schedule.txt
@@ -143,6 +143,15 @@ Who:	Christoph Hellwig <hch@lst.de>
 
 ---------------------------
 
+What:	CONFIG_FORCED_INLINING
+When:	June 2006
+Why:	Config option is there to see if gcc is good enough. (in january
+        2006). If it is, the behavior should just be the default. If it's not,
+	the option should just go away entirely.
+Who:    Arjan van de Ven  <arjan@infradead.org>
+
+---------------------------
+
 What:	START_ARRAY ioctl for md
 When:	July 2006
 Files:	drivers/md/md.c


