Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWAIRPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWAIRPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAIRPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:15:21 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:59733 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964886AbWAIRPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:15:19 -0500
Date: Mon, 9 Jan 2006 12:15:14 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: linux-ia64@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ia64: including <asm/signal.h> alone causes compilation errors
Message-ID: <20060109171514.GA25096@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Including *just* <asm/signal.h> on ia64 will result in a compilation failure,
 where it will succeed on every other architecture.

 Every other arch includes <linux/compiler.h> either directly or via
 <linux/types.h> at the top of <asm-*/signal.h>. ia64 includes
 <linux/types.h> after including <asm-generic/signal.h>, which causes
 the __user in <asm-generic/signal.h> to get passed through untouched, causing
 compilation errors.

 This patch moves the #include <linux/types.h> up to the beginning of signal.h,
 as found on every other arch.

 A specific example of where this behavior is observed is the recent addition
 of OCFS2. fs/ocfs2/cluster/userdlm.c seems alone in only including
 <asm/signal.h>, which seems to be perfectly valid.

 While I could have just fixed this in the OCFS2 code, I thought that making
 ia64 more consistent with the rest of the kernel would be the better fix.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.15/include/asm-ia64/signal.h linux-2.6.15-ocfs2/include/asm-ia64/signal.h
--- linux-2.6.15/include/asm-ia64/signal.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-ocfs2/include/asm-ia64/signal.h	2006-01-09 11:08:16.404700640 -0500
@@ -1,6 +1,8 @@
 #ifndef _ASM_IA64_SIGNAL_H
 #define _ASM_IA64_SIGNAL_H
 
+#include <linux/types.h>
+
 /*
  * Modified 1998-2001, 2003
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
@@ -122,8 +124,6 @@
 
 # ifndef __ASSEMBLY__
 
-#  include <linux/types.h>
-
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-- 
Jeff Mahoney
SuSE Labs
