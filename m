Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUL3NBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUL3NBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUL3NBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:01:49 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:62906 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S261631AbUL3NBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:01:44 -0500
From: Mike Hearn <mh@codeweavers.com>
To: Thomas Sailer <sailer@scs.ch>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, the3dfxdude@gmail.com,
       pouech-eric@wanadoo.fr, dan@debian.org, roland@redhat.com,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com,
       wine-patches@winehq.com
In-Reply-To: <1104401393.5128.24.camel@gamecube.scs.ch>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
	 <5304685704122912132e3f7f76@mail.gmail.com>
	 <1104371395.5128.2.camel@gamecube.scs.ch>
	 <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
	 <1104376558.5128.22.camel@gamecube.scs.ch>
	 <20041229201531.40a0144a.akpm@osdl.org>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
Organization: Codeweavers, Inc
Date: Thu, 30 Dec 2004 13:06:20 +0000
Message-Id: <1104411980.3073.6.camel@littlegreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-SPF-Flag: YES
X-SA-Exim-Connect-IP: 81.97.76.53
X-SA-Exim-Mail-From: mh@codeweavers.com
Subject: Re: ptrace single-stepping change breaks Wine
Content-Type: multipart/mixed; boundary="=-he0BONuEXroSPSpHaHke"
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-he0BONuEXroSPSpHaHke
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-12-30 at 11:09 +0100, Thomas Sailer wrote:
> On Wed, 2004-12-29 at 20:15 -0800, Andrew Morton wrote:
> > You can globally disable flex-mmap with
> > 
> > 	echo 1 > /proc/sys/vm/legacy_va_layout
> > 
> > Does it fix things?
> 
> Haven't tried. But setarch i386 -L /usr/bin/wine ... did fix it.
> 
> Tom

Tom, does this patch against Wine help? It should do the same thing as
the setarch program, so if that fixes it then this should also (if I've
understood how this mechanism works of course).

Mike Hearn <mh@codeweavers.com>
Set the Linux ABI personality to get a legacy VM layout

--=-he0BONuEXroSPSpHaHke
Content-Disposition: attachment; filename=linux-personality.patch
Content-Type: text/x-patch; name=linux-personality.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- configure.ac  (revision 14)
+++ configure.ac  (local)
@@ -188,6 +188,7 @@ AC_CHECK_HEADERS(\
 	linux/joystick.h \
 	linux/major.h \
 	linux/param.h \
+	linux/personality.h \
 	linux/serial.h \
 	linux/ucdrom.h \
 	machine/cpu.h \
--- libs/wine/loader.c  (revision 14)
+++ libs/wine/loader.c  (local)
@@ -41,6 +41,11 @@
 #include "winbase.h"
 #include "wine/library.h"
 
+#ifdef HAVE_LINUX_PERSONALITY_H
+#include <sys/syscall.h>
+#include <linux/personality.h>
+#endif
+
 #ifdef __APPLE__
 #include <crt_externs.h>
 #define environ (*_NSGetEnviron())
@@ -515,6 +520,22 @@ static void debug_usage(void)
 
 
 /***********************************************************************
+ *           linux_personality_init
+ *
+ * Sets the "please unbreak me" mmap flag to disable things like
+ * flex-mmap. Note that this will also disable exec-shield
+ * randomization for any ELF DLLs loaded after this point but the
+ * initial libraries (libc etc) linked in automatically will be
+ * randomized.
+ */
+static void linux_personality_init(void)
+{
+#if defined(HAVE_LINUX_PERSONALITY_H) && defined(__i386__)
+    syscall(SYS_personality, PER_LINUX32 | 0x0200000 /* ADDR_COMPAT_LAYOUT */);
+#endif
+}
+
+/***********************************************************************
  *           wine_init
  *
  * Main Wine initialisation.
@@ -526,6 +547,7 @@ void wine_init( int argc, char *argv[], 
     void *ntdll;
     void (*init_func)(void);
 
+    linux_personality_init();
     build_dll_path();
     wine_init_argv0_path( argv[0] );
     __wine_main_argc = argc;

--=-he0BONuEXroSPSpHaHke--

