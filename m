Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVBNLgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVBNLgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 06:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVBNLgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 06:36:01 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:8138 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261392AbVBNLfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 06:35:42 -0500
Subject: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK
	doesn't compile
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200502082223.j18MMxs0013724@ccure.user-mode-linux.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	 <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
	 <200502081837.22519.blaisorblade@yahoo.it>
	 <200502082223.j18MMxs0013724@ccure.user-mode-linux.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Mon, 14 Feb 2005 11:35:03 +0000
Message-Id: <1108380903.22656.9.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 17:22 -0500, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > Why not simply disable CONFIG_GCOV for him, in this case? 
> 
> Anton presumably turned on CONFIG_GCOV because he wanted to do some profiling...

Yes.  I finally found a way to get it to compile.  Compiling without TT
mode and WITHOUT static build it still fails with the same problem
(__bb_init_func problem I already reported).  But compiling without TT
but WITH static build the __bb_init_func problem goes away but instead I
get a __gcov_init missing symbol in my modules.

Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
added this as an export symbol and lo and behold the kernel and modules
compiled and I am now up an running with UML and NTFS as a module.  (-:

Here is the patch that I used to fix this:

--- ntfs-2.6-devel/arch/um/kernel/gmon_syms.c.old	2005-02-14 11:27:04.789474410 +0000
+++ ntfs-2.6-devel/arch/um/kernel/gmon_syms.c	2005-02-14 11:26:49.191117739 +0000
@@ -8,6 +8,9 @@
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
 
+extern void __gcov_init(void *);
+EXPORT_SYMBOL(__gcov_init);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


