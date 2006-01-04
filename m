Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWADThY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWADThY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWADThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:37:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21521 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751275AbWADThY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:37:24 -0500
Date: Wed, 4 Jan 2006 20:37:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] External modules using several directories
Message-ID: <20060104193713.GA9479@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the feeling that this question has been asked many times on lkml
now so I wrote this quick summary.
Anyone with additional comments or is it complete rubbish?

	Sam

diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index 1c0db65..7e77f93 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -18,6 +18,7 @@ In this document you will find informati
 	=== 5. Include files
 	   --- 5.1 How to include files from the kernel include dir
 	   --- 5.2 External modules using an include/ dir
+	   --- 5.3 External modules using several directories
 	=== 6. Module installation
 	   --- 6.1 INSTALL_MOD_PATH
 	   --- 6.2 INSTALL_MOD_DIR
@@ -344,6 +345,45 @@ directory and therefore needs to deal wi
 	Note that in the assignment there is no space between -I and the path.
 	This is a kbuild limitation:  there must be no space present.
 
+--- 5.3 External modules using several directories
+
+	If an external module does not follow the usual kernel style but
+	decide to spread files over several directories then kbuild can
+	support this too.
+
+	Consider the following example:
+	
+	|
+	+- src/complex_main.c
+	|   +- hal/hardwareif.c
+	|   +- hal/include/hardwareif.h
+	+- include/complex.h
+	
+	To build a single module named complex.ko we then need the following
+	kbuild file:
+
+	Kbuild:
+		obj-m := complex.o
+		complex-y := src/complex_main.o
+		complex-y += src/hal/hardwareif.o
+
+		EXTRA_CFLAGS := -I$(src)/include
+		EXTRA_CFLAGS += -I$(src)src/hal/include
+
+
+	kbuild knows how to handle .o files located in another directory -
+	although this is NOT reccommended practice. The syntax is to specify
+	the directory relative to the directory where the Kbuild file is
+	located.
+
+	To find the .h files we have to explicitly tell kbuild where to look
+	for the .h files. When kbuild executes current directory is always
+	the root of the kernel tree (argument to -C) and therefore we have to
+	tell kbuild how to find the .h files using absolute paths.
+	$(src) will specify the absolute path to the directory where the
+	Kbuild file are located when being build as an external module.
+	Therefore -I$(src)/ is used to point out the directory of the Kbuild
+	file and any additional path are just appended.
 
 === 6. Module installation
 
