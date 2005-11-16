Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVKPNJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVKPNJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVKPNJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:09:08 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:63962 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S965256AbVKPNJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:09:07 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] optional use "gzip --rsyncable" for bzImage
Date: Wed, 16 Nov 2005 14:08:48 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161408.49287.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!


As (at least in debian) gzip has the "--rsyncable" parameter included, 
I'd like to suggest this patch to (configurable) use this for bzImage creation.

The default is "N" to stay compatible with current behaviour.


I didn't find an entry in MAINTAINERS; and according to git a lot of people 
touch arch/i386/Kconfig, so I just send to the l-k.

Andrew, how about an -mm inclusion? Or is the patch too small to warrant that?



Regards,

Phil



From: philipp.marek@bmlv.gv.at

diff -urN linux-2.6.12.orig/arch/i386/boot/compressed/Makefile linux-2.6.12/arch/i386/boot/compressed
/Makefile
--- linux-2.6.12.orig/arch/i386/boot/compressed/Makefile        2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/arch/i386/boot/compressed/Makefile     2005-11-16 13:44:34.000000000 +0100
@@ -4,6 +4,12 @@
 # create a compressed vmlinux image from the original vmlinux
 #

+ifdef CONFIG_RSYNCABLE
+GZIP_OPT       := --rsyncable
+else
+GZIP_OPT       :=
+endif
+
 targets                := vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS   := -traditional

@@ -17,7 +23,7 @@
        $(call if_changed,objcopy)

 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-       $(call if_changed,gzip)
+       $(call if_changed,gzip $(CONFIG_RSYNCABLE))

 LDFLAGS_piggy.o := -r --format binary --oformat elf32-i386 -T

diff -urN linux-2.6.12.orig/arch/i386/Kconfig linux-2.6.12/arch/i386/Kconfig
--- linux-2.6.12.orig/arch/i386/Kconfig 2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/arch/i386/Kconfig      2005-11-16 13:27:12.000000000 +0100
@@ -922,6 +922,17 @@
        generate incorrect output with certain kernel constructs when
        -mregparm=3 is used.

+config RSYNCABLE
+       bool "Make bzImage better rsyncable (EXPERIMENTAL)"
+       depends on EXPERIMENTAL
+       default n
+       help
+       Compresses the kernel with "gzip --rsyncable". This makes the kernel
+       slightly larger (1-2%), but allows rsync to synchronize.
+
+
 config SECCOMP
        bool "Enable seccomp to safely compute untrusted bytecode"
        depends on PROC_FS
