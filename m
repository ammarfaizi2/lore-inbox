Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTE0JCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTE0JCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:02:23 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:43650
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S262930AbTE0JBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:01:21 -0400
Date: Tue, 27 May 2003 05:16:45 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
Message-ID: <20030527091644.GF585@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030527044744.GJ9947@vitelus.com> <Pine.LNX.4.44.0305262159290.12230-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305262159290.12230-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 10:07:28PM -0700, Linus Torvalds wrote:
> 
> On Mon, 26 May 2003, Aaron Lehmann wrote:
> > 
> > The output between "#include <...> search starts here:" and "End of
> > search list." seems like the combination of what you want for
> > gcc_includepath and sys_includepath. I assume the output is ordered. I
> > might send a patch if I'm bored tonight.
> 
> If it comes to parsing "gcc -v" output, I have to say that I personally
> find that to be just crazy, and I'd much rather just see the (incorrect
> but working) '-print-file-name=include' hack.

How's this for a hack that makes it work a bit better?

# This is a BitKeeper generated patch for the following project:
# Project Name: TSCT - The Silly C Tokenizer
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.344   -> 1.345  
#	       pre-process.c	1.62    -> 1.63   
#	            Makefile	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/27	ryan@michonline.com	1.345
# This update (hopefully) will allow 'check' to find the appropriate, gcc-local 
# include headers (dependent, of course, upon the system it was built on)
# 
# It's still a hack, but at least it will work in a few more places.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue May 27 05:10:56 2003
+++ b/Makefile	Tue May 27 05:10:56 2003
@@ -32,7 +32,7 @@
 expression.o: $(LIB_H)
 lib.o: $(LIB_H)
 parse.o: $(LIB_H)
-pre-process.o: $(LIB_H)
+pre-process.o: $(LIB_H) pre-process.h
 scope.o: $(LIB_H)
 show-parse.o: $(LIB_H)
 symbol.o: $(LIB_H)
@@ -40,5 +40,8 @@
 test-parsing.o: $(LIB_H)
 tokenize.o: $(LIB_H)
 
+pre-process.h:
+	echo "#define GCC_INTERNAL_INCLUDE \"`gcc -print-file-name=include`\"" > pre-process.h
+
 clean:
-	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS)
+	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) pre-process.h
diff -Nru a/pre-process.c b/pre-process.c
--- a/pre-process.c	Tue May 27 05:10:56 2003
+++ b/pre-process.c	Tue May 27 05:10:56 2003
@@ -18,6 +18,7 @@
 #include <fcntl.h>
 #include <limits.h>
 
+#include "pre-process.h"
 #include "lib.h"
 #include "parse.h"
 #include "token.h"
@@ -47,6 +48,7 @@
 const char *gcc_includepath[] = {
 	"/usr/lib/gcc-lib/i386-redhat-linux/3.2.1/include",
 	"/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include",
+	GCC_INTERNAL_INCLUDE,
 	NULL
 };
 

-- 

Ryan Anderson
  sometimes Pug Majere
