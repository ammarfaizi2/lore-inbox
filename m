Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUELMYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUELMYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbUELMYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:24:07 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:38812 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265042AbUELMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:23:46 -0400
Subject: SOLVED - Re: PROBLEM: compiling NTFS write support
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: andrea.fracasso@infoware-srl.com
Cc: lkml <linux-kernel@vger.kernel.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
In-Reply-To: <4555.194.98.240.35.1084362984.squirrel@mail.infoware-srl.com>
References: <27239.194.98.240.35.1084356865.squirrel@mail.infoware-srl.com>
	 <1084362026.16624.14.camel@imp.csi.cam.ac.uk>
	 <4555.194.98.240.35.1084362984.squirrel@mail.infoware-srl.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1084364605.16624.22.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 13:23:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 12:56, andrea.fracasso@infoware-srl.com wrote:
> > On Wed, 2004-05-12 at 11:14, andrea.fracasso@infoware-srl.com wrote:
> >> Hi, I have found a problem compiling te source of kernel 2.6.6, if I
> >> enable NTFS write support when i run "make" i get this error:
> >>
> >> ....
> >>   CC      fs/ntfs/inode.o
> >>   CC      fs/ntfs/logfile.o
> >> {standard input}: Assembler messages:
> >> {standard input}:683: Error: suffix or operands invalid for `bsf'
> >> make[2]: *** [fs/ntfs/logfile.o] Error 1
> >> make[1]: *** [fs/ntfs] Error 2
> >> make: *** [fs] Error 2
> >>
> >> my kernel version is:
> >> Linux version 2.6.5-AS1500 (root@ntb-gozzolox) (gcc version 3.3.2
> >> 20031022
> >> (Red Hat Linux 3.3.2-1)) #3 Thu Apr 15 10:13:11 CEST 2004
> 
> The binutils ver is:
> binutils-2.14.90.0.6-4

This happens because gcc (wrongly!) optimizes a variable into a constant
and then ffs() fails to assemble because the bsfl instruction is only
allowed with memory operands and not constants.

/me hates gcc...

Please try the below fix.  It uses generic_ffs() which is ffs() the slow
way so it should build fine.

Thanks a lot for your help.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/

--- bklinux-2.6/fs/ntfs/logfile.c	2004-05-08 23:43:29.000000000 +0100
+++ ntfs-2.6/fs/ntfs/logfile.c	2004-05-12 13:16:47.615924480 +0100
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/buffer_head.h>
+#include <linux/bitops.h>
 
 #include "logfile.h"
 #include "volume.h"
@@ -455,7 +456,13 @@ BOOL ntfs_check_logfile(struct inode *lo
 	else
 		log_page_size = PAGE_CACHE_SIZE;
 	log_page_mask = log_page_size - 1;
-	log_page_bits = ffs(log_page_size) - 1;
+	/*
+	 * Gcc is annoying and sometimes optimizes log_page_size and turns it
+	 * into a constant in the assembler output and ffs() then fails to
+	 * assemble because bsfl instruction cannot be used with a constant so
+	 * we have to use generic_ffs() which does it by hand.
+	 */
+	log_page_bits = generic_ffs(log_page_size) - 1;
 	size &= ~(log_page_size - 1);
 	/*
 	 * Ensure the log file is big enough to store at least the two restart


