Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbRABT1w>; Tue, 2 Jan 2001 14:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRABT1c>; Tue, 2 Jan 2001 14:27:32 -0500
Received: from [216.161.55.93] ([216.161.55.93]:4337 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131549AbRABT12>;
	Tue, 2 Jan 2001 14:27:28 -0500
Date: Tue, 2 Jan 2001 10:57:18 -0800
From: Greg KH <greg@wirex.com>
To: linux-kernel@vger.kernel.org, stackguard@immunix.org
Subject: StackGuard compiler patch for 2.4.0-prerelease
Message-ID: <20010102105718.E4190@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, linux-kernel@vger.kernel.org,
	stackguard@immunix.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Due to some prodding from a /. post, here's the updated patch to enable
the StackGuard version of gcc be able to compile a 2.4.0-prerelease
kernel properly.

This patch is also available at:
	http://immunix.org/ImmunixOS/7.0-beta/i386/extras/

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="canary-2.4.0-prerelease.diff"

diff -Naur -X /home/greg/linux/dontdiff linux-2.4.0-prerelease/Makefile linux-2.4.0-prerelease-greg/Makefile
--- linux-2.4.0-prerelease/Makefile	Tue Jan  2 10:26:10 2001
+++ linux-2.4.0-prerelease-greg/Makefile	Tue Jan  2 10:31:04 2001
@@ -227,6 +227,10 @@
 
 include arch/$(ARCH)/Makefile
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS	+= $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS	+= $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 export	CPPFLAGS CFLAGS AFLAGS
 
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS LINKFLAGS MAKEBOOT ASFLAGS
diff -Naur -X /home/greg/linux/dontdiff linux-2.4.0-prerelease/arch/i386/boot/compressed/Makefile linux-2.4.0-prerelease-greg/arch/i386/boot/compressed/Makefile
--- linux-2.4.0-prerelease/arch/i386/boot/compressed/Makefile	Tue Mar  7 11:04:12 2000
+++ linux-2.4.0-prerelease-greg/arch/i386/boot/compressed/Makefile	Tue Jan  2 10:31:04 2001
@@ -12,6 +12,12 @@
 CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS
 ZLDFLAGS = -e startup_32
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS += $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS += $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
+
+
 #
 # ZIMAGE_OFFSET is the load offset of the compression loader
 # BZIMAGE_OFFSET is the load offset of the high loaded compression loader

--rwEMma7ioTxnRzrJ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
