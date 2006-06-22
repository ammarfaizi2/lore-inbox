Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWFVUqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWFVUqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWFVUqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:46:31 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:12817 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161345AbWFVUqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:46:30 -0400
Date: Thu, 22 Jun 2006 22:46:27 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Is the x86-64 kernel size limit real?
Message-ID: <20060622204627.GA47994@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get bitched at by the build process because the kernel I get is
around 4.5Mb compressed.  i386 does not have that limitation.
Interestingly, a diff between the two build.c gives:

--- ../../../i386/boot/tools/build.c	2006-06-22 20:19:33.000000000 +0200
+++ build.c	2006-06-22 20:19:33.000000000 +0200
@@ -70,8 +70,7 @@
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, sz, setup_sectors;
-	int c;
+	unsigned int i, c, sz, setup_sectors;
 	u32 sys_size;
 	byte major_root, minor_root;
 	struct stat sb;
@@ -150,8 +149,10 @@
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
-		die("System is too big. Try using bzImage or modules.");
+	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
+	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
+		die("System is too big. Try using %smodules.",
+			is_big_kernel ? "" : "bzImage or ");
 	while (sz > 0) {
 		int l, n;
 

which shows two things:
1- a8f5034540195307362d071a8b387226b410469f should have a x86-64 version
2- the limit looks entirely artificial

So, is removing the limit prone to bite me?

  OG.

PS: Please do not turn this thread into a pro/against modules ones, TYVM.
