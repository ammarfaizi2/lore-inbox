Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSLAPGx>; Sun, 1 Dec 2002 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLAPGw>; Sun, 1 Dec 2002 10:06:52 -0500
Received: from gherkin.frus.com ([192.158.254.49]:50304 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S261854AbSLAPGw>;
	Sun, 1 Dec 2002 10:06:52 -0500
Subject: [PATCH] aic7xxx/aicasm ld failure
To: linux-kernel@vger.kernel.org
Date: Sun, 1 Dec 2002 09:14:17 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20021201151418.16BB94ED3@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno what the officially blessed compiler is these days, or whether
that even makes a difference.  The problem is that the order in which
object modules and libraries are specified on the linker command line
is significant.  The following patchlet (against 2.5.48-2.5.50) moves
"-ldb" out of AICASM_CFLAGS and into a separate LIBS variable to avoid
an undefined __db185_open symbol.


--- linux/drivers/scsi/aic7xxx/aicasm/Makefile.orig	2002-11-12 15:30:39.000000000 -0600
+++ linux/drivers/scsi/aic7xxx/aicasm/Makefile	2002-11-18 14:57:47.000000000 -0600
@@ -7,11 +7,12 @@
 GENHDRS= y.tab.h aicdb.h
 
 SRCS=	${GENSRCS} ${CSRCS}
+LIBS=	-ldb
 
 # Cleaned up by make clean
 clean-files := $(GENSRCS) $(GENHDRS) y.output $(PROG)
 # Override default kernel CFLAGS.  This is a userland app.
-AICASM_CFLAGS:= -I/usr/include -I. -ldb
+AICASM_CFLAGS:= -I/usr/include -I.
 YFLAGS= -d
 
 NOMAN=	noman
@@ -29,7 +30,7 @@
 endif
 
 $(PROG):  $(SRCS) $(GENHDRS)
-	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
+	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG) $(LIBS)
 
 aicdb.h:
 	@if [ -e "/usr/include/db3/db_185.h" ]; then		\

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
