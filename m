Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280456AbRKJEa2>; Fri, 9 Nov 2001 23:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRKJEaS>; Fri, 9 Nov 2001 23:30:18 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29960 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280457AbRKJEaH>;
	Fri, 9 Nov 2001 23:30:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: andersg@0x63.nu
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Modutils can't handle long kernel names 
In-Reply-To: Your message of "Fri, 09 Nov 2001 23:23:43 BST."
             <20011109232343.B32090@h55p111.delphi.afb.lu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Nov 2001 15:29:49 +1100
Message-ID: <13690.1005366589@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001 23:23:43 +0100, 
andersg@0x63.nu wrote:
>On Fri, Nov 09, 2001 at 04:34:00PM +1100, Keith Owens wrote:
>> It is not a modutils problem, it is a fixed restriction on the size of
>> the uname() fields, modutils just uses what uname -r gives it.
>
>this patch would catch it at compiletime, wouldn't it?
>--- Makefile.orig	Fri Nov  9 23:17:36 2001
>+++ Makefile	Fri Nov  9 23:18:25 2001
>@@ -338,7 +338,7 @@
> 	@mv -f .ver $@
> 
> init/version.o: init/version.c include/linux/compile.h include/config/MARKER
>-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
>+	$(CC) $(CFLAGS) -Werror $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
> 
> init/main.o: init/main.c include/config/MARKER
> 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $*.o $<

Not quite.  If any of the fields are exactly 65 characters long
excluding the trailing NUL, gcc does not flag a warning.  Alas 65
characters trips the uname() bug.  It is arguable if
  char foo[65] = "65_printable_characters..........................................";
should cause a gcc warning or not, but it does not.

Also only some of the fields should cause a warning if they are too
long.  A domain name can legally be 255 characters and must not cause
an error when compiling the kernel.  So some fields must be truncated,
others must cause an error if they are too long.  The length checking
has to be done in the Makefile.

This patch fixes the problem of overlong utsname values.  Against
2.4.14, Linus, please apply.

Index: 14.1/Makefile
--- 14.1/Makefile Tue, 06 Nov 2001 12:07:56 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.19 644)
+++ 14.1(w)/Makefile Sat, 10 Nov 2001 15:23:44 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.19 644)
@@ -304,25 +304,29 @@ newversion:
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
+	@echo -n \#`cat .version` > .ver1
+	@if [ -n "$(CONFIG_SMP)" ] ; then echo -n " SMP" >> .ver1; fi
+	@if [ -f .name ]; then  echo -n \-`cat .name` >> .ver1; fi
+	@echo ' '`date` >> .ver1
+	@echo \#define UTS_VERSION \"`cat .ver1 | $(uts_truncate)`\" > .ver
 	@echo \#define LINUX_COMPILE_TIME \"`date +%T`\" >> .ver
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

