Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVCNUtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVCNUtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVCNUtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:49:13 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:56597 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261877AbVCNUtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:49:07 -0500
Date: Mon, 14 Mar 2005 21:49:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] "PREEMPT" in UTS_VERSION
Message-ID: <20050314204917.GB17925@mars.ravnborg.org>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050209184011.GB2366@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209184011.GB2366@waste.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 10:40:11AM -0800, Matt Mackall wrote:
> Add PREEMPT to UTS_VERSION where enabled as is done for SMP to make
> preempt kernels easily identifiable.
I have the following patch in my tree now. It has the advantage that
compile.h gets updated when you change the PREEMPT setting.

How many scripts parsing the output of `uname -v` will break because of
this?

	Sam

===== init/Makefile 1.28 vs edited =====
--- 1.28/init/Makefile	2005-01-05 03:48:07 +01:00
+++ edited/init/Makefile	2005-03-14 21:30:13 +01:00
@@ -25,4 +25,5 @@
 
 include/linux/compile.h: FORCE
 	@echo '  CHK     $@'
-	@$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ \
+	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)" "$(CC) $(CFLAGS)"
===== scripts/mkcompile_h 1.17 vs edited =====
--- 1.17/scripts/mkcompile_h	2003-09-10 08:41:43 +02:00
+++ edited/scripts/mkcompile_h	2005-03-14 21:43:50 +01:00
@@ -1,7 +1,8 @@
 TARGET=$1
 ARCH=$2
 SMP=$3
-CC=$4
+PREEMPT=$4
+CC=$5
 
 # If compile.h exists already and we don't own autoconf.h
 # (i.e. we're not the same user who did make *config), don't
@@ -26,8 +27,10 @@
 
 
 UTS_VERSION="#$VERSION"
-if [ -n "$SMP" ] ; then UTS_VERSION="$UTS_VERSION SMP"; fi
-UTS_VERSION="$UTS_VERSION `LC_ALL=C LANG=C date`"
+CONFIG_FLAGS=""
+if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
+if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
+UTS_VERSION="$UTS_VERSION $CONFIG_FLAGS `LC_ALL=C LANG=C date`"
 
 # Truncate to maximum length
 
@@ -37,7 +40,8 @@
 # Generate a temporary compile.h
 
 ( echo /\* This file is auto generated, version $VERSION \*/
-
+  if [ -n "$CONFIG_FLAGS" ] ; then echo "/* $CONFIG_FLAGS */"; fi
+  
   echo \#define UTS_MACHINE \"$ARCH\"
 
   echo \#define UTS_VERSION \"`echo $UTS_VERSION | $UTS_TRUNCATE`\"
