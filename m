Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTDEBfr (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbTDEBfr (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:35:47 -0500
Received: from almesberger.net ([63.105.73.239]:50186 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261684AbTDEBfb (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:35:31 -0500
Date: Fri, 4 Apr 2003 22:46:52 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/FYI] reliable markers (hooks/probes/taps/...)
Message-ID: <20030404224652.A19288@almesberger.net>
References: <20030403070758.A18709@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403070758.A18709@almesberger.net>; from wa@almesberger.net on Thu, Apr 03, 2003 at 07:07:58AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Here's a pretty light-weight approach I call "reliable markers":

Turns out that the memory clobber didn't make them particularly
reliable. Here's a better version. Usage:

MARKER(label_name,var...);

Where var... is an optional comma-separated list of arguments or
variables that may be accessed (read or modified) while at this
breakpoint.

(This is just for demonstration. For serious use, one would generate
a markers.h that can handle more than just four arguments.)

- Werner

---------------------------------- cut here -----------------------------------

--- /dev/null	Thu Aug 30 17:30:55 2001
+++ linux-2.5.66/include/linux/markers.h	Fri Apr  4 20:36:39 2003
@@ -0,0 +1,134 @@
+/*
+ * include/linux/markers.h - Reliable code markers (labels)
+ *
+ * Written 2003 by Werner Almesberger, Caltech Netlab FAST project
+ */
+
+#ifndef _LINUX_MARKERS_H
+#define _LINUX_MARKERS_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_MARKERS
+
+/*
+ * __marker_clobber_* macros are machine-generated. If you need to change them,
+ * use the build process from umlsim, which generates the kernel header file as
+ * umlsim/lib/markers_kernel.h
+ *
+ * umlsim can be found at http://umlsim.sourceforge.net/
+ */
+
+/*
+ * The following construct iterates over a variable-length list of variable
+ * names, and converts them to the clobber syntax.
+ */
+
+#define __marker_clobber_do_0_end(...)
+#define __marker_clobber_do_1_end(...)
+#define __marker_clobber_do_2_end(...)
+#define __marker_clobber_do_3_end(...)
+#define __marker_clobber_do_4_end(...)
+#define __marker_clobber_do_0_(car,...) \
+  , "+m"(car) __marker_clobber_map_1((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_clobber_do_1_(car,...) \
+  , "+m"(car) __marker_clobber_map_2((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_clobber_do_2_(car,...) \
+  , "+m"(car) __marker_clobber_map_3((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_clobber_do_3_(car,...) \
+  , "+m"(car) __marker_clobber_map_4((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_clobber_do_4_(car,...) \
+  , "+m"(car) __marker_clobber_map_5((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_clobber_map_0(list,op,...) __marker_clobber_do_0_##op list
+#define __marker_clobber_map_1(list,op,...) __marker_clobber_do_1_##op list
+#define __marker_clobber_map_2(list,op,...) __marker_clobber_do_2_##op list
+#define __marker_clobber_map_3(list,op,...) __marker_clobber_do_3_##op list
+#define __marker_clobber_map_4(list,op,...) __marker_clobber_do_4_##op list
+
+/* redefine, without the comma */
+#undef __marker_clobber_do_0_
+#define __marker_clobber_do_0_(car,...) \
+  "+m"(car) __marker_clobber_map_1((__VA_ARGS__), ,##__VA_ARGS__ end)
+
+#define __marker_clobbers(...) \
+  __marker_clobber_map_0((__VA_ARGS__), ,##__VA_ARGS__ end)
+
+
+/*
+ * And another one: this one simply counts the number of arguments.
+ * We need this to skip past the clobbers in the asm statement.
+ *
+ * We can't use named arguments (supported starting with gcc 3.1), because
+ * trying to do so crashes gcc ...
+ */
+
+#define __marker_count_do_0_end(...) "0"
+#define __marker_count_do_1_end(...) "1"
+#define __marker_count_do_2_end(...) "2"
+#define __marker_count_do_3_end(...) "3"
+#define __marker_count_do_4_end(...) "4"
+#define __marker_count_do_0_(car,...) \
+  __marker_count_1((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_count_do_1_(car,...) \
+  __marker_count_2((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_count_do_2_(car,...) \
+  __marker_count_3((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_count_do_3_(car,...) \
+  __marker_count_4((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_count_do_4_(car,...) \
+  __marker_count_5((__VA_ARGS__), ,##__VA_ARGS__ end)
+#define __marker_count_0(list,op,...) __marker_count_do_0_##op list
+#define __marker_count_1(list,op,...) __marker_count_do_1_##op list
+#define __marker_count_2(list,op,...) __marker_count_do_2_##op list
+#define __marker_count_3(list,op,...) __marker_count_do_3_##op list
+#define __marker_count_4(list,op,...) __marker_count_do_4_##op list
+#define __marker_count(...) __marker_count_0((__VA_ARGS__), ,##__VA_ARGS__ end)
+
+
+/*
+ * __MARKER(name,args...) generates an entry in the ".dbg_markers" section with
+ * the following content:
+ *
+ * Offset Length (bytes)
+ *    0     4	marker address
+ *    4     4	pointer to function name (__func__) in .rodata
+ *    8    >1	file name (\0-terminated)
+ *   var.  0-3	padding bytes (all zero, to speed up searches)
+ *   var.  >1	label name (\0-terminated)
+ *   var.  0-3	padding bytes (all zero, to speed up searches)
+ *
+ * The (optional) list of arguments contains the names of variables that will
+ * be accessed from the debugger while the program is stopped at this
+ * breakpoint.
+ */
+
+
+#define __MARKER(name,...) \
+  __asm__ __volatile__( \
+    "1:\n" \
+    "\t.pushsection .dbg_markers,\"\",@progbits\n" \
+    "\t.long 1b\n" \
+    "\t.long %" __marker_count(__VA_ARGS__) "\n" \
+    "\t.asciz \"" __FILE__ "\"\n" \
+    "\t.align 4,0\n" \
+    "\t.asciz \"" #name "\"\n" \
+    "\t.align 4,0\n" \
+    "\t.popsection\n" \
+    : __marker_clobbers(__VA_ARGS__) : [fn] "m" (*__func__) : "memory")
+
+/*
+ * MARKER protects __MARKER against multiple uses of the same marker name
+ * within the same function.
+ */
+
+#define MARKER(name,...) \
+  do { __marker_##name: __attribute__((unused)) \
+       __MARKER(name,__VA_ARGS__); } while (0)
+
+#else /* CONFIG_MARKERS */
+
+#define MARKER(...)
+
+#endif /* !CONFIG_MARKERS */
+
+#endif /* _LINUX_MARKERS_H */
--- linux-2.5.66/net/core/dev.c.orig	Thu Apr  3 03:17:21 2003
+++ linux-2.5.66/net/core/dev.c	Fri Apr  4 21:30:27 2003
@@ -107,6 +107,7 @@
 #include <linux/kmod.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/markers.h>
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
@@ -1471,6 +1472,7 @@
 	int ret = NET_RX_DROP;
 	unsigned short type = skb->protocol;
 
+	MARKER(entry,skb);
 	if (!skb->stamp.tv_sec)
 		do_gettimeofday(&skb->stamp);
 
--- linux-2.5.66/arch/um/Kconfig.orig	Thu Apr  3 03:50:05 2003
+++ linux-2.5.66/arch/um/Kconfig	Thu Apr  3 04:20:43 2003
@@ -363,5 +363,29 @@
         If you're involved in UML kernel development and want to use gcov,
         say Y.  If you're unsure, say N.
 
+config UMLSIM
+	bool "Enable umlsim support"
+	default n
+	help
+	umlsim uses a UML kernel for event-driven simulations. This
+	option adds code to support virtual time (boot command-line
+	option 'vtime'), and to inform the umlsim control program
+	when the kernel is idle.
+
+	A kernel containing umlsim support can also be used without
+	virtual time and umlsim.
+
+	See <http://umlsim.sourceforge.net/> for more details.
+
+config MARKERS
+	bool "Enable reliable markers"
+	default UMLSIM
+	help
+	Reliable markers are used to mark potential breakpoint locations.
+	Debuggers (or debugger-like programs, such as umlsim) need
+	specific code if they want to use reliable markers.
+
+	If you're not using umlsim, you probably want to say N. If you're
+	using this kernel with umlsim, say Y.
 endmenu
 
--- linux-2.5.66/arch/um/drivers/daemon_kern.c.orig	Thu Apr  3 04:26:47 2003
+++ linux-2.5.66/arch/um/drivers/daemon_kern.c	Fri Apr  4 21:30:58 2003
@@ -9,6 +9,7 @@
 #include "linux/init.h"
 #include "linux/netdevice.h"
 #include "linux/etherdevice.h"
+#include "linux/markers.h"
 #include "net_kern.h"
 #include "net_user.h"
 #include "daemon.h"
@@ -54,6 +55,7 @@
 static int daemon_write(int fd, struct sk_buff **skb,
 			struct uml_net_private *lp)
 {
+	MARKER(entry,skb);
 	return(daemon_user_write(fd, (*skb)->data, (*skb)->len, 
 				 (struct daemon_data *) &lp->user));
 }

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
