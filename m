Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKX0b>; Mon, 11 Dec 2000 18:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130801AbQLKX0X>; Mon, 11 Dec 2000 18:26:23 -0500
Received: from [216.161.55.93] ([216.161.55.93]:50682 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129314AbQLKX0N>;
	Mon, 11 Dec 2000 18:26:13 -0500
Date: Mon, 11 Dec 2000 14:57:18 -0800
From: Greg KH <greg@wirex.com>
To: stackguard@immunix.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch for stackguard compiler and 2.2.18
Message-ID: <20001211145718.E1273@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, stackguard@immunix.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's an update for my patch to enable the just released 2.2.18 kernel
to compile with any of the different versions of the StackGuard
compiler.

If anyone has any problems with it, please let me know,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg

--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="canary-2.2.18.diff"

diff -Naur -X /home/greg/linux/dontdiff linux-2.2.18/Makefile linux-2.2.18-greg/Makefile
--- linux-2.2.18/Makefile	Sun Dec 10 16:49:41 2000
+++ linux-2.2.18-greg/Makefile	Mon Dec 11 14:17:12 2000
@@ -97,6 +97,12 @@
 
 CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS		+= $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+HOSTCFLAGS	+= $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS		+= $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+HOSTCFLAGS	+= $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 # use '-fno-strict-aliasing', but only if the compiler can take it
 CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.2.18/arch/i386/boot/compressed/Makefile linux-2.2.18-greg/arch/i386/boot/compressed/Makefile
--- linux-2.2.18/arch/i386/boot/compressed/Makefile	Tue Jan  4 10:12:11 2000
+++ linux-2.2.18-greg/arch/i386/boot/compressed/Makefile	Mon Dec 11 14:17:12 2000
@@ -10,6 +10,11 @@
 OBJECTS = $(HEAD) misc.o
 
 CFLAGS = -O2 -DSTDC_HEADERS
+
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS += $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS += $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 ZLDFLAGS = -e startup_32
 
 #

--2iBwrppp/7QCDedR--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
