Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbTDCJ4k>; Thu, 3 Apr 2003 04:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbTDCJ4k>; Thu, 3 Apr 2003 04:56:40 -0500
Received: from almesberger.net ([63.105.73.239]:40453 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263343AbTDCJ4f>; Thu, 3 Apr 2003 04:56:35 -0500
Date: Thu, 3 Apr 2003 07:07:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/FYI] reliable markers (hooks/probes/taps/...)
Message-ID: <20030403070758.A18709@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, there was some discussion on various mechanisms for
inserting taps for debuggers, tracing, security monitors, etc.
into the kernel.

Here's a pretty light-weight approach I call "reliable markers":

 - they provide only the code locations, the rest is up to the
   debugger (or such)
 - gcc won't move them out of the code path (unlike C labels)
 - they force arguments to be where gcc says they are (in the
   DWARF2 information)
 - markers in inline functions get replicated, so one can easily
   set breakpoints
 - zero overhead if disabled at compile-time
 - relatively small overhead if enabled at compile time (uses a
   memory clobber which constrains optimizations, no other code
   or run-time data is added)

I'm using them for umlsim, http://umlsim.sourceforge.net/
The umlsim control process reads the usual DWARF2 debugging
information, and can then also do things like:

 - set breakpoints, a bit like kprobes
 - call functions in the kernel (usually from the idle task)
 - force a function to return
 - read and write arguments and variables

Below is a patch with the markers and two usage examples in the
kernel. On the umlsim side (uses a Perl/C-ish script language),
they would be used like this:

run/ping-peek.umlsim:

...
$brk_a_out = break($a.daemon_write.entry);	<--- breakpoint
...
        $pkt = $grab_outgoing_packet();		(see below)
        $enqueue($$,$pkt,$delay);
        $$.return (*skb)->len;			<--- return from function
...

include/nettap.umlsim:

global $grab_outgoing_packet = function
{
    return (unsigned char [(*skb)->len]) (*skb)->data; <-- access arg & var
};

umlsim is still in its infancy, but this should illustrate how
much can be done with such simple breakpoint support, plus the
debugging information gcc already provides.

- Werner

---------------------------------- cut here -----------------------------------

--- /dev/null	Thu Aug 30 17:30:55 2001
+++ linux-2.5.66/include/linux/markers.h	Thu Apr  3 03:51:22 2003
@@ -0,0 +1,55 @@
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
+ * __MARKER(name) generates an entry in the ".dbg_markers" section with the
+ * following content:
+ *
+ * Offset Length (bytes)
+ *    0     4	marker address
+ *    4     4	pointer to function name (__func__) in .rodata
+ *    8    >1	file name (\0-terminated)
+ *   var.  0-3	padding bytes (all zero, to speed up searches)
+ *   var.  >1	label name (\0-terminated)
+ *   var.  0-3	padding bytes (all zero, to speed up searches)
+ */
+
+
+#define __MARKER(name) \
+  __asm__ __volatile__( \
+    "1:\n" \
+    "\t.pushsection .dbg_markers,\"\",@progbits\n" \
+    "\t.long 1b\n" \
+    "\t.long %0\n" \
+    "\t.asciz \"" __FILE__ "\"\n" \
+    "\t.align 4,0\n" \
+    "\t.asciz \"" #name "\"\n" \
+    "\t.align 4,0\n" \
+    "\t.popsection\n" : : "m" (*__func__) : "memory")
+
+/*
+ * MARKER protects __MARKER against multiple uses of the same marker name
+ * within the same function.
+ */
+
+#define MARKER(name) \
+  do { __marker_##name: __attribute__((unused)) \
+       __MARKER(name); } while (0)
+
+#else /* CONFIG_MARKERS */
+
+#define MARKER(name)
+
+#endif /* !CONFIG_MARKERS */
+
+#endif /* _LINUX_MARKERS_H */
--- linux-2.5.66/net/core/dev.c.orig	Thu Apr  3 03:17:21 2003
+++ linux-2.5.66/net/core/dev.c	Thu Apr  3 04:24:40 2003
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
 
+	MARKER(entry);
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
+++ linux-2.5.66/arch/um/drivers/daemon_kern.c	Thu Apr  3 04:31:10 2003
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
+	MARKER(entry);
 	return(daemon_user_write(fd, (*skb)->data, (*skb)->len, 
 				 (struct daemon_data *) &lp->user));
 }

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
