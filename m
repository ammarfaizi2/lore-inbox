Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUB0QZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUB0QZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:25:32 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29448 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263032AbUB0QZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:25:11 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Controlling code alignment from kernel config
Date: Fri, 27 Feb 2004 18:05:36 +0200
User-Agent: KMail/1.5.4
Cc: kai@germaschewski.name
References: <200402270027.00780.vda@port.imtp.ilyichevsk.odessa.ua> <20040226223859.GB3537@mars.ravnborg.org>
In-Reply-To: <20040226223859.GB3537@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Qr2PA9FPF7jZQlp"
Message-Id: <200402271805.36805.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Qr2PA9FPF7jZQlp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 February 2004 00:38, Sam Ravnborg wrote:
> > Is there any hope for these options be settable
> > in make *config?
>
> Hi, I see no problem in adding support for this from a build system
> perspective. But I will request you to bring it up at lkml, people there
> may have knowledge / opinions that shall be taken into account.
>
> Do you care to try implemting it yourself, or are you stuck with the
> functionality of the build system?

Attached patch adds

(n) Function alignment
(n) Label alignment
(n) Loop alignment
(n) Jump alignment

to "General setup".

I compiled kernel with all options set to 1 (no alignment):

# size vmlinux.old vmlinux
   text    data     bss     dec     hex filename
4641327 1115225  220804 5977356  5b350c vmlinux.old
4362115 1115184  220804 5698103  56f237 vmlinux

(Dunno why data have changed too)

Comments?
--
vda

--Boundary-00=_Qr2PA9FPF7jZQlp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -urN 2.6.3.orig/Makefile 2.6.3/Makefile
--- 2.6.3.orig/Makefile	Wed Feb 18 05:58:39 2004
+++ 2.6.3/Makefile	Fri Feb 27 17:49:05 2004
@@ -438,6 +438,19 @@
 CFLAGS		+= -O2
 endif
 
+ifneq ($(CONFIG_CC_ALIGN_FUNCTIONS),0)
+CFLAGS		+= -falign-functions=$(CONFIG_CC_ALIGN_FUNCTIONS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_LABELS),0)
+CFLAGS		+= -falign-labels=$(CONFIG_CC_ALIGN_LABELS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_LOOPS),0)
+CFLAGS		+= -falign-loops=$(CONFIG_CC_ALIGN_LOOPS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_JUMPS),0)
+CFLAGS		+= -falign-jumps=$(CONFIG_CC_ALIGN_JUMPS)
+endif
+
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
diff -urN 2.6.3.orig/init/Kconfig 2.6.3/init/Kconfig
--- 2.6.3.orig/init/Kconfig	Wed Feb 18 05:59:12 2004
+++ 2.6.3/init/Kconfig	Fri Feb 27 17:58:17 2004
@@ -209,6 +209,43 @@
 
 	  If unsure, say N.
 
+config CC_ALIGN_FUNCTIONS
+	int "Function alignment"
+	default 0
+	help
+	  Align the start of functions to the next power-of-two greater than n,
+	  skipping up to n bytes.  For instance, 32 aligns functions
+	  to the next 32-byte boundary, but 24 would align to the next
+	  32-byte boundary only if this can be done by skipping 23 bytes or less.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_LABELS
+	int "Label alignment"
+	default 0
+	help
+	  Align all branch targets to a power-of-two boundary, skipping
+	  up to n bytes like ALIGN_FUNCTIONS.  This option can easily
+	  make code slower, because it must insert dummy operations for
+	  when the branch target is reached in the usual flow of the code.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_LOOPS
+	int "Loop alignment"
+	default 0
+	help
+	  Align loops to a power-of-two boundary, skipping up to n bytes.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_JUMPS
+	int "Jump alignment"
+	default 0
+	help
+	  Align branch targets to a power-of-two boundary, for branch
+	  targets where the targets can only be reached by jumping,
+	  skipping up to n bytes like ALIGN_FUNCTIONS.  In this case,
+	  no dummy operations need be executed.
+	  Zero means use compiler's default.
+
 endmenu		# General setup
 
 

--Boundary-00=_Qr2PA9FPF7jZQlp--

