Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSFFNb0>; Thu, 6 Jun 2002 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFFNbZ>; Thu, 6 Jun 2002 09:31:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:51212 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316973AbSFFNay>;
	Thu, 6 Jun 2002 09:30:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [patch] 2.4.19-pre10 Enforce uts limit, use LANG=C for date/time
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 23:30:45 +1000
Message-ID: <4981.1023370245@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the length of $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
exceeds 64 characters it silently corrupts the utsname data, resulting
in garbage for uname -r and problems running the kernel and modules.
Abort if KERNELRELEASE is too long.  Truncation is not good enough, it
results in ambiguous /lib/modules/`uname -r` contents.

Ensure that the date/time in uname are always in LANG=C.  Users with
other languages report that 8 bit values cause the boot messages to go
haywire.

Both are backports from kbuild 2.5.

Index: 19-pre10.1/Makefile
--- 19-pre10.1/Makefile Tue, 04 Jun 2002 13:38:03 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.24 644)
+++ 19-pre10.1(w)/Makefile Thu, 06 Jun 2002 23:23:30 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.24 644)
@@ -324,25 +324,29 @@ newversion:
 	. scripts/mkversion > .tmpversion
 	@mv -f .tmpversion .version
 
+uts_len		:= 64
+uts_truncate	:= sed -e 's/\(.\{1,$(uts_len)\}\).*/\1/'
+
 include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
-	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
-	@if [ -n "$(CONFIG_SMP)" ] ; then echo -n " SMP" >> .ver; fi
-	@if [ -f .name ]; then  echo -n \-`cat .name` >> .ver; fi
-	@echo ' '`date`'"' >> .ver
-	@echo \#define LINUX_COMPILE_TIME \"`date +%T`\" >> .ver
+	@echo -n \#`cat .version` > .ver1
+	@if [ -n "$(CONFIG_SMP)" ] ; then echo -n " SMP" >> .ver1; fi
+	@if [ -f .name ]; then  echo -n \-`cat .name` >> .ver1; fi
+	@LANG=C echo ' '`date` >> .ver1
+	@echo \#define UTS_VERSION \"`cat .ver1 | $(uts_truncate)`\" > .ver
+	@LANG=C echo \#define LINUX_COMPILE_TIME \"`date +%T`\" >> .ver
 	@echo \#define LINUX_COMPILE_BY \"`whoami`\" >> .ver
-	@echo \#define LINUX_COMPILE_HOST \"`hostname`\" >> .ver
-	@if [ -x /bin/dnsdomainname ]; then \
-	   echo \#define LINUX_COMPILE_DOMAIN \"`dnsdomainname`\"; \
-	 elif [ -x /bin/domainname ]; then \
-	   echo \#define LINUX_COMPILE_DOMAIN \"`domainname`\"; \
-	 else \
-	   echo \#define LINUX_COMPILE_DOMAIN ; \
-	 fi >> .ver
+	@echo \#define LINUX_COMPILE_HOST \"`hostname | $(uts_truncate)`\" >> .ver
+	@([ -x /bin/dnsdomainname ] && /bin/dnsdomainname > .ver1) || \
+	 ([ -x /bin/domainname ] && /bin/domainname > .ver1) || \
+	 echo > .ver1
+	@echo \#define LINUX_COMPILE_DOMAIN \"`cat .ver1 | $(uts_truncate)`\" >> .ver
 	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail -1`\" >> .ver
 	@mv -f .ver $@
+	@rm -f .ver1
 
 include/linux/version.h: ./Makefile
+	@expr length "$(KERNELRELEASE)" \<= $(uts_len) > /dev/null || \
+	  (echo KERNELRELEASE \"$(KERNELRELEASE)\" exceeds $(uts_len) characters >&2; false)
 	@echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" > .ver
 	@echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)` >> .ver
 	@echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))' >>.ver

